pageextension 50070 PurchaseInvoice extends "Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Buy-from Vendor No.")
        {
            field("Contract Entry No."; "Contract Entry No.")
            {
                ApplicationArea = all;
            }
            field("Contract No."; "Contract No.")
            {
                ApplicationArea = all;
            }
        }
        modify("Posting Description")
        {
            Visible = true;
            editable = true;

        }
        addafter(Status)
        {
            field(KUF; KUF) { }
        }
        modify("Currency Code")
        {
            Visible = true;
        }



        addafter("Document Date")
        {
            field("VAT Date"; "VAT Date")
            {

            }
        }

        addafter("VAT Bus. Posting Group")
        {
            field("Vendor Posting Group"; Rec."Vendor Posting Group") { Editable = true; }
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                Validate(Rec."Posting Date", Rec."Document Date");
                //Rec."Posting Date" := Rec."Document Date";
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    /*PurchInvLine.Reset();
        PurchInvLine.SetFilter("Document No.", '%1', 'UF22/+0009');
        if PurchInvLine.FindFirst() then begin
            Message(Format(PurchInvLine."Cost Type"));
        end;*/

    var
        myInt: Integer;
}
