tableextension 50096 Sales_Invoice_Line extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50001; "Manufacturer Code"; Code[20])
        {

            DataClassification = ToBeClassified;

        }
        field(50049; "Payment Type Invoice"; Code[10]) //ED
        {
            Caption = 'Payment Type Invoice';
            TableRelation = "Customer Templ.";
        }
        field(50200; "CNG BLG"; Boolean)
        {
            Caption = 'CNG BLG';
        }

        // Add changes to table fields here
        field(50050; "Fiscal printed"; Boolean)
        {
            Caption = 'Fiscal printed';
        }
        field(50051; "Fiscal No."; COde[20])
        {
            Caption = 'Fiscal No.';
            DataClassification = ToBeClassified;

        }
        field(50052; "Fiscal DateTime"; DateTime)
        {
            Caption = 'Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50053; "Fiscal User"; COde[250])
        {
            Caption = 'Fiscal User';
            DataClassification = ToBeClassified;

        }
        field(50054; "Type of vehicle"; enum "Type of Vehicle")
        {
            Caption = 'Type of vehicle';
        }
        field(50055; "Vehicle Registration"; Text[250])
        {
            Caption = 'Vehicle Registration';
        }

        field(50056; "Driver type"; Option)
        {
            Caption = 'Driver type';
            OptionCaption = ' ,External,Internal';
            OptionMembers = " ",External,Internal;

            trigger OnValidate()
            var
                myInt: Integer;
                EmployeeD: Record Employee;
                ContactD: Record Contact;
            begin

                if "Driver type" = "Driver type"::Internal then begin
                    EmployeeD.Reset();
                    EmployeeD.SetFilter("No.", '%1', "Driver ID");
                    if EmployeeD.FindFirst() then
                        "Driver Name" := EmployeeD."First Name" + ' ' + EmployeeD."Last Name"
                    else
                        "Driver Name" := '';

                end
                else begin
                    ContactD.Reset();
                    ContactD.SetFilter("No.", '%1', "Driver ID");
                    ContactD.SetFilter("Type Relation", '%1', ContactD."Type Relation"::Driver);
                    if ContactD.FindFirst() then
                        "Driver Name" := ContactD.Name
                    else
                        "Driver Name" := '';


                end;

            end;
        }
        field(50598; "Subsidies"; Boolean)
        {
            Caption = 'Subsidies - yes';
        }
        field(50599; "Old Quantity"; Decimal)
        {
            Caption = 'Old Quantity';
        }
        field(50600; "Cargo done"; Boolean)
        {
            Caption = 'Cargo done';
        }

        field(50057; "Driver ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver ID';
            TableRelation = if ("Driver type" = const(Internal)) Employee
            else
            Contact;
            trigger OnValidate()
            var
                myInt: Integer;
                EmployeeD: Record Employee;
                ContactD: Record Contact;
            begin

                if "Driver type" = "Driver type"::Internal then begin
                    EmployeeD.Reset();
                    EmployeeD.SetFilter("No.", '%1', "Driver ID");
                    if EmployeeD.FindFirst() then
                        "Driver Name" := EmployeeD."First Name" + ' ' + EmployeeD."Last Name"
                    else
                        "Driver Name" := '';

                end
                else begin
                    ContactD.Reset();
                    ContactD.SetFilter("No.", '%1', "Driver ID");
                    ContactD.SetFilter("Type Relation", '%1', ContactD."Type Relation"::Driver);
                    if ContactD.FindFirst() then
                        "Driver Name" := ContactD.Name
                    else
                        "Driver Name" := '';


                end;

            end;




        }

        field(50578; "Driver Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Name';



        }
        field(50579; "Driver Registration No."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Registration No.';



        }

        field(50597; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
            begin

            end;
        }
        field(50594; "Avans Amount"; Decimal)
        {
            Caption = 'Avans Amount';

            //đemina poruka: ovo polje sam morala prerangirati. Sig ti znaš zašto ti je ovo s validacijom zakucan broj, međutim zbog operacije transferfield i kreiranje iz prodajnih naloga u otpremnice i slično, postavila si bila da ti polje "Payment Method Code" 50580  (Sales Shipment Line) dodjeli ovu vrijednost u tvoje polje Avans koje je tipa decimal. Ne može se čak nastaviti ni knjižizi. Molim te pogledaj ovu poruku da znaš za ubuduće i slobodno je kasnije obriši.
            trigger OnValidate()

            begin

                validate("Unit price", "Avans Amount" - ("Avans Amount" * 14.5299 / 100));
                //Validate("Unit price");

            end;
        }
        field(50583; "Old Price"; Decimal)
        {

            Caption = 'Old Price';

            trigger Onvalidate()
            var
                myInt: Integer;
            begin


                //             Difference := Amount - "Total Old Price";


            end;


        }
        field(50584; "Difference"; Decimal)
        {

            Caption = 'Difference between New and Old Price';

        }

        field(50585; "R. Fiscal printed"; Boolean)
        {
            Caption = 'R. Fiscal printed';
        }
        field(50586; "R. Fiscal No."; COde[20])
        {
            Caption = 'R. Fiscal No.';
            DataClassification = ToBeClassified;

        }
        field(50587; "R. Fiscal DateTime"; DateTime)
        {
            Caption = 'R. Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50588; "R. Fiscal User"; COde[250])
        {
            Caption = 'R. Fiscal User';
            DataClassification = ToBeClassified;

        }


        field(50589; "New Fiscal printed"; Boolean)
        {
            Caption = 'New Fiscal printed';
        }
        field(50590; "New Fiscal No."; COde[20])
        {
            Caption = 'New Fiscal No.';
            DataClassification = ToBeClassified;

        }
        field(50591; "New Fiscal DateTime"; DateTime)
        {
            Caption = 'New Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50592; "New Fiscal User"; COde[250])
        {
            Caption = 'New Fiscal User';
            DataClassification = ToBeClassified;

        }

        field(50593; "Total Old Price"; Decimal)
        {

            Caption = 'Total Old Price';

            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //    Difference := Amount - "Total Old Price";

            end;



        }

        field(50595; "Internal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Internal';


        }
        field(50596; "NN"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NN';


        }
        field(50601; "Shipment create"; Boolean)
        {
            Caption = 'Shipment create';
        }
        field(50602; "New Price"; Boolean)
        {
            Caption = 'New Price';
        }


    }

    var
        myInt: Integer;
}