tableextension 50005 "Service Line" extends "Service Line"
{
    fields
    {
        field(50020; "Fixed Asset OS"; code[20])
        {
            Caption = 'Fixed Asset OS';
            TableRelation = "Fixed Asset"."No." where("Gas Station Type" = filter(<> ''));
            trigger OnValidate()
            var
                myInt: Integer;
                FA: Record "Fixed Asset";
            begin

                FA.Reset();
                FA.SetFilter("No.", '%1', rec."Fixed Asset OS");
                if fa.FindFirst() then begin
                    "Fixed Asset Mark" := fa.Mark;
                end

                else begin
                    "Fixed Asset Mark" := '';
                end;
            end;


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

        modify("Location Code")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

                if Type = Type::Item then begin
                    "Quantity (Base)" := Quantity;
                    "Qty. to Ship" := Quantity;
                    "Outstanding Qty. (Base)" := Quantity;
                    "Outstanding Quantity" := Quantity;
                    "Quantity (Base)" := Quantity;
                    "Qty. to Invoice" := Quantity;
                    "Qty. to Invoice (Base)" := Quantity;
                    if "Source Location Code" = '' then
                        "Source Location Code" := 'GLAVNO';
                end;

            end;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                "Internal Employees" := false;
            end;


            trigger OnAfterValidate()
            var
                ServiceL: Record "Service Line";
                ItemNo: Record "Item Ledger Entry";
            begin
                OnAfterValidateNo();

                if (rec."RN Type" = rec."RN Type"::Intervention)
                and ("Unit of Measure Code2" = '') then begin
                    validate("Unit of Measure Code2", 'KOM');
                end;
                if ("Unit of Measure Code2" <> "Unit of Measure Code") then
                    validate("Unit of Measure Code2", "Unit of Measure Code");


                if "Quantity RN" = 0 then begin
                    validate("Quantity RN", Quantity);

                    if (Type = Type::Item) and (Rec."No." <> 'GAS2') then begin
                        ItemNo.Reset();
                        ItemNo.SetFilter("Item No.", '%1', rec."No.");
                        ItemNo.SetFilter("Cost Amount (Actual)", '%1', 0);
                        if ItemNo.FindFirst() then begin
                            Message('Trošak artikla ' + rec."No." + ' ima vrijednost ' + format(0) + ', molim Vas da provjeriti cijenu!');
                        end;
                    end;


                end;


            end;

        }
        modify(Quantity)
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if Type = Type::Item then begin
                    "Quantity (Base)" := Quantity;
                    if "Planned Quantity" = 0 then
                        "Planned Quantity" := Quantity;
                    "Qty. to Ship" := Quantity;
                    "Outstanding Qty. (Base)" := Quantity;
                    "Outstanding Quantity" := Quantity;
                    "Quantity (Base)" := Quantity;
                    "Qty. to Invoice" := Quantity;
                    "Qty. to Invoice (Base)" := Quantity;
                    if "Source Location Code" = '' then
                        "Source Location Code" := 'GLAVNO';
                    "Quantity RN" := Quantity;
                end;
            end;
        }
        field(50000; "Request Resource Type"; Enum "Request Resource Type")
        {
            Caption = 'Request Resource Type';
            DataClassification = CustomerContent;
            InitValue = " ";
            //ValuesAllowed = 99, 100, 101, 102, 7;
            ValuesAllowed = 99, 100, 101, 102, 105;

            /*ValuesAllowed = 99, 100, 101, 102, 7, 9;*/

            trigger OnValidate()
            begin
                CheckResourceConnectionType();
                type := Type::Resource;
            end;
        }
        field(50001; "Resource Connection Type"; enum "Resource Connection Type")
        {
            Caption = 'Resource Connection Type';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CheckResourceConnectionType();
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
                OnValidateResourceNo();
                "Internal Employees" := true;

                if type = type::Item then begin
                    validate("Unit of Measure Code2", "Unit of Measure");
                    if "Source Location Code" = '' then
                        "Source Location Code" := 'GLAVNO';
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
                    if (Quantity = 0) and ("Planned Quantity" <> 0) then
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
            ValuesAllowed = 99, 100, 101, 102, 105;
            /* ValuesAllowed = 99, 100, 101, 102, 7, 9; */
            trigger OnValidate()
            begin
                CheckResourceConnectionType();
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
                end;
                if Type = Type::Item then begin
                    "Quantity (Base)" := Quantity;
                    "Qty. to Ship" := Quantity;
                    "Outstanding Qty. (Base)" := Quantity;
                    "Outstanding Quantity" := Quantity;
                    "Quantity (Base)" := Quantity;
                    "Qty. to Invoice" := Quantity;
                    "Qty. to Invoice (Base)" := Quantity;
                    if "Source Location Code" = '' then
                        "Source Location Code" := 'GLAVNO';
                end;

            end;
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

        field(60081; "Shiped Quantity2"; Decimal)
        {
            Caption = 'Shiped Quantity';
            //otpremljeno, a nije naplaćeno
            FieldClass = FlowField;
            //    CalcFormula = lookup("Posted Whse. Shipment Line".Quantity where("Source No." = field("Transfer Order"), "Line No." = field("Line No.")));
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Sales Header No." = field("Document No."), "Location Code" = field("Location Code"), "Entry Type" = filter(Transfer)));


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

        field(70278; "Gauge"; code[20])
        {
            caption = 'Gauge';
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
    local procedure OnAfterValidateNo()
    var
        Resource: Record Resource;
    begin
        if ("Type" <> "Type"::Resource) or ("No." = '') then
            exit;

        if not Resource.Get("No.") then begin
            "Request Resource Type" := Enum::"Request Resource Type"::" ";
            ResetResourceFields();
            exit;
        end;

        "Request Resource Type" := Resource."Request Resource Type";
        if Type = Type::Resource then begin
            validate(Quantity, 1);
            "Quantity (Base)" := Quantity;
            "Qty. to Ship" := 0;
            "Qty. to Ship (Base)" := 0;
        end;
        if Type = Type::Item then begin
            validate("Location Code", 'GLAVNO');
            "Quantity (Base)" := Quantity;
            "Qty. to Ship" := Quantity;
            "Qty. to Ship (Base)" := Quantity;
            "Qty. to Invoice" := Quantity;
            "Qty. to Invoice (Base)" := Quantity;
            if "Source Location Code" = '' then
                "Source Location Code" := 'GLAVNO';
        end;
    end;

    local procedure OnValidateResourceNo()
    var
        Employee: Record Employee;
        Contact: Record Contact;
    begin
        if "Resource No." = '' then begin
            ResetResourceFields();
            exit;
        end;
        TestField("Type", Enum::"Service Line Type"::Resource);
        case "Resource Connection Type" of
            Enum::"Resource Connection Type"::Internal:
                begin

                    if not Employee.Get("Resource No.") then begin
                        ResetResourceFields();
                        exit;
                    end;
                    "Resource Name" := Employee.FullName();
                    "Education Level" := Employee."Education Level";
                end;
            Enum::"Resource Connection Type"::External:
                begin
                    if not Contact.Get("Resource No.") then begin
                        ResetResourceFields();
                        exit;
                    end;
                    "Resource Name" := Contact.Name;
                    "Education Level" := Contact."Education Level";
                end;
            else
                Error('');
        end;
    end;


    trigger OnBeforeInsert()
    var
        myInt: Integer;
    begin
        //   if "RN Type" = "Rn Type"::Intervention then
        //     validate(Type, Type::" ");

    end;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if rec."Request Resource Type1" <> rec."Request Resource Type1"::" " then begin
            rec."Internal Employees" := true
        end
        else begin
            rec."Internal Employees" := false;
        end;




    end;

    local procedure ResetResourceFields()
    begin
        "Resource Name" := '';
    end;

    local procedure CheckResourceConnectionType()
    var
        ServiceLine: Record "Service Line";
    begin
        //  TestField("Resource No.", '');

        case "Request Resource Type" of
            Enum::"Request Resource Type"::" ",
            Enum::"Request Resource Type"::Designer:
                ;
            Enum::"Request Resource Type"::Chimneyman,
            Enum::"Request Resource Type"::"Construction Manager",
            Enum::"Request Resource Type"::Constructor,
            Enum::"Request Resource Type"::Investor,
            Enum::"Request Resource Type"::Repairman,
            Enum::"Request Resource Type"::Electro,
            Enum::"Request Resource Type"::Welder,
            Enum::"Request Resource Type"::Contractor:
                if CurrFieldNo = FieldNo("Request Resource Type") then
                    "Resource Connection Type" := Enum::"Resource Connection Type"::External
                else
                    TestField("Resource Connection Type", Enum::"Resource Connection Type"::External);
            else
                if CurrFieldNo = FieldNo("Request Resource Type") then
                    "Resource Connection Type" := Enum::"Resource Connection Type"::Internal
                else
                    Testfield("Resource Connection Type", Enum::"Resource Connection Type"::Internal);

                /*  ServiceLine.Reset();
                  ServiceLine.SetFilter("Document No.", '%1', rec."Document No.");
                  ServiceLine.SetCurrentKey("Line No.");
                  ServiceLine.Ascending;
                  if ServiceLine.FindLast() then
                      "Line No." := ServiceLine."Line No." + 10000
                  else
                      "Line No." := 10000;*/

                if rec."Request Resource Type1" <> rec."Request Resource Type1"::" " then begin
                    rec."Internal Employees" := true
                end
                else begin
                    rec."Internal Employees" := false;
                end;


        end;
    end;
}
