pageextension 50105 "Purchase Order List Extends" extends "Purchase Order List"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("Contract Purchase Item";"Contract Purchase Item")
            {
                ApplicationArea = All;
            }
            field("User ID Number";"User ID Number")
            {
                ApplicationArea = All;
            }
        }        
    }

    actions
    {
        
    }

    var

}