tableextension 50057 PurchaseLineExtends extends "Purchase Line"
{
    fields
    {
        //    VAT Base (retro.)

        modify("Gen. Prod. Posting Group")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
                Line: Record "Purch. Rcpt. Line";
                ItemUpdate: Record item;
                RecRef: RecordRef;
                RecordRefExample: Codeunit "Modiy Permissions";

            begin


                Line.Reset();
                Line.SetFilter("Order No.", '%1', rec."Document No.");
                Line.SetFilter("Order Line No.", '%1', rec."Line No.");
                Line.SetFilter("Qty. Rcd. Not Invoiced", '<>%1', 0);
                if line.FindFirst() then
                    repeat
                        Line.Validate("Gen. Prod. Posting Group", rec."Gen. Prod. Posting Group");
                        RecRef.GetTable(Line);
                        RecordRefExample.ModifyRecords(RecRef);

                        // Line.modify;
                        ItemUpdate.Reset();
                        ItemUpdate.SetFilter("No.", '%1', rec."No.");
                        if ItemUpdate.FindFirst() then begin
                            ItemUpdate.Validate("Gen. Prod. Posting Group", rec."Gen. Prod. Posting Group");
                            ItemUpdate.Modify();
                        end;
                    until line.next = 0;

            end;
        }


        field(50000; "G/L Correction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Order Code"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Vendor"."Vendor Item No." where
            ("Item No." = field("No."), "Vendor No." = field("Buy-from Vendor No."));
            //"Item Vendor"."Vendor Item No." WHERE (Item No.=FIELD(No.),Vendor No.=FIELD(Buy-from Vendor No.))
        }
        field(50003; "Quality Control Needed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //FA Charge No.
        field(50006; "FA Charge No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Item No. for PDV Assign."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Cost Type"; Enum "Cost Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Plan No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Purchase Plan Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Direktni sporazum"; Enum "Procedure Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Purchase Type"; Enum "Purchase Type Enum")
        {
            Caption = 'Purchase Type';
        }
        /*field(50016; Exemption; Boolean)
        {
            Caption = 'Exemption';
        }*/
        field(50017; "Contract Entry No."; Code[20])
        {
            Caption = 'Contract Entry No.';
            DataClassification = ToBeClassified;
        }
        field(50018; "Contract Purchase Item"; Text[200])
        {
            Caption = 'Contract Purchase Item';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Contract Purchase Item" where("No." = field("Document No.")));
        }
        field(50019; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Buy-from Vendor No.")));
        }
        field(50020; "User ID Number"; Text[100])
        {
            Caption = 'User ID Number';
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."User ID Number" where("No." = field("Document No.")));
        }
        field(50021; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = Department."Code";
        }
        field(50022; "VAT Rounding"; Decimal)
        {
            Caption = 'VAT Rounding';
            trigger OnValidate()
            begin
                validate("VAT Difference", "VAT Rounding");
            end;

        }

        modify(Type)
        {
            trigger OnBeforeValidate()
            var
                UserSetup: Record "User Setup";
                ph: Record "Purchase Header";
            begin
                ph.Reset();
                ph.SetFilter("Document Type", '%1', Rec."Document Type");
                ph.setfilter("No.", '%1', Rec."Document No.");
                if ph.FindFirst() then begin
                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        UserSetup."Contract No." := ph."Contract Entry No.";
                        //Message(UserSetup."Contract No.");
                        UserSetup.Modify();
                    end;
                end;
                //


            end;

            trigger OnAfterValidate()
            var
                myInt: Integer;
                UserSetup: Record "User Setup";
            begin
                if (Type = Type::Item) or (Type = Type::"Fixed Asset") then begin
                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        if UserSetup."Allowed Purchase Order (I)" = false then
                            Error('Nije Vam dozvoljeno kreirati narudžbenice za osnovna sredstav i artikle!');
                    end;
                end;

            end;

        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
                ItemL: Record Item;
                ContractScope: Record "Contract Scope";
                PurchaseHeaderTable: Record "Purchase Header";
                PurchaseContract: Record "Purchase Contract";
            begin
                /*UserSetup.Reset();                                VRATITI ZA BRISANJE BROJA UGOVORA
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup."Contract No." := '';
                    Message(UserSetup."Contract No.");
                    UserSetup.Modify();
                end;*/
                //

                /*Message(Format("No."));
                "Direct Unit Cost":=59;
                Validate("Direct Unit Cost", 40);*/

                if Rec.Type = Rec.Type::"Fixed Asset" then begin
                    Validate("Unit of Measure Code", 'KOM');
                    Validate(Quantity, 1);
                end;

                PurchaseHeaderTable.Reset();
                PurchaseHeaderTable.SetFilter("No.", '%1', "Document No.");
                if PurchaseHeaderTable.FindFirst() then begin
                    ContractScope.Reset();
                    ContractScope.SetFilter("Contract Entry No.", '%1', PurchaseHeaderTable."Contract Entry No."); //MORAM NACI I VRSTU NABAVKE I DS

                    PurchaseContract.Reset();
                    PurchaseContract.SetFilter("Contract Entry No.", '%1', PurchaseHeaderTable."Contract Entry No."); //ako je ugovor označen sa fiksnom cijenom
                    if PurchaseContract.FindFirst() then begin
                        if PurchaseContract."Fixed Price" then begin
                            if PurchaseContract."Purchase Type".AsInteger() = 1 then
                                ContractScope.SetFilter("Item No.", '%1', "No.")
                            else
                                if PurchaseContract."Purchase Type".AsInteger() = 2 then
                                    ContractScope.SetFilter("G/L Account No.", '%1', "No.")
                                else
                                    if PurchaseContract."Purchase Type".AsInteger() = 3 then
                                        ContractScope.SetFilter("Resource No.", '%1', "No.")
                                    else
                                        if PurchaseContract."Purchase Type".AsInteger() = 4 then
                                            ContractScope.SetFilter("Fixed Asset No.", '%1', "No.");


                            if ContractScope.FindFirst() then
                                Validate("Direct Unit Cost", ContractScope."Unit Price");
                        end;

                    end;

                end;

            end;
        }
        field(50061; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
        }
        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                UserSetup: Record "User Setup";
                ItemL: Record Item;
                ContractScope: Record "Contract Scope";
                PurchaseHeaderTable: Record "Purchase Header";
                PurchaseContract: Record "Purchase Contract";
            begin
                /*UserSetup.Reset();                                VRATITI ZA BRISANJE BROJA UGOVORA
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup."Contract No." := '';
                    Message(UserSetup."Contract No.");
                    UserSetup.Modify();
                end;*/
                //

                /*Message(Format("No."));
                "Direct Unit Cost":=59;
                Validate("Direct Unit Cost", 40);*/

                PurchaseHeaderTable.Reset();
                PurchaseHeaderTable.SetFilter("No.", '%1', "Document No.");
                if PurchaseHeaderTable.FindFirst() then begin
                    ContractScope.Reset();
                    ContractScope.SetFilter("Contract Entry No.", '%1', PurchaseHeaderTable."Contract Entry No."); //MORAM NACI I VRSTU NABAVKE I DS

                    PurchaseContract.Reset();
                    PurchaseContract.SetFilter("Contract Entry No.", '%1', PurchaseHeaderTable."Contract Entry No."); //ako je ugovor označen sa fiksnom cijenom
                    if PurchaseContract.FindFirst() then begin
                        if PurchaseContract."Fixed Price" then begin
                            if PurchaseContract."Purchase Type".AsInteger() = 1 then
                                ContractScope.SetFilter("Item No.", '%1', "No.")
                            else
                                if PurchaseContract."Purchase Type".AsInteger() = 2 then
                                    ContractScope.SetFilter("G/L Account No.", '%1', "No.")
                                else
                                    if PurchaseContract."Purchase Type".AsInteger() = 3 then
                                        ContractScope.SetFilter("Resource No.", '%1', "No.")
                                    else
                                        if PurchaseContract."Purchase Type".AsInteger() = 4 then
                                            ContractScope.SetFilter("Fixed Asset No.", '%1', "No.");
                            if ContractScope.FindFirst() then
                                Validate("Direct Unit Cost", ContractScope."Unit Price");
                        end;

                    end;

                end;

            end;
        }
        modify("Amount Including VAT")
        {
            trigger OnAfterValidate()
            begin
                Message(Rec."Contract No.");
                Message(Rec."Contract Entry No.");
            end;
        }

    }
    trigger OnBeforeModify() //R
    begin
        if (rec.type = rec.Type::"Fixed Asset") then begin
            if rec.Quantity <> 1 then
                Error(Text000);

            if rec."VAT Rounding" < xrec."VAT Rounding" then
                validate("VAT Difference", "VAT Rounding");

        end;
    end;

    var
        myInt: Integer;
        PurchaseHeaderTable: Record "Purchase Header";
        VendorTable: Record Vendor;
        Text000: Label 'Quantity must be equal 1!';//
}
