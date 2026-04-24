pageextension 50161 "Inventory Posting Groups" extends "Inventory Posting Groups"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(GlAccountNo; GlAccountNo) { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}