tableextension 50029 FinancieCue extends "Finance Cue"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Opened Purchase Orders"; Integer)
        {
            Caption = 'Opened Purchase Orders';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order), Status = FILTER(Open)));

        }
        field(50002; "Opened Purchase Invoices"; Integer)
        {
            Caption = 'Opened Purchase Invoices';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice)));

        }
        field(50003; "Entry Not  Finished - Items"; Integer)
        {
            Caption = 'Entry Not  Finished - Items';
            FieldClass = FlowField;
            CalcFormula = Count(Item WHERE("Entry Finished" = FILTER(false)));
        }
        field(50004; "Entry Not  Finished - Vendors"; Integer)
        {
            Caption = 'Entry Not  Finished - Vendors';
            FieldClass = FlowField;
            CalcFormula = Count(Vendor WHERE("Entry Finished" = FILTER(false)));
        }
        field(50005; "Entry Not  Finished Customers"; Integer)
        {
            Caption = 'Entry Not  Finished - Customers';
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE("Entry Finished" = FILTER(false)));
        }
        field(50006; "Fixed Asset"; Integer)
        {
            Caption = 'Fixed Asset';
            FieldClass = FlowField;
            CalcFormula = Count("Fixed Asset");
        }
        field(50007; "Requests to Approve2"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Open)));
            Caption = 'Requests to Approve';

        }
        field(50008; "Requests Sent for Approval2"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = FILTER(Open)));


            Caption = 'Requests Sent for Approval';


        }
        field(50009; "Code Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            Caption = 'Code Filter';
        }
        field(50010; "Small Inventory"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = Count(Item WHERE("No." = field("Code Filter")));


            Caption = 'Small Inventory';
        }
        field(50011; "Commercial Approve"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Odobrila komercijala';
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = FILTER(Order),
                                                         Commercial = const(true)));
        }
        field(500481; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter 2';
            Editable = false;
            FieldClass = FlowFilter;
        }

        field(50012; "New Reminders"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Potencijalna utuženja';


            CalcFormula = Count("Reminder Header" WHERE("Document Date" = FIELD("Date Filter 2")));
        }
        field(50013; "Inventory Group 1"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Inventory Group 1';



            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 1")));
        }
        field(50014; "GL Account No. 1"; code[20])
        {
            Caption = 'GL Account No. 1';
            FieldClass = FlowFilter;

        }
        field(50015; "Inventory Group 2"; Integer)
        {
            FieldClass = FlowField;
            // Caption = 'Inventory Group 1';


            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 2")));
        }
        field(50016; "GL Account No. 2"; code[20])
        {
            Caption = 'GL Account No. 2';
            FieldClass = FlowFilter;
        }

        field(50017; "Inventory Group 3"; Integer)
        {
            FieldClass = FlowField;



            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 3")));
        }
        field(50018; "GL Account No. 3"; code[20])
        {
            Caption = 'GL Account No. 3';
            FieldClass = FlowFilter;
        }


        field(50019; "Inventory Group 4"; Integer)
        {
            FieldClass = FlowField;



            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 4")));
        }
        field(50020; "GL Account No. 4"; code[20])
        {
            Caption = 'GL Account No. 4';
            FieldClass = FlowFilter;
        }

        field(50021; "Inventory Group 5"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Inventory Group 5';



            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 5")));
        }
        field(50022; "GL Account No. 5"; code[20])
        {
            Caption = 'GL Account No. 5';
            FieldClass = FlowFilter;
        }
        field(50023; "Inventory Group 6"; Integer)
        {
            FieldClass = FlowField;



            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 6")));
        }
        field(50024; "GL Account No. 6"; code[20])
        {
            Caption = 'GL Account No. 6';
            FieldClass = FlowFilter;
        }

        field(50025; "Inventory Group 7"; Integer)
        {
            FieldClass = FlowField;


            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 7")));
        }
        field(50026; "GL Account No. 7"; code[20])
        {
            Caption = 'GL Account No. 7';
            FieldClass = FlowFilter;
        }


        field(50027; "Inventory Group 8"; Integer)
        {
            FieldClass = FlowField;


            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("G/L Account No." = FIELD("GL Account No. 8")));
        }
        field(50028; "GL Account No. 8"; code[20])
        {
            Caption = 'GL Account No. 8';
            FieldClass = FlowFilter;
        }



    }

    var
        myInt: Integer;

}