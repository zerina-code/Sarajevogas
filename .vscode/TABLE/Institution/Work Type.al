tableextension 50098 Files extends "Work Type"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
        }
        field(50597; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
                SH: Record "Sales Header";
                Cus: Record Customer;
            begin

            end;
        }
        field(50579; "Driver Registration No."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Registration No.';
             TableRelation = "Employee Statistics Group"."Code" where("Customer No." = field("Customer No."));
            trigger OnValidate()
            var
                myInt: Integer;
                ESG: Record "Employee Statistics Group";
            begin
                ESG.Reset();
                ESG.SetFilter(Code, '%1', "Driver Registration No.");
                if ESG.FindFirst() then begin
                    validate(Rec."Type of vehicle", esg."Type of vehicle");
                end;
            end;




        }
        field(50004; "Price"; Decimal)
        {
            Caption = 'Price';
        }
        field(50005; "Total"; Decimal)
        {
            Caption = 'Total';
        }

        field(50006; "Customer No."; code[20])
        {
            Caption = 'Total';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var

                Cus: Record Customer;
            begin
                IF cus.GET("Customer No.")
                then begin
                    "Customer Name" := Cus.Name;

                    if cus."VAT Registration No." <> '' then begin
                        "Payment Method Code" := 'VIRMAN';
                        "Driver type" := "Driver type"::External;
                    end;

                    if cus."Internal Customer" = true then begin
                        "Payment Method Code" := 'Vlastita';
                        "Driver type" := "Driver type"::Internal;
                    end;


                end;

            end;
        }

        field(50007; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
            editable = FALSE;
        }



        field(50054; "Type of vehicle"; enum "Type of Vehicle")
        {
            Caption = 'Type of vehicle';
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Customer;
            begin
                //     if ("Type of vehicle" = "Type of vehicle"::"Cargo vehicles") and (rec."Driver type" = rec."Driver type"::Internal) then begin

                /*   Cust.GET("Sell-to Customer No.");
                   IF Cust."Internal Customer" then
                       validate("VAT Prod. Posting Group", 'PDV0');

               end;
               */

            end;
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
                Cust: Record Customer;
            begin

                if ("Type of vehicle" = "Type of vehicle"::"Cargo vehicles") and (rec."Driver type" = rec."Driver type"::Internal) then begin

                    //    Cust.GET("Sell-to Customer No.");
                    //  IF Cust."Internal Customer" then
                    //    validate("VAT Prod. Posting Group", 'PDV0');

                end;


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
        field(50057; "Driver ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver ID';
            TableRelation = if ("Driver type" = const(Internal)) Employee where("CNG Employee" = filter(true), StatusExt = filter(Active))
            else
            Contact where("Type Relation" = filter(Driver), "Active CNG" = filter(true));
            trigger OnValidate()
            var
                myInt: Integer;
                EmployeeD: Record Employee;
                ContactD: Record Contact;
            begin

                if "Driver type" = "Driver type"::Internal then begin
                    EmployeeD.Reset();
                    EmployeeD.SetFilter("No.", '%1', "Driver ID");
                    if EmployeeD.FindFirst() then begin
                        "Driver Name" := EmployeeD."First Name" + ' ' + EmployeeD."Last Name";


                    end

                    else begin
                        "Driver Name" := '';

                    end;


                end
                else begin
                    ContactD.Reset();
                    ContactD.SetFilter("No.", '%1', "Driver ID");
                    ContactD.SetFilter("Type Relation", '%1', ContactD."Type Relation"::Driver);
                    if ContactD.FindFirst() then begin

                        "Driver Name" := ContactD.Name;

                    end
                    else begin

                        "Driver Name" := '';

                    end;





                end;
            end;







        }

        field(50578; "Driver Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Name';



        }
    }

    var
        myInt: Integer;
}