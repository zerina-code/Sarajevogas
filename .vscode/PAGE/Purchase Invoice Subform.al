
pageextension 50069 "Purchase Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Posting Group"; "Posting Group")
            {
                Editable = true;
                Visible = true;

            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                Editable = true;
                Visible = true;
            }
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                Editable = true;
                Visible = true;

            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                Editable = true;
                Visible = true;

            }
        }
        addafter(Description)
        {
            field("Department Code"; "Department Code")
            {
                ApplicationArea = all;
            }
        }
        modify("Shortcut Dimension 1 Code")
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
        addafter("Qty. Assigned")
        {
            field("VAT Prod. Posting Group99627"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Rounding"; "VAT Rounding")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;
            }
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }

        modify("Line Discount %") { Visible = true; }
        modify("Line Discount Amount") { Visible = true; }
        modify("Line Amount") { Editable = false; }
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

    var
        PurchaseHeaderTable: Record "Purchase Header";
        PurchaseContract: Record "Purchase Contract";
}