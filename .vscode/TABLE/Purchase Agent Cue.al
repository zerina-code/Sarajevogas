tableextension 50055 "Purchase Agent Cue" extends "Purchase Cue"
{
    //ED

    fields

    {

        field(50000; "Vendors"; Integer)
        {

            CalcFormula = Count(Vendor);
            FieldClass = FlowField;
            Caption = 'All Vendors';
        }
        field(50001; "Items"; Integer)
        {

            CalcFormula = Count(Item);
            FieldClass = FlowField;
            Caption = 'Svi artikli';
        }
        /*field(50002; "Customers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer);
            Caption = 'All Customers';
        }*/
        field(50003; "Resources"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Resource);
            Caption = 'Usluge';
        }
        field(50004; "Outstanding Purchase Orders2"; Integer)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Released),
                                                         "Completely Received" = FILTER(false),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Outstanding Purchase Orders';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "Purchase Return Orders - All2"; Integer)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER("Return Order"),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Purchase Return Orders - All';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "NotBlocked"; Integer) //dobavljači koji nisu blokirani
        {

            CalcFormula = Count(Vendor WHERE(Blocked = const(" ")));
            FieldClass = FlowField;
            Caption = 'Not Blocked';
        }
        field(50007; "Blocked"; Integer) //dobavljači za koje je u polju Blocked stavljeno Payment ili All
        {

            CalcFormula = Count(Vendor WHERE(Blocked = filter(1 | 2)));
            FieldClass = FlowField;
            Caption = 'Blocked';
        }
        field(50008; "AvailableItems"; Integer) //artikli kojih ima na stanju, prema polju Inventar
        {
            FieldClass = FlowField;
            CalcFormula = Count(Item);
            Caption = 'Artikli kojih ima na stanju';
        }

        field(50009; "NotAvailableItems"; Integer) //artikli kojih nema na stanju, prema polju Inventar
        {
            FieldClass = FlowField;
            CalcFormula = Count(Item);
            Caption = 'Artikli kojih nema na stanju';
        }
        field(50010; "FixedAssets"; Integer) //osnovna sredstva
        {
            FieldClass = FlowField;
            CalcFormula = Count("Fixed Asset");
            Caption = 'Osnovna sredstva';

        }
        field(50011; "PurchaseHeaders"; Integer) //sve narudzbenice
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header");
            Caption = 'Sve narudžbenice';

            // Editable = false;
        }
        field(50012; "OpenOrders"; Integer)
        {

            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Open),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Otvoreno';
            FieldClass = FlowField;

            /*CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Open)));*/
        }
        field(50013; "ReleasedOrders"; Integer)
        {
            /*CalcFormula = Count ("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Open),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter")));*/
            Caption = 'Lansirano';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Released)));

        }
        field(50014; "CommercialApproval"; Integer)
        {
            Caption = 'Čeka odobrenje Komercijale';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Commercial = const(false)));
        }
        /*field(50015; "AccountingApproval"; Integer)
         {
             Caption = 'Čeka odobrenje Računovodstva';
             FieldClass = FlowField;
             CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                          Accounting = const(false)));
         }*/
        /*field(50016; "PlanNabavkeRoba"; Integer)
        {
            Caption = 'Roba';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Plan" WHERE(plan = FILTER(Order),
                                                         Finance = const(false)));
        }*/
        field(50017; "Purchase Return Orders - Open"; Integer)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER("Return Order"),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                         Status = filter(Open)));
            Caption = 'Otvoreni';
            Editable = true;
            FieldClass = FlowField;
        }
        field(50018; "Purchase Return Orders - R"; Integer)
        {
            AccessByPermission = TableData "Return Shipment Header" = R;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER("Return Order"),
                                                         "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                         Status = filter(Released)));
            Caption = 'Lansirani';
            Editable = true;
            FieldClass = FlowField;
        }

        field(50019; "Posted Purchase Invoices"; Integer)
        {
            CalcFormula = Count("Purch. Inv. Header" WHERE("Responsibility Center" = FIELD("Responsibility Center Filter")
                                                        ));
            Caption = 'Proknjižene narudžbenice';
            Editable = true;
            FieldClass = FlowField;
        }

        field(50329; "Sales Orders - Open"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order)
                                                      ));
            Caption = 'Sales Orders';


        }

        field(50330; "Date Filter2"; Date)
        {
            Caption = 'Date Filter2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50331; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
        }
        field(50332; "Posted Receipts - Today"; Integer)
        {
            CalcFormula = Count("Posted Whse. Receipt Header" WHERE("Posting Date" = FIELD("Date Filter2"),
                                                                     "Location Code" = FIELD("Location Filter")));
            Caption = 'Posted Receipts - Today';
            Editable = false;
            FieldClass = FlowField;
        }

        /*field(50020; "ItemsOpenOrders"; Integer)
        {

            CalcFormula = Count("Purchase Line" WHERE("Document Type" = FILTER(Order),                                                         
                                                    "Responsibility Center" = FIELD("Responsibility Center Filter")));
            Caption = 'Otvoreno po artiklima';
            FieldClass = FlowField;
        }*/
        field(50333; "Received in WHSE"; Integer)
        {
            Caption = 'Received in Whse';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Count("Purchase Header" WHERE("Purchase Line - Received" = FILTER(> 0)));
        }
        field(50334; "Canceled Whse Receipts"; Integer)
        {
            Caption = 'Canceled Whse Receipts';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Purch. Rcpt. Header" WHERE(Correction = FILTER(true)));
        }

    }

    var
        CurrentYear: Integer;
}