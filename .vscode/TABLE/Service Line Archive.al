table 50172 "Service Line Archive"
{
    Caption = 'Service Line';
    DrillDownPageID = "Service Line List";
    LookupPageID = "Service Line List";

    fields
    {
        field(1; "Document Type"; Enum "Service Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Service Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Enum "Service Line Type")
        {
            Caption = 'Type';


        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item WHERE(Type = FILTER(Inventory | "Non-Inventory"),
                                                                   Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST(Cost)) "Service Cost";


        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;


        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group";
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;


        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;


        }
        field(18; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;


        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Price';


        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';


        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';


        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;


        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;


        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;


        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-to Item Entry';


        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));


        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

        }
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Editable = false;
            TableRelation = "Customer Price Group";

        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job."No." WHERE("Bill-to Customer No." = FIELD("Bill-to Customer No."));


        }
        field(46; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));


        }
        field(47; "Job Line Type"; Option)
        {
            Caption = 'Job Line Type';
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable';
            OptionMembers = " ",Budget,Billable,"Both Budget and Billable";


        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";


        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;


        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
            Editable = false;

        }
        field(60; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';


        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            Editable = false;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            Editable = false;


        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";


        }
        field(75; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";


        }
        field(77; "VAT Calculation Type"; Enum "Tax Calculation Type")
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            TableRelation = "Service Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                             "Document No." = FIELD("Document No."));
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";


        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';


        }
        field(87; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";


        }
        field(88; "VAT Clause Code"; Code[20])
        {
            Caption = 'VAT Clause Code';
            TableRelation = "VAT Clause";
        }
        field(89; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";


        }
        field(90; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";


        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            Editable = false;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY)';
            Editable = false;
        }
        field(95; "Reserved Quantity"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Source Type" = CONST(5902),
                                                                   "Source Subtype" = FIELD("Document Type"),
                                                                   "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(96; Reserve; Enum "Reserve Method")
        {
            Caption = 'Reserve';


        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Amount';


        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[20])
        {
            Caption = 'VAT Identifier';
            Editable = false;
        }
        field(145; "Pmt. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Pmt. Discount Amount';


        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";


        }
        field(950; "Time Sheet No."; Code[20])
        {
            Caption = 'Time Sheet No.';
            TableRelation = "Time Sheet Header";
        }
        field(951; "Time Sheet Line No."; Integer)
        {
            Caption = 'Time Sheet Line No.';
            TableRelation = "Time Sheet Line"."Line No." WHERE("Time Sheet No." = FIELD("Time Sheet No."));
        }
        field(952; "Time Sheet Date"; Date)
        {
            Caption = 'Time Sheet Date';
            TableRelation = "Time Sheet Detail".Date WHERE("Time Sheet No." = FIELD("Time Sheet No."),
                                                            "Time Sheet Line No." = FIELD("Time Sheet Line No."));
        }
        field(1019; "Job Planning Line No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            BlankZero = true;
            Caption = 'Job Planning Line No.';


        }
        field(1030; "Job Remaining Qty."; Decimal)
        {
            AccessByPermission = TableData Job = R;
            Caption = 'Job Remaining Qty.';
            DecimalPlaces = 0 : 5;


        }
        field(1031; "Job Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Job Remaining Qty. (Base)';
        }
        field(1032; "Job Remaining Total Cost"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Remaining Total Cost';
            Editable = false;
        }
        field(1033; "Job Remaining Total Cost (LCY)"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatType = 1;
            Caption = 'Job Remaining Total Cost (LCY)';
            Editable = false;
        }
        field(1034; "Job Remaining Line Amount"; Decimal)
        {
            AccessByPermission = TableData Job = R;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Remaining Line Amount';
            Editable = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));


        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = IF ("Document Type" = FILTER(Order | Invoice),
                                "Location Code" = FILTER(<> ''),
                                Type = CONST(Item)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                  "Item No." = FIELD("No."),
                                                                                  "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Document Type" = FILTER("Credit Memo"),
                                                                                           "Location Code" = FILTER(<> ''),
                                                                                           Type = CONST(Item)) Bin.Code WHERE("Location Code" = FIELD("Location Code"));


        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned';
            Editable = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            IF (Type = CONST(Resource)) "Resource Unit of Measure".Code WHERE("Resource No." = FIELD("No."))
            ELSE
            "Unit of Measure";


        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;

        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Document No."),
                                                                            "Source Ref. No." = FIELD("Line No."),
                                                                            "Source Type" = CONST(5902),
                                                                            "Source Subtype" = FIELD("Document Type"),
                                                                            "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;


        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";


        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = Exist("Item Substitution" WHERE(Type = CONST(Item),
                                                           "No." = FIELD("No."),
                                                           "Substitute Type" = CONST(Item)));
            Caption = 'Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5709; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Catalog';
            Editable = false;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            ObsoleteReason = 'Product Groups became first level children of Item Categories.';
            ObsoleteState = Removed;
            ObsoleteTag = '15.0';
        }
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Warehouse Shipment Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(5902),
                                                                                         "Source Subtype" = FIELD("Document Type"),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
            Editable = false;
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';

        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';

        }
        field(5792; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Time';


        }
        field(5794; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';


        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";


        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));


        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
        }
        field(5902; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No.";

        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-to Service Entry';
            Editable = false;
        }
        field(5904; "Service Item Line No."; Integer)
        {
            Caption = 'Service Item Line No.';
            TableRelation = "Service Item Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("Document No."));


        }
        field(5905; "Service Item Serial No."; Code[50])
        {
            Caption = 'Service Item Serial No.';


        }
        field(5906; "Service Item Line Description"; Text[100])
        {
            CalcFormula = Lookup("Service Item Line".Description WHERE("Document Type" = FIELD("Document Type"),
                                                                        "Document No." = FIELD("Document No."),
                                                                        "Line No." = FIELD("Service Item Line No.")));
            Caption = 'Service Item Line Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            Editable = false;
            TableRelation = "Service Price Adjustment Group";
        }
        field(5908; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5909; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Editable = false;
        }
        field(5910; "Needed by Date"; Date)
        {
            Caption = 'Needed by Date';


        }
        field(5916; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(5917; "Qty. to Consume"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qty. to Consume';
            DecimalPlaces = 0 : 5;


        }
        field(5918; "Quantity Consumed"; Decimal)
        {
            Caption = 'Quantity Consumed';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5919; "Qty. to Consume (Base)"; Decimal)
        {
            BlankZero = true;
            Caption = 'Qty. to Consume (Base)';
            DecimalPlaces = 0 : 5;


        }
        field(5920; "Qty. Consumed (Base)"; Decimal)
        {
            Caption = 'Qty. Consumed (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5928; "Service Price Group Code"; Code[10])
        {
            Caption = 'Service Price Group Code';
            TableRelation = "Service Price Group";
        }
        field(5929; "Fault Area Code"; Code[10])
        {
            Caption = 'Fault Area Code';
            TableRelation = "Fault Area";


        }
        field(5930; "Symptom Code"; Code[10])
        {
            Caption = 'Symptom Code';
            TableRelation = "Symptom Code";


        }
        field(5931; "Fault Code"; Code[10])
        {
            Caption = 'Fault Code';
            TableRelation = "Fault Code".Code WHERE("Fault Area Code" = FIELD("Fault Area Code"),
                                                     "Symptom Code" = FIELD("Symptom Code"));
        }
        field(5932; "Resolution Code"; Code[10])
        {
            Caption = 'Resolution Code';
            TableRelation = "Resolution Code";
        }
        field(5933; "Exclude Warranty"; Boolean)
        {
            Caption = 'Exclude Warranty';
            Editable = true;

        }
        field(5934; Warranty; Boolean)
        {
            Caption = 'Warranty';
            Editable = false;


        }
        field(5936; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));


        }
        field(5938; "Contract Disc. %"; Decimal)
        {
            Caption = 'Contract Disc. %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;


        }
        field(5939; "Warranty Disc. %"; Decimal)
        {
            Caption = 'Warranty Disc. %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(5965; "Component Line No."; Integer)
        {
            Caption = 'Component Line No.';
        }
        field(5966; "Spare Part Action"; Option)
        {
            Caption = 'Spare Part Action';
            OptionCaption = ' ,Permanent,Temporary,Component Replaced,Component Installed';
            OptionMembers = " ",Permanent,"Temporary","Component Replaced","Component Installed";
        }
        field(5967; "Fault Reason Code"; Code[10])
        {
            Caption = 'Fault Reason Code';
            TableRelation = "Fault Reason Code";


        }
        field(5968; "Replaced Item No."; Code[20])
        {
            Caption = 'Replaced Item No.';
            TableRelation = IF ("Replaced Item Type" = CONST(Item)) Item
            ELSE
            IF ("Replaced Item Type" = CONST("Service Item")) "Service Item";
        }
        field(5969; "Exclude Contract Discount"; Boolean)
        {
            Caption = 'Exclude Contract Discount';
            Editable = true;

        }
        field(5970; "Replaced Item Type"; Enum "Replaced Service Item Component Type")
        {
            Caption = 'Replaced Item Type';
        }
        field(5994; "Price Adjmt. Status"; Option)
        {
            Caption = 'Price Adjmt. Status';
            Editable = false;
            OptionCaption = ' ,Adjusted,Modified';
            OptionMembers = " ",Adjusted,Modified;
        }
        field(5997; "Line Discount Type"; Option)
        {
            Caption = 'Line Discount Type';
            Editable = false;
            OptionCaption = ' ,Warranty Disc.,Contract Disc.,Line Disc.,Manual';
            OptionMembers = " ","Warranty Disc.","Contract Disc.","Line Disc.",Manual;
        }
        field(5999; "Copy Components From"; Option)
        {
            Caption = 'Copy Components From';
            OptionCaption = 'None,Item BOM,Old Service Item,Old Serv.Item w/o Serial No.';
            OptionMembers = "None","Item BOM","Old Service Item","Old Serv.Item w/o Serial No.";
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";


        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";


        }
        field(7300; "Qty. Picked"; Decimal)
        {
            Caption = 'Qty. Picked';
            DecimalPlaces = 0 : 5;
            Editable = false;


        }
        field(7301; "Qty. Picked (Base)"; Decimal)
        {
            Caption = 'Qty. Picked (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(7302; "Completely Picked"; Boolean)
        {
            Caption = 'Completely Picked';
            Editable = false;
        }
        field(7303; "Pick Qty. (Base)"; Decimal)
        {
            Caption = 'Pick Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(50020; "Fixed Asset OS"; code[20])
        {
            Caption = 'Fixed Asset OS';
            TableRelation = "Fixed Asset"."No." where("Gas Station Type" = filter(<> ''));



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

        field(50021; "Fixed Asset Mark"; text[250])
        {
            Caption = 'Fixed Asset Mark';
            Editable = false;


        }



        field(50000; "Request Resource Type"; Enum "Request Resource Type")
        {
            Caption = 'Request Resource Type';
            DataClassification = CustomerContent;
            InitValue = " ";
            //ValuesAllowed = 99, 100, 101, 102, 7;
            ValuesAllowed = 99, 100, 101, 102, 105;

            /*ValuesAllowed = 99, 100, 101, 102, 7, 9;*/


        }
        field(50001; "Resource Connection Type"; enum "Resource Connection Type")
        {
            Caption = 'Resource Connection Type';
            DataClassification = CustomerContent;

        }
        field(50002; "Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource No.';
            TableRelation = if ("Resource Connection Type" = const(Internal)) Employee
            else
            if ("Resource Connection Type" = const(External)) Contact where("Type Relation" = field("Request Resource Type"));


        }
        field(50003; "Resource Name"; Text[100])
        {
            Caption = 'Resource Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "Planned Quantity"; Decimal)
        {
            Caption = 'Planned Quantity';
            DataClassification = CustomerContent;

        }
        field(50005; Intent; Enum Intent)
        {
            Caption = 'Intent';
            DataClassification = CustomerContent;
        }
        field(50006; "Resource Quantity"; Decimal)
        {
            Caption = 'Resource Quantity';
            DataClassification = CustomerContent;

        }
        field(50007; "Education Level"; Enum School)
        {
            Caption = 'Education Level';
        }
        field(50008; "Internal Employees"; Boolean)
        {
            Caption = 'Internal Employees';
        }
        field(50009; "Unit of Measure Code2"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";


        }
        field(50010; "Request Resource Type1"; Enum "Request Resource Type")
        {
            Caption = 'Request Resource Type';
            DataClassification = CustomerContent;
            InitValue = " ";
            ValuesAllowed = 99, 100, 101, 102, 105;
            /* ValuesAllowed = 99, 100, 101, 102, 7, 9; */

        }
        field(50011; "RN Type"; Enum "Service Line Type RN")
        {
            Caption = 'RN Type';


        }
        field(50012; "Quantity RN"; Decimal)
        {
            Caption = 'RN Type';

        }
        field(50013; "Transfer Order"; code[20])
        {
            Caption = 'Transfer Order';
        }
        field(70072; "Request Department"; Code[20])
        {
            Caption = 'Request Department', Comment = 'Org. jedinica pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Department" where("No." = field("Document No.")));

        }
        field(70073; "Request Department Name"; Text[150])
        {
            Caption = 'Request Department Name', Comment = 'Naziv org. jedinice pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Department Name" where("No." = field("Document No.")));
            Editable = false;
        }
        field(60072; "Responsible Department"; Code[20])
        {
            Caption = 'Responsible Department', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Responsible Department" where("No." = field("Document No.")));


        }
        field(60073; "Responsible Department Name"; Text[250])
        {
            Caption = 'Responsible Department Name', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Responsible Department Name" where("No." = field("Document No.")));


        }
        field(60074; "Shiped Quantity"; Decimal)
        {
            Caption = 'Shiped Quantity';
            //otpremljeno, a nije naplaćeno
            FieldClass = FlowField;
            //    CalcFormula = lookup("Posted Whse. Shipment Line".Quantity where("Source No." = field("Transfer Order"), "Line No." = field("Line No.")));
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Sales Header No." = field("Shipment No. Filter"), "Location Code" = field("Location Code"), "Entry Type" = filter(Transfer)));


        }
        field(60075; "Invoiced Quantity"; Decimal)
        {

            Caption = 'Invoiced Quantity';

            //fakturisano

            FieldClass = FlowField;
            //   CalcFormula = lookup("Posted Whse. Shipment Line".Quantity where("Source No." = field("Transfer Order"), "Line No." = field("Line No.")));


            CalcFormula = - sum("Item Ledger Entry"."Invoiced Quantity" where("Item No." = field("No."), "Sales Header No." = field("CZK Request No. Filter"), "Location Code" = field("Location Code"),
            "Entry Type" = filter("Sale")));

        }
        field(60079; "CZK Request No. Filter"; code[20])
        {
            Caption = 'CZK Request No.';
            FieldClass = FlowFilter;

        }
        field(60080; "Shipment No. Filter"; code[20])
        {
            Caption = 'Shipment No. Filter';
            FieldClass = FlowFilter;

        }
        field(60077; "Document Date"; Date)
        {

            Caption = 'Document Date';

            //fakturisano

            FieldClass = FlowField;
            //   CalcFormula = lookup("Posted Whse. Shipment Line".Quantity where("Source No." = field("Transfer Order"), "Line No." = field("Line No.")));

            CalcFormula = lookup("Service Header"."Document Date" where("No." = field("Document No.")));

        }
        field(60076; "Number of leaks detected"; Integer)
        {
            Caption = 'Number of leaks detected"';
        }
        field(60078; "Source Location Code"; Code[20])
        {
            Caption = 'Source Location Code';
            TableRelation = Location;
        }
        field(70273; "Location Name"; Text[250])
        {
            Caption = 'Location Name';
            FieldClass = FlowField;
            //naziv lokacije
            CalcFormula = lookup("Service Item Line".Address where("Document No." = field("Document No."), "Document Type" = field("Document Type")));

        }
        field(70274; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            //naziv lokacije
            CalcFormula = lookup("Service Header".Name where("Customer No." = field("Customer No."), "No." = field("Document No."), "Document Type" = field("Document Type")));

        }
        field(70275; "Connected Quantity"; Decimal)
        {
            Caption = 'Connected Quantity';
            //otpremljeno, a nije naplaćeno
            FieldClass = FlowField;
            //    CalcFormula = lookup("Posted Whse. Shipment Line".Quantity where("Source No." = field("Transfer Order"), "Line No." = field("Line No.")));
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Sales Header No." = field("CZK Connected No. Filter"), "Location Code" = field("Location Code"), "Entry Type" = filter(Transfer)));


        }
        field(70276; "CZK Connected No. Filter"; code[20])
        {
            Caption = 'CZK Connected No. Filter';
            FieldClass = FlowFilter;

        }
        field(70277; "Request Type"; enum "Request Type")
        {
            Caption = 'Request Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Type" where("No." = field("Document No.")));

        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "No.", "Order Date")
        {
        }
        key(Key3; "Service Item No.", Type, "Posting Date")
        {
        }
        key(Key4; "Document Type", "Bill-to Customer No.", "Currency Code", "Document No.")
        {
            SumIndexFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
        key(Key5; "Document Type", "Document No.", "Service Item No.")
        {
        }
        key(Key6; "Document Type", "Document No.", "Service Item Line No.", "Serv. Price Adjmt. Gr. Code")
        {
            SumIndexFields = "Line Amount";
        }
        key(Key7; "Document Type", "Document No.", "Service Item Line No.", Type, "No.")
        {
        }
        key(Key8; Type, "No.", "Variant Code", "Location Code", "Needed by Date", "Document Type", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code")
        {
            SumIndexFields = "Quantity (Base)", "Outstanding Qty. (Base)";
        }
        key(Key9; "Appl.-to Service Entry")
        {
        }
        key(Key10; "Document Type", "Document No.", "Service Item Line No.", "Component Line No.")
        {
        }
        key(Key11; "Fault Reason Code")
        {
        }
        key(Key12; "Document Type", "Customer No.", "Shipment No.", "Document No.")
        {
            SumIndexFields = "Outstanding Amount (LCY)";
        }
        key(Key13; "Document Type", "Document No.", "Location Code")
        {
        }
        key(Key14; "Document Type", "Document No.", Type, "No.")
        {
        }
        key(Key15; "Document No.", "Document Type")
        {
            MaintainSqlIndex = false;
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)", "Line Amount";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Type, "No.", Description, Quantity, "Unit of Measure Code", "Line Amount")
        {
        }
    }

    trigger OnDelete()
    var
        Item: Record Item;
        ServiceLine2: Record "Service Line";
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
        Text000: Label 'You cannot invoice more than %1 units.';
        Text001: Label 'You cannot invoice more than %1 base units.';
        Text002: Label 'You cannot rename a %1.';
        Text003: Label 'must not be less than %1';
        Text004: Label 'You must confirm %1 %2, because %3 is not equal to %4 in %5 %6.';
        Text005: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'Replace Component,New Component,Ignore';
        Text007: Label 'You must select a %1.';
        Text008: Label 'You cannot change the value of the %1 field because the %2 field in the Fault Reason Codes window contains a check mark for the %3 %4.';
        Text009: Label 'You have changed the value of the field %1.\Do you want to continue ?';
        Text010: Label '%1 cannot be less than %2.';
        Text011: Label 'When replacing a %1 the quantity must be 1.';
        ManualReserveQst: Label 'Automatic reservation is not possible.\Do you want to reserve items manually?';
        Text013: Label ' must be 0 when %1 is %2.';
        Text015: Label 'You have already selected %1 %2 for replacement.';
        Text016: Label 'You cannot ship more than %1 units.';
        Text017: Label 'You cannot ship more than %1 base units.';
        Text018: Label '%1 %2 is greater than %3 and was adjusted to %4.';
        CompAlreadyReplacedErr: Label 'The component that you selected has already been replaced in service line %1.', Comment = '%1 = Line No.';
        ServMgtSetup: Record "Service Mgt. Setup";
        ServiceLine: Record "Service Line";
        ServHeader: Record "Service Header";
        ServItem: Record "Service Item";
        ServItemLine: Record "Service Item Line";
        Resource: Record Resource;
        Location: Record Location;
        FaultReasonCode: Record "Fault Reason Code";
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        SKU: Record "Stockkeeping Unit";
        DimMgt: Codeunit DimensionManagement;
        SalesTaxCalculate: Codeunit "Sales Tax Calculate";
        UOMMgt: Codeunit "Unit of Measure Management";
        CatalogItemMgt: Codeunit "Catalog Item Management";
        ReserveServLine: Codeunit "Service Line-Reserve";
        WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";
        ApplicationAreaMgmt: Codeunit "Application Area Mgmt.";
        FieldCausedPriceCalculation: Integer;
        Select: Integer;
        FullAutoReservation: Boolean;
        HideReplacementDialog: Boolean;
        Text022: Label 'The %1 cannot be greater than the %2 set on the %3.';
        Text023: Label 'You must enter a serial number.';
        ReplaceServItemAction: Boolean;
        Text026: Label 'When replacing or creating a service item component you may only enter a whole number into the %1 field.';
        Text027: Label 'The %1 %2 with a check mark in the %3 field cannot be entered if the service line type is other than Item or Resource.';
        Text028: Label 'You cannot consume more than %1 units.';
        Text029: Label 'must be positive';
        Text030: Label 'must be negative';
        Text031: Label 'You must specify %1.';
        Text032: Label 'You cannot consume more than %1 base units.';
        Text033: Label 'The line you are trying to change has the adjusted price.\';
        Text034: Label 'Do you want to continue?';
        Text035: Label 'Warehouse';
        Text036: Label 'Inventory';
        Text037: Label 'You cannot change %1 when %2 is %3 and %4 is positive.';
        Text038: Label 'You cannot change %1 when %2 is %3 and %4 is negative.';
        Text039: Label 'You cannot return more than %1 units for %2 %3.';
        Text040: Label 'You must use form %1 to enter %2, if item tracking is used.';
        Text041: Label 'There were no Resource Lines to split.';
        Text042: Label 'When posting the Applied to Ledger Entry %1 will be opened first';
        HideCostWarning: Boolean;
        HideWarrantyWarning: Boolean;
        Text043: Label 'You cannot change the value of the %1 field manually if %2 for this line is %3.';
        Text044: Label 'Do you want to split the resource line and use it to create resource lines\for the other service items with divided amounts?';
        Text045: Label 'You cannot delete this service line because one or more service entries exist for this line.';
        Text046: Label 'You cannot change the %1 when the %2 has been filled in.';
        Text047: Label '%1 can only be set when %2 is set.';
        Text048: Label '%1 cannot be changed when %2 is set.';
        Text049: Label '%1 is required for %2 = %3.', Comment = 'Example: Inventory put-away is required for Line 50000.';
        WhseRequirementMsg: Label '%1 is required for this line. The entered information may be disregarded by warehouse activities.', Comment = '%1=Document';
        StatusCheckSuspended: Boolean;
        Text051: Label 'You cannot add an item line.';
        Text052: Label 'You cannot change the %1 field because one or more service entries exist for this line.';
        Text053: Label 'You cannot modify the service line because one or more service entries exist for this line.';
        IsCustCrLimitChecked: Boolean;
        LocationChangedMsg: Label 'Item %1 with serial number %2 is stored on location %3. The Location Code field on the service line will be updated.', Comment = '%1 = Item No., %2 = Item serial No., %3 = Location code';
        LineDiscountPctErr: Label 'The value in the Line Discount % field must be between 0 and 100.';

}

