pageextension 50148 "Posted Service Invoice Subform" extends "Posted Service Invoice Subform"
{
    layout
    {
        // Add changes to page layout here


        addafter("Line Amount")
        {
            field("VAT %"; "VAT %") { }
            field("Amount Including VAT"; "Amount Including VAT") { }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}