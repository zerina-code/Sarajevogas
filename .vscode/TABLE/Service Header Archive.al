table 50169 "Service Header Archive"
{
    Caption = 'Service Header';
    DataCaptionFields = "No.", Name, Description;
    DrillDownPageID = "Service List";
    LookupPageID = "Service List";
    Permissions = TableData "Loaner Entry" = d,
                  TableData "Service Order Allocation" = rimd;

    fields
    {
        field(1; "Document Type"; Enum "Service Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;


        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';


        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;


        }
        field(5; "Bill-to Name"; Text[100])
        {
            Caption = 'Bill-to Name';
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
        }
        field(7; "Bill-to Address"; Text[100])
        {
            Caption = 'Bill-to Address';
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            TableRelation = IF ("Bill-to Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Bill-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Bill-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code");
            end;


        }
        field(10; "Bill-to Contact"; Text[100])
        {
            Caption = 'Bill-to Contact';
        }
        field(11; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));

        }
        field(13; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
        }
        field(15; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code".City
            ELSE
            IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");
            end;


        }
        field(18; "Ship-to Contact"; Text[100])
        {
            Caption = 'Ship-to Contact';
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Order Date';
            NotBlank = true;


        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';


        }
        field(22; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description';
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";


        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;


        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";


        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;


        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));


        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));


        }
        field(31; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            Editable = false;
            TableRelation = "Customer Posting Group";
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;


        }
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";


        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';

        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';


        }
        field(40; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";


        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;

        }
        field(43; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";


        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("No."),
                                                              Type = CONST(General)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }
        field(52; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';



        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";

        }
        field(62; "Shipping No."; Code[20])
        {
            Caption = 'Shipping No.';
        }

        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
        }
        field(64; "Last Shipping No."; Code[20])
        {
            Caption = 'Last Shipping No.';
            Editable = false;
            TableRelation = "Service Shipment Header";
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Service Invoice Header";
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";


        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";



        }
        field(77; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";



        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(79; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(80; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(81; Address; Text[100])
        {
            Caption = 'Address';

        }
        field(82; "Address 2"; Text[50])
        {
            Caption = 'Address 2';


        }
        field(83; City; Text[30])
        {
            Caption = 'City';
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


        }
        field(84; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = IF ("Bill-to Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Bill-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Bill-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Bill-to City", "Bill-to Post Code", "Bill-to County", "Bill-to Country/Region Code");
            end;

        }
        field(86; "Bill-to County"; Text[30])
        {
            CaptionClass = '5,1,' + "Bill-to Country/Region Code";
            Caption = 'Bill-to County';
        }
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(88; "Post Code"; Code[20])
        {
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


        }
        field(89; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';


        }
        field(90; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";


        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = IF ("Ship-to Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Ship-to Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Ship-to Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            begin
                PostCode.LookupPostCode("Ship-to City", "Ship-to Post Code", "Ship-to County", "Ship-to Country/Region Code");
            end;


        }
        field(92; "Ship-to County"; Text[30])
        {
            CaptionClass = '5,1,' + "Ship-to Country/Region Code";
            Caption = 'Ship-to County';
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(94; "Bal. Account Type"; enum "Payment Balance Account Type")
        {
            Caption = 'Bal. Account Type';
        }
        field(97; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";


        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';


        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;


        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";


        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";


        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";


        }
        field(107; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(108; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";


        }
        field(109; "Shipping No. Series"; Code[20])
        {
            Caption = 'Shipping No. Series';
            TableRelation = "No. Series";


        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";


        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';


        }
        field(116; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";


        }
        field(117; Reserve; Enum "Reserve Method")
        {
            Caption = 'Reserve';
        }
        field(118; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID';


        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

        }
        field(120; Status; Enum "Service Document Status")
        {
            Caption = 'Status';

        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
        }
        field(130; "Release Status"; Option)
        {
            Caption = 'Release Status';
            Editable = false;
            OptionCaption = 'Open,Released to Ship';
            OptionMembers = Open,"Released to Ship";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";




        }
        field(1200; "Direct Debit Mandate ID"; Code[35])
        {
            Caption = 'Direct Debit Mandate ID';
            TableRelation = "SEPA Direct Debit Mandate" WHERE("Customer No." = FIELD("Bill-to Customer No."),
                                                               Closed = CONST(false),
                                                               Blocked = CONST(false));
            DataClassification = SystemMetadata;
        }
        field(5052; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                if "Customer No." <> '' then
                    if Cont.Get("Contact No.") then
                        Cont.SetRange("Company No.", Cont."Company No.")
                    else
                        if ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Customer No.") then
                            Cont.SetRange("Company No.", ContBusinessRelation."Contact No.")
                        else
                            Cont.SetRange("No.", '');

                if "Contact No." <> '' then
                    if Cont.Get("Contact No.") then;
                if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
                    xRec := Rec;
                    Validate("Contact No.", Cont."No.");
                end;
            end;


        }
        field(5053; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
                if "Bill-to Customer No." <> '' then
                    if Cont.Get("Bill-to Contact No.") then
                        Cont.SetRange("Company No.", Cont."Company No.")
                    else
                        if ContBusinessRelation.FindByRelation(ContBusinessRelation."Link to Table"::Customer, "Bill-to Customer No.") then
                            Cont.SetRange("Company No.", ContBusinessRelation."Contact No.")
                        else
                            Cont.SetRange("No.", '');

                if "Bill-to Contact No." <> '' then
                    if Cont.Get("Bill-to Contact No.") then;
                if PAGE.RunModal(0, Cont) = ACTION::LookupOK then begin
                    xRec := Rec;
                    Validate("Bill-to Contact No.", Cont."No.");
                end;
            end;


        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";


        }
        field(5750; "Shipping Advice"; Enum "Sales Header Shipping Advice")
        {
            Caption = 'Shipping Advice';


        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min("Service Line"."Completely Shipped" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "Document No." = FIELD("No."),
                                                                         Type = FILTER(<> " "),
                                                                         "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location.Code;
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Time';


        }
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));


        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5902; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5904; "Service Order Type"; Code[10])
        {
            Caption = 'Service Order Type';
            TableRelation = "Service Order Type";


        }
        field(5905; "Link Service to Service Item"; Boolean)
        {
            Caption = 'Link Service to Service Item';


        }
        field(5907; Priority; Option)
        {
            Caption = 'Priority';
            Editable = false;
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
        }
        field(5911; "Allocated Hours"; Decimal)
        {
            CalcFormula = Sum("Service Order Allocation"."Allocated Hours" WHERE("Document Type" = FIELD("Document Type"),
                                                                                  "Document No." = FIELD("No."),
                                                                                  "Allocation Date" = FIELD("Date Filter"),
                                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                                  Status = FILTER(Active | Finished),
                                                                                  "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Allocated Hours';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5915; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(5916; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;


        }
        field(5917; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            ExtendedDatatype = PhoneNo;
        }
        field(5918; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(5921; "No. of Unallocated Items"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("No."),
                                                           "No. of Active/Finished Allocs" = CONST(0)));
            Caption = 'No. of Unallocated Items';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5923; "Order Time"; Time)
        {
            Caption = 'Order Time';
            NotBlank = true;


        }
        field(5924; "Default Response Time (Hours)"; Decimal)
        {
            Caption = 'Default Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(5925; "Actual Response Time (Hours)"; Decimal)
        {
            Caption = 'Actual Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(5926; "Service Time (Hours)"; Decimal)
        {
            Caption = 'Service Time (Hours)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5927; "Response Date"; Date)
        {
            Caption = 'Response Date';
            Editable = false;
        }
        field(5928; "Response Time"; Time)
        {
            Caption = 'Response Time';
            Editable = false;
        }
        field(5929; "Starting Date"; Date)
        {
            Caption = 'Starting Date';


        }
        field(5930; "Starting Time"; Time)
        {
            Caption = 'Starting Time';


        }
        field(5931; "Finishing Date"; Date)
        {
            Caption = 'Finishing Date';


        }
        field(5932; "Finishing Time"; Time)
        {
            Caption = 'Finishing Time';


        }
        field(5933; "Contract Serv. Hours Exist"; Boolean)
        {
            CalcFormula = Exist("Service Hour" WHERE("Service Contract No." = FIELD("Contract No.")));
            Caption = 'Contract Serv. Hours Exist';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5934; "Reallocation Needed"; Boolean)
        {
            CalcFormula = Exist("Service Order Allocation" WHERE(Status = CONST("Reallocation Needed"),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No."),
                                                                  "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Reallocation Needed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5936; "Notify Customer"; Option)
        {
            Caption = 'Notify Customer';
            OptionCaption = 'No,By Phone 1,By Phone 2,By Fax,By Email';
            OptionMembers = No,"By Phone 1","By Phone 2","By Fax","By Email";
        }
        field(5937; "Max. Labor Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            BlankZero = true;
            Caption = 'Max. Labor Unit Price';


        }
        field(5938; "Warning Status"; Option)
        {
            Caption = 'Warning Status';
            OptionCaption = ' ,First Warning,Second Warning,Third Warning';
            OptionMembers = " ","First Warning","Second Warning","Third Warning";
        }
        field(5939; "No. of Allocations"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No."),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                  "Allocation Date" = FIELD("Date Filter"),
                                                                  Status = FILTER(Active | Finished)));
            Caption = 'No. of Allocations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5940; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
                                                                            "Customer No." = FIELD("Customer No."),
                                                                            "Ship-to Code" = FIELD("Ship-to Code"),
                                                                            "Bill-to Customer No." = FIELD("Bill-to Customer No."));

            trigger OnLookup()
            var
                ServContractHeader: Record "Service Contract Header";
                ServContractList: Page "Service Contract List";
            begin
                if "Contract No." <> '' then
                    if ServContractHeader.Get(ServContractHeader."Contract Type"::Contract, "Contract No.") then
                        ServContractList.SetRecord(ServContractHeader);

                ServContractHeader.Reset();
                ServContractHeader.FilterGroup(2);
                ServContractHeader.SetCurrentKey("Customer No.", "Ship-to Code");
                ServContractHeader.SetRange("Customer No.", "Customer No.");
                ServContractHeader.SetRange("Ship-to Code", "Ship-to Code");
                ServContractHeader.SetRange("Contract Type", ServContractHeader."Contract Type"::Contract);
                ServContractHeader.SetRange("Bill-to Customer No.", "Bill-to Customer No.");
                ServContractHeader.SetRange(Status, ServContractHeader.Status::Signed);
                ServContractHeader.SetFilter("Starting Date", '<=%1', "Order Date");
                ServContractHeader.SetFilter("Expiration Date", '>=%1 | =%2', "Order Date", 0D);
                ServContractHeader.FilterGroup(0);
                Clear(ServContractList);
                ServContractList.SetTableView(ServContractHeader);
                ServContractList.LookupMode(true);
                if ServContractList.RunModal = ACTION::LookupOK then begin
                    ServContractList.GetRecord(ServContractHeader);
                    Validate("Contract No.", ServContractHeader."Contract No.");
                end;
            end;


        }
        field(5951; "Type Filter"; Option)
        {
            Caption = 'Type Filter';
            FieldClass = FlowFilter;
            OptionCaption = ' ,Resource,Item,Service Cost,Service Contract';
            OptionMembers = " ",Resource,Item,"Service Cost","Service Contract";
        }
        field(5952; "Customer Filter"; Code[20])
        {
            Caption = 'Customer Filter';
            FieldClass = FlowFilter;
            TableRelation = Customer."No.";
        }
        field(5953; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(5954; "Contract Filter"; Code[20])
        {
            Caption = 'Contract Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));
        }
        field(5955; "Ship-to Fax No."; Text[30])
        {
            Caption = 'Ship-to Fax No.';
        }
        field(5956; "Ship-to E-Mail"; Text[80])
        {
            Caption = 'Ship-to Email';
            ExtendedDatatype = EMail;


        }
        field(5957; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(5958; "Ship-to Phone"; Text[30])
        {
            Caption = 'Ship-to Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(5959; "Ship-to Phone 2"; Text[30])
        {
            Caption = 'Ship-to Phone 2';
            ExtendedDatatype = PhoneNo;
        }
        field(5966; "Service Zone Filter"; Code[10])
        {
            Caption = 'Service Zone Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Zone".Code;
        }
        field(5968; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            Editable = false;
            TableRelation = "Service Zone".Code;


        }
        field(5981; "Expected Finishing Date"; Date)
        {
            Caption = 'Expected Finishing Date';
        }
        field(7000; "Price Calculation Method"; Enum "Price Calculation Method")
        {
            Caption = 'Price Calculation Method';
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';

        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";


        }
        field(9001; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
        }
        field(5044; "Time Archived"; Time)
        {
            Caption = 'Time Archived';
        }
        field(5045; "Date Archived"; Date)
        {
            Caption = 'Date Archived';
        }
        field(5046; "Archived By"; Code[50])
        {
            Caption = 'Archived By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Service Invoice Line"."Amount Including VAT" WHERE("Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }

        field(500001; "Implementation Time"; Time)
        {

            DataClassification = ToBeClassified;

        }
        field(60000; "Request Type"; Enum "Request Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
        }
        field(60001; "Request Group"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Request Group';
            TableRelation = "Request Group".Description;
        }
        field(60002; "Work Order Type"; enum "Work Order Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Type';
        }
        field(60003; "Remote Reading Device"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Remote Reading Device';
            TableRelation = "Remote Reading Device".Description;
        }
        field(60004; "Chimney Man"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Chimnay Man';
            TableRelation = Contact;
        }
        field(60005; "Pipeline Recording"; enum "Pipeline Recording")
        {
            DataClassification = CustomerContent;
            Caption = 'Pipeline Recording';
        }
        field(60006; Activity; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Activity';
            TableRelation = "Request Activity".Description;
        }
        field(60007; "Activity Type"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Activity Type';
            TableRelation = "Activity Type".Description where("Group request" = field("Request Group"));
        }
        field(60008; "Geo. Activity Type"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Geo. Activity Type';
            TableRelation = "Geo. Activity Type".Description;
        }
        field(60009; "Recording Method"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Recording Method';
        }
        field(60010; "Marking Method"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Marking Method';
        }
        field(60011; "Designer Connection Type"; enum "Resource Connection Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Designer Connection Type';
        }
        field(60012; "Designer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Designer No.';
            TableRelation = if ("Designer Connection Type" = const(Internal)) Employee
            else
            if ("Designer Connection Type" = const(External)) Contact where("Type Relation" = const(Designer));

        }
        field(60013; "Project"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Project';
            TableRelation = "Project".Description;

        }
        field(60014; Grouping; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grouping';
            // TableRelation = Grouping.Description;
        }
        field(60015; "Excavation"; enum "Excavation")
        {
            DataClassification = CustomerContent;
            Caption = 'Excavation';
        }

        field(60016; "Previous Gas"; enum "Previous Gas")
        {
            DataClassification = CustomerContent;
            Caption = 'Previous Gas';
        }
        field(60017; "Prep. Process. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Processing Employee No.';
            TableRelation = Employee;

        }
        field(60018; "Prep. Contr. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Controlling Employee No.';
            TableRelation = Employee;

        }
        field(60019; "Prep. Verif. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Verification Employee No.';
            TableRelation = Employee;

        }
        field(60020; "Real. Process. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee No.';
            TableRelation = Employee;


        }
        field(50198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }


        field(60021; "Real. Contr. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee No.';
            TableRelation = Employee;




        }
        field(60022; "Real. Verif. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee No.';
            TableRelation = Employee;


        }
        field(60023; "Accord No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Accord No.';
            TableRelation = "Service Header"."No." where("Document Type" = const(Order));
        }
        field(60024; "Owner No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Owner No.';
            TableRelation = Contact where("Type Relation" = const(Owner));

        }
        field(60025; "Work Order Requester"; enum "Work Order Requester")
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Requester';
        }
        field(60026; "Designer Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Designer Phone No.';
        }
        field(60027; "Designer Email"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Designer Email';
        }
        field(60028; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(type = filter(Regular));

        }
        field(60029; "Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code"), type = filter(Regular)));
            Editable = false;
        }

        field(60030; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(60031; "MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ")));
            Editable = false;
        }

        field(60032; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;

        }

        field(60033; "Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street")));
            Editable = false;
        }
        field(60034; "Street No."; Code[20])
        {
            Caption = 'Street No.';
            DataClassification = CustomerContent;

        }
        field(60037; "Project. Route"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Project. Route';
        }
        field(60038; "CZK Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'CZK Request No.';
            TableRelation = "Service Header"."No." where("Document Type" = const(Order));

        }
        field(60039; "Request ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Request ID';
            Editable = false;

            //automatski se dodjeljuje Redni broj/godina
        }
        field(60040; "Owner Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Owner Name';
        }
        field(60041; "Owner Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(60042; "Owner Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Owner Municipality Code"), Type = filter(Regular)));
            Editable = false;
        }

        field(60043; "Owner MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(60044; "Owner MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("Owner MZ")));
            Editable = false;
        }

        field(60045; "Owner Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;

        }

        field(60046; "Owner Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Owner Street")));
            Editable = false;
        }
        field(60047; "Owner Street No."; Code[20])
        {
            Caption = 'Street No.';
            DataClassification = CustomerContent;

        }
        field(60048; "Owner Address"; Text[100])
        {
            Caption = 'Owner Address';
            DataClassification = CustomerContent;
        }
        field(60050; "Work Order Due Date"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Due Date', Comment = 'Rok za obradu radnog naloga';
        }
        field(60051; "Work Order Registry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Registry No.', Comment = 'Broj u registratoru';
        }
        field(60052; "Work Order Request No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Request No.', Comment = 'Veza na radni nalog';
            TableRelation = "Service Header"."No." where("Document Type" = const(Order), "Request Type" = const("General Work Order"));
        }
        field(60053; "Work Order Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Request Date', Comment = 'Datum veze radnog naloga';
        }
        field(60054; "Work Order Emergency"; enum "Work Order Emergency")
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Emergency', Comment = 'Hitnost prijave';
        }
        field(60055; "Execution Company No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company No.', Comment = 'Br. izvođača';
            TableRelation = Contact where("Type Relation" = const(Contractor));

        }
        field(60056; "Execution Company Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company Name', Comment = 'Naziv izvođača';
        }
        field(60057; "Execution Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company Address', Comment = 'Sjedište izvođača';
        }
        field(60058; "Execution Company Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Execution Company Phone No.', Comment = 'Br. telefona izvođača';
        }
        field(60059; "Work Execution Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Work Execution Date', Comment = 'Datum izvođenja radova';
        }
        field(60060; "Planned W. Exec. Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Planned Work Exec. Starting Date', Comment = 'Planirani datum početka radova';
        }
        field(60061; "Planned W. Exec. Ending Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Planned Work Exec. Ending Date', Comment = 'Planirani datum završetka radova';
        }
        field(60062; "CZK Date"; Date)
        {
            Caption = 'CZK Date', Comment = 'Datum prijema u CZK';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Document Date" where("No." = field("CZK Request No."), "Document Type" = const(Order)));
            Editable = false;
        }

        field(60063; "Sent to ZIK"; Date)
        {
            Caption = 'Sent to ZIK', Comment = 'Poslano u ZIK';
            // DataClassification = CustomerContent;
            //    FieldClass=FlowField;
            //  CalcFormula=lookup("Service Header"."Sent to ZIK" where ("CZK Request No."=field("CZK Request No."),"Request Type"=filter("General Geo. Work Order Office"),
            //"Sent to ZIK"=filter(<>'')));


        }
        field(60064; "Received from ZIK"; Date)
        {
            Caption = 'Received from ZIK', Comment = 'Preuzeto iz ZIK';
            // DataClassification = CustomerContent;
            //  FieldClass=FlowField;
            //CalcFormula=lookup("Service Header"."Received from ZIK" where ("CZK Request No."=field("CZK Request No."),"Request Type"=filter("General Geo. Work Order Office"),
            //"Received from ZIK"=filter(<>'')));
        }
        field(60065; "Field Work Planned"; Date)
        {
            Caption = 'Field Work Planned', Comment = 'Plan izlaska na teren';
            DataClassification = CustomerContent;
        }
        field(60066; "Excavation Permit"; Boolean)
        {
            Caption = 'Excavation Permit', Comment = 'Dozvola za prokop';
            DataClassification = CustomerContent;
        }
        field(60067; "Legal Property Note"; Text[250])
        {
            Caption = 'Legal Property Note', Comment = 'Rješavanje imovinsko-pravnih odnosa';
            DataClassification = CustomerContent;
        }
        field(60068; "Employee Responsible"; Code[20])
        {
            Caption = 'Employee Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }



        field(60069; "Processing Date"; Date)
        {
            Caption = 'Processing Date', Comment = 'Datum obrade';
            DataClassification = CustomerContent;
        }
        field(60070; "Request File"; Blob)
        {
            Caption = 'Request File', Comment = 'Datoteka zahtjeva';
            DataClassification = CustomerContent;
        }
        field(60071; "Request File Name"; Text[100])
        {
            Caption = 'Request File Name', Comment = 'Naziv priložene datoteke';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60072; "Responsible Department"; Code[20])
        {
            Caption = 'Responsible Department', Comment = 'Odgovorna org. jedinica';
            DataClassification = CustomerContent;
            TableRelation = Department.Code;

        }
        field(60073; "IKP Realisation"; Integer)
        {
            Caption = 'IKP Realisation', Comment = 'Realizacija IKP';
            DataClassification = CustomerContent;
        }
        field(60074; Deadline; Integer)
        {
            Caption = 'Deadline', Comment = 'Rok dana';
            DataClassification = CustomerContent;
        }
        field(60075; "Realisation in Days"; Integer)
        {
            Caption = 'Realisation in Days', Comment = 'Broj dana realizacije';
            DataClassification = CustomerContent;
        }
        field(60076; Dued; Integer)
        {
            Caption = 'Dued', Comment = 'Zaduženo';
            DataClassification = CustomerContent;
        }
        field(60077; Realized; Integer)
        {
            Caption = 'Realized', Comment = 'Realizovano';
            DataClassification = CustomerContent;
        }
        field(60078; "Realisation Date"; Date)
        {
            Caption = 'Realization Date', Comment = 'Datum realizacije';
            DataClassification = CustomerContent;
        }
        field(60079; "ID Network"; Text[250])
        {
            Caption = 'ID Network', Comment = 'ID mreža';
            DataClassification = CustomerContent;
        }
        field(60080; "ID Vertical"; Text[250])
        {
            Caption = 'ID Vertical', Comment = 'ID vertikala';
            DataClassification = CustomerContent;
        }
        field(60081; "Recording/Marking Finished"; Boolean)
        {
            Caption = 'Finished', Comment = 'Završeno';
            DataClassification = CustomerContent;
        }
        field(60082; "DGM Total Length"; Decimal)
        {
            Caption = 'DGM Total Length', Comment = 'Ukupna dužina DGM';
            DataClassification = CustomerContent;
        }
        field(60083; "PG Total Length"; Decimal)
        {
            Caption = 'PG Total Length', Comment = 'Ukupna dužina PG';
            DataClassification = CustomerContent;
        }
        field(60084; "No. of Connections"; Integer)
        {
            Caption = 'No. of Connections', Comment = 'Broj priključaka';
            DataClassification = CustomerContent;
        }
        field(60085; "No. of Objects"; Integer)
        {
            Caption = 'No. of Objects', Comment = 'Broj objekata';
            DataClassification = CustomerContent;
        }
        field(60086; "No. of Cutting"; Integer)
        {
            Caption = 'No. of Cutting', Comment = 'Broj šlicanja';
            DataClassification = CustomerContent;
        }
        field(60087; "Rec/Marking Fully Finished"; Boolean)
        {
            Caption = 'Fully Finished', Comment = 'Završeno u cijelosti';
            DataClassification = CustomerContent;
        }
        field(60088; "Rec/Marking Start Date"; DateTime)
        {
            Caption = 'Start Date', Comment = 'Vrijeme početka';
            DataClassification = CustomerContent;
        }
        field(60089; "Rec/Marking End Date"; DateTime)
        {
            Caption = 'End Date', Comment = 'Vrijeme završetka';
            DataClassification = CustomerContent;
        }
        field(60090; "EU Activity"; text[250])
        {
            Caption = 'EU Activity';
            TableRelation = "MM Activity".Description where(Type = const(EU));
            DataClassification = CustomerContent;
        }
        field(60091; "Designer Name"; Text[100])
        {
            Caption = 'Designer Name';
            DataClassification = CustomerContent;
        }
        field(60092; Heating; Boolean)
        {
            Caption = 'Heating';
            DataClassification = CustomerContent;
        }
        field(60093; "Request Due Date"; Date)
        {
            Caption = 'Request Due Date';
            DataClassification = CustomerContent;
        }
        field(60094; "Last DateTime Modified"; DateTime)
        {
            Caption = 'Last DateTime Modified', Comment = 'Vrijeme zadnje izmjene';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60095; "Last Modified by User"; Code[50])
        {
            Caption = 'Last Modified by User', Comment = 'Korisnik zadnje izmjene';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70028; "Municipality Code 2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));

        }
        field(70029; "Municipality Name 2"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code 2"), Type = filter(Regular)));
            Editable = false;
        }

        field(70030; "MZ 2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(70031; "MZ Name 2"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ 2")));
            Editable = false;
        }

        field(70032; "Street 2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;

        }

        field(70033; "Street Name 2"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street 2")));
            Editable = false;
        }
        field(70034; "Street No. 2"; Code[20])
        {
            Caption = 'Street No.';
            DataClassification = CustomerContent;

        }
        field(70035; "City 2"; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(70036; "Post Code 2"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
        }
        field(70037; "Stroke No."; Integer)
        {
            Caption = 'Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70038; "Customer String"; Integer)
        {
            Caption = 'Customer String';
            DataClassification = CustomerContent;
        }
        field(70039; "Zone Stroke No."; Integer)
        {
            Caption = 'Zone Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70040; "Stroke No. 2"; Integer)
        {
            Caption = 'Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70041; "Customer String 2"; Integer)
        {
            Caption = 'Customer String';
            DataClassification = CustomerContent;
        }
        field(70042; "Zone Stroke No. 2"; Integer)
        {
            Caption = 'Zone Stroke No.';
            DataClassification = CustomerContent;
        }
        field(70043; "Floor 2"; Code[20])
        {
            Caption = 'Floor';
            DataClassification = CustomerContent;
        }
        field(70044; "Apartment No. 2"; Code[5])
        {
            Caption = 'Apartment No.';
            DataClassification = CustomerContent;
        }
        field(70045; "Customer Category"; Enum Category)
        {
            Caption = 'Customer Category';
            DataClassification = CustomerContent;
        }

        field(70047; "Responsible Department Name"; Text[150])
        {
            Caption = 'Responsible Department Name';
            //  FieldClass = FlowField;
            //   CalcFormula = lookup(Department.Description where(Code = field("Responsible Department")));
            Editable = false;
        }
        field(70048; "Area Dimension"; Text[80])
        {
            Caption = 'Area Dimension', Comment = 'Površina';
            DataClassification = CustomerContent;
        }
        field(70050; "kW Power"; Decimal)
        {
            Caption = 'kW Power';
            DataClassification = CustomerContent;
        }
        field(70051; "Land"; Text[80])
        {
            Caption = 'Land', Comment = 'Parcela';
            DataClassification = CustomerContent;
        }
        field(70052; "Proforma Paid"; Boolean)
        {
            Caption = 'Proforma Paid', Comment = 'Plaćeno po profakturi';
            DataClassification = CustomerContent;
        }
        field(70938; "Advance Created"; Boolean)
        {
            Caption = 'Advance Created', Comment = 'Kreiran avans';
            DataClassification = CustomerContent;
        }
         field(70941; "Credit Memo Created"; Boolean)
        {
            Caption = 'Credit Memo Created', Comment = 'Kreiran storno avansa';
            DataClassification = CustomerContent;
        }
          field(70939; "Advance No."; Code[20])
        {
            Caption = 'Advance No.', Comment = 'Avans kreiran za ovu fakturu';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Invoice Header"."No." where("CZK Request" = field("No."), Prepayment = filter(true)));
        }

        field(70940; "Credit M.Advance No."; Code[20])
        {
            Caption = 'Sales Cr.Memo Header Advance', Comment = 'Storno avansa za ovu fakturu';
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Cr.Memo Header"."No." where("CZK Request" = field("No."), Prepayment = filter(true)));
        }

        field(70053; "SGPO Date Fire Protection"; Date)
        {
            Caption = 'SGPO Date Fire Protection', Comment = 'Dostavljeno SGPO na stručno mišljenje - protivpožarna zaštita';
            DataClassification = CustomerContent;
        }
        field(70054; "SGPO Date El. Installation"; Date)
        {
            Caption = 'SGPO Date El. Installation', Comment = 'Dostavljeno SGPO na stručno mišljenje - el. instalacija';
        }

        field(70056; "Pickup Date"; Date)
        {
            Caption = 'Pickup Date', Comment = 'Datum preuzimanja';
            DataClassification = CustomerContent;
        }
        field(70057; "No. of Project Accordances"; Integer)
        {
            Caption = 'No. of Project Accordances', Comment = 'Broj saglanosti na projekat';
            DataClassification = CustomerContent;
        }
        field(70058; "No. of El. Accord. per Project"; Integer)
        {
            Caption = 'No. of El. Accord. per Project', Comment = 'Broj el. saglasnosti po projektu';
            DataClassification = CustomerContent;
        }
        field(70059; "Firefight Accordance"; Text[250])
        {
            Caption = 'Firefight Accordance', Comment = 'Protipožarna saglasnost';
            DataClassification = CustomerContent;
        }
        field(70060; "El. Accordance Date"; Date)
        {
            Caption = 'El. Accordance Date', Comment = 'Datum el. energetske saglasnosti';
            DataClassification = CustomerContent;
        }
        field(70061; "Project Accordance Date"; Date)
        {
            Caption = 'Project Accordance Date', Comment = 'Datum saglasnosti na projekat';
            DataClassification = CustomerContent;
        }
        field(70062; "UGI Project Name"; Text[250])
        {
            Caption = 'UGI Project Name', Comment = 'Naziv projekta UGI';
            DataClassification = CustomerContent;
            TableRelation = Project.Description;

        }
        field(70063; "Service Line Diameter"; Text[250])
        {
            Caption = 'Service Line Diameter', Comment = 'Prečnik servisnog voda';
            DataClassification = CustomerContent;



        }

        field(70064; "DGM Diameter"; Decimal)
        {
            Caption = 'DGM Diameter', Comment = 'Prečnik DGM';
            DataClassification = CustomerContent;
        }
        field(70065; "G Gauge Size"; Text[250])
        {
            Caption = 'G Gauge Size', Comment = 'Veličina G mjerača';
            DataClassification = CustomerContent;
            //  TableRelation = "Types Of Diseases" where(Types = filter("Gauge size"));
        }
        field(70066; "Measure Point Pressure"; Text[250])
        {
            Caption = 'Measure Point Pressure', Comment = 'Pritisak na mjestu mjerenja';
            DataClassification = CustomerContent;
        }
        field(70067; "Design Company"; Text[250])
        {
            Caption = 'Design Company', Comment = 'Projektantska firma';
            DataClassification = CustomerContent;
            // TableRelation = Contact.Name where("Type Relation" = filter(Designer));
        }
        field(70068; "UGI Project Creation Date"; Date)
        {
            Caption = 'UGI Project Creation Date', Comment = 'Datum izrade UGI projekta';
        }
        field(70069; "Information Number"; Code[20])
        {
            Caption = 'Information Number', Comment = 'Broj infromacije';
            DataClassification = CustomerContent;
            //TableRelation = "Temp Service Header"."No." where("Customer No." = field("Customer No."), "Request Type" = filter("Information on Connection"));




        }
        field(70070; "Project Accordance"; Text[250])
        {
            Caption = 'Project Accordance', Comment = 'Saglanost na projekat nadležne institucije';
            DataClassification = CustomerContent;
        }
        field(70071; "Chimney Expert Opinion"; Text[250])
        {
            Caption = 'Chimney Expert Opinion', Comment = 'Stručni nalaz dimnjačara';
            DataClassification = CustomerContent;
        }
        field(70072; "Request Department"; Code[20])
        {
            Caption = 'Request Department', Comment = 'Org. jedinica pošiljaoca';
            DataClassification = CustomerContent;
            TableRelation = Department.Code;


        }
        field(70073; "Request Department Name"; Text[150])
        {
            Caption = 'Request Department Name', Comment = 'Naziv org. jedinice pošiljaoca';
            //  FieldClass = FlowField;
            //  CalcFormula = lookup(Department.Description where(Code = field("Request Department")));
            Editable = false;
        }
        field(70074; "PPZ for Building"; Boolean)
        {
            Caption = 'PPZ for Building', Comment = 'PPZ za zgradu';
            DataClassification = CustomerContent;
        }
        field(70075; "G Size"; Text[250])
        {
            Caption = 'G Size', Comment = 'Veličina G';
            DataClassification = CustomerContent;
        }
        field(70076; "Vertical"; Text[250])
        {
            Caption = 'Vertical', Comment = 'Vertikala';
            DataClassification = CustomerContent;
        }
        field(70077; "Responsible Contact"; Text[250])
        {
            Caption = 'Responsible Contact', Comment = 'Odgovorno lice';
            DataClassification = CustomerContent;
        }
        field(70078; "Welder"; Code[20])
        {
            Caption = 'Welder', Comment = 'Zavarivač';
            DataClassification = CustomerContent;
            TableRelation = Contact where("Type Relation" = const(Welder));
        }
        field(70079; "Welder Name"; Text[100])
        {
            Caption = 'Welder Name', Comment = 'Ime zavarivača';
            FieldClass = FlowField;
            CalcFormula = lookup(Contact.Name where("No." = field(Welder)));
            Editable = false;
        }
        field(70080; "Press Conn. Tool"; Text[250])
        {
            Caption = 'Press Conn. Tool', Comment = 'Alat za pres spoj';
            DataClassification = CustomerContent;
        }
        field(70081; "Execution Protocol No."; text[20])
        {
            Caption = 'Execution Protocol No.', Comment = 'Broj protokola izvođača';
            DataClassification = CustomerContent;
        }
        field(70082; "According to Legislation"; Text[250])
        {
            Caption = 'According to Legislation', Comment = 'U skladu s propisima';
            DataClassification = CustomerContent;
        }
        field(70083; "Welder Atest"; Boolean)
        {
            Caption = 'Welder Atest', Comment = 'Atest varioca';
            DataClassification = CustomerContent;
        }
        field(70085; "Request Sent to Sarajevogas"; Boolean)
        {
            Caption = 'Request Sent to Sarajevogas', Comment = 'Zahtjev upućen Sarajevogasu';
            DataClassification = CustomerContent;
        }
        field(70086; "Request Sent to VIK"; Boolean)
        {
            Caption = 'Request Sent to VIK', Comment = 'Zahtjev upućen VIK';
            DataClassification = CustomerContent;
        }
        field(70087; "Request Sent to Toplane"; Boolean)
        {
            Caption = 'Request Sent to Toplane', Comment = 'Zahtjev upućen Toplane';
            DataClassification = CustomerContent;
        }
        field(70088; "Request Sent to RAD"; Boolean)
        {
            Caption = 'Request Sent to RAD', Comment = 'Zahtjev upućen RAD';
            DataClassification = CustomerContent;
        }
        field(70089; Classification; Text[50])
        {
            Caption = 'Classification', Comment = 'Klasifikacija';
            DataClassification = CustomerContent;
        }
        field(70090; "Registry No."; Text[10])
        {
            Caption = 'Registry No.', Comment = 'R. br. u registratoru';
            DataClassification = CustomerContent;
        }
        field(70091; "Entry Person"; Text[250])
        {
            Caption = 'Entry Person', Comment = 'Referent unosa';
            DataClassification = CustomerContent;
        }
        field(70092; "Change Person"; Text[250])
        {
            Caption = 'Change Person', Comment = 'Referent izmjene';
            DataClassification = CustomerContent;
        }
        field(70093; Number; Integer)
        {
            Caption = 'Number';
            DataClassification = CustomerContent;
        }
        field(70094; GeoID; Integer)
        {
            Caption = 'GeoID', Locked = true;
            DataClassification = CustomerContent;
        }
        field(70095; "Registry Code"; Text[10])
        {
            Caption = 'Registry Code', Comment = 'Registrator';
            DataClassification = CustomerContent;
        }
        field(70096; "Archive Date"; Date)
        {
            Caption = 'Archive Date', Comment = 'Datum arhive';
            DataClassification = CustomerContent;
        }
        field(70097; "Entry Date"; Date)
        {
            Caption = 'Entry Date', Comment = 'Datum unosa';
            DataClassification = CustomerContent;
        }
        field(70098; "Change Date"; Date)
        {
            Caption = 'Change Date', Comment = 'Datum izmjene';
            DataClassification = CustomerContent;
        }
        field(70099; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";

        }
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }
        field(70100; "Add Description"; Text[250]) //ED
        {
            Caption = 'Add Description';

        }


        field(70101; "Registration No."; Text[20]) //ED
        {
            Caption = 'Add Description';

        }
        field(70102; "Status_request"; enum "Information of processing") //ED
        {
            Caption = 'Status request';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History 2"."Information of processing" where("Request No." = field("No."), Active = filter(true), "Source Table" = filter(5900), "Request Type" = field("Request Type")));


        }


        field(70103; "Contractor No"; Text[250])
        {
            Caption = 'Contractor';
        }
        field(70104; "Project Date"; Date)
        {
            Caption = 'Project Date';
        }
        field(70105; "Service Header UGI"; code[20])
        {
            Caption = 'Service Header UGI';
            TableRelation = "Service Header"."No." where("Customer No." = field("Customer No."), "Request Type" = filter("Project overview Request" | "Project and Energy Accordance"));

        }

        field(70106; "Service Date UGI"; Date)
        {
            Caption = 'Service Date UGI';

        }
        field(70107; "UGI type"; enum UGI)
        {
            Caption = 'UGI Type';
        }
        field(70108; "Owner is Customer"; Boolean)
        {
            Caption = 'Owner is customer';

        }

        field(70109; "Execution Protocol No. Text"; Text[250])
        {
            Caption = 'Execution Protocol No.', Comment = 'Broj protokola izvođača';
            DataClassification = CustomerContent;
        }

        field(70110; "No. for Execution"; Code[20])
        {
            Caption = 'No. for Execution';


        }
        field(70111; "Date for Execution"; Date)
        {
            Caption = 'No. for Execution';

        }

        field(70112; "First view No."; Code[20])
        {
            Caption = 'First view No.';

        }
        field(70113; "First view date"; Date)
        {
            Caption = 'First view date';

        }

        //ĐK 

        field(70115; "Prep. Process. Empl. Name."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Processing Employee Name';

        }
        field(70116; "Prep. Contr. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Controlling Employee Name';

        }
        field(70117; "Prep. Verif. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Preparation - Verification Employee Name';

        }
        field(70118; "Real. Process. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee Name';

        }
        field(70119; "Real. Contr. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee Name';

        }
        field(70120; "Real. Verif. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee Name';

        }
        field(70121; "Firefight Accordance No."; Text[250])
        {
            Caption = 'Firefight Accordance No.', Comment = 'Protipožarna saglasnost broj';
            DataClassification = CustomerContent;
        }
        field(70122; "Measuring Area 1"; Decimal)
        {
            Caption = 'Measuring Area 1';
            DecimalPlaces = 1 : 3;
        }
        field(70123; "Measuring Area 2"; Decimal)
        {
            Caption = 'Measuring Area 2';
        }
        field(70124; "Document No."; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("A-B Attachments" where(Code = field("No."), Source = filter("Service Order"), Type = filter("Service Order")));


        }
        field(70125; "Catastral Municipality"; Code[20])
        {
            Caption = 'Catastral Municipality';
            TableRelation = Municipality.Code where(Type = filter(KO));

        }
        field(70126; "Catastral Municipality Name"; Text[250])
        {
            Caption = 'Catastral Municipality';
            Editable = false;
            //   FieldClass = FlowField;
            // CalcFormula = lookup(Municipality.Name where(Type = filter(KO), Code = field("Catastral Municipality")));
            // TableRelation = Municipality.Code where(Type = filter(KO));
        }
        field(70127; "Connection to"; Option)
        {
            Caption = 'Connection to';
            OptionMembers = " ","Distribution gas line","Service gas line";
            OptionCaption = ' ,Distribution gas line,Service gas line';
        }

        field(70128; "Archived"; Boolean)
        {
            Caption = 'Archived';


        }

        field(70130; "GEO WorkPlaces"; Text[250])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = "GEO WorkPlace".Description;

        }
        field(70132; "GEO WorkPlaces Code"; code[20])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = "GEO WorkPlace".Code;


        }

        field(70133; "Marking Finished"; Boolean)
        {
            Caption = 'Finished', Comment = 'Završeno';
            DataClassification = CustomerContent;
        }
        field(70134; "Mark Method"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Marking Method';
        }
        field(70135; "Mark DGM Total Length"; Decimal)
        {
            Caption = 'DGM Total Length', Comment = 'Ukupna dužina DGM';
            DataClassification = CustomerContent;
        }
        field(70136; "Mark PG Total Length"; Decimal)
        {
            Caption = 'PG Total Length', Comment = 'Ukupna dužina PG';
            DataClassification = CustomerContent;
        }


        field(70137; "Marking Fully Finished"; Boolean)
        {
            Caption = 'Fully Finished', Comment = 'Završeno u cijelosti';
            DataClassification = CustomerContent;
        }
        field(70138; "Marking Start Date"; DateTime)
        {
            Caption = 'Start Date', Comment = 'Vrijeme početka';
            DataClassification = CustomerContent;
        }
        field(70139; "Marking End Date"; DateTime)
        {
            Caption = 'End Date', Comment = 'Vrijeme završetka';
            DataClassification = CustomerContent;
        }
        field(70140; "Mark No. of Connections"; Integer)
        {
            Caption = 'No. of Connections', Comment = 'Broj priključaka';
            DataClassification = CustomerContent;
        }

        field(70141; "Class"; Option)
        {
            Caption = 'Class';
            OptionMembers = " ","T","T E-um","T E-ins","K";
            OptionCaption = ' ,T,T E-um,T E-ins,K';
        }

        //obilježavanje
        field(70142; "Marking Done"; Boolean)
        {
            Caption = 'Finished', Comment = 'Završeno';
            DataClassification = CustomerContent;
        }
        field(70143; "Marking Method 2"; enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Marking Method';
        }
        field(70144; "Marking DGM Total Length"; Decimal)
        {
            Caption = 'DGM Total Length', Comment = 'Ukupna dužina DGM';
            DataClassification = CustomerContent;
        }
        field(70145; "Marking PG Total Length"; Decimal)
        {
            Caption = 'PG Total Length', Comment = 'Ukupna dužina PG';
            DataClassification = CustomerContent;
        }


        field(70146; "Marking Fully Done"; Boolean)
        {
            Caption = 'Fully Finished', Comment = 'Završeno u cijelosti';
            DataClassification = CustomerContent;
        }
        field(70147; "Marking Start Date - 2"; DateTime)
        {
            Caption = 'Start Date', Comment = 'Vrijeme početka';
            DataClassification = CustomerContent;
        }
        field(70148; "Marking End Date 2"; DateTime)
        {
            Caption = 'End Date', Comment = 'Vrijeme završetka';
            DataClassification = CustomerContent;
        }
        field(70149; "Marking No. of Connections"; Integer)
        {
            Caption = 'No. of Connections', Comment = 'Broj priključaka';
            DataClassification = CustomerContent;
        }
        field(70150; "Spray"; Integer)
        {
            Caption = 'Spray';
        }
        field(70151; "Harpoon"; Integer)
        {
            Caption = 'Harpoon';
        }
        field(70152; "Bolcna"; Integer)
        {
            Caption = 'Bolcna';
        }
        field(70153; "Palette"; Integer)
        {
            Caption = 'Palette';
        }

        //korištena oprema
        field(70154; "Trimble M3"; boolean)
        {
            caption = 'Trimble M3';
        }
        field(70155; "Sokkia SET2030"; boolean)
        {
            Caption = 'Sokkia SET2030';
        }
        field(70156; "Zeiss REC ELTA 15"; Boolean)
        {
            Caption = 'Zeiss REC ELTA 15';
        }
        field(70157; "GPS L1 - Promark 3"; Boolean)
        {
            Caption = 'GPS L1 - Promark 3';
        }
        field(70158; "GPS - Others"; Boolean)
        {
            Caption = 'GPS - others';
        }
        field(70159; "GPS TRIMBLE R8S"; Boolean)
        {
            Caption = 'GPS TRIMBLE R8S';
        }
        field(70160; "TRIMBLE C5"; Boolean)
        {
            Caption = 'Trimble C5';
        }
        field(70161; "Sokkia 5 m"; Boolean)
        {
            Caption = 'Sokkia 5 m';
        }
        field(70162; "Sokkia 3.8 m"; Boolean)
        {
            Caption = 'Sokkia 3.8 m';
        }
        field(70163; "Sokkia 2.7 m"; Boolean)
        {
            Caption = 'Sokkia 2.7 m';
        }
        field(70164; "Wild 2.15 m"; Boolean)
        {
            Caption = 'Wild 2.15 m';
        }
        field(70165; "Sokkia 1x"; Boolean)
        {
            Caption = 'Sokkia 1x';
        }
        field(70166; "Zeiss 3x"; Boolean)
        {
            Caption = 'Zeiss 3x';
        }
        field(70177; "Zeiss 1x"; Boolean)
        {
            Caption = 'Zeiss 1x';
        }
        field(70178; "Wild 1x"; Boolean)
        {
            Caption = 'Wild 1x';
        }
        field(70179; "50 m"; Boolean)
        {
            caption = '50 m';
        }
        field(70180; "30 m"; Boolean)
        {
            Caption = '30 m';
        }
        field(70181; "20 m"; Boolean)
        {
            Caption = '20 m';
        }
        field(70182; "Leica Disto"; Boolean)
        {
            Caption = 'Leica Disto';
        }
        field(70183; "Accessories for Centering"; Boolean)
        {
            Caption = 'Accessories for forced Centering';
        }

        field(70184; "Spray -R"; Integer)
        {
            Caption = 'Spray';
        }
        field(70185; "Harpoon -R"; Integer)
        {
            Caption = 'Harpoon';
        }
        field(70186; "Bolcna -R"; Integer)
        {
            Caption = 'Bolcna';
        }
        field(70187; "Palette -R"; Integer)
        {
            Caption = 'Palette';
        }

        field(70188; "Trimble M3 -R"; boolean)
        {
            caption = 'Trimble M3';
        }
        field(70189; "Sokkia SET2030 -R"; boolean)
        {
            Caption = 'Sokkia SET2030';
        }
        field(70190; "Zeiss REC ELTA 15 -R"; Boolean)
        {
            Caption = 'Zeiss REC ELTA 15';
        }
        field(70191; "GPS L1 - Promark 3 -R"; Boolean)
        {
            Caption = 'GPS L1 - Promark 3';
        }
        field(70192; "GPS - Others - R"; Boolean)
        {
            Caption = 'GPS - others';
        }
        field(70193; "GPS TRIMBLE R8S -R"; Boolean)
        {
            Caption = 'GPS TRIMBLE R8S';
        }
        field(70194; "TRIMBLE C5 -R"; Boolean)
        {
            Caption = 'Trimble C5';
        }
        field(70195; "Sokkia 5 m -R"; Boolean)
        {
            Caption = 'Sokkia 5 m';
        }
        field(70196; "Sokkia 3.8 m -R"; Boolean)
        {
            Caption = 'Sokkia 3.8 m';
        }
        field(70197; "Sokkia 2.7 m -R"; Boolean)
        {
            Caption = 'Sokkia 2.7 m';
        }
        field(70198; "Wild 2.15 m -R"; Boolean)
        {
            Caption = 'Wild 2.15 m';
        }
        field(70199; "Sokkia 1x-R"; Boolean)
        {
            Caption = 'Sokkia 1x';
        }
        field(70200; "Zeiss 3x -R"; Boolean)
        {
            Caption = 'Zeiss 3x';
        }
        field(70201; "Zeiss 1x-R"; Boolean)
        {
            Caption = 'Zeiss 1x';
        }
        field(70202; "Wild 1x-R"; Boolean)
        {
            Caption = 'Wild 1x';
        }
        field(70203; "50 m-R"; Boolean)
        {
            caption = '50 m';
        }
        field(70204; "30 m-R"; Boolean)
        {
            Caption = '30 m';
        }
        field(70205; "20 m-R"; Boolean)
        {
            Caption = '20 m';
        }
        field(70206; "Leica Disto-R"; Boolean)
        {
            Caption = 'Leica Disto';
        }
        field(70207; "Accessories for Centering-R"; Boolean)
        {
            Caption = 'Accessories for forced Centering';
        }
        field(70208; "Reason For Service Order"; Text[250])
        {
            Caption = 'Reason For Service Order';
            TableRelation = "Dismantling Reason".Description where(type = filter("Reason for Service Order"));
        }
        field(70209; "Remark For Service Order"; Text[250])
        {
            Caption = 'Remark For Service Order';

        }
        field(70210; "Supervisory Board"; text[250])
        {
            Caption = 'Supervisory Board';
        }
        field(70211; "Holder of works"; text[250])
        {
            Caption = 'Holder of works';
            TableRelation = Department.Description;

            TestTableRelation = false;
            ValidateTableRelation = false;

        }
        field(70212; "RN Source"; enum "RN Source")
        {
            Caption = 'RN Source';
        }
        field(70213; "Investor Code"; Code[20])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = Contact."No." where("Type Relation" = filter(Investor));

        }

        field(70214; "Investor Name"; Text[250])
        {
            Caption = 'GEO WorkPlaces';
            //   TableRelation = Contact."No." where ("Type Relation"=filter(Investor));


        }

        field(70215; "GEO Constructor Manager"; Code[20])
        {
            Caption = 'GEO WorkPlaces';
            TableRelation = Contact."No." where("Type Relation" = filter("GEO Construction Manager"));


        }
        field(70216; "GEO Constructor Manager Name"; Code[250])
        {
            Caption = 'GEO WorkPlaces';

        }
        field(70217; "Sector"; Code[20])
        {
            Caption = 'Sector Code';
            TableRelation = Sector.Code;

        }
        field(70218; "Sector Text"; Text[250])
        {
            Caption = 'Sector Name';
            //TableRelation=Sector.Code;
        }

        field(70220; "Measure Point Pressure1"; enum Pressure2)
        {
            Caption = 'Measure Point Pressure', Comment = 'Pritisak na mjestu mjerenja';
            DataClassification = CustomerContent;
        }
        field(70221; "Protocol No."; Text[250])
        {
            Caption = 'Protocol No.', Comment = 'Pritisak na mjestu mjerenja';
            DataClassification = CustomerContent;
        }
        field(70222; "Chimney Expert Date"; Date)
        {
            Caption = 'Chimney Expert Date', Comment = 'Stručni nalaz dimnjačara';
            DataClassification = CustomerContent;
        }
        field(70223; "A-B"; Boolean)
        {
            Caption = 'A-B';
            DataClassification = CustomerContent;
        }
        field(70224; "A-B Entry"; code[20])
        {
            Caption = 'A-B Entry';
            DataClassification = CustomerContent;
        }
        //korištena oprema za obilježavanje

        field(70225; "Trimble M3 -O"; boolean)
        {
            caption = 'Trimble M3';
        }
        field(70226; "Sokkia SET2030 -O"; boolean)
        {
            Caption = 'Sokkia SET2030';
        }
        field(70227; "Zeiss REC ELTA 15 -O"; Boolean)
        {
            Caption = 'Zeiss REC ELTA 15';
        }
        field(70228; "GPS L1 - Promark 3 -O"; Boolean)
        {
            Caption = 'GPS L1 - Promark 3';
        }
        field(70229; "GPS - Others - O"; Boolean)
        {
            Caption = 'GPS - others';
        }
        field(70230; "GPS TRIMBLE R8S -O"; Boolean)
        {
            Caption = 'GPS TRIMBLE R8S';
        }
        field(70231; "TRIMBLE C5 -O"; Boolean)
        {
            Caption = 'Trimble C5';
        }
        field(70232; "Sokkia 5 m -O"; Boolean)
        {
            Caption = 'Sokkia 5 m';
        }
        field(70233; "Sokkia 3.8 m -O"; Boolean)
        {
            Caption = 'Sokkia 3.8 m';
        }
        field(70234; "Sokkia 2.7 m -O"; Boolean)
        {
            Caption = 'Sokkia 2.7 m';
        }
        field(70235; "Wild 2.15 m -O"; Boolean)
        {
            Caption = 'Wild 2.15 m';
        }
        field(70236; "Sokkia 1x-O"; Boolean)
        {
            Caption = 'Sokkia 1x';
        }
        field(70237; "Zeiss 3x -O"; Boolean)
        {
            Caption = 'Zeiss 3x';
        }
        field(70238; "Zeiss 1x-O"; Boolean)
        {
            Caption = 'Zeiss 1x';
        }
        field(70239; "Wild 1x-O"; Boolean)
        {
            Caption = 'Wild 1x';
        }
        field(70240; "50 m-O"; Boolean)
        {
            caption = '50 m';
        }
        field(70241; "30 m-O"; Boolean)
        {
            Caption = '30 m';
        }
        field(70242; "20 m-O"; Boolean)
        {
            Caption = '20 m';
        }
        field(70243; "Leica Disto-O"; Boolean)
        {
            Caption = 'Leica Disto';
        }
        field(70244; "Accessories for Centering-O"; Boolean)
        {
            Caption = 'Accessories for forced Centering';
        }


        field(70245; "Spray -O"; Integer)
        {
            Caption = 'Spray';
        }
        field(70246; "Harpoon -O"; Integer)
        {
            Caption = 'Harpoon';
        }
        field(70247; "Bolcna -O"; Integer)
        {
            Caption = 'Bolcna';
        }
        field(70248; "Palette -O"; Integer)
        {
            Caption = 'Palette';
        }
        field(70249; "Employee Prepare Responsible"; Code[20])
        {
            Caption = 'Employee Prepare Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(70250; "Employee Control Responsible"; Code[20])
        {
            Caption = 'Employee Control Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(70251; "Evidential Number"; Code[20])
        {
            Caption = 'Evidential Number';


        }
        field(70252; "Date of ticket"; date)
        {
            Caption = 'Date of ticket';
        }
        field(70253; "Time of ticket"; time)
        {
            Caption = 'Time of ticket';
        }

        field(70254; "Date of sender"; date)
        {
            Caption = 'Date of sender';
        }
        field(70255; "Time of sender"; time)
        {
            Caption = 'Time of sender';
        }
        field(70256; "Control Done"; Boolean)
        {
            Caption = 'Control Done';


        }

        field(70257; "Verif Done"; Boolean)
        {
            Caption = 'Verif Done';


        }
        field(70258; "Realisation Done"; Boolean)
        {
            Caption = 'Realisation Done';

        }

        //kraj


        field(70260; "Sent to ZIK GEO"; Date)
        {
            Caption = 'Sent to ZIK', Comment = 'Poslano u ZIK';
            DataClassification = CustomerContent;
        }
        field(70261; "Received from ZIK GEO"; Date)
        {
            Caption = 'Received from ZIK', Comment = 'Preuzeto iz ZIK';
            DataClassification = CustomerContent;
        }
        field(70267; "Filters by Fixed Asset"; code[20])
        {
            Caption = 'Filters by Fixed Asset';

        }
        field(70262; "Filters by Gauge"; Text[250])
        {
            Caption = 'Filters by Gauge';
            // TableRelation = "Installation History"."Inventory Number" where(type = filter(Gauge), active = filter(true));

        }
        field(70263; "Filters by Measuring point"; Code[20])
        {
            Caption = 'Filters by Measuring point';
            TableRelation = "Service Item"."No.";


        }
        field(70264; "Calculation Code"; code[20])
        {
            Caption = 'Calculation Code';
        }
        field(70265; "Massive Code"; code[20])
        {
            Caption = 'Massive Code';
        }
        field(70266; "CZK Invoice Date"; Date)
        {
            Caption = 'CZK Date', Comment = 'Datum prijema u CZK';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Invoice Header"."Document Date" where("Order No." = field("CZK Request No.")));
            Editable = false;
        }

        field(70268; "Transfer Order"; Code[20])
        {
            Caption = 'Transfer Order';


        }

        field(70269; "Amount"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Templates for CR';
            CalcFormula = sum("Service Line".Amount where("Document No." = field("No.")));

        }
        field(70270; "Done Date"; Date)
        {
            Caption = 'Done Date';
        }

        field(70271; "Control Date"; Date)
        {
            Caption = 'Control Date';

        }
        field(70272; "Verif Date"; Date)
        {
            Caption = 'Verif Date';

        }
        field(70273; "Location Name"; Text[250])
        {
            Caption = 'Location Name';
            FieldClass = FlowField;
            //naziv lokacije
            CalcFormula = lookup("Service Item Line".Address where("Document No." = field("No."), "Document Type" = field("Document Type")));

        }
        field(70274; "Service Item Line count"; Integer)
        {
            Caption = 'Service Item Line count';
            //brojac linija
            FieldClass = FlowField;
            CalcFormula = count("Service Item Line" where("Document No." = field("No."), "Document Type" = field("Document Type")));

        }

        field(70275; "Due Days Status"; Integer) //ED
        {
            Caption = 'Due Days Status';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History 2"."Due days" where("Request No." = field("No."), Active = filter(true), "Source Table" = filter(5900), "Request Type" = field("Request Type")));


        }
        field(70276; "Need to reopen work order"; Boolean) //ED
        {
            Caption = 'Need to reopen work order';


        }

        field(70277; "Due Days Reopen"; Integer) //ED
        {
            Caption = 'Due Days Reopen';

        }
        field(70279; "Applied GEO WorkPlaces"; Boolean)
        {
            Caption = 'Applied Investor';
        }
        field(70280; "GPS Tersus"; boolean)
        {
            caption = 'GPS Tersus';
        }
        field(70286; "GPS Tersus (S)"; boolean)
        {
            caption = 'GPS Tersus (Recording)';
        }


        field(70287; "GPS Tersus (T)"; boolean)
        {
            caption = 'GPS Tersus (T)';
        }
        //Novi
        field(70296; "Topcon OS 201"; boolean)
        {
            caption = 'Topcon OS 201';
        }
        field(70297; "Topcon OS 201 (S)"; boolean)
        {
            caption = 'Topcon OS 201 (Recording)';
        }


        field(70298; "Topcon OS 201 (T)"; boolean)
        {
            caption = 'Topcon OS 201 (T)';
        }
        //kraj
        field(70288; "Folder yes"; Boolean)
        {
            Caption = 'Folder yes';
        }
        field(70289; "Contact Geo"; text[40])
        {
            Caption = 'Contact Geo';
            TableRelation = Contact."No." where("Type Relation" = filter(6 | 7 | 8 | 9 | 10 | 11 | 13 | 16 | 17 | 18));
            TestTableRelation = false;

        }

        field(70294; "Construction Manager"; text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Construction Manager';
            TableRelation = Employee."No.";



        }
        field(70295; "Construction Manager Name"; text[20])

        {
            DataClassification = CustomerContent;
            Caption = 'Construction Manager Name';
            TableRelation = Employee."Search Name";


        }


        field(70281; "Prep Control Done"; Boolean)
        {
            Caption = 'Prep Done';

        }

        field(70282; "Prep Verif Done"; Boolean)
        {
            Caption = 'Prep Verif Done';


        }
        field(70283; "Prep Realisation Done"; Boolean)
        {
            Caption = 'Prep Realisation Done';

        }


        field(70284; "Prep Done Date"; Date)
        {
            Caption = 'Prep Done Date';
        }

        field(70285; "Prep Control Date"; Date)
        {
            Caption = 'Prep Control Date';

        }
        field(7028; "Prep Verif Date"; Date)
        {
            Caption = 'Prep Verif Date';

        }

        //kraj
        field(70278; "Applied Investor"; Boolean)
        {
            Caption = 'Applied Investor';


        }
        field(70290; Initials; Text[30])
        {
            Caption = 'Initials';
        }
        field(70293; NC; Text[250])
        {
            Caption = 'NC';
        }
        field(70291; "Number of Floors"; Text[250])
        {
            Caption = 'Number of Floors';
        }
        field(70292; "Consumption Category"; Text[250])
        {
            Caption = 'Consumption Category';
        }
        FIELD(70923; "Gas Installation Data"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Gas Installation Data" WHERE("Customer No." = field("Customer No.")));
        }
        field(70924; "Service Line RN Team"; code[20])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN Team';
            CalcFormula = lookup("Service Line RN"."Resource No." where("Document No." = field("No."), "Request Resource Type1" = filter("Team Leader")));
        }
        field(70925; "Service Line RN Team Name"; Text[250])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN Team Name';
            CalcFormula = lookup("Service Line RN"."Resource Name" where("Document No." = field("No."), "Request Resource Type1" = filter("Team Leader")));
        }
        field(70936; "Service Line RN External"; code[20])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN External';
            CalcFormula = lookup("Service Line RN"."Resource No." where("Document No." = field("No."), "Resource Connection Type" = filter(External)));
        }
        field(70937; "Service Line RN External Name"; Text[250])
        {
            FieldClass = FlowField;
            Caption = 'Service Line RN External Name';
            CalcFormula = lookup("Service Line RN"."Resource Name" where("Document No." = field("No."), "Resource Connection Type" = filter(External)));
        }
        field(70926; "Source Table Inf Number"; Text[50])
        {
            // U ovo polje se sejva Source Table za polje Information Number, kako bi razlikovalo izmedju običnog service headera i proknjižene serv fakture
            Editable = false;
        }
        field(70927; "Mandatory approval"; boolean)
        {
            Caption = 'Mandatory approval for fire and explosion protection';
        }
        field(70928; "Work Order Registry No. letter"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Order Registry No. letter', Comment = 'Broj u registratoru slovima';
        }
        field(70929; "Type of Investition"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Investition';
            TableRelation = InvestitionTable.Code;


        }
        field(70930; "Sent Mail"; Boolean)
        {
            Caption = 'Sent Mail';
        }
        field(70931; "Bill-to Registration No."; Text[20])
        {
            Caption = 'Bill-to registration no.';
        }

        field(70932; "Bill-to VAT Registration No."; Text[20])
        {
            Caption = 'Bill-to VAT Registration No.';
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "No.", "Document Type")
        {
        }
        key(Key3; "Customer No.", "Order Date")
        {
        }
        key(Key4; "Contract No.", Status, "Posting Date")
        {
        }
        key(Key5; Status, "Response Date", "Response Time", Priority, "Responsibility Center")
        {
        }
        key(Key6; Status, Priority, "Response Date", "Response Time")
        {
        }
        key(Key7; "Document Type", "Customer No.", "Order Date")
        {
            MaintainSQLIndex = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Document Type", "No.", "Customer No.", "Posting Date", Status)
        {
        }
    }



    trigger OnInsert()
    var
        ServShptHeader: Record "Service Shipment Header";
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        Text000: Label 'You cannot delete this document. Your identification is set up to process from Responsibility Center %1 only.', Comment = '%1=User management service filter;';
        Text001: Label 'Changing %1 in service header %2 will not update the existing service lines.\You must update the existing service lines manually.';
        Text003: Label 'You cannot change the %1 because the %2 %3 %4 is associated with a %5 %6.', Comment = '%1=Customer number field caption;%2=Document type;%3=Number field caption;%4=Number;%5=Contract number field caption;%6=Contract number; ';
        Text004: Label 'When you change the %1 the existing Service item line and service line will be deleted.\Do you want to change the %1?';
        Text005: Label 'Do you want to change the %1?';
        Text007: Label '%1 cannot be greater than %2.';
        Text008: Label 'You cannot create Service %1 with %2=%3 because this number has already been used in the system.', Comment = '%1=Document type format;%2=Number field caption;%3=Number;';
        Text010: Label 'Your identification is set up to process from %1 %2 only.', Comment = '%1=Resposibility center table caption;%2=User management service filter;';
        Text011: Label '%1 cannot be greater than %2 in the %3 table.';
        Text012: Label 'If you change %1, the existing service lines will be deleted and the program will create new service lines based on the new information on the header.\Do you want to change the %1?';
        Text013: Label 'Deleting this document will cause a gap in the number series for posted credit memos. An empty posted credit memo %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text015: Label 'Do you want to update the exchange rate?';
        Text016: Label 'You have modified %1.\Do you want to update the service lines?';
        Text018: Label 'You have not specified the %1 for %2 %3=%4, %5=%6.', Comment = '%1=Service order type field caption;%2=table caption;%3=Document type field caption;%4=Document type format;%5=Number field caption;%6=Number format;';
        Text019: Label 'You have changed %1 on the service header, but it has not been changed on the existing service lines.\The change may affect the exchange rate used in the price calculation of the service lines.';
        Text021: Label 'You have changed %1 on the %2, but it has not been changed on the existing service lines.\You must update the existing service lines manually.';
        ServSetup: Record "Service Mgt. Setup";
        Cust: Record Customer;
        ServHeader: Record "Service Header";
        ServLine: Record "Service Line";
        ServItemLine: Record "Service Item Line";
        PostCode: Record "Post Code";
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        ServShptHeader: Record "Service Shipment Header";
        ServInvHeader: Record "Service Invoice Header";
        ServCrMemoHeader: Record "Service Cr.Memo Header";
        ReservEntry: Record "Reservation Entry";
        TempReservEntry: Record "Reservation Entry" temporary;
        Salesperson: Record "Salesperson/Purchaser";
        ServOrderMgt: Codeunit ServOrderManagement;
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ServLogMgt: Codeunit ServLogManagement;
        UserSetupMgt: Codeunit "User Setup Management";
        NotifyCust: Codeunit "Customer-Notify by Email";
        ServPost: Codeunit "Service-Post";
        ApplicationAreaMgmt: Codeunit "Application Area Mgmt.";
        CurrencyDate: Date;
        TempLinkToServItem: Boolean;
        HideValidationDialog: Boolean;
        Text024: Label 'The %1 cannot be greater than the minimum %1 of the\ Service Item Lines.';
        Text025: Label 'The %1 cannot be less than the maximum %1 of the related\ Service Item Lines.';
        Text026: Label '%1 cannot be earlier than the %2.';
        Text027: Label 'The %1 cannot be greater than the minimum %2 of the related\ Service Item Lines.';
        ValidatingFromLines: Boolean;
        LinesExist: Boolean;
        Text028: Label 'You cannot change the %1 because %2 exists.';
        Text029: Label 'The %1 field on the %2 will be updated if you change %3 manually.\Do you want to continue?';
        Text031: Label 'You cannot change %1 to %2 in %3 %4.\\%5 %6 in %7 %8 line is preventing it.', Comment = '%1=Status field caption;%2=Status format;%3=table caption;%4=Number;%5=ServItemLine repair status code field caption;%6=ServItemLine repair status code;%7=ServItemLine table caption;%8=ServItemLine line number;';
        Text037: Label 'Contact %1 %2 is not related to customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        Text038: Label 'Contact %1 %2 is related to a different company than customer %3.', Comment = '%1=Contact number;%2=Contact name;%3=Customer number;';
        Text039: Label 'Contact %1 %2 is not related to a customer.', Comment = '%1=Contact number;%2=Contact name;';
        ContactNo: Code[20];
        Text040: Label 'You cannot delete %1 %2 because the %4 %5 for Service Item Line %3 has not been received.', Comment = '%1=table caption;%2=ServItemLine document number;%3=ServItemLine line number;%4=ServItemLine loaner number field caption;%5=ServItemLine loaner number;';
        SkipContact: Boolean;
        SkipBillToContact: Boolean;
        Text041: Label 'Contract %1 is not signed.';
        Text042: Label 'The service period for contract %1 has not yet started.';
        Text043: Label 'The service period for contract %1 has expired.';
        Text044: Label 'You cannot rename a %1.';
        Confirmed: Boolean;
        Text045: Label 'You can not change the %1 field because %2 %3 has %4 = %5 and the %6 has already been assigned %7 %8.', Comment = '%1=Posting date field caption;%2=Posting number series field caption;%3=Posting number series;%4=NoSeries date order field caption;%5=NoSeries date order;%6=Document type;%7=posting number field caption;%8=Posting number;';
        Text046: Label 'You cannot delete invoice %1 because one or more service ledger entries exist for this invoice.';
        Text047: Label 'You cannot change %1 because reservation, item tracking, or order tracking exists on the sales order.';
        Text050: Label 'You cannot reset %1 because the document still has one or more lines.';
        Text051: Label 'The service %1 %2 already exists.', Comment = '%1=Document type format;%2=Number;';
        Text053: Label 'Deleting this document will cause a gap in the number series for shipments. An empty shipment %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text054: Label 'Deleting this document will cause a gap in the number series for posted invoices. An empty posted invoice %1 will be created to fill this gap in the number series.\\Do you want to continue?';
        Text055: Label 'You have modified the %1 field. Note that the recalculation of VAT may cause penny differences, so you must check the amounts afterwards. Do you want to update the %2 field on the lines to reflect the new value of %1?';
        Text057: Label 'When you change the %1 the existing service line will be deleted.\Do you want to change the %1?';
        Text058: Label 'You cannot change %1 because %2 %3 is linked to Contract %4.', Comment = '%1=Currency code field caption;%2=Document type;%3=Number;%4=Contract number;';
        Text060: Label 'Responsibility Center is set up to process from %1 %2 only.', Comment = '%1=Assigned user ID;%2=User management service filter assigned user id;';
        Text061: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text062: Label 'An open inventory pick exists for the %1 and because %2 is %3.\\You must first post or delete the inventory pick or change %2 to Partial.';
        Text063: Label 'An open warehouse shipment exists for the %1 and %2 is %3.\\You must add the item(s) as new line(s) to the existing warehouse shipment or change %2 to Partial.';
        Text064: Label 'You cannot change %1 to %2 because an open inventory pick on the %3.';
        Text065: Label 'You cannot change %1  to %2 because an open warehouse shipment exists for the %3.';
        Text066: Label 'You cannot change the dimension because there are service entries connected to this line.';
        PostedDocsToPrintCreatedMsg: Label 'One or more related posted documents have been generated during deletion to fill gaps in the posting number series. You can view or print the documents from the respective document archive.';
        DocumentNotPostedClosePageQst: Label 'The document has been saved but is not yet posted.\\Are you sure you want to exit?';
        MissingExchangeRatesQst: Label 'There are no exchange rates for currency %1 and date %2. Do you want to add them now? Otherwise, the last change you made will be reverted.', Comment = '%1 - currency code, %2 - posting date';
        FullServiceTypesTxt: Label 'Service Quote,Service Order,Service Invoice,Service Credit Memo';

    local procedure GetProcessingDocumentType(RequestDocumentType: Enum "Request Type"): Enum "Request Type";
    begin
        case RequestDocumentType of
            enum::"Request Type"::"Information Issuing Request":
                exit(Enum::"Request Type"::"Information on Connection");
            enum::"Request Type"::"Project overview Request":
                exit(Enum::"Request Type"::"Project and Energy Accordance");
            enum::"Request Type"::"Location Accordance Issuing Request":
                exit(Enum::"Request Type"::"Location Accordance Issuing Information");
            enum::"Request Type"::"Route Accordance Issuing Request":
                exit(Enum::"Request Type"::"Route Accordance Issuing Information");
            enum::"Request Type"::"Spatial plan Accordance Issuing Request":
                exit(Enum::"Request Type"::"Spatial plan Accordance Issuing Information");
            enum::"Request Type"::"Work Execution Request":
                exit(Enum::"Request Type"::"UGI Overview and First Release");
            else
                exit(Enum::"Request Type"::"Others");
        end;
    end;

    procedure OpenRequestDocumentCard(DocumentNo: Code[20])
    var
        ServiceHeader: Record "Service Header Archive";
    begin
        if DocumentNo = '' then
            exit;
        ServiceHeader.Get(Enum::"Service Document Type"::Order, DocumentNo);
        ServiceHeader.SetRange("Document Type", Enum::"Service Document Type"::Order);
        ServiceHeader.SetRange("Request Type", ServiceHeader."Request Type");
        ServiceHeader.SetRange("CZK Request No.", "No.");
        Page.RunModal(Page::"Request Card Archive", ServiceHeader);
    end;


    procedure GetProcessingDocument(): Code[20]
    var
        ServiceHeader: Record "Service Header Archive";
        ProcessingDocumentType: Enum "Request Type";
    begin
        ProcessingDocumentType := GetProcessingDocumentType("Request Type");
        if ProcessingDocumentType = Enum::"Request Type"::"Others" then
            exit;

        ServiceHeader.SetLoadFields("No.");
        ServiceHeader.SetRange("Request Type", ProcessingDocumentType);
        ServiceHeader.SetRange("CZK Request No.", "No.");
        if ServiceHeader.FindFirst then
            exit(ServiceHeader."No.");

        exit('');
    end;
}

