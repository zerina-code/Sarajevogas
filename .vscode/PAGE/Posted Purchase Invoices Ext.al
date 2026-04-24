pageextension 50106 "Posted Purchase Invoices Ext" extends "Posted Purchase Invoices"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Contract Purchase Item"; "Contract Purchase Item")
            {
                ApplicationArea = All;
            }
            field("User ID Number"; "User ID Number")
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor Invoice No.")
        {


            field("VAT Date"; "VAT Date")
            {
                ApplicationArea = All;
            }
            field("KUF"; KUf)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("Co&mments")
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

}