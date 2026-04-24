tableextension 50110 ServiceInvoiceLine extends "Service Invoice Line"
{
    fields
    {
        // Add changes to table fields here
        field(50013; "Transfer Order"; code[20])
        {
            Caption = 'Transfer Order';
        }
        field(50000; "Request Resource Type"; Enum "Request Resource Type")
        {
            Caption = 'Request Resource Type';
            DataClassification = CustomerContent;
            InitValue = " ";
            ValuesAllowed = 99, 100, 101, 102, 7, 9;
            trigger OnValidate()
            begin
                //    CheckResourceConnectionType();
                type := Type::Resource;
            end;
        }
        field(50001; "Resource Connection Type"; enum "Resource Connection Type")
        {
            Caption = 'Resource Connection Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //   CheckResourceConnectionType();
            end;
        }
        field(50002; "Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Resource No.';
            TableRelation = if ("Resource Connection Type" = const(Internal)) Employee
            else
            if ("Resource Connection Type" = const(External)) Contact where("Type Relation" = field("Request Resource Type"));

            trigger OnValidate()
            var
                Res: Record "Service Line";
                ServiceHeader: Record "Service Header";
            begin

                /*    Res.Reset();
                    Res.SetFilter("Document No.", '%1', rec."Document No.");
                    res.SetCurrentKey("Line No.");
                    res.Ascending;
                    if res.FindLast() then
                        "Line No." := res."Line No." + 1000
                    else
                        "Line No." := 1000;*/
                if type = type::" " then
                    Type := type::Resource;
                "Internal Employees" := true;

                IF "Unit Price" = 0 then begin
                    ServiceHeader.Reset();
                    ServiceHeader.SetFilter("No.", '%1', rec."Document No.");
                    if ServiceHeader.FindFirst() then begin
                        if ((ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"General Geo. Work Order") or
                (ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"General Geo. Work Order Office")
                or (ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"General Work Order")
                or (ServiceHeader."Request Type" <> ServiceHeader."Request Type"::"Work Execution Request")) then
                            Message('Morate unijeti cijenu!');
                    end;
                end;
                //  OnValidateResourceNo();
                "Internal Employees" := true;

                if type = type::Item then begin
                    validate("Unit of Measure Code2", "Unit of Measure");
                end;
            end;
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
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Resource Quantity" = 0 then begin
                    "Resource Quantity" := "Planned Quantity";
                    Quantity := "Planned Quantity";
                end

            end;
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
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Quantity := "Resource Quantity";

            end;
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
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec."RN Type" <> rec."RN Type"::Intervention then begin
                    validate("Unit of Measure Code", "Unit of Measure Code2")
                end;

            end;

        }
        field(50010; "Request Resource Type1"; Enum "Request Resource Type")
        {
            Caption = 'Request Resource Type';
            DataClassification = CustomerContent;
            InitValue = " ";
            // ValuesAllowed = 99, 100, 101, 102, 7, 9;
            trigger OnValidate()
            begin
                //  CheckResourceConnectionType();
                type := Type::Resource;
            end;
        }
        field(50011; "RN Type"; Enum "Service Line Type RN")
        {
            Caption = 'RN Type';

            trigger OnValidate()
            begin
                //  CheckIfCanBeModified;
                //   validate(Type, "RN Type");
                // 
                validate(Type, "RN Type");

                if "RN Type" <> "RN Type"::Intervention then begin
                    Validate(type, "RN Type");
                    "RN Type" := type;
                end;
                //  if "RN Type" = "RN Type"::Intervention then begin
                //    validate(type, type::" ");
                //     end;
            end;
        }
        field(50012; "Quantity RN"; Decimal)
        {
            Caption = 'RN Type';

            trigger OnValidate()
            begin
                //  CheckIfCanBeModified;
                if Type <> Type::" " then begin
                    Quantity := "Quantity RN";
                end

            end;
        }
        field(70072; "Request Department"; Code[20])
        {
            Caption = 'Request Department', Comment = 'Org. jedinica pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Invoice Header"."Request Department" where("No." = field("Document No.")));

        }
        field(70073; "Request Department Name"; Text[150])
        {
            Caption = 'Request Department Name', Comment = 'Naziv org. jedinice pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Invoice Header"."Request Department Name" where("No." = field("Document No.")));
            Editable = false;
        }
        field(60072; "Responsible Department"; Code[20])
        {
            Caption = 'Responsible Department', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Invoice Header"."Responsible Department" where("No." = field("Document No.")));


        }
        field(60073; "Responsible Department Name"; Text[250])
        {
            Caption = 'Responsible Department Name', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Invoice Header"."Responsible Department Name" where("No." = field("Document No.")));


        }

        field(60074; "Shiped Quantity"; Decimal)
        {
            Caption = 'Shiped Quantity';
            //otpremljeno, a nije naplaćeno
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line".Quantity where("Source No." = field("Transfer Order"), "Line No." = field("Line No.")));


        }
        field(60078; "Source Location Code"; Code[20])
        {
            Caption = 'Source Location Code';
            TableRelation = Location;
        }
        field(60076; "Number of leaks detected"; Integer)
        {
            Caption = 'Number of leaks detected"';
        }
        field(70270; "VAT billing"; Decimal)
        {
            caption = 'VAT billing';
        }
        field(70271; "Total billing"; Decimal)
        {
            caption = 'Total billing';
        }

    }
    var
        myInt: Integer;
}