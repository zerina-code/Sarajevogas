table 50177 "Service Item Line Archive"
{
    Caption = 'Service Item Line';
    Permissions = TableData "Loaner Entry" = rimd,
                  TableData "Service Order Allocation" = rimd;

    fields
    {

        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            TableRelation = "Service Header"."No." WHERE("Document Type" = FIELD("Document Type"));


        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No.";


        }
        field(4; "Service Item Group Code"; Code[10])
        {
            Caption = 'Service Item Group Code';
            TableRelation = "Service Item Group".Code;

        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";


        }
        field(6; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';


        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';


        }
        field(8; "Description 2"; Text[50])
        {
            Caption = 'Description 2';


        }
        field(9; "Repair Status Code"; Code[10])
        {
            Caption = 'Repair Status Code';
            TableRelation = "Repair Status";


        }
        field(10; Priority; Option)
        {
            Caption = 'Priority';
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
        }
        field(11; "Response Time (Hours)"; Decimal)
        {
            Caption = 'Response Time (Hours)';
            DecimalPlaces = 0 : 5;

        }
        field(12; "Response Date"; Date)
        {
            Caption = 'Response Date';


        }
        field(13; "Response Time"; Time)
        {
            Caption = 'Response Time';


        }
        field(14; "Starting Date"; Date)
        {
            Caption = 'Starting Date';


        }
        field(15; "Starting Time"; Time)
        {
            Caption = 'Starting Time';


        }
        field(16; "Finishing Date"; Date)
        {
            Caption = 'Finishing Date';


        }
        field(17; "Finishing Time"; Time)
        {
            Caption = 'Finishing Time';


        }
        field(18; "Service Shelf No."; Code[10])
        {
            Caption = 'Service Shelf No.';
            TableRelation = "Service Shelf";
        }
        field(19; "Warranty Starting Date (Parts)"; Date)
        {
            Caption = 'Warranty Starting Date (Parts)';


        }
        field(20; "Warranty Ending Date (Parts)"; Date)
        {
            Caption = 'Warranty Ending Date (Parts)';


        }
        field(21; Warranty; Boolean)
        {
            Caption = 'Warranty';


        }
        field(22; "Warranty % (Parts)"; Decimal)
        {
            Caption = 'Warranty % (Parts)';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(23; "Warranty % (Labor)"; Decimal)
        {
            Caption = 'Warranty % (Labor)';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(24; "Warranty Starting Date (Labor)"; Date)
        {
            Caption = 'Warranty Starting Date (Labor)';

        }
        field(25; "Warranty Ending Date (Labor)"; Date)
        {
            Caption = 'Warranty Ending Date (Labor)';

        }
        field(26; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));

        }
        field(27; "Location of Service Item"; Text[30])
        {
            CalcFormula = Lookup("Service Item"."Location of Service Item" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Location of Service Item';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Loaner No."; Code[20])
        {
            Caption = 'Loaner No.';
            TableRelation = Loaner."No.";

        }
        field(29; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(30; "Vendor Item No."; Text[50])
        {
            Caption = 'Vendor Item No.';
        }
        field(31; "Fault Reason Code"; Code[10])
        {
            Caption = 'Fault Reason Code';
            TableRelation = "Fault Reason Code";


        }
        field(32; "Service Price Group Code"; Code[10])
        {
            Caption = 'Service Price Group Code';
            TableRelation = "Service Price Group";


        }
        field(33; "Fault Area Code"; Code[10])
        {
            Caption = 'Fault Area Code';
            TableRelation = "Fault Area";


        }
        field(34; "Symptom Code"; Code[10])
        {
            Caption = 'Symptom Code';
            TableRelation = "Symptom Code";


        }
        field(35; "Fault Code"; Code[10])
        {
            Caption = 'Fault Code';
            TableRelation = "Fault Code".Code WHERE("Fault Area Code" = FIELD("Fault Area Code"),
                                                     "Symptom Code" = FIELD("Symptom Code"));
        }
        field(36; "Resolution Code"; Code[10])
        {
            Caption = 'Resolution Code';
            TableRelation = "Resolution Code";
        }
        field(37; "Fault Comment"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No."),
                                                              Type = CONST(Fault),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Fault Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Resolution Comment"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No."),
                                                              Type = CONST(Resolution),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Resolution Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));


        }
        field(41; "Service Item Loaner Comment"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No."),
                                                              Type = CONST("Service Item Loaner"),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Service Item Loaner Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Actual Response Time (Hours)"; Decimal)
        {
            Caption = 'Actual Response Time (Hours)';
            DecimalPlaces = 0 : 5;
        }
        field(43; "Document Type"; Enum "Service Document Type")
        {
            Caption = 'Document Type';
            Editable = false;
        }
        field(44; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            Editable = false;
            TableRelation = "Service Price Adjustment Group";
        }
        field(45; "Adjustment Type"; Option)
        {
            Caption = 'Adjustment Type';
            Editable = false;
            OptionCaption = 'Fixed,Maximum,Minimum';
            OptionMembers = "Fixed",Maximum,Minimum;
        }
        field(46; "Base Amount to Adjust"; Decimal)
        {
            Caption = 'Base Amount to Adjust';
            Editable = false;
        }
        field(60; "No. of Active/Finished Allocs"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("Document No."),
                                                                  "Service Item Line No." = FIELD("Line No."),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                  "Allocation Date" = FIELD("Allocation Date Filter"),
                                                                  Status = FILTER(Active | Finished)));
            Caption = 'No. of Active/Finished Allocs';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "No. of Allocations"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE(Status = FIELD("Allocation Status Filter"),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                  "Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("Document No."),
                                                                  "Service Item Line No." = FIELD("Line No.")));
            Caption = 'No. of Allocations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "No. of Previous Services"; Integer)
        {
            CalcFormula = Count("Service Shipment Item Line" WHERE("Item No." = FIELD("Item No."),
                                                                    "Serial No." = FIELD("Serial No.")));
            Caption = 'No. of Previous Services';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Contract Line No."; Integer)
        {
            Caption = 'Contract Line No.';
            TableRelation = "Service Contract Line"."Line No." WHERE("Contract Type" = CONST(Contract),
                                                                      "Contract No." = FIELD("Contract No."));
        }
        field(64; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(65; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(91; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(92; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(93; "Allocation Date Filter"; Date)
        {
            Caption = 'Allocation Date Filter';
            FieldClass = FlowFilter;
        }
        field(94; "Repair Status Code Filter"; Code[10])
        {
            Caption = 'Repair Status Code Filter';
            FieldClass = FlowFilter;
            TableRelation = "Repair Status".Code;
        }
        field(96; "Allocation Status Filter"; Option)
        {
            Caption = 'Allocation Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Nonactive,Active,Finished,Canceled,Reallocation Needed';
            OptionMembers = Nonactive,Active,Finished,Canceled,"Reallocation Needed";
        }
        field(97; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(98; "Service Order Filter"; Code[20])
        {
            Caption = 'Service Order Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Header"."No.";
        }
        field(99; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(100; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));


        }
        field(101; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(130; "Release Status"; Option)
        {
            Caption = 'Release Status';
            OptionCaption = 'Open,Released to Ship';
            OptionMembers = Open,"Released to Ship";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";


        }
        field(50198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }

        field(50199; "MM previous"; Code[20])
        {
            Caption = 'MM previous';
        }

        field(50111; "Service Item No. - Relation"; Code[20])
        {
            Caption = 'Service Item No.';
            //   TableRelation = "Service Item"."No." where("Customer No." = field("Customer No."));

        }

        field(50000; "Gauge No."; Code[20])
        {
            Caption = 'Gauge No.';

            DataClassification = CustomerContent;
            TableRelation = Gauge where("Customer No." = field("Customer No."));


        }
        field(50001; "Purpose"; Text[250])
        {
            Caption = 'Purpose';
            DataClassification = CustomerContent;
            TableRelation = Purpose.Description where(Type = const(MM));
        }
        field(50002; "Dwelling Type"; Text[250])
        {
            Caption = 'Dwelling Type';
            DataClassification = CustomerContent;
            TableRelation = "Dwelling Type".Description;
        }
        field(50003; Elevation; Decimal)
        {
            Caption = 'Elevation';
            DataClassification = CustomerContent;
        }
        field(50004; "Reading Mode"; Option)
        {
            Caption = 'Reading Mode';
            DataClassification = CustomerContent;
            OptionMembers = ,"Reading List","Digital";
            OptionCaption = ' ,Reading List,Digital';
        }
        field(50005; "MM Category"; Enum Category)
        {
            Caption = 'MM Category';
            DataClassification = CustomerContent;
        }
        field(50006; "Consent ID"; code[20])
        {
            Caption = 'Consent ID';
            //  FieldClass = FlowField;
            //CalcFormula = lookup(Consent.Code where("Measuring Point Code" = field("Service Item No."), Active = const(true)));
            //   Editable = false;
        }

        field(50032; "Gas Installation Data"; Integer)
        {
            Caption = 'Gas Installation Data';
            FieldClass = FlowField;
            CalcFormula = count("Gas Installation Data" where("Measure Point No." = field("Service Item No."), "Gauge No." = field(Gauge),
            "Customer No." = field("Customer No.")));
            Editable = false;
        }

        field(50007; "Gauge"; Code[20])
        {
            Caption = 'Gauge';
            TableRelation = Gauge.No where("Customer No." = field("Customer No."), "Measuring Point" = field("Service Item No. - Relation"));          // FieldClass = FlowField;
                                                                                                                                                       // CalcFormula = count(Gauge where("Measuring Point" = field("Service Item No.")));
                                                                                                                                                       // Editable = false;


        }
        field(50008; "Total installed kW"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Installed kW', Comment = 'Ukupno instalisano opt. (kW)';
        }
        field(50009; "Number of Measure Points"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number of Measure Points';
        }
        field(50010; "Corrector"; Code[20])
        {
            Caption = 'Corrector';

            TableRelation = "El. Volume Corr".Code where("Customer No." = field("Customer No."), "Measuring Point" = field("Service Item No. - Relation"));
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(50011; "Status MM"; enum "Status Cust/MM")
        {
            Caption = 'Status MM';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Status History MM"."Information of processing" where(Active = const(true), "Measuring Point" = field("Service Item No."), "Source Table" = filter(5900)));
        }

        field(50100; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));

        }
        field(50101; "Municipality Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Name';
        }

        field(50102; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;

        }
        field(50103; "MZ Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'MZ Name';
        }

        field(50104; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;

        }

        field(50105; "Street Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Street Name';
        }
        field(50106; "Street No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Street No.';

        }
        field(50107; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(50108; "String"; Integer)
        {
            Caption = 'String', Comment = 'Niz';
            TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field(MZ), Street = field(Street), "Municipality Code" = field("Municipality Code"));
            DataClassification = CustomerContent;
        }
        field(50109; "Stroke"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Stroke', Comment = 'Hod';
            TableRelation = Stroke.Code where("MZ-Code" = field(MZ), Street = field(Street), "Municipality Code" = field("Municipality Code"));
        }
        field(50110; "Zone Stroke"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Zone Stroke', Comment = 'Zona hoda';
        }

        field(50112; "Gauge Size"; text[250])
        {
            Caption = 'Gauge size';
            TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));

        }
        field(50113; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = MM,"OS","Loc";
            OptionCaption = 'MM,OS,Loc';

        }

        field(50114; "RMS"; Code[20])

        {
            Caption = 'RMS';

        }
        field(50115; "New Gauges"; Code[20])

        {
            Caption = 'New Gauges';
            //ovo je novi mjerač
            TableRelation = IF ("Type G_R" = CONST(Gauge)) "Gauge"

            ELSE
            if ("Type G_R" = const(Gauge_RM)) Gauge else
            IF ("Type G_R" = CONST(Corrector))
                                      "El. Volume Corr" else
            IF ("Type G_R" = CONST(Radio_Module)) "Radio Module";
            ValidateTableRelation = false;

        }

        field(50116; "Home No. MM"; Code[5])
        {
            Caption = 'Home No.';
            //ĐK   TableRelation = Street."Home No." where(Code = field(Street));

        }
        field(50117; "Apartment No. MM"; Code[5])
        {
            Caption = 'Apartment No.';
            //  TableRelation = Street."Apartment No." where(Code = field(Street), "Home No." = field("Home No."), Floor = field(Floor));
        }
        field(50118; "Floor MM"; code[20])
        {
            Caption = 'Floor MM';
            //   TableRelation = Street.Floor where(Code = field(Street), "Home No." = field("Home No."));


        }
        field(50119; "Street No. Text MM"; text[250])
        {
            Caption = 'Street No. text MM';
        }
        field(50120; "Date of consumption"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of consumption';


        }
        field(50121; "Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading';

        }
        field(50122; "Meter Manufacturer"; Text[250])
        {
            Caption = 'Meter Manufacturer';
            TableRelation = Manufacturer;

        }
        field(50123; "Year of Production"; Integer)
        {
            Caption = 'Year of Production"';

        }
        field(50124; "DD calibration"; Integer) { Caption = 'DD calibration'; }
        field(50125; "Request type"; enum "Request Type")
        {
            Caption = 'Request Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Type" where("No." = field("Document No.")));

        }

        field(50126; "Gas Appliance"; Integer)
        {
            Caption = 'Gas Appliance';
            FieldClass = FlowField;
            CalcFormula = count("Gas Appliance" where("Measure Point No." = field("Service Item No.")));
            Editable = false;
        }
        field(50127; "Meter Manufacturer Desc"; Text[250])
        {
            Caption = 'Meter Manufacturer Desc';
            //  TableRelation = Manufacturer;
        }
        field(50128; "Return RN"; Boolean)
        {
            Caption = 'Return RN';
        }
        field(50129; "Inventory Number New"; Code[20]) { Caption = 'Inventory Number'; }

        field(50130; "Gauge Size New"; text[250])
        {
            Caption = 'Gauge Size New';
            TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));

        }
        field(50131; "Date of consumption New"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of consumption New';

        }
        field(50132; "Reading New"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading New';

        }
        //new value

        field(50133; "Measuring Point Address New"; Text[250]) { Caption = 'Measuring Point Address New'; }


        //ovdje će sve biti new



        field(50134; "Measurer manufacturer New"; Text[250]) { Caption = 'Measurer manufacturer New'; }
        field(50135; "Production Year New"; Integer) { Caption = 'Production Year New'; }
        field(50136; "Calibration Year New"; Integer) { Caption = 'Calibration Year New'; }


        field(50138; "Serial Number I New"; text[250]) { Caption = 'Serial Number I New'; }
        field(50139; "Serial Number II New"; text[250]) { Caption = 'Serial Number New'; }

        field(50140; "Dismantling date New"; Date)
        {
            Caption = 'Dismantling date New';
        }
        field(50141; "Programming date New"; Date) { Caption = 'Programming date New'; }
        field(50142; "Date of rescheduling New"; date) { Caption = 'Date of rescheduling New'; }

        field(50143; "DD calibration New"; Integer) { Caption = 'DD calibration new'; }

        field(50144; "Reason for dismantling New"; Text[250])
        {
            Caption = 'Reason for dismantling';
            TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling"));

        }
        field(50145; "Customer No. New"; Code[20])
        {
            Caption = 'Customer No. New';
            TableRelation = Customer."No.";

        }
        field(50146; "Customer Name New"; Text[250])
        {
            Caption = 'Customer Name New';

        }
        field(50147; "Customer City New"; Text[30])
        {
            //  CalcFormula = Lookup(Customer.City WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer City New';
            Editable = false;
            //   FieldClass = FlowField;
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(50148; "Municipality Code MM New"; code[20])
        {
            Caption = 'Municipality Code MM New';
            TableRelation = Municipality.Code where(type = filter(Regular));

        }
        field(50149; "Customer Zone stroke New"; Integer)
        {
            Caption = 'Customer Zone stroke New';

        }
        field(50150; "Street Name MM New"; Text[250])
        {
            Caption = 'Street Name MM New';
            // FieldClass = FlowField;
            //CalcFormula = lookup(Street.Description where(Code = field(Street)));
        }

        field(50151; "Customer Post Code New"; Code[20])
        {
            //   CalcFormula = Lookup(Customer."Post Code" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Post Code';
            Editable = false;
            //  FieldClass = FlowField;
        }
        field(50152; "Street No. MM New"; Code[20])
        {
            Caption = 'Street No. MM New';


        }
        field(50153; "MM Description New"; Text[100])
        {
            Caption = 'MM Description New';



        }
        field(50154; "Customer Address New"; Text[100])
        {
            //     CalcFormula = Lookup(Customer.Address WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Address New';
            Editable = false;
            //   FieldClass = FlowField;
        }

        field(50155; "Address MM New"; text[250])
        {
            Caption = 'Address MM New';


        }
        field(50156; "Street MM New"; code[20])
        {
            Caption = 'Street MM New';
            TableRelation = Street.Code;




        }

        field(50157; "Measuring Point Stroke New"; Integer)
        {
            Caption = 'Measuring Point Stroke New';
            //TableRelation = Stroke.Code where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));




        }
        field(50158; "Measuring Point string New"; Integer)
        {
            Caption = 'Measuring Point string New';
            //    TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));



        }
        field(50159; "MZ MM New"; code[20])
        {
            Caption = 'Local Community New';
            TableRelation = MZ.Code;


        }
        field(50160; "MZ Name MM New"; Text[250])
        {
            Caption = 'MZ Name MM New';
            //FieldClass = FlowField;
            // CalcFormula = lookup(MZ.Description where(Code = field("MZ MM")));
        }
        field(50161; "Customer Stroke New"; Integer)
        {
            Caption = 'Customer Stroke New';
            //Hod


        }
        field(50162; "Customer string New"; Integer)
        {
            Caption = 'Customer string New';
            //niz

        }

        field(50163; "Customer Category New"; enum Category)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Category New';


        }




        /*  field(50061; "Calculation Valide"; Boolean)
          {
              Caption = 'Calculation Valide';

          }*/
        field(50166; "EL Volume Description New"; text[250])
        {
            Caption = 'EL Volume Description New';
        }
        field(50167; "Installation Date New"; Date)
        {
            Caption = 'Installation Date';
            //datum ugradnje koji je bio, a mi ga sad mijenjamo.
        }
        field(50168; "Measuring Point Code New"; code[20])
        {
            Caption = 'Measuring Point Code New';
            TableRelation = "Service Item"."No.";



        }

        field(50169; "Phone No. MM"; Text[250])
        {
            Caption = 'Phone No. MM';
            ExtendedDatatype = PhoneNo;
        }
        field(50170; "Document Date"; Date)
        {
            Caption = 'Document Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Document Date" where("No." = field("Document No.")));
        }


        //kraj

        field(50171; "Type G_R"; Option)
        {
            Caption = 'Type';
            OptionMembers = ,Gauge,Corrector,Radio_Module,Gauge_RM,Corrector_RM;
            OptionCaption = ' ,Gauge,Corrector,Radio_Module,Gauge_Radio_Module,Corrector_RadioModule';

        }
        field(50172; "Request Department"; Code[20])
        {
            Caption = 'Request Department', Comment = 'Org. jedinica pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Department" where("No." = field("Document No.")));

        }
        field(50173; "Request Department Name"; Text[150])
        {
            Caption = 'Request Department Name', Comment = 'Naziv org. jedinice pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Department Name" where("No." = field("Document No.")));
            Editable = false;
        }
        field(50174; "Responsible Department"; Code[20])
        {
            Caption = 'Responsible Department', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Responsible Department" where("No." = field("Document No.")));

        }
        field(50175; "Responsible Department Name"; Text[250])
        {
            Caption = 'Responsible Department Name', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Responsible Department Name" where("No." = field("Document No.")));


        }


        field(70115; "Prep. Process. Empl. Name."; Text[250])
        {
            Caption = 'Preparation - Processing Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Process. Empl. Name." where("No." = field("Document No.")));

        }
        field(70116; "Prep. Contr. Empl. Name"; Text[250])
        {

            Caption = 'Preparation - Controlling Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Contr. Empl. Name" where("No." = field("Document No.")));

        }
        field(70117; "Prep. Verif. Empl. Name"; Text[250])
        {

            Caption = 'Preparation - Verification Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Verif. Empl. Name" where("No." = field("Document No.")));

        }
        field(70118; "Real. Process. Empl. Name"; Text[250])
        {

            Caption = 'Realisation - Processing Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Process. Empl. Name" where("No." = field("Document No.")));

        }
        field(70119; "Real. Contr. Empl. Name"; Text[250])
        {

            Caption = 'Realisation - Controlling Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Contr. Empl. Name" where("No." = field("Document No.")));

        }
        field(70120; "Real. Verif. Empl. Name"; Text[250])
        {

            Caption = 'Realisation - Verification Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Verif. Empl. Name" where("No." = field("Document No.")));

        }
        field(60017; "Prep. Process. Empl. No."; Code[20])
        {

            Caption = 'Preparation - Processing Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Process. Empl. No." where("No." = field("Document No.")));

        }
        field(60018; "Prep. Contr. Empl. No."; Code[20])
        {
            Caption = 'Preparation - Controlling Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Contr. Empl. No." where("No." = field("Document No.")));
        }
        field(60019; "Prep. Verif. Empl. No."; Code[20])
        {

            Caption = 'Preparation - Verification Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Verif. Empl. No." where("No." = field("Document No.")));
        }
        field(60020; "Real. Process. Empl. No."; Code[20])
        {

            Caption = 'Realisation - Processing Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Process. Empl. No." where("No." = field("Document No.")));
        }
        field(60021; "Real. Contr. Empl. No."; Code[20])
        {
            Caption = 'Realisation - Controlling Employee No.';
            TableRelation = Employee;

            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Contr. Empl. No." where("No." = field("Document No.")));

        }
        field(60022; "Real. Verif. Empl. No."; Code[20])
        {
            Caption = 'Realisation - Verification Employee No.';
            TableRelation = Employee;

            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Verif. Empl. No." where("No." = field("Document No.")));
        }
        field(70258; "Done Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Done Date" where("No." = field("Document No.")));
        }

        //da znam da je realizacija završena od ovog radnog naloga, koji je masovni

        field(50177; "Mark"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Mark', Comment = 'Oznaka';
        }

        field(50079; "Gas Station Placement"; Enum "Gas Station Placement")
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Station Placement';
        }



        field(50176; "Applied"; Boolean)
        {
            Caption = 'Applied';



            //kraj
        }

        field(50179; "CZK ID"; Code[20])
        {

            TableRelation = "Service Item Line";
            Editable = false;
            Caption = 'CZK ID';

        }

        field(50178; "Work Order Created"; Boolean)
        {

            Caption = 'Work Order Created';
            FieldClass = FlowField;
            CalcFormula = exist("Service Item Line" where("CZK ID" = field("Document No."), "Service Item No. - Relation" = field("Service Item No. - Relation"), Address = field(Address), "Line No." = field("Line No.")));


        }

        field(50180; "Work Order Applied"; Boolean)
        {
            Caption = 'Work Order Applied';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Item Line".Applied where("CZK ID" = field("Document No."), "Service Item No. - Relation" = field("Service Item No. - Relation"), Address = field(Address), "Line No." = field("Line No.")));


        }
        field(50181; "Corrector Serial Number"; text[250])
        {
            Caption = 'Corrector';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }

        field(60087; "Adjusted Volume"; Decimal)
        {
            Caption = 'Adjusted Volume';
        }

        field(60088; "Unadjusted Volume"; Decimal)
        {
            Caption = 'Unadjusted Volume';
        }

        field(60089; "Absolute Pressure Of Corrector"; Decimal)
        {
            Caption = 'Absolute Pressure Of The Corrector';
        }
        field(60090; "Temperature"; Decimal)
        {
            Caption = 'Temperature';
        }
        field(60091; "Correction Factor"; Decimal)
        {
            Caption = 'Correction Factor';
        }
        field(60092; "Operating Pressure On ML"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Caption = 'Operating Pressure On ML';
        }
        field(60105; "Pressure Type"; enum "Pressure type")
        {
            Caption = 'Pressure Type';
        }


        field(60106; "Pressure Type New"; enum "Pressure type")
        {
            Caption = 'Pressure Type New';
        }




        field(60109; "Temperature Value"; decimal)
        {
            Caption = 'Temperature Value';
        }


        field(60110; "Temperature Value New"; decimal)
        {
            Caption = 'Temperature Value New';
        }

        field(60111; "Adjusted Volume New"; Decimal)
        {
            Caption = 'Adjusted Volume New';
        }

        field(60112; "Unadjusted Volume New"; Decimal)
        {
            Caption = 'Unadjusted Volume New';
        }

        field(60113; "Absolute Pressure Of Corr. New"; Decimal)
        {
            Caption = 'Absolute Pressure Of The Corrector New';
        }
        field(60114; "Temperature New"; Decimal)
        {
            Caption = 'Temperature New';
        }
        field(60115; "Correction Factor New"; Decimal)
        {
            Caption = 'Correction Factor New';
        }
        field(60116; "Operating Pressure On ML New"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Caption = 'Operating Pressure On ML New';
        }
        field(60117; "Allow Deviation"; Boolean)
        {

            Caption = 'Allow Deviation';
        }


        field(50182; "Radio Module Serial I"; text[250])
        {
            Caption = 'Radio Module Serial I';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(50183; "Radio Module Serial II"; text[250])
        {
            Caption = 'Radio Module Serial II';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(50184; "Radio Module Code"; Code[20])
        {
            // RMF.setfilteR("Gauge Code", '%1', rec.Gauge);
            Caption = 'Radio Module Code';
            //"Radio Module".Code where("Gauge Code" = field(gauge), "Measuring Point Code" = field("Service Item No. - Relation"));
            TableRelation = IF ("Radio Module Code" = CONST('')) "Radio Module".Code where("Gauge Code" = field(gauge), "Measuring Point Code" = field("Service Item No. - Relation"))
            ELSE
            IF ("Radio Module Code" = FILTER(<> '')) "Radio Module".Code WHERE(Code = field("Radio Module Code"));

            //  Editable = false;

        }
        field(60076; "Already Transfer"; Boolean)
        {
            Caption = 'Already Transfer';
        }
        field(60077; "Radio Module Code New"; Code[20])
        {
            Caption = 'Radio Module Code';
            //   TableRelation = "Radio Module".Code where("Gauge Code" = field("New Gauges"));

            //  Editable = false;

        }
        field(60078; "Radio Module Serial I New"; text[250])
        {
            Caption = 'Radio Module Serial I New';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(60079; "Radio Module Serial II New"; text[250])
        {
            Caption = 'Radio Module Serial II New';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(60080; "Done Document"; Boolean)
        {
            Caption = 'Done Document';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Realisation Done" where("No." = field("Document No.")));
        }
        field(60081; "Year of Production RM"; Integer)
        {
            Caption = 'Year of Production RM\Corr"';
        }
        field(60082; "Type Radio Module"; enum "Type radio module")
        {
            Caption = 'Type Radio Module';
        }
        field(60084; "Type Radio Module New"; enum "Type radio module")
        {
            Caption = 'Type Radio Module New';
        }
        field(60083; Model; text[250]) { Caption = 'Model'; }
        field(60085; "Model New"; text[250]) { Caption = 'Model new'; }

        field(60086; "Customer Name"; text[250])
        {
            Caption = 'Customer Name';
        }
        field(60094; "Remotely Type"; enum "Remotely Type")
        {
            Caption = 'Remotely Type';

        }
        field(60093; "Remotely"; Boolean)
        {
            Caption = 'Remotely';
        }
        field(60095; "Finishing Date (filter)"; Date)
        {
            Caption = 'Finishing Date (filter)';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Finishing Date" where("No." = field("Document No.")));
        }
        field(60096; "Year of Production RM New"; Integer)
        {
            Caption = 'Year of Production RM New"';
        }
        field(60103; "Year of Production Corr Old"; Integer)
        {
            Caption = 'Year of Production Corr Old"';
        }
        field(60104; "DD calibration Corr Old"; Integer)
        {
            Caption = 'DD calibration Corr Old';
        }
        field(60100; "Corrector Serial Number New"; text[250])

        {
            Caption = 'Corrector Serial Number New';
        }
        field(60102; "Reading New RM"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading New RM';

        }
        field(60101; "Reading New Corrector"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading New Corrector';

        }
        field(60097; "Year of Production Corr New"; Integer)
        {
            Caption = 'Year of Production Corr New"';
        }
        field(60098; "DD calibration Corr New"; Integer)
        {
            Caption = 'DD calibration Corr New';
        }
        field(60099; "Corrector New"; Code[20])
        {
            Caption = 'Corrector New';
            TableRelation = "El. Volume Corr".Code;

            //  Editable = false;

        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Line No.", "Document Type")
        {
        }
        key(Key3; "Document Type", "Document No.", "Service Item No.", "Contract No.", "Contract Line No.")
        {
            MaintainSQLIndex = false;
        }
        key(Key4; "Service Item No.")
        {
        }
        key(Key5; "Document Type", "Document No.", "Response Date", "Response Time")
        {
        }
        key(Key6; "Response Date", "Response Time", Priority)
        {
        }
        key(Key7; "Loaner No.")
        {
        }
        key(Key8; "Document Type", "Document No.", "Starting Date", "Starting Time")
        {
            MaintainSQLIndex = false;
        }
        key(Key9; "Document Type", "Document No.", "Finishing Date", "Finishing Time")
        {
            MaintainSQLIndex = false;
        }
        key(Key10; "Fault Reason Code")
        {
        }
        key(Key11; "Contract No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Service Item No.", Description, "Serial No.")
        {
        }
    }

    trigger OnDelete()
    var
        LoanerEntry: Record "Loaner Entry";
    begin

    end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        Text000: Label 'The %1 allows only one %2 in each %3.';
        Text001: Label 'You cannot insert %1, because %2 is missing in %3 %4.\\You can create a customer by clicking Functions,Create Customer.';
        Text002: Label 'You cannot insert %1, because %2 is missing in %3 %4.';
        Text003: Label 'You have changed one of the fault reporting codes on the %1, but it has not been changed on the existing service lines. You must update the existing service lines manually.';
        Text006: Label 'You cannot delete %1 %2,%3, because %4 %5 has not been received.';
        Text008: Label 'You cannot delete %1 %2,%3, because %4 is attached to it.';
        Text010: Label 'You cannot rename a %1.';
        Text011: Label 'You cannot change the %1 on the %2, because %3 is attached to it.';
        Text012: Label '%1 %2 does not belong to %3 %4.';
        Text016: Label 'You cannot change the %1 field because it is linked to the %2 specified on the line.';
        Text018: Label 'The %1 cannot be greater than the %2 %3.';
        Text019: Label 'The %1 cannot be earlier than the %2.';
        Text020: Label 'The %1 cannot be greater than the %2.';
        Text022: Label 'The %1 cannot be earlier than the %2 %3.';
        Text023: Label 'You cannot change the warranty information because %1 is selected.';
        Text024: Label 'Do you want to activate a warranty for this service item line?';
        Text025: Label 'Do you want to deactivate the warranty for this service item line?';
        Text026: Label 'You cannot reset the %1 field.\You can receive it by clicking Functions, Receive Loaner.';
        Text028: Label 'You cannot change the %1, because it has been lent in connection with %2 %3 %4.\\You can receive it by clicking Functions, Receive Loaner.', Comment = '1%=FIELDCAPTION("Loaner No."); 2%=FORMAT(ServHeader."Document Type"); 3%=ServHeader.FIELDCAPTION("No."); 4%=ServHeader."No.");';
        Text029: Label 'Do you want to lend %1 %2?';
        Text030: Label '%1 %2 has already been lent within %3 %4 %5.', Comment = '1%=TempServItemLine.FIELDCAPTION("Loaner No."); 2%=TempServItemLine."Loaner No."; 3%=FORMAT(ServHeader."Document Type"); 4%=ServHeader.FIELDCAPTION("No."); 5%=ServHeader."No.");';
        ServMgtSetup: Record "Service Mgt. Setup";
        ServOrderAlloc: Record "Service Order Allocation";
        ServItem: Record "Service Item";
        ServContract: Record "Service Contract Header";
        ServLine: Record "Service Line";
        ServItemLine: Record "Service Item Line";
        ServHour: Record "Service Hour";
        ServHour2: Record "Service Hour";
        ServHeader: Record "Service Header";
        ServHeader2: Record "Service Header";
        ServHeader3: Record "Service Header";
        ServCommentLine: Record "Service Comment Line";
        ServItemGr: Record "Service Item Group";
        RepairStatus: Record "Repair Status";
        RepairStatus2: Record "Repair Status";
        Loaner: Record Loaner;
        ServContractLine: Record "Service Contract Line";
        Item: Record Item;
        ServLogMgt: Codeunit ServLogManagement;
        ServOrderAllocMgt: Codeunit ServAllocationManagement;
        ServOrderMgt: Codeunit ServOrderManagement;
        SegManagement: Codeunit SegManagement;
        ServLoanerMgt: Codeunit ServLoanerManagement;
        DimMgt: Codeunit DimensionManagement;
        NoOfRec: Integer;
        TempDay: Integer;
        FirstServItemLine: Boolean;
        TempDate: Date;
        Text033: Label 'A service item line cannot belong to a service contract and to a service price group at the same time.';
        Text035: Label 'The %1 %2 cannot be used in service orders.';
        Text036: Label 'The %1 %2 cannot be used in service quotes.';
        RepairStatusPriority: Integer;
        UseLineNo: Integer;
        Text037: Label 'It is not possible to select %1 because some linked service lines have been posted.';
        LoanerLent: Boolean;
        ServContractExist: Boolean;
        Text038: Label 'Price adjustment on each existing %1 will be cancelled. Continue?';
        Text039: Label 'The update has been interrupted to respect the warning.';
        HideDialogBox: Boolean;
        Text040: Label 'The selected %1 has a different %2 for this %3.\\Do you want to continue?';
        Text041: Label 'You must specify %1 on %2 in the %3 window for the %4 %5.', Comment = '1%=ServHour.FIELDCAPTION("Starting Time"); 2%=ServHour.Day; 3%=Text058=''Service Hours''; %4=ServHour.FIELDCAPTION("Service Contract No.");%5="Contract No.");';
        Text042: Label 'You must specify %1 on %2 in the %3 window.';
        Text043: Label 'You must specify %1 on %2, %3 %4 in the %5 window for the %6 %7.', Comment = '3%=FIELDCAPTION("Starting Date"); 4%=ServHour."Starting Date"; 6%=ServHour.FIELDCAPTION("Service Contract No."); 7%="Contract No.");';
        Text044: Label 'You must specify %1 on %2, %3 %4 in the %5 window.', Comment = '1%=ServHour.FIELDCAPTION("Starting Time"); 2%=ServHour.Day; 3%=ServHour.FIELDCAPTION("Starting Date"); 4%=ServHour."Starting Date"; 5%=Text057=''Default Service Hours'';';
        Text045: Label 'The %1 for this %2 occurs in more than 1 year. Please verify the setting for service hours and the %3 for the %4.';
        Text047: Label 'Service item %1 is included in more than one contract.\\Do you want to assign a contract number to the service order line?';
        Text048: Label 'You cannot change the %1 because it has already been set on the header.';
        Text049: Label 'Contract %1 does not include service item %2.';
        Text050: Label 'Service contract %1 specified on the service order header does not include service item %2.';
        Text051: Label 'You cannot select contract %1 because it is owned by another customer.';
        Text052: Label 'Contract %1 is not signed.';
        Text053: Label 'You cannot change the contract number because some of the service lines have already been posted.';
        Text054: Label 'If you change the contract number, the existing service lines for this order line will be re-created.\Do you want to continue?';
        UseServItemLineAsxRec: Boolean;
        SkipResponseTimeHrsUpdate: Boolean;
        Text055: Label 'You cannot change the %1 because %2 %3 has not been received.', Comment = '2%=FIELDCAPTION("Loaner No."); 3%="Loaner No.";';
        Text056: Label 'One or more service lines of %6 %7 and/or %8 exist for %1, %2 %3, %4 %5. There is a check mark in the %9 field of %10 %11, therefore %10 %11 cannot be applied to service line of %6 %7 and/or %8.\\ Do you want to apply it for other service lines?';
        Text057: Label 'Default Service Hours';
        Text058: Label 'Service Hours';
        Text059: Label 'Default warranty duration is negative. The warranty cannot be activated.';
        Text060: Label 'You may have changed a dimension.\\Do you want to update the lines?';


}

