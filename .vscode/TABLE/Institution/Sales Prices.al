pageextension 50102 "Sales Prices" extends "Sales Prices"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Unit Price")
        {
            field("Retail Unit Price"; "Retail Unit Price") { ApplicationArea = all; }
            field("Wholesale Unit Price"; "Wholesale Unit Price") { ApplicationArea = all; }
            field("Purchase unit price"; "Purchase unit price") { }
            field("Unit price of distribution"; "Unit price of distribution") { }


        }
        addafter("Unit Price")
        {
            field("Maintenance Resource No."; "Maintenance Resource No.") { ApplicationArea = all; }
            field("Price not by Gauge"; "Price not by Gauge") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}