pageextension 50060 "PostedPurchaseInvoice" extends "Posted Purchase Invoice"
{

    //ED

    layout
    {
        // Add changes to page layout here
        addbefore("Buy-from Vendor Name")
        {
            field("Contract Entry No."; "Contract Entry No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Contract No."; "Contract No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Contract Purchase Item"; "Contract Purchase Item")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Responsibility Center")
        {
            field("User ID Number"; "User ID Number")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Commercial UserID"; "Commercial UserID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Accounting UserID"; "Accounting UserID")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(KUF; KUF) { Editable = True; }
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Payment Discount %")
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
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        /*addafter(Print)
        {
            action("Posted Purchase Order confirmation")
            {
                Caption = 'Posted Purchase invoice Order confirmation action';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    Report.RunModal(4443, true, true, Rec);
                end;
            }

        }*/
        addafter("Approvals")
        {
            action("Purchase calculation")
            {
                ApplicationArea = All;
                Caption = 'Purchase calculation', Comment = 'Nabavna kalkulacija';
                Image = Document;
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    PurchCalc: Report "Purchase Cost Calc. - Procur.";
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    PurchInvHeader.Reset();
                    PurchInvHeader.SetFilter("No.", Rec."No.");
                    PurchCalc.SetTableView(PurchInvHeader);
                    PurchCalc.RUN();
                end;
            }

        }
    }

    var
        PurchInvLine: Record "Purch. Inv. Line";
}