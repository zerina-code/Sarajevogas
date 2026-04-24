table 50078 "Service Line RN Temp"
{
    Caption = 'Service Line RN Temp';
    //  DrillDownPageID = "Service Line List";
    //LookupPageID = "Service Line List";

    fields
    {


        field(50006; "Resource Quantity"; Decimal)
        {
            Caption = 'Resource Quantity';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //   Quantity := "Resource Quantity";

            end;
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

        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            var
                Item: Record Item;
                ItemLedgEntry: Record "Item Ledger Entry";
            begin





                /*     if "Document Type" <> "Document Type"::"Credit Memo" then begin
                         if (Quantity * "Quantity Shipped" < 0) or
                            ((Abs(Quantity) < Abs("Quantity Shipped")) and ("Shipment No." = ''))
                         then
                             FieldError(Quantity, StrSubstNo(Text003, FieldCaption("Quantity Shipped")));
                         if ("Quantity (Base)" * "Qty. Shipped (Base)" < 0) or
                            ((Abs("Quantity (Base)") < Abs("Qty. Shipped (Base)")) and ("Shipment No." = ''))
                         then
                             FieldError("Quantity (Base)", StrSubstNo(Text003, FieldCaption("Qty. Shipped (Base)")));
                     end;*/




            end;
        }
        field(50013; "Massive Code"; COde[20])
        {
            Caption = 'Massive Code';
        }

        field(5; Type; Enum "Service Line Type")
        {
            Caption = 'Type';

            trigger OnValidate()
            begin


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
                CheckResourceConnectionType();
                type := Type::Resource;
            end;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(50008; "Internal Employees"; Boolean)
        {
            Caption = 'Internal Employees';
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
        field(90000; "Type Relation"; enum "Contact Business Relation Link To Table")
        {
            Caption = 'Type Relation';
        }
        field(50000; "Request Resource Type"; Enum "Request Resource Type")
        {
            Caption = 'Request Resource Type';
            DataClassification = CustomerContent;
            InitValue = " ";
            ValuesAllowed = 99, 100, 101, 102, 7, 9;
            trigger OnValidate()
            begin
                CheckResourceConnectionType();
                type := Type::Resource;
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
                OnValidateResourceNo();


                "Internal Employees" := true;
            end;
        }

        field(50007; "Education Level"; Enum School)
        {
            Caption = 'Education Level';
        }
        field(50003; "Resource Name"; Text[100])
        {
            Caption = 'Resource Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Request Resource Type1", "Line No.", "Massive Code")
        {
            Clustered = true;
        }
    }

    local procedure ResetResourceFields()
    begin
        "Resource Name" := '';
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

    local procedure CheckResourceConnectionType()
    var
        ServiceLine: Record "Service Line";
    begin
        TestField("Resource No.", '');

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



    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}