table 50159 "Gas Installation Data"
{
    Caption = 'Gas Installation Data';
    DataClassification = CustomerContent;
    DrillDownPageId = "Gas Installation Data";
    LookupPageId = "Gas Installation Data";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = false;
        }
        field(2; "Gas Station No."; Code[20])
        {
            Caption = 'Gas Station No.';
            DataClassification = CustomerContent;
            TableRelation = "Fixed Asset";
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            trigger OnValidate()
            begin
                OnValidateCustomerNo();
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(5; "Measure Point No."; Code[20])
        {
            Caption = 'Measure Point No.';
            DataClassification = CustomerContent;
            TableRelation = "Service Item";
            trigger OnValidate()
            begin
                OnValidateMeasurePointNo();
            end;
        }
        field(6; "Gauge No."; Code[20])
        {
            Caption = 'Gauge No.';
            //  FieldClass = FlowField;
            //  CalcFormula = count(Gauge where("Measuring Point" = field("Measure Point No.")));
            //  Editable = false;
            TableRelation = gauge.Code;
        }
        field(7; "Gas Station Placement"; Enum "Gas Station Placement")
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Station Placement';
        }
        field(8; "Pipe/Connection Type"; Enum "Pipe/Connection Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Pipe/Connection Type';
        }
        field(9; "Ceiling Ventilation"; Enum "Ceiling Ventilation")
        {
            DataClassification = CustomerContent;
            Caption = 'Ceiling Ventilation';
        }
        field(10; "Outdoor Ventilation"; Enum "Outdoor Ventilation")
        {
            DataClassification = CustomerContent;
            Caption = 'Outdoor Ventilation';
        }
        field(11; "Gas Appliance Disconn."; Enum "Appliance Disconnected")
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Appliance Disconnected';
        }
        field(12; "RMS Disconn."; Enum "Appliance Disconnected")
        {
            DataClassification = CustomerContent;
            //na koji način je isključen
            Caption = 'RMS Disconnected';
        }
        field(13; Hardness; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Hardness';
            //TableRelation = "Gas Station Attribute".Description where("Gas Station Attribute Type" = const(Hardness));
            TableRelation = Contact."No." where("Type Relation" = filter(Contractor));
            TestTableRelation = false;
            trigger OnValidate()
            var
                myInt: Integer;
                ContacF: record Contact;
            begin

                ContacF.reset;
                ContacF.SetFilter("No.", '%1', Hardness);
                if contacf.FindFirst() then
                    Hardness := contacf.Name
                else
                    Hardness := '';

            end;
        }
        field(14; Impermeability; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Impermeability';
            TableRelation = Contact."No." where("Type Relation" = filter(Contractor));
            TestTableRelation = false;
            // TableRelation = "Gas Station Attribute".Description where("Gas Station Attribute Type" = const(Impermeability));

            trigger OnValidate()
            var
                myInt: Integer;
                ContacF: record Contact;
            begin

                ContacF.reset;
                ContacF.SetFilter("No.", '%1', Impermeability);
                if contacf.FindFirst() then
                    Impermeability := contacf.Name
                else
                    Impermeability := '';

            end;


        }
        field(15; Usability; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Usability';
            TestTableRelation = false;
            TableRelation = Contact."No." where("Type Relation" = filter(Contractor));
            // TableRelation = "Gas Station Attribute".Description where("Gas Station Attribute Type" = const(Usability));

            trigger OnValidate()
            var
                myInt: Integer;
                ContacF: record Contact;
            begin

                ContacF.reset;
                ContacF.SetFilter("No.", '%1', Usability);
                if contacf.FindFirst() then
                    Usability := contacf.Name
                else
                    Usability := '';

            end;
        }



        field(50101; "Attest Electro Execution"; enum "Option for AEE")
        {
            Caption = 'Attest Electro Execution';
        }
        field(16; Attest; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Attest';
            TestTableRelation = false;
            TableRelation = Contact where("Type Relation" = filter(Electro));
            trigger OnValidate()
            var
                myInt: Integer;
                COnst: Record contact;
            begin
                COnst.Reset();
                COnst.SetFilter("No.", '%1', Attest);
                const.SetFilter("Type Relation", '%1', const."Type Relation"::Electro);
                if const.FindFirst() then begin
                    "Attest Text" := COnst.Name;
                end

                else begin
                    "Attest Text" := '';
                end;
            end;

        }

        field(50037; "Attest Text"; Text[250])

        {
            DataClassification = CustomerContent;
            Caption = 'Attest Text';

            Editable = False;
            //TableRelation = Contact where("Type Relation" = filter(Electro));
        }

        field(17; Chimney; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Chimney';
            TestTableRelation = false;
            TableRelation = Contact where("Type Relation" = filter("Chimney sweep"));
            //  TableRelation = "Gas Station Attribute".Description where("Gas Station Attribute Type" = const(Chimney));

            trigger OnValidate()
            var
                myInt: Integer;
                ContacF: record Contact;
            begin

                ContacF.reset;
                ContacF.SetFilter("No.", '%1', Chimney);
                if contacf.FindFirst() then
                    Chimney := contacf.Name
                else
                    Chimney := '';

            end;

        }
        field(18; Serviceman; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Serviceman';
            TestTableRelation = false;
            TableRelation = Contact where("Type Relation" = filter(Serviceman));

            trigger OnValidate()
            var
                myInt: Integer;
                COnst: Record contact;
            begin
                COnst.Reset();
                COnst.SetFilter("No.", '%1', Serviceman);
                const.SetFilter("Type Relation", '%1', const."Type Relation"::Serviceman);
                if const.FindFirst() then begin
                    "Serviceman Text" := COnst.Name;
                end

                else begin
                    "Serviceman Text" := '';
                end;
            end;
        }

        field(50038; "Serviceman Text"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Serviceman';

            Editable = falsE;
        }

        field(19; "Alternative Fuel"; enum "Option")
        {
            DataClassification = CustomerContent;
            Caption = 'Alternative Fuel';
        }
        field(20; "Purpose"; Text[250])
        {
            Caption = 'Purpose';
            TableRelation = Purpose.Description where(Type = const(MM));

            trigger OnValidate()
            var
                myInt: Integer;
                MMRN: Record "Service Item";
                SItemLine: Record "Service Item Line";
            begin
                if "Measure Point No." <> '' then begin

                    MMRN.Reset();
                    MMRN.SetFilter("No.", '%1', "Measure Point No.");
                    if MMRN.FindFirst() then begin
                        MMRN.validate(Purpose, rec.Purpose);
                        MMRN.Modify();
                    end;
                    SItemLine.Reset();
                    SItemLine.SetFilter("Service Item No. - Relation", '%1', rec."Measure Point No.");
                    SItemLine.SetFilter("Document Date", '<=%1', rec.Date);
                    SItemLine.SetFilter("Done Document", '%1', false);
                    if SItemLine.findset() then
                        repeat
                            SItemLine.Validate(Purpose, rec.Purpose);
                            SItemLine.Modify();
                        until SItemLine.Next() = 0;

                end;
            end;
        }
        field(21; "Connection Elements Locked"; enum "Option")
        {
            DataClassification = CustomerContent;
            Caption = 'Connection Elements Locked', Comment = 'Spojni elementi plombirani';
        }
        field(22; "Accessible for Reading"; enum "Option")
        {
            DataClassification = CustomerContent;
            Caption = 'Accessible for Reading', Comment = 'Pristupačan za očitanje';
        }
        field(23; "Technical Doc. Provided"; enum "Option")
        {
            DataClassification = CustomerContent;
            Caption = 'Technical Documentation Provided', Comment = 'Tehnička dok. data na uvid';
        }
        field(24; "Designer Connection Type"; enum "Resource Connection Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Designer Connection Type';
            trigger OnValidate()
            begin
                TestField("Designer No.", '');
            end;
        }
        field(25; "Designer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Designer No.';
            TableRelation = if ("Designer Connection Type" = const(Internal)) Employee
            else
            if ("Designer Connection Type" = const(External)) Contact;
        }
        field(26; "Consent ID"; code[50])
        {
            Caption = 'Consent ID';
            //   FieldClass = FlowField;
            // CalcFormula = lookup(Consent.Code where("Measuring Point Code" = field("Measure Point No."), Active = const(true)));
        }
        field(27; "Total Heating Area"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Total Heating Area (m2)', Comment = 'Ukupna površina za grijanje (m2)';
        }
        field(100; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(101; "Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code"), Type = filter(Regular)));
            Editable = false;
        }

        field(102; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(103; "MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ")));
            Editable = false;
        }

        field(104; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
        }

        field(105; "Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street")));
            Editable = false;
        }
        field(106; "Home No."; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Home No.';
            //   TableRelation = Street."Home No." where(Code = field("Street"));
        }
        field(107; "Floor"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Floor';
            //  TableRelation = Street.Floor where(Code = field("Street"), "Home No." = field("Home No."));
        }

        field(108; "Apartment No."; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment No.';
            //  TableRelation = Street."Apartment No." where(Code = field("Street"), "Home No." = field("Home No."), Floor = field("Floor"));
        }
        field(200; "MP Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MP Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(201; "MP Municipality Name"; Text[250])
        {
            Caption = 'MP Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("MP Municipality Code"), Type = filter(Regular)));
            Editable = false;
        }

        field(202; "MP MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MP Local Community';
            TableRelation = MZ.Code;
        }
        field(203; "MP MZ Name"; Text[250])
        {
            Caption = 'MP MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MP MZ")));
            Editable = false;
        }

        field(204; "MP Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MP Street';
            TableRelation = Street.Code;
        }

        field(205; "MP Street Name"; Text[250])
        {
            Caption = 'MP Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("MP Street")));
            Editable = false;
        }
        field(206; "MP Home No."; Code[5])
        {
            //EK zakomen.
            DataClassification = CustomerContent;
            Caption = 'MP Home No.';
            //  TableRelation = Street."Home No." where(Code = field("MP Street"));
            //EK
            /*    FieldClass = FlowField;
                CalcFormula = lookup(Street.Description where(Code = field("MP Home No.")));*/
        }
        field(207; "MP Floor"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MP Floor';
            //  TableRelation = Street.Floor where(Code = field("MP Street"), "Home No." = field("MP Home No."));
        }

        field(208; "MP Apartment No."; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'MP Apartment No.';
            //    TableRelation = Street."Apartment No." where(Code = field("MP Street"), "Home No." = field("MP Home No."), Floor = field("MP Floor"));
        }
        field(50020; "Measuring Point string"; Integer)
        {
            Caption = 'Measuring Point string';
            //  TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));
            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin



            end;
            //niz


        }
        field(50019; "Measuring Point Stroke"; Integer)
        {
            Caption = 'Measuring Point Stroke';
            // TableRelation = Stroke.Code where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));

            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin


            end;
            //Hod


        }
        field(50021; "Date"; date)
        {
            Caption = 'Date';
        }
        field(50022; "Intervention valve in RMS"; enum "Intervention valve in RMS")
        {
            caption = 'Intervention valve in RMS';
        }
        field(50023; "CH4"; enum "Option")
        {
            caption = 'CH4';
        }

        field(50024; "Const CH4"; enum "Option")
        {
            caption = 'Const CH4';
        }

        field(50025; "Hardness Date"; Date)
        {
            caption = 'Hardness Date';
        }
        field(50026; "Impermeability Date"; Date)
        {
            Caption = 'Impermeability Date';
        }
        field(50027; "Usability Date"; Date)
        {
            Caption = 'Usability Date';
        }
        field(50078; "Usability UGI"; enum "Option")
        {
            Caption = 'Usability UGI';
        }
        field(50028; "Working pressure test"; Text[250])
        {
            Caption = 'Working pressure test';

            TableRelation = Contact."No." where("Type Relation" = filter(Contractor));
            TestTableRelation = false;
            trigger OnValidate()
            var
                myInt: Integer;
                ContacF: record Contact;
            begin

                ContacF.reset;
                ContacF.SetFilter("No.", '%1', "Working pressure test");
                if contacf.FindFirst() then
                    "Working pressure test" := contacf.Name
                else
                    "Working pressure test" := '';

            end;
        }
        field(50029; "Working pressure Date test"; date)
        {
            Caption = 'Working pressure date test';
        }
        field(50030; "Attest date"; date)
        {
            Caption = 'Attest date';
        }
        field(50100; "Chimney System Control Execution"; enum "Option for CSCE")
        {
            Caption = 'Chimney System Control Execution';
        }
        field(50031; "Chimney Date"; date)
        {
            Caption = 'Chimney Date';
        }
        field(50032; "Gas appliance service"; enum "Option for GAPPS")
        {
            Caption = 'Gas appliance service';
        }
        field(50033; "Gas appliance service date"; Date)
        {
            Caption = 'Gas appliance service Date';
        }
        field(50034; "Connection type"; enum "Connection type")

        { Caption = 'Connection type'; }
        field(50035; "Anticorrosive protection"; enum "Options for boolean")
        {
            Caption = 'Anticorrosive protection';

        }
        field(50036; "Fire Protection"; enum "Options for boolean")
        {
            Caption = 'Fire Protection';
        }
        field(50039; "ppm"; Decimal)
        {
            Caption = 'ppm';
        }
        field(50040; "Location of leakage"; text[250])
        {
            Caption = 'Location of leakage';
        }
        field(50041; "Shutdown gas consumer"; enum "Option")
        {
            Caption = 'Shutdown in front of the gas consumer';
        }
        field(50042; "UGI put into operation"; enum "Option")
        {
            Caption = 'UGI put into operation';
        }
        field(50043; "UGI remained in operation"; enum "Option")
        {
            Caption = 'UGI remained in operation';
        }
        field(50044; "UGI out of operation"; enum "Option")
        {
            Caption = 'UGI out of operation';
        }
        field(50045; "UGI remained out of order"; enum "Option")
        {
            Caption = 'UGI remained out of order';
        }
        field(50046; "Shutdown on the IV"; enum "Option")
        {
            Caption = 'Shutdown on the intervention valve';
        }
        field(50047; "Shutdown IV"; enum "Appliance Disconnected")
        {
            Caption = 'Shutdown on the intervention valve by';
        }
        field(50048; "Shutdown gas consumer by"; enum "Appliance Disconnected")
        {
            Caption = 'Shutdown on gas consumer by';
        }
        field(50049; "Remark"; text[250])
        {
            Caption = 'Remark';
        }
        field(50050; "Due Date"; Integer)
        {
            Caption = 'Due Date';
        }
        field(50051; "Alternative fuel text"; Text[250])
        {
            Caption = 'Alternative fuel';
            TableRelation = "Alternative Fuel".Description;
        }
        field(50052; "Visual inspection of the gas"; enum "Option")
        {
            Caption = 'Visual inspection of the gas';

        }
        field(50053; "Observed flaws in RMS"; enum "Option")
        {
            Caption = 'Observed flaws in RMS';
        }
        field(50054; "The seal is correct"; enum "Option")
        {
            Caption = 'The seal on the dial is correct';
        }
        field(50055; "RMS Reading"; Integer)
        {
            Caption = 'RMS Reading';
        }
        field(50056; "UGI - affect tightness"; enum Option)
        {
            caption = 'Observed changes to UGI that could affect tightness';
        }
        field(50057; "All openings tightly closed"; enum "Option")
        {
            Caption = 'All openings tightly closed';
        }
        field(50058; "Detection of gas lines"; enum "Option")
        {
            Caption = 'Detection of gas lines';
        }
        field(50059; "CO2"; enum "Option")
        {
            Caption = 'CO2';
        }
        field(50060; "UGI is technically correct"; enum "UGI status")
        {
            Caption = 'The UGI installation is technically correct.';
        }
        field(50061; "Plomba SG RMS"; Text[250])
        {
            Caption = 'Plomba SG RMS';
        }
        field(50062; "Plomba SG GA"; Text[250])
        {
            Caption = 'Plomba SG GA';
        }
        field(50063; "Visual inspection of the RMS"; enum "Option")
        {
            Caption = 'Visual inspection of the RMS';

        }
        field(50064; "Alternative fuel Date"; Date)
        {
            Caption = 'Alternative fuel Date';

        }
        field(50065; "ppm1"; Decimal)
        {
            Caption = 'ppm';
        }
        field(50066; "Location of leakage1"; text[250])
        {
            Caption = 'Location of leakage';
        }
        field(50067; "ppm2"; Decimal)
        {
            Caption = 'ppm';
        }
        field(50068; "Location of leakage2"; text[250])
        {
            Caption = 'Location of leakage';
        }
        field(50069; "Reading Value 0"; Boolean)
        {
            Caption = 'Reading Value 0';
        }
        field(50070; "First Gas Release"; Boolean)
        {
            Caption = 'First Gas Release';
        }




    }


    keys
    {
        key(PK; "Entry No.", "Measure Point No.", "Gauge No.", "Customer No.")
        {
            Clustered = true;
        }
    }
    /*
        trigger OnInsert()
        var
            myInt: Integer;
            Cust: Record Customer;
            ServiceItem: Record "Service Item";
            Previous: Record "Gas Installation Data";
            Entry: Integer;
            PreviousLast: Record "Gas Installation Data";
            PreviousLastRename: Record "Gas Installation Data";
            Mandat: Record "Mandatory Attachment Setup";
            DocumentAttachment: Record "Document Attachment";
        begin



            Previous.Reset();
            Previous.SetFilter("Measure Point No.", '%1', rec."Measure Point No.");
            Previous.SetCurrentKey(Date);
            Previous.Ascending;
            if Previous.FindLast() then begin
                rec.TransferFields(Previous);
                rec.Validate(date, Today);
                PreviousLast.Reset();
                PreviousLast.SetCurrentKey("Entry No.");
                PreviousLast.Ascending;
                rec.Validate("Entry No.", PreviousLast."Entry No." + 1);

                if PreviousLastRename.get("Entry No.", "Measure Point No.", "Gauge No.", "Customer No.")
                then
                    PreviousLastRename.Rename(PreviousLast."Entry No." + 1, "Measure Point No.", "Gauge No.", "Customer No.");
                //"Entry No.", "Measure Point No.", "Gauge No.", "Customer No.")
            end;


            Cust.Reset();
            cust.SetFilter("No.", '%1', rec."Customer No.");
            if cust.FindFirst() then begin
                rec.Validate("Customer Name", cust.Name);
                rec.Validate("Municipality Code", cust."Municipality Code Customer");
                rec.Validate("Apartment No.", cust."Apartment No. Customer");
                rec.Validate(Floor, cust."Floor Customer");
                rec.Validate(Street, cust."Street Customer");
                rec.Validate(MZ, cust."MZ Customer");
                rec.Validate("Home No.", cust."Home No. Customer");
            end
            else begin
                rec.Validate("Customer Name", '');
                rec.Validate("Municipality Code", '');
                rec.Validate("Apartment No.", '');
                rec.Validate(Floor, '');
                rec.Validate(Street, '');
                rec.Validate(MZ, '');
                rec.Validate("Home No.", '');

            end;




            ServiceItem.Reset();
            ServiceItem.SetFilter("No.", '%1', rec."Measure Point No.");
            if ServiceItem.FindFirst() then begin
                rec.Validate("MP Municipality Code", ServiceItem."Municipality Code MM");
                rec.Validate("MP Apartment No.", ServiceItem."Apartment No.");
                rec.Validate("MP Floor", ServiceItem.Floor);
                rec.Validate("MP Street", ServiceItem.Street);
                rec.Validate("MP MZ", ServiceItem."MZ MM");
                rec.Validate("MP Home No.", ServiceItem."Home No.");
                rec.Validate("Measuring Point Stroke", ServiceItem."Measuring Point Stroke");
                rec.Validate("Measuring Point string", ServiceItem."Measuring Point string");
            end
            else begin
                rec.Validate("MP Municipality Code", '');
                rec.Validate("MP Apartment No.", '');
                rec.Validate("MP Floor", '');
                rec.Validate("MP Street", '');
                rec.Validate("MP MZ", '');
                rec.Validate("MP Home No.", '');
                rec.Validate("Measuring Point Stroke", 0);
                rec.Validate("Measuring Point string", 0);

            end;

            Mandat.Reset();
            Mandat.SetFilter("Gas installation", '%1', true);
            //  Mandat.SetFilter("Request Type", '%1', ServiceHeader."Request Type");
            if mandat.FindSet() then
                repeat
                    DocumentAttachment.Init();
                    DocumentAttachment."Table ID" := Database::"Service Item";
                    DocumentAttachment."No." := rec."Measure Point No.";

                    DocumentAttachment."Line No." := 1000;
                    DocumentAttachment.Mandatory := Mandat.Mandatory;
                    DocumentAttachment.ID := 0;
                    DocumentAttachment."GAS installation" := mandat."Gas Installation";
                    DocumentAttachment."Mandatory Attachment Type" := mandat."Mandatory Attachment Type";
                    DocumentAttachment."File Name" := 'Odaberite datoteku...';
                    DocumentAttachment.Insert();
                until Mandat.Next() = 0;

            //djemina ovdje obavezni prilozi

        end;
        */



    //EK
    trigger OnInsert()
    var
        Cust: Record Customer;
        ServiceItem: Record "Service Item";
        Previous: Record "Gas Installation Data";
        Entry: Integer;
        PreviousLast: Record "Gas Installation Data";
        PreviousLastRename: Record "Gas Installation Data";
        Mandat: Record "Mandatory Attachment Setup";
        DocumentAttachment: Record "Document Attachment";
        FirstGasRelease: Boolean;
        GasInstallationData: Record "Gas Installation Data";
        ServiceItemLine: Record "Service Item Line";
    begin

        PreviousLast.Reset();
        PreviousLast.SetCurrentKey("Entry No.");
        PreviousLast.Ascending;
        if PreviousLast.FindLast() then
            // rec.Validate("Entry No.", PreviousLast."Entry No." + 1);
            "Entry No." := PreviousLast."Entry No." + 1
        else
            "Entry No." := 1;


        //EK 25.09 
        /* FirstGasRelease := Confirm('Da li se izvršava prvo puštanje gasa?', true);
         rec.Validate("First Gas Release", FirstGasRelease);
         Previous.Reset();
         Previous.SetFilter("Measure Point No.", '%1', rec."Measure Point No.");
         Previous.SetCurrentKey(Date);
         Previous.Ascending;
         if Previous.FindLast() then begin
             if FirstGasRelease then begin
                 // Preslikavanje samo određenih polja

                 rec.Validate("Customer No.", Previous."Customer No.");
                 rec.Validate("Gauge No.", Previous."Gauge No.");
                 rec.Validate("Measure Point No.", Previous."Measure Point No.");
             end else begin
                 // Standardno preslikavanje svih podataka
                 rec.TransferFields(Previous);
                 rec."Entry No." := PreviousLast."Entry No." + 1;
             end;

             rec.Validate(date, Today); */ //25.09.





        PreviousLast.Reset();
        PreviousLast.SetCurrentKey("Entry No.");
        PreviousLast.Ascending;
        rec.Validate("Entry No.", PreviousLast."Entry No." + 1);

        if PreviousLastRename.get("Entry No.", "Measure Point No.", "Gauge No.", "Customer No.") then
            PreviousLastRename.Rename(PreviousLast."Entry No." + 1, "Measure Point No.", "Gauge No.", "Customer No.");

        FirstGasRelease := Confirm('Da li se izvršava prvo puštanje gasa?', true);
        Rec.Validate("First Gas Release", FirstGasRelease);
        //1710-EK

        Rec."Customer No." := Rec.GetFilter("Customer No.");
        Rec."Measure Point No." := Rec.GetFilter("Measure Point No.");
        Rec."Gauge No." := Rec.GetFilter("Gauge No.");


        if not FirstGasRelease then begin
            Previous.Reset();
            Previous.SetRange("Measure Point No.", Rec."Measure Point No.");
            if Previous.FindLast() then begin
                // Kopiraj sve podatke iz prethodnog zapisa
                Rec.TransferFields(Previous);


                Rec."Customer No." := Rec.GetFilter("Customer No.");
                Rec."Measure Point No." := Rec.GetFilter("Measure Point No.");
                Rec."Gauge No." := Rec.GetFilter("Gauge No.");
                //trebaju i ostali podaci, npr. o adresi i slično
                rec.Validate("Customer No.", Rec.GetFilter("Customer No."));
                rec.Validate("Measure Point No.", Rec.GetFilter("Measure Point No."));


                Rec.Validate("Entry No.", PreviousLast."Entry No." + 1);
            end;
        end;



        //
        /*ovo radi 1710
                // Ako nije prvo puštanje gasa, popunjavamo ostala polja
                //EK zakom.
                if FirstGasRelease then begin
                    rec."Customer No." := Rec.GetFilter("Customer No.");
                    rec."Measure Point No." := Rec.GetFilter("Measure Point No.");
                    rec."Gauge No." := Rec.GetFilter("Gauge No.");
                end else begin

                    Previous.Reset();
                    Previous.SetRange("Measure Point No.", Rec."Measure Point No.");
                    if Previous.FindLast() then begin
                        Rec.TransferFields(Previous);
                        // Obavezno ponovo dodijeli novi Entry No.
                        Rec.Validate("Entry No.", PreviousLast."Entry No." + 1);
                    end;

        ovo radi 1710*/

        /*end else begin
            Cust.Reset();
            Cust.SetFilter("No.", '%1', rec."Customer No.");
            if Cust.FindFirst() then begin
                rec.Validate("Customer Name", Cust.Name);
                rec.Validate("Municipality Code", Cust."Municipality Code Customer");
                rec.Validate("Apartment No.", Cust."Apartment No. Customer");
                rec.Validate(Floor, Cust."Floor Customer");
                rec.Validate(Street, Cust."Street Customer");
                rec.Validate(MZ, Cust."MZ Customer");
                rec.Validate("Home No.", Cust."Home No. Customer");
            end else begin
                rec.Validate("Customer Name", '');
                rec.Validate("Municipality Code", '');
                rec.Validate("Apartment No.", '');
                rec.Validate(Floor, '');
                rec.Validate(Street, '');
                rec.Validate(MZ, '');
                rec.Validate("Home No.", '');
            end;

            ServiceItem.Reset();
            ServiceItem.SetFilter("No.", '%1', rec."Measure Point No.");
            if ServiceItem.FindFirst() then begin
                rec.Validate("MP Municipality Code", ServiceItem."Municipality Code MM");
                rec.Validate("MP Apartment No.", ServiceItem."Apartment No.");
                rec.Validate("MP Floor", ServiceItem.Floor);
                rec.Validate("MP Street", ServiceItem.Street);
                rec.Validate("MP MZ", ServiceItem."MZ MM");
                rec.Validate("MP Home No.", ServiceItem."Home No.");
                rec.Validate("Measuring Point Stroke", ServiceItem."Measuring Point Stroke");
                rec.Validate("Measuring Point string", ServiceItem."Measuring Point string");

                rec.Validate("MP Home No.", ServiceItem."Home No.");
                rec.Validate(Floor, ServiceItem.Floor);


            end else begin
                rec.Validate("MP Municipality Code", '');
                rec.Validate("MP Apartment No.", '');
                rec.Validate("MP Floor", '');
                rec.Validate("MP Street", '');
                rec.Validate("MP MZ", '');
                rec.Validate("MP Home No.", '');
                rec.Validate("Measuring Point Stroke", 0);
                rec.Validate("Measuring Point string", 0);

                rec.Validate("MP Home No.", '');
                rec.Validate(Floor, '');

            end;*/
        //   end;

        Mandat.Reset();
        Mandat.SetFilter("Gas installation", '%1', true);
        if Mandat.FindSet() then
            repeat
                DocumentAttachment.Init();
                DocumentAttachment."Table ID" := Database::"Service Item";
                DocumentAttachment."No." := rec."Measure Point No.";
                DocumentAttachment."Line No." := 1000;
                DocumentAttachment.Mandatory := Mandat.Mandatory;
                DocumentAttachment.ID := 0;
                DocumentAttachment."GAS installation" := Mandat."Gas Installation";
                DocumentAttachment."Mandatory Attachment Type" := Mandat."Mandatory Attachment Type";
                DocumentAttachment."File Name" := 'Odaberite datoteku...';
                DocumentAttachment.Insert();
            until Mandat.Next() = 0;
    end;




    /*  local procedure OnValidateCustomerNo()
      var
          Customer: Record Customer;
      begin
          if "Customer No." = '' then begin
              "Customer Name" := '';
              "Municipality Code" := '';
              "MZ" := '';
              "Street" := '';
              "Home No." := '';
              "Floor" := '';
              "Apartment No." := '';
              exit;
          end;
          Customer.Get("Customer No.");
          "Customer Name" := Customer.Name;
          "Municipality Code" := Customer."Municipality Code Customer";
          "MZ" := Customer."MZ Customer";
          "Street" := Customer."Street Customer";
          "Home No." := Customer."Home No. Customer";
          "Floor" := Customer."Floor Customer";
          "Apartment No." := Customer."Apartment No. Customer";
      end;*/


    //EK
    local procedure OnValidateCustomerNo()
    var
        Customer: Record Customer;
    begin
        if "Customer No." = '' then begin
            "Customer Name" := '';
            "Municipality Code" := '';
            "MZ" := '';
            "Street" := '';
            "Home No." := '';
            "Floor" := '';
            "Apartment No." := '';
            exit;
        end;

        /*
                if "First Gas Release" then
                    exit; // Ako je prvo puštanje gasa, ne popunjavati podatke*/

        Customer.Get("Customer No.");
        "Customer Name" := Customer.Name;
        "Municipality Code" := Customer."Municipality Code Customer";
        "MZ" := Customer."MZ Customer";
        "Street" := Customer."Street Customer";
        "Home No." := Customer."Home No. Customer";
        "Floor" := Customer."Floor Customer";
        "Apartment No." := Customer."Apartment No. Customer";
    end;

    /*
        procedure OnValidateMeasurePointNo()
        var
            ServiceItem: Record "Service Item";
        begin
            if "Measure Point No." = '' then begin
                "MP Municipality Code" := '';
                "MP MZ" := '';
                "MP Street" := '';
                "MP Home No." := '';
                "MP Floor" := '';
                "MP Apartment No." := '';
                Purpose := '';
                "Alternative Fuel" := "Alternative Fuel"::Empty;
                exit;
            end;
            ServiceItem.Get("Measure Point No.");
            "MP Municipality Code" := ServiceItem."Municipality Code MM";
            "MP MZ" := ServiceItem."MZ MM";
            "MP Street" := Serviceitem.Street;
            "MP Home No." := ServiceItem."Home No.";
            "MP Floor" := ServiceItem.Floor;
            "MP Apartment No." := ServiceItem."Apartment No.";
            Purpose := ServiceItem.Purpose;
            "Alternative Fuel" := ServiceItem."Alternative fuel";
            rec.Validate("Measuring Point Stroke", ServiceItem."Measuring Point Stroke");
            rec.Validate("Measuring Point string", ServiceItem."Measuring Point string");
        end;
    */
    //EK
    procedure OnValidateMeasurePointNo()
    var
        ServiceItem: Record "Service Item";
    begin
        if "Measure Point No." = '' then begin
            "MP Municipality Code" := '';
            "MP MZ" := '';
            "MP Street" := '';
            "MP Home No." := '';
            "MP Floor" := '';
            "MP Apartment No." := '';
            //   Purpose := '';
            "Alternative Fuel" := "Alternative Fuel"::Empty;
            "MP Home No." := '';
            exit;
        end;

        /*    if "First Gas Release" then
                exit; // Ako je prvo puštanje gasa, ne popunjavati podatke*/

        ServiceItem.Get("Measure Point No.");
        "MP Municipality Code" := ServiceItem."Municipality Code MM";
        "MP MZ" := ServiceItem."MZ MM";
        "MP Street" := Serviceitem.Street;
        "MP Home No." := ServiceItem."Home No.";
        "MP Floor" := ServiceItem.Floor;
        "MP Apartment No." := ServiceItem."Apartment No.";
        //   Purpose := ServiceItem.Purpose;
        "Alternative Fuel" := ServiceItem."Alternative fuel";

        rec.Validate("MP Home No.", ServiceItem."Home No.");
        rec.Validate(Floor, ServiceItem.Floor);


        rec.Validate("Measuring Point Stroke", ServiceItem."Measuring Point Stroke");
        rec.Validate("Measuring Point string", ServiceItem."Measuring Point string");
    end;



    trigger OnDelete()
    var
        GasAppliance: Record "Gas Appliance";
    begin
        if "Entry No." = 0 then
            exit;
        GasAppliance.SetRange("Gas Install. Data Entry No.", "Entry No.");
        GasAppliance.DeleteAll;
    end;


}
