pageextension 50121 "Sales Shipment Ext." extends "Posted Sales Shpt. Subform"
{

    layout
    {

        addafter("No.")
        {

            field("Sell-to Customer No."; "Sell-to Customer No.") { }


        }


        addafter("Shipment Date")

        {
            field("Driver Name"; "Driver Name") { }
            field("Driver Registration No."; "Driver Registration No.") { }
            field("Driver Type"; "Driver Type") { }
            field("Type of vehicle"; "Type of vehicle") { }
            field("Payment Method Code"; "Payment Method Code") { }
            field("Fiscal No."; "Fiscal No.") { ApplicationArea = all; }
            field("Fiscal User"; "Fiscal User") { ApplicationArea = all; Editable = false; }
            field("Fiscal DateTime"; "Fiscal DateTime") { ApplicationArea = all; Editable = false; }
            field("Amount"; "Amount") { ApplicationArea = all; Editable = false; }
            field("Amount Incl. VAT"; "Amount Incl. VAT") { ApplicationArea = all; Editable = false; }








        }
    }

    trigger OnOpenPage()
    begin
        //  setfilter("Posting Date", '%1', TODAY);
    end;
}

