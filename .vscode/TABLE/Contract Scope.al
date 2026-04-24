table 50155 "Contract Scope"
{
    Caption = 'Contract Scope';
    DrillDownPageID = "Contract Scope";
    LookupPageID = "Contract Scope";

    fields
    {
        field(1; "Contract Entry No."; Code[20])
        {
            Caption = 'Contract Entry No.';
            TableRelation = "Purchase Contract";

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                PurchaseContractTable.Reset();
                PurchaseContractTable.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No."); //trazim prema rednom broju ugovora
                //PurchaseContractTable.SetFilter("No.", '%1', Rec."Contract No.");
                /*if PurchaseContractTable.FindFirst() then
                    Rec."Purchase Type" := FORMAT(PurchaseContractTable."Purchase Type");*/

                UserSetup.Reset(); //zbog filtriranja na redovima narudzbenice
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup."Contract No." := '';
                    UserSetup.Modify();

                end;
            end;
        }
        field(2; "Item No."; Code[50])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";

            trigger OnValidate()
            var
                PurchHeader: Record "Purchase Line";
            begin
                ItemTable.Reset();
                ItemTable.SetFilter("No.", '%1', Rec."Item No.");
                if ItemTable.FindFirst() then
                    "Item Name" := ItemTable.Description;
            end;
        }
        field(3; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            Editable = false;
        }
        field(4; "Resource No."; Code[50])
        {
            Caption = 'Resource No.';
            TableRelation = Resource."No.";

            trigger OnValidate()
            begin
                ResourceTable.Reset();
                ResourceTable.SetFilter("No.", '%1', Rec."Resource No.");
                if ResourceTable.FindFirst() then
                    "Resource Name" := ResourceTable.Name;
            end;
        }
        field(5; "Resource Name"; Text[100])
        {
            Caption = 'Resource Name';
            Editable = false;
        }
        /*field(6; "Purchase Type"; Text[20])
        {
            Caption = 'Purchase Type';
            Editable = false;
        }*/
        field(7; "G/L Account No."; Code[50])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account"."No.";

            trigger OnValidate()
            begin
                GLAccountTable.Reset();
                GLAccountTable.SetFilter("No.", '%1', Rec."G/L Account No.");
                if GLAccountTable.FindFirst() then
                    "G/L Account Name" := GLAccountTable.Name;
            end;
        }
        field(8; "G/L Account Name"; Text[100])
        {
            Caption = 'G/L Account Name';
            Editable = false;
        }
        field(9; "Quantity"; Integer)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Total := "Unit Price" * Quantity;

                PurchaseContractTable.Reset();
                PurchaseContractTable.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                if PurchaseContractTable.FindFirst() then begin
                    if (PurchaseContractTable."Purchase Type" = PurchaseContractTable."Purchase Type"::"Osnovna sredstva") then begin
                        if (rec.Quantity <> 1) then
                            Error(Text000)
                        else
                            Quantity := 1;
                    end;
                end;

            end;
        }
        field(10; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Total := "Unit Price" * Quantity;

            end;
        }
        field(12; "Direktni sporazum"; Boolean)
        {
            Caption = 'Vrsta postupka';
        }
        /*field(13; "Exemption"; Boolean)
        {
            Caption = 'Exemption';
        }*/
        field(13; Type; Enum "Purchase Line Type - CS")
        {
            Caption = 'Type';
        }
        field(14; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
        field(15; "Fixed Asset No."; Code[50])
        {
            Caption = 'Br.osnovnog sredstva';
            TableRelation = "Fixed Asset"."No.";

            trigger OnValidate()
            begin
                FixedAssetTable.Reset();
                FixedAssetTable.SetFilter("No.", '%1', Rec."Fixed Asset No.");
                if FixedAssetTable.FindFirst() then begin
                    "Fixed Asset Name" := FixedAssetTable.Description;

                end;
            end;
        }
        field(16; "Fixed Asset Name"; Text[100])
        {
            Caption = 'Naziv osnovnog sredstva';
            Editable = false;
        }
        field(17; "Total"; Decimal)
        {
            Caption = 'Total';

        }



    }

    keys
    {
        key(Key1; "Contract Entry No.", "Item No.", "Resource No.", "G/L Account No.", "Fixed Asset No.", "Unit Price")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        //Message('elmira');
    end;

    var
        ItemTable: Record Item;
        ResourceTable: Record Resource;
        PurchaseContractTable: Record "Purchase Contract";
        GLAccountTable: Record "G/L Account";
        FixedAssetTable: Record "Fixed Asset";
        Text000: Label 'Quantity must be equal 1!';
}

