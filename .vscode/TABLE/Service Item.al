tableextension 50067 ServiceItem extends "Service Item"
{
    fields
    {
        // Add changes to table fields herea
        field(50000; "Municipality Code MM"; code[20])
        {
            Caption = 'Municipality Code MM';
            TableRelation = Municipality.Code where(type = filter(Regular));
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
                PostCode: Record "Post Code";
                SItemLog: Record "Service Item Log";
            begin
                Mun.Reset();
                Mun.SetFilter(Code, '%1', "Municipality Code MM");
                Mun.SetFilter(type, '%1', Mun.Type::Regular);
                if Mun.FindFirst() then begin
                    "City MM" := Mun.City;
                    PostCode.Reset();
                    PostCode.SetFilter(City, '%1', "City MM");
                    if PostCode.FindFirst() then
                        "Post Code MM" := PostCode.Code
                    else
                        "Post Code MM" := '';
                end
                else begin
                    "City MM" := '';
                    "Post Code MM" := '';
                end;

            end;
        }
        modify("Customer No.")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
                Cu: Record customer;

            begin
                Cu.Reset();
                Cu.setfilter("No.", '%1', Rec."Customer No.");
                if Cu.FindFirst() then begin
                    Cu.CalcFields("Municipality Name Customer", "Street Name Customer", "MZ Name Customer");

                    Rec.Validate("Address Customer", Cu.Address);
                    Rec.Validate("MZ Customer", Cu."MZ Customer");
                    Rec."MZ Name Customer" := Cu."MZ Name Customer";
                    Rec.Validate("Street Customer", Cu."Street Customer");
                    Rec."Street Name Customer" := cu."Street Name Customer";
                    rec."Municipality Code Customer" := Cu."Municipality Code Customer";
                    rec."Municipality Name Customer" := Cu."Municipality Name Customer";
                    rec."Home No. Customer" := Cu."Home No. Customer";
                    Rec."Customer Category" := cu."Customer Category";
                    Rec."Floor Customer" := cu."Floor Customer";
                    Rec."Customer string" := Cu."Customer String";
                    Rec."Customer Stroke" := cu."Customer Stroke";

                    Rec."Apartment No. Customer" := Cu."Apartment No. Customer";
                    Rec."Address MM" := Rec."Address MM";


                end
                else begin
                    "Address Customer" := '';
                    Rec."Customer string" := 0;
                    Rec."Customer Stroke" := 0;
                    rec."Customer Category" := rec."Customer Category"::" ";
                    "Municipality Code Customer" := '';
                    Rec."Address MM" := '';
                    "MZ Customer" := '';
                    "Street Customer" := '';
                    "Home No. Customer" := '';
                    "Floor Customer" := '';
                    "Apartment No. Customer" := '';

                end;

            end;
        }
        field(50013; "Municipality Name MM"; Text[250])
        {
            Caption = 'Municipality Name MM';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code MM"), type = filter(Regular)));
        }
        field(50068; "Customer No. - Gauge"; Code[20])

        {
            Caption = 'Customer No. - Gauge';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = Lookup("Installation History"."Customer No." where("Measuring Point Code" = field("No."), Active = const(true)));



        }

        field(50069; "Customer Name. - Gauge"; Text[250])

        {
            Caption = 'Customer Name. - Gauge';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = Lookup("Installation History"."Customer Name" where("Measuring Point Code" = field("No."), Active = const(true)));

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
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ MM")));
        }

        field(50002; "Street"; code[20])
        {
            Caption = 'Street';
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

                if ("Street No." <> '') and (Street <> '') then begin

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
                            rec.Validate("Mobile No.", Stroke."Zone stroke");
                            rec.Validate("Fictitious Code", Stroke."Fictitious Code");
                        end
                        else begin
                            "Municipality Code MM" := '';
                            "Mobile No." := 0;
                            "MZ MM" := '';
                            //ĐK       "Street Customer" := '';
                            "Measuring Point Stroke" := 0;
                            "Measuring Point String" := 0;
                            "Zone stroke" := 0;
                            "Fictitious Code" := 0;

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
                            rec.Validate("Mobile No.", Stroke."Zone stroke");
                            rec.Validate("Fictitious Code", Stroke."Fictitious Code");
                        end
                        else begin
                            "Municipality Code MM" := '';
                            "MZ MM" := '';

                            "Measuring Point Stroke" := 0;
                            "Measuring Point String" := 0;
                            "Zone stroke" := 0;
                            "Mobile No." := 0;
                            "Fictitious Code" := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code MM" := '';
                    "MZ MM" := '';
                    "Measuring Point Stroke" := 0;
                    "Measuring Point String" := 0;
                    "Zone stroke" := 0;
                    "Mobile No." := 0;
                    "Fictitious Code" := 0;


                end;
                CalcFields("Street Name MM");



                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name MM" + ' ' + "Street No. Text"
                else
                    Address := "Street Name MM" + ' ' + "Street No.";

                "Address MM" := Address;


            end;



        }

        field(50015; "Street Name MM"; Text[250])
        {
            Caption = 'Street Name MM';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field(Street)));
        }

        field(50006; "Status MM"; enum "Status Cust/MM")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Status History MM"."Information of processing" where(Active = const(true), "Measuring Point" = field("No."), "Source Table" = filter(5940)));
            //  ValuesAllowed = 0, 18, 19, 20, 21, 49, 50;
        }

        field(50003; "Home No."; Code[5])
        {
            Caption = 'Home No.';
            //ĐK   TableRelation = Street."Home No." where(Code = field(Street));
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //ĐK   Address := Rec."MZ MM" + ' ' + Rec.Street + ' ' + "Home No.";

            end;
        }
        field(50004; "Apartment No."; Code[5])
        {
            Caption = 'Apartment No.';
            //  TableRelation = Street."Apartment No." where(Code = field(Street), "Home No." = field("Home No."), Floor = field(Floor));
        }
        field(50005; "Floor"; code[20])
        {
            Caption = 'Floor MM';
            //   TableRelation = Street.Floor where(Code = field(Street), "Home No." = field("Home No."));


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


        field(50010; "Home No. Customer"; Code[5])
        {
            Caption = 'Home No.';
            TableRelation = Street."Home No." where(Code = field(Street));
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
            TableRelation = Street."Apartment No." where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"), Floor = field("Floor Customer"));
        }
        field(50012; "Floor Customer"; code[20])
        {
            Caption = 'Floor Customer';
            TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"));


        }
        field(50019; "Measuring Point Stroke"; Integer)
        {
            Caption = 'Measuring Point Stroke';
            TableRelation = Stroke.Code where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));

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
            TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));
            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin



            end;
            //niz

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

        field(50021; "Activity"; text[250])
        {
            Caption = 'Activity';
            TableRelation = "MM Activity".Description where(Type = const(Basic));

        }
        field(50022; "EU Activity"; text[250])
        {
            Caption = 'EU Activity';
            TableRelation = "MM Activity".Description where(Type = const(EU));

        }
        field(50023; "EF Activity"; text[250])
        {
            Caption = 'EF Activity';
            TableRelation = "MM Activity".Description where(Type = const(Ef));

        }
        field(50024; "Summer Zone"; Integer)
        {
            Caption = 'Summer Zone';


        }
        field(50025; "Winter Zone"; Integer)
        {
            Caption = 'Winter Zone';


        }
        field(50026; "Economic/Technic"; Option)
        {
            Caption = 'Economic/Technic';
            OptionMembers = ,"Economic","Technic";
            OptionCaption = ' ,Economic,Technic';

        }
        field(50027; "Reading Mode"; Option)
        {
            Caption = 'Reading Mode';
            OptionMembers = ,"Reading List","Digital";
            OptionCaption = ' ,Reading List,Digital';

        }
        field(50028; "Adjusted Pressure"; Decimal)
        {
            Caption = 'Adjusted Pressure';
            DecimalPlaces = 1 : 4;
        }
        field(50029; "GIS"; Integer)
        {
            Caption = 'GIS';
        }
        field(50030; "Purpose"; Text[250])
        {
            Caption = 'Purpose';
            TableRelation = Purpose.Description where(Type = const(MM));
        }

        field(50031; "Unmeasured"; Code[20])
        {
            Caption = 'Unmeasured';

            TableRelation = Contact;
            trigger OnLookup()
            Var
                UserSetup: Record "User Setup";

            begin
                Commit();
                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup."Type Relation" := UserSetup."Type Relation"::ServiceItem;
                    UserSetup.Modify();
                end;
                Commit();
                LookupContactList;

            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin
                Contact := '';
                if "Unmeasured" <> '' then begin
                    Cont.Get("Unmeasured");
                    "Unmeasured Name" := Cont.Name;

                end
                else begin
                    "Unmeasured Name" := '';
                end;
            end;
        }

        field(50088; "Unmeasured Name"; Text[20])
        {
            Caption = 'Unmeasured Name';
            Editable = false;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin


            end;

        }


        field(50032; "Measured"; Text[250])
        {
            Caption = 'Measured';

            TableRelation = Contact;
            trigger OnLookup()
            Var
                Usersetup: Record "User Setup";

            begin
                Commit();
                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup."Type Relation" := UserSetup."Type Relation"::ServiceItem;
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
                if "Unmeasured" <> '' then begin
                    Cont.Get("Unmeasured");
                    "Unmeasured Name" := Cont.Name;

                end
                else begin
                    "Unmeasured Name" := '';
                end;
            end;
        }
        field(50089; "Measured Name"; Text[20])
        {
            Caption = 'Measured Name';
            Editable = false;

            trigger OnValidate()
            var
                Cont: Record Contact;
            begin


            end;

        }

        field(50034; "Designer"; Text[250])
        {
            Caption = 'Designer';
            //   TableRelation = Designer.Description;
        }

        field(50035; "Elevation"; Decimal)
        {
            Caption = 'Elevation';
        }
        field(50036; "Date TK"; Date)
        {
            Caption = 'Date TK';
        }
        field(50037; "Alternative fuel"; enum Option)
        {
            Caption = 'Alternative fuel';
        }
        field(50038; "Designed KW"; Decimal)
        {
            Caption = 'Designed KW"';
        }
        field(50039; "Installed KW"; Decimal)
        {
            Caption = 'Installed KW"';
        }
        field(50040; "Transit Zone"; Integer)
        {
            Caption = 'Transit Zone';


        }
        field(50041; "Starting Measuring"; Date)
        {
            Caption = 'Starting Measuring';


        }
        field(50042; "Minimal Consumption"; Text[250])
        {
            Caption = 'Minimal Consumption';


        }
        field(50043; "Consent ID"; code[20])
        {
            Caption = 'Consent ID';
            FieldClass = FlowField;
            CalcFormula = max("Service Item Line"."Consent ID" where("Service Item No. - Relation" = field("No.")));
        }

        field(50044; "Customer Category"; Enum Category)
        {
            Caption = 'Customer Category';

        }
        field(50045; "MM Category"; Enum Category)
        {
            Caption = 'MM Category';

        }
        field(50046; "Technical review"; text[250])
        {
            Caption = 'Technical review';

        }
        field(50047; "Control Number"; text[250])
        {
            Caption = 'Control Number';

        }
        field(50048; "Statement"; text[250])
        {
            Caption = 'Statement';
            TableRelation = "Types Of Diseases".Description where(Types = filter(Statement));

        }
        field(50049; "Address Customer"; text[250])
        {
            Caption = 'Address Customer';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                "Address 2" := "Address Customer";

            end;


        }
        field(50050; "Address MM"; text[250])
        {
            Caption = 'Address MM';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                Address := "Address MM";

            end;


        }
        field(50051; "Date 1"; Date)
        {
            Caption = 'Date of official notification of technical acceptance';
        }
        field(50052; "Date 2"; Date)
        {
            Caption = 'Date of return of the copy of the request in question';
        }
        field(50053; "Date 3"; Date)
        {
            Caption = ' Date of execution of the technical solution';
        }
        field(50054; "Gauge"; Integer)
        {
            Caption = 'Gauge';
            FieldClass = FlowField;
            CalcFormula = count("Installation History" where("Measuring Point Code" = field("No."), Active = const(true), Type = const(Gauge)));
        }
        field(50055; "Corrector"; Integer)
        {
            Caption = 'Corrector';
            FieldClass = FlowField;
            CalcFormula = count("Installation History" where("Measuring Point Code" = field("No."), Active = const(true), Type = const(Corrector)));
        }
        field(50056; "Dwelling Type"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Dwelling Type';
            TableRelation = "Dwelling Type".Description;

        }
        field(50060; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(50061; "E-Mail"; Text[80])
        {
            Caption = 'Email';
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
        field(50062; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                Char: DotNet Char;
                i: Integer;
                PhoneNoCannotContainLettersErr: Label 'must not contain letters';
            begin
                for i := 1 to StrLen("Mobile Phone No.") do
                    if Char.IsLetter("Mobile Phone No."[i]) then
                        FieldError("Mobile Phone No.", PhoneNoCannotContainLettersErr);
            end;
        }

        field(50063; "Phone No. MM"; Text[250])
        {
            Caption = 'Phone No. MM';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                Char: DotNet Char;
                i: Integer;
                PhoneNoCannotContainLettersErr: Label 'must not contain letters';
            begin
                for i := 1 to StrLen("Phone No. MM") do
                    if Char.IsLetter("Phone No. MM"[i]) then
                        FieldError("Phone No. MM", PhoneNoCannotContainLettersErr);
            end;
        }

        field(50065; "Zone stroke"; Integer)
        {
            Caption = 'Zone stroke';

        }

        field(50064; "Street No."; Code[20])
        {
            Caption = 'Street No.';
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                if ("Street No." <> '') and (Street <> '') then begin

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
                            rec.Validate("Mobile No.", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code MM" := '';
                            "MZ MM" := '';
                            //ĐK       "Street Customer" := '';
                            "Measuring Point Stroke" := 0;
                            "Measuring Point String" := 0;
                            "Mobile No." := 0;
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
                            rec.Validate("Mobile No.", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code MM" := '';
                            "MZ MM" := '';

                            "Measuring Point Stroke" := 0;
                            "Measuring Point String" := 0;
                            "Zone stroke" := 0;
                            "Mobile No." := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code MM" := '';
                    "MZ MM" := '';
                    "Measuring Point Stroke" := 0;
                    "Measuring Point String" := 0;
                    "Zone stroke" := 0;
                    "Mobile No." := 0;


                end;


                CalcFields("Street Name MM");


                if ("Street No. Text" = 'bb') or ("Street No. Text" = 'BB') then
                    Address := "Street Name MM" + ' ' + "Street No. Text"
                else
                    Address := "Street Name MM" + ' ' + "Street No.";

                "Address MM" := Address;
            end;

        }

        field(50076; "Remotely"; Boolean)
        {
            //FieldClass = FlowField;
            Caption = 'Remotely';
            // CalcFormula = lookup("Installation History".Remotely where(Type = filter(Corrector), Active = filter(true), "Measuring Point Code" = field("No.")));
        }

        field(50077; "Remotely Type"; enum "Remotely Type")
        {
            //    FieldClass = FlowField;
            //   CalcFormula = lookup("Installation History"."Remotely Type" where(Type = filter(Corrector), Active = filter(true), "Measuring Point Code" = field("No.")));

            Caption = 'Remotely Type';


        }
        field(50066; "Hodogram"; Integer)
        { Caption = 'Hodogram'; }
        field(50067; "MM VAT Excluded"; Boolean)
        {
            Caption = 'MM VAT Excluded';
        }
        field(50070; "Fax No."; Text[250])
        {
            Caption = 'Fax No.';
        }
        field(50071; "Fax No. - Transfer"; Text[250])
        {
            Caption = 'Fax No. - Transfer';
        }

        field(50072; "Measuring Zone - winter"; Integer)
        {
            Caption = 'Measuring Zone - winter';


        }
        field(50073; "Measuring Zone - summer"; Integer)
        {
            Caption = 'Measuring Zone - summer';


        }
        field(50074; "Street No. Text"; text[250])
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
        field(50075; "Fictitious Code"; Integer)
        {
            Caption = 'Fictitious Code';
        }
        field(50078; "Radio Module"; Integer)
        {
            Caption = 'Radio Module';
            FieldClass = FlowField;
            CalcFormula = count("Installation History" where("Measuring Point Code" = field("No."), Active = const(true), Type = const(Radio_Module)));


        }

        field(50079; "Gauge Position"; Option)
        {
            Caption = 'Gauge Position';
            OptionMembers = "Unknown","Before Regulator","After Regulator","Without regulator";
            OptionCaption = 'Unknown,Before Regulator,After Regulator,Without regulator';

        }

        field(50083; "Number of impulses (Imp/m3)"; Decimal) { Caption = 'Number of impulses (Imp/m3)'; }
        field(50084; "Pulse transmitter LF/HE"; Decimal) { Caption = 'Pulse transmitter LF/HE'; }

        field(50080; "Applied Customer inf"; Boolean)
        {
            Caption = 'Applied Customer inf';
            trigger OnValidate()
            var
                myInt: Integer;
                ContactV: Record Contact;
                NoSe: Record "No. Series";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                CU: Record Customer;
            begin
                if "Applied Customer inf" = true then begin
                    //vlasnika

                    ContactV.init;
                    NoSe.Reset();
                    NoSe.SetFilter("Type Relation", '%1', NoSe."Type Relation"::Owner);
                    if NoSe.FindFirst() then begin
                        NoSeriesMgt.InitSeries(NoSe.Code, xRec."No. Series", 0D, ContactV."No.", "No. Series");

                    end;

                    ContactV.validate(Name, name);
                    ContactV.validate(Type, ContactV.Type::Person);
                    ContactV.Validate("Type Relation", ContactV."Type Relation"::Owner);
                    ContactV.Validate(Street, rec.Street);
                    ContactV.Validate("Street No.", rec."Street No.");
                    ContactV.validate("Mobile Phone No.", cu."Mobile Phone No.");
                    ContactV.validate("E-Mail", cu."E-Mail");

                    CU.Reset();
                    CU.SetFilter("No.", '%1', rec."Customer No.");
                    if cu.FindFirst() then
                        ContactV.Validate("Phone No.", cu."Customer Phone No.");

                    ContactV.insert;
                    Commit();
                    rec."Contact MM" := ContactV."No.";

                    rec."Owner E-Mail" := ContactV."E-Mail";
                    rec."Owner Mobile Phone No." := ContactV."Mobile Phone No.";
                    rec."Owner Name" := cu.Name + cu."Name 2";
                    rec."Owner Phone No." := cu."Customer Phone No.";


                end

            end;
        }

        field(500056; "Owner Name"; Text[250])
        {
            Caption = 'Owner Name';
        }
        field(50059; "Contact MM"; Text[100])
        {

            Caption = 'Contact MM';
            TableRelation = Contact."No." where("Type Relation" = filter(Owner));
            trigger OnLookup()
            Var
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
                // "Contact MM" := '';
                if "Contact MM" <> '' then begin
                    Cont.Get("Contact MM");
                    CheckServiceItemContactRelation(Cont);


                    if Cont.Type = Cont.Type::Person then
                        "Contact MM" := Cont."No.";

                    if Cont.Image.HasValue then
                        CopyContactPicture(Cont);

                    if Cont."Phone No." <> '' then
                        "Phone No. MM" := Cont."Phone No.";

                    if Cont."Mobile Phone No." <> '' then
                        "Mobile Phone No." := Cont."Mobile Phone No.";

                end else
                    if Image.HasValue then
                        Clear(Image);
            end;




        }

        field(50085; "Owner Primary Contact"; Code[20])
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

                    //  CheckCustomerContactRelation(Cont);

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

        field(50086; "Owner Phone No."; Text[250])
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

        field(50087; "Owner E-Mail"; Text[80])
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
        field(50094; "Winter Pecentage"; Decimal)
        {
            Caption = 'Winter Pecentage';
        }
        field(50095; "Summer Pecentage"; Decimal)
        {
            Caption = 'Summer Pecentage';
        }
        field(50096; "City MM"; Text[30])
        {
            Caption = 'City';
        }
        field(50097; "Post Code MM"; Code[20])
        {
            Caption = 'Post Code MM';
        }


        field(50090; "Owner Mobile Phone No."; Text[30])
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


        field(50091; "Owner Contact"; Text[100])
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

        field(50092; "Reading Type"; Option)
        {
            Caption = 'Reading Mode';
            OptionMembers = ,"Manual","Remote","Remote MBAS";
            OptionCaption = ' ,Manual,Remote,Remote MBAS';

        }


        field(50101; "Flow direction"; Enum "Flow Direction") { Caption = 'Flow Direction'; }

        field(50102; "VU installation"; Option)
        {
            Caption = 'VU Installation';
            OptionMembers = "Unknown","Inside","Outside";

            OptionCaption = 'Unknown,Inside,Outside';
        }

        field(50103; "HV Installation"; Option)
        {
            Caption = 'HV installation';
            OptionMembers = "Unknown","Vertical","Horizontal";

            OptionCaption = 'Unknown,Vertical,Horizontal';
        }

        field(50104; "Pul"; Decimal) { Caption = 'Pul'; }

        field(50105; "Piz"; Decimal) { Caption = 'Piz'; }

        field(50106; "Tmin"; Decimal) { Caption = 'Tmin'; }

        field(50107; "Tmax"; Decimal) { Caption = 'Tmax'; }


        field(50108; "Mobile No."; Integer) { Caption = 'Mobile No.'; }


        field(50109; "Applied address"; Boolean)
        {
            Caption = 'Applied address';

            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Customer;
            begin
                if "Applied address" = true then begin
                    //provjeriti da li ide dostava ili
                    Cust.Reset();
                    Cust.SetFilter("No.", '%1', rec."Customer No.");
                    if cust.FindFirst() then begin
                        Validate(Street, Cust."Street Customer");
                        Validate("Street No.", Cust."Street No.");
                        "Street No. Text" := cust."Street No. Text";
                        Validate(Floor, cust."Floor Customer 2");
                        Validate("Apartment No.", cust."Apartment No. Customer 2");
                        Validate("Home No.", Cust."Home No. Customer");
                        if rec.Description = '' then
                            Validate(Description, cust.Name);
                    end;

                    //5050

                end;

            end;
        }

        field(50111; "Type of reading"; enum "Type of reading")
        {
            Caption = 'Type of reading';
        }
        field(50112; "Reading Time"; enum "Reading Time")
        {
            Caption = 'Reading Time';
        }
        field(50113; "Posting"; enum "Enum Posting Sales")
        {
            Caption = 'Posting';
        }
        field(50114; "Distribution"; enum Distribution)
        {
            Caption = 'Distribution of consumption (multiple customers on one scale)';
        }
        field(50115; "Distribution - read"; enum "Enum Distribution or Read"
        )
        {
            Caption = 'Distribution - read';
        }
        field(50116; "Specification"; enum Specification)
        {
            Caption = 'Specification';
        }
        field(50117; "Bill delivery"; enum "Bill delivery")
        {
            Caption = 'Bill delivery';
        }
        field(50118; "RMS Maintenance"; enum "RMS MAINTENANCE")
        {
            Caption = 'RMS Maintenance';
        }

        field(50119; "Method of calculation"; enum "Method of calculation")
        {
            Caption = 'Method of calculation';



        }
        field(50120; "Posting GAS"; enum Posting)
        {
            Caption = 'Posting GAS';



        }
        field(50121; "Measuring point off"; Boolean)
        {
            Caption = 'Measuring point off';

        }
        field(50122; "Measuring point off Date"; Date)
        {
            Caption = 'Measuring point off Date';

        }
        field(50123; "Pressure Date"; Date)
        {
            Caption = 'Pressure Date';

        }
        field(50125; "Measuring point in"; Boolean)
        {
            Caption = 'Measuring point in';

        }
        field(50126; "Measuring point in Date"; Date)
        {
            Caption = 'Measuring point in Date';

        }
        field(50127; "Last Reason"; Text[250])
        {
            Caption = 'Last Reason';

        }




    }

    keys
    {

        key(Address; "Address MM") //secondary key
        {
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
        us: Record "User Setup";
        ServiceItemUpdate: Codeunit "ServiceItem-Update";
        Conact: Record contact;
        Cust: Record Customer;
        SH: Record "Status History MM";
    begin

        Distribution := Distribution::"Distribution No";
        "Distribution - read" := "Distribution - read"::"Distribution No.";

        SH.Init();
        SH."Measuring Point" := rec."No.";
        sh."Insert User ID" := UserId;
        sh."Insert Date and Time" := CurrentDateTime;
        sh."Source Table" := 5940;
        sh."Information of processing" := sh."Information of processing"::Potential;

        sh.Active := true;
        SH.Insert();

        ServiceItemUpdate.OnInsert(Rec);
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin

            if us."Customer No." <> '' then begin

                Cust.Reset();
                Cust.SetFilter("No.", '%1', us."Customer No.");
                if Cust.FindFirst() then begin
                    rec.Validate("Customer No.", us."Customer No.");
                    rec.Validate("MM Category", Cust."Customer Category");
                    rec.Validate("Customer Category", Cust."Customer Category");
                end;

            end;

        end;
        if ("MM Category" = "MM Category"::" ")
        and ("Customer Category" <> "Customer Category"::" ") then
            Error('Ne može kupac i mjerno mjesto biti različite kategorije!');



    end;

    trigger OnAfterDelete()
    var
        GasAppliance: Record "Gas Appliance";
    begin
        if "No." <> '' then begin
            GasAppliance.SetRange("Measure Point No.", "No.");
            GasAppliance.DeleteAll();
        end;

    end;

    local procedure LookupContactList()
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        Cont: Record Contact;
        TempCust: Record "Service Item" temporary;
    begin
        Cont.FilterGroup(2);
        if FindByRelation(ContactBusinessRelation."Link to Table"::ServiceItem, "No.") then
            Cont.SetRange("Company No.", ContactBusinessRelation."Contact No.")
        else
            Cont.SetRange("Company No.", '');
        Cont.SetFilter("Type Relation", '%1', Cont."Type Relation"::Owner);

        if "Contact MM" <> '' then
            if Cont.Get("Contact MM") then;
        if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
            TempCust.Copy(Rec);
            Find;
            TransferFields(TempCust, false);
            Validate("Contact MM", Cont."No.");
        end;
    end;

    local procedure CheckServiceItemContactRelation(Cont: Record Contact)
    var
        ContBusRel: Record "Contact Business Relation";
        IsHandled: Boolean;
        Text003: Label 'Contact %1 %2 is not related to Service Item %3 %4.';
    begin
        FindOrRestoreContactBusinessRelation(Cont, Rec, ContBusRel."Link to Table"::ServiceItem);

        IsHandled := false;

        if not IsHandled then
            if Cont."Company No." <> ContBusRel."Contact No." then
                Error(Text003, Cont."No.", Cont.Name, "No.", Name);
    end;

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

    trigger OnRename()
    var
        myInt: Integer;
    begin
        if (xRec."No." <> Rec."No.") and (xrec."No." <> '') then
            Error('Nije moguće mijenjati već dodijeljenu šifru!');

    end;

    trigger OnModify()
    var
        myInt: Integer;
        CompanyInf: Record "User Setup";
        CS: Record "Calculation Setup";
        CU: Codeunit "Update Data Billing";
    begin

        if (xRec."No." <> Rec."No.") and (xrec."No." <> '') then
            Error('Nije moguće mijenjati već dodijeljenu šifru!');
        cs.Get();
        if cs."Update Data" = true then begin
            cu.UpdateMMData(rec);
        end;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
        CompanyInf: Record "User Setup";
    begin

        if UserId <> 'SARAJEVOGAS\TENEO' then
            Error('Karticu mjernog mjesta nije moguće obrisati!');

    end;


    trigger OnAfterInsert()
    var
        myInt: Integer;
        CompanyInf: Record "User Setup";
    begin

    end;

    procedure FindByRelation(LinkType: Enum "Contact Business Relation Link To Table"; LinkNo: Code[20]): Boolean
    var

    begin

        ContactB.Reset;
        ContactB.SetCurrentKey("Link to Table", "No.");
        ContactB.SetRange("Link to Table", LinkType);
        ContactB.SetRange("No.", LinkNo);
        //L exit(ContactB.FindFirst);
    end;

    local procedure GetBusinessRelationCodeFromSetup(LinkToTable: Enum "Contact Business Relation Link To Table"): Code[10]
    var
        MarketingSetup: Record "Marketing Setup";
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        MarketingSetup.Get();
        case LinkToTable of
            ContactBusinessRelation."Link to Table"::Customer:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Customers");
                    exit(MarketingSetup."Bus. Rel. Code for Customers");
                end;
            ContactBusinessRelation."Link to Table"::Vendor:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Vendors");
                    exit(MarketingSetup."Bus. Rel. Code for Vendors");
                end;
            ContactBusinessRelation."Link to Table"::Employee:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Employees");
                    exit(MarketingSetup."Bus. Rel. Code for Employees");
                end;
            ContactBusinessRelation."Link to Table"::ServiceItem:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for SI");
                    exit(MarketingSetup."Bus. Rel. Code for SI");
                end;
            ContactBusinessRelation."Link to Table"::Builder:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Builder");
                    exit(MarketingSetup."Bus. Rel. Code for Builder");
                end;

            ContactBusinessRelation."Link to Table"::Welder:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Welder");
                    exit(MarketingSetup."Bus. Rel. Code for Welder");
                end;
            ContactBusinessRelation."Link to Table"::Contractor:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Contractor");
                    exit(MarketingSetup."Bus. Rel. Code for Contractor");
                end;
            ContactBusinessRelation."Link to Table"::"Construction Manager":
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for CM");
                    exit(MarketingSetup."Bus. Rel. Code for CM");
                end;
            ContactBusinessRelation."Link to Table"::Designer:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Designer");
                    exit(MarketingSetup."Bus. Rel. Code for Designer");
                end;
            ContactBusinessRelation."Link to Table"::Investor:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for Investor");
                    exit(MarketingSetup."Bus. Rel. Code for Investor");
                end;

            ContactBusinessRelation."Link to Table"::"Chimney sweep":
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for CW");
                    exit(MarketingSetup."Bus. Rel. Code for CW");
                end;
            ContactBusinessRelation."Link to Table"::Serviceman:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for SM");
                    exit(MarketingSetup."Bus. Rel. Code for SM");
                end;

            ContactBusinessRelation."Link to Table"::Owner:
                begin
                    MarketingSetup.TestField("Bus. Rel. Code for OW");
                    exit(MarketingSetup."Bus. Rel. Code for OW");
                end;

        //Serviceman

        end;
    end;

    procedure CreateRelation(ContactNo: Code[20]; LinkNo: Code[20]; LinkToTable: Enum "Contact Business Relation Link To Table")
    var
        ContactBe: Record "Contact Business Relation";
    begin
        ContactBe.Reset();
        ContactBe.SetFilter("Contact No.", '%1', ContactNo);
        ContactBe.SetFilter("Business Relation Code", '%1', GetBusinessRelationCodeFromSetup(LinkToTable));
        ContactBe.SetFilter("No.", '%1', LinkNo);
        if not ContactBe.FindFirst() then begin
            ContactB.Init;
            ContactB."Contact No." := ContactNo;
            ContactB."Business Relation Code" := GetBusinessRelationCodeFromSetup(LinkToTable);
            ContactB."Link to Table" := LinkToTable;
            ContactB."No." := LinkNo;
            Insert(true);
        end;
    end;



    procedure FindOrRestoreContactBusinessRelation(var Cont: Record Contact; RecVar: Variant; LinkToTable: Enum "Contact Business Relation Link To Table")
    var
        ContCompany: Record Contact;
        CustContUpdate: Codeunit "CustCont-Update";
        VendContUpdate: Codeunit "VendCont-Update";
        ServiceItemContUpdate: Codeunit "ServiceItem-Update";
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        RecRef.GetTable(RecVar);
        FieldRef := RecRef.Field(1);

        if not FindByRelation(LinkToTable, Format(FieldRef.Value)) then
            if Cont.Type = Cont.Type::Person then
                if ContCompany.Get(Cont."Company No.") then begin
                    ContCompany.CheckForExistingRelationships(LinkToTable);
                    CreateRelation(ContCompany."No.", Format(FieldRef.Value), LinkToTable);
                end else begin
                    case RecRef.Number of
                        DATABASE::Customer:
                            CustContUpdate.OnInsert(RecVar);
                        DATABASE::Vendor:
                            VendContUpdate.OnInsert(RecVar);
                        Database::"Service Item":
                            ServiceItemContUpdate.OnInsert(RecVar);

                    end;
                    FindFirst;
                    Cont.Validate("Company No.", ContactB."Contact No.");
                    Cont.Modify(true);
                end;
    end;

    procedure InsertBusinessRelation(var Cont: Record Contact; RecVar: Variant; LinkToTable: Enum "Contact Business Relation Link To Table"; var No: Code[20]; var BusCode: code[20])
    var
        ContBusRel: Record "Contact Business Relation";
    begin
        with ContBusRel do begin
            Init;
            "Contact No." := Cont."No.";
            "Business Relation Code" := BusCode;
            "Link to Table" := LinkToTable;
            "No." := No;
            Insert(true);
        end;
    end;



    var
        myInt: Integer;
        OverrideImageQst: Label 'Override Image?';
        ContactB: Record "Contact Business Relation";
        PhoneNoCannotContainLettersErr: Label 'must not contain letters';
}