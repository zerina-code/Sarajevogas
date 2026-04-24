pageextension 50125 Customer_Template_Card extends "Customer Templ. Card"
{
    layout
    {
        modify(Description) { Visible = false; }
        addafter(Code) { field("Description 2"; "Description 2") { ApplicationArea = All; } field(CNG; CNG) { ApplicationArea = all; } }
        // Add changes to page layout here
        modify("Contact Type") { Visible = false; }
        modify("Address & Contact") { Visible = false; }
        modify(Invoicing) { Visible = False; }
        modify(Payments) { Visible = False; }
        modify(Shipping) { Visible = False; }
        modify(Blocked)


        {
            Visible = false;
        }
        addafter(CNG)
        {
            field(NN; NN) { ApplicationArea = all; }
            field("Bill Category"; "Bill Category") { }
            field("No. Series Bill"; "No. Series Bill") { }
            field("Undo No. Series Bill"; "Undo No. Series Bill") { }
            field("Posting No. Series Bill"; "Posting No. Series Bill") { }
            field("Undo Posting No. Series Bill"; "Undo Posting No. Series Bill") { }
            field("Contact Phone"; "Contact Phone") { }
            field("Advance GK"; "Advance GK") { }
            field("Advance No. Series Bill";"Advance No. Series Bill"){}
            field("Post. Advance No. Series Bill";"Post. Advance No. Series Bill"){}
             field("Corr. Advance No. Series Bill";"Corr. Advance No. Series Bill"){}
            field("Corr. Post. Advance No. Series Bill";"Corr. Post. Advance No. Series Bill"){}
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Dimensions) { Visible = false; }
        modify(CopyTemplate) { Visible = false; }
    }

    var
        myInt: Integer;
}