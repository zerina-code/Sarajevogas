pageextension 50058 "Posted Purch Inv Lines" extends "Posted Purchase Invoice Lines"
{
    layout
    {
        // Add changes to page layout here
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Variant Code")
        {
            Visible = false;
        }
        modify("Depreciation Book Code")
        {
            Visible = false;
        }
        modify("Job No.")
        {
            Visible = false;
        }
        modify("Insurance No.")
        {
            Visible = false;
        }
        modify("Depr. until FA Posting Date")
        {
            Visible = false;
        }
        modify("Depr. Acquisition Cost")
        {
            Visible = false;
        }
        modify("Budgeted FA No.")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor No.")
        {
            field("Purchase Plan Code"; "Purchase Plan Code")
            {
                ApplicationArea = all;
            }
            field("Direktni sporazum"; "Direktni sporazum")
            {
                ApplicationArea = all;
            }
            field("Purchase Type"; "Purchase Type")
            {
                ApplicationArea = all;
            }
            field("Plan No."; "Plan No.")
            {
                ApplicationArea = all;
            }
            field("Contract Entry No."; "Contract Entry No.")
            {
                ApplicationArea = all;
            }
            field("Contract No."; "Contract No.")
            {
                ApplicationArea = all;
            }
            field("Cost Type"; "Cost Type")
            {
                ApplicationArea = all;
            }

            field("Department Code"; "Department Code")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}
