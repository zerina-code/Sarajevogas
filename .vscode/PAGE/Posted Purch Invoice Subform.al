pageextension 50059 "Posted Purc Invoice Subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Cost Type"; "Cost Type")
            {
                ApplicationArea = All;

                /*trigger OnValidate()
                begin
                    PurchInvHeaderTable.Reset();
                    PurchInvHeaderTable.SetFilter("No.", '%1', Rec."Document No.");
                    if PurchInvHeaderTable.FindFirst() then begin
                        PurchaseContractTable.Reset();
                        PurchaseContractTable.SetFilter("No.", '%1', PurchInvHeaderTable."Contract No.");
                        if PurchaseContractTable.FindFirst() then begin
                            PurchaseContractTable."Investicioni trošak" := Rec."Amount Including VAT";
                            PurchaseContractTable.Modify();
                        end;
                    end;


                end;*/
            }


            field("Department Code"; "Department Code")
            {
                ApplicationArea = all;
            }
        }

        modify("Job No.")
        {
            Visible = false;
        }
        modify("Deferral Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here

    }



    var
        PurchaseContractTable: Record "Purchase Contract";
        PurchInvHeaderTable: Record "Purch. Inv. Header";
        PurchInvLineTable: Record "Purch. Inv. Line";
}