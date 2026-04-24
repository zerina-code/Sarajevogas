pageextension 50052 "Location Card Extends" extends "Location Card"
{
    layout
    {
        addafter(Name)
        {
            field(Order; Order) { ApplicationArea = all; }
        }
        modify(Bins)
        {
            Visible = false;
        }
        modify("Bin Policies")
        {
            Visible = false;
        }
        modify(ShowMap)
        {
            Visible = false;
        }
        addbefore("Use As In-Transit")
        {
            field("Use As In-Revers"; "Use As In-Revers")
            {
                Visible = true;
                ApplicationArea = all;

            }
            field("CNG MP"; "CNG MP") { ApplicationArea = all; }
            field("CNG VP"; "CNG VP") { ApplicationArea = all; }
            field("CNG VL"; "CNG VL") { ApplicationArea = all; }
            field("Hide PP"; "Hide PP") { }
        }
        addafter(Contact)
        {
            field("Responsible Person"; "Responsible Person")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Responsible Person Name"; "Responsible Person Name")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Responsible Person Position"; "Responsible Person Position")
            {
                Visible = true;
                ApplicationArea = all;
                //Editable = false;
            }
            field("Responsible Person Exit"; "Responsible Person Exit")
            {
                Visible = true;
                ApplicationArea = all;

            }
            field("Responsible Person Exit Unit"; "Responsible Person Exit Unit")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Responsible Person Exit Position"; "Responsible Person E Position")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Responsible Person Exit Name"; "Responsible Person Exit Name")
            {
                Visible = true;
                ApplicationArea = all;

            }
            field("Invoice Responsible Person"; "Invoice Responsible Person")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Invoice Responsible Person Position"; "Invoice Responsible Person Pos")
            {
                Visible = true;
                ApplicationArea = all;
            }
            field("Invoice Responsible Person Name"; "Invoice Responsible Person N")
            {
                Visible = true;
                ApplicationArea = all;
            }

        }
    }
}