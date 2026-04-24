
pageextension 50071 "Purchase Order Subform Extends" extends "Purchase Order Subform"
{
    layout
    {

        modify(Description)
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
                ItemR: Record Item;

            begin
                if rec.Type = rec.Type::Item then begin
                    ItemR.Reset();
                    ItemR.SetFilter("No.", '%1', rec."No.");
                    if ItemR.FindFirst() then begin
                        if ItemR.Description <> rec.Description then
                            Error(Text001);
                    end;
                end;


            end;


        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group") { Visible = true; }

        addbefore("VAT Prod. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group") { }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group") { }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group") { }
            field("VAT Rounding"; "VAT Rounding")
            {
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }

        addafter("VAT Prod. Posting Group")
        {
            field("Posting Group"; "Posting Group") { Editable = true; }
        }


        //R

        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                ContractScope: Record "Contract Scope";
                Text000: Label 'Količina mora biti manja ili jednaka količini na ugovoru!';
            begin
                ContractScope.Reset();
                ContractScope.SetFilter("Contract Entry No.", '%1', "Contract Entry No.");
                ContractScope.SetFilter("Item No.", '%1', "No.");
                if ContractScope.FindFirst() then begin
                    if ContractScope.Quantity < rec.Quantity then
                        Error(Text000);
                end;
            end;
        }
        addafter(Description)
        {
            field("Cost Type"; "Cost Type")
            {
                Caption = 'Cost Type';
            }
        }
        addafter("Quantity Invoiced")
        {
            field("Department Code"; "Department Code")
            {
                Caption = 'Department Code';
                ApplicationArea = all;
            }
        }
        moveafter("Quantity Invoiced"; "VAT Prod. Posting Group")
    }



    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        PurchaseHeaderTable.Reset();
        PurchaseHeaderTable.SetFilter("No.", '%1', Rec."Document No.");
        if PurchaseHeaderTable.FindFirst() then begin
            Rec."Contract No." := PurchaseHeaderTable."Contract No.";
            Rec."Contract Entry No." := PurchaseHeaderTable."Contract Entry No."
        end;

        PurchaseContract.Reset();
        PurchaseContract.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
        if PurchaseContract.FindFirst() then begin
            Rec."Plan No." := PurchaseContract."Entry No. Plan";
            Rec."Purchase Plan Code" := PurchaseContract."Purchase Plan Code";
            Rec."Direktni sporazum" := PurchaseContract."Direktni sporazum";
            Rec."Purchase Type" := PurchaseContract."Purchase Type";
        end;
    end;

    trigger OnClosePage()
    var
        UserSetup: Record "User Setup";
        ItemL: Record Item;
        ContractScope: Record "Contract Scope";
        PurchaseHeaderTable: Record "Purchase Header";
        PurchaseContract: Record "Purchase Contract";
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            UserSetup."Contract No." := '';
            //Message(UserSetup."Contract No.");
            UserSetup.Modify();
        end;
    end;

    var
        ItemTable: Record Item;
        PurchaseHeaderTable: Record "Purchase Header";
        PurchaseContract: Record "Purchase Contract";
        ContractScope: Record "Contract Scope";

        DocumentTotals: Codeunit "Document Totals";
        TotalPurchaseHeader: Record "Purchase Header";
        TotalPurchaseLine: Record "Purchase Line";
        RefreshMessageText: Text;
        RefreshMessageEnabled: Boolean;
        Text001: Label 'Its not allowed to change Description';
        VATAmount: Decimal;
        InvDiscAmountEditable: Boolean;
        TotalAmountStyle: Text;

}