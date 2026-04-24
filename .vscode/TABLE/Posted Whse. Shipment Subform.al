pageextension 50162 "Posted Whse. Shipment Subform" extends "Posted Whse. Shipment Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {
            field("G/L Account No."; "G/L Account No.") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}