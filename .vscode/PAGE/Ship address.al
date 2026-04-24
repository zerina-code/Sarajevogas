pageextension 50089 ShipAddress extends "Ship-to Address"
{
    layout
    {
        // Add changes to page layout here
        addafter(Address)
        {

            field(Street; Street) { ApplicationArea = all; }
            field("Street Name"; "Street Name") { ApplicationArea = all; Editable = false; }
            field("Street No."; "Street No.") { ApplicationArea = all; }
            field("Municipality Code"; "Municipality Code") { ApplicationArea = all; Editable = false; }
            field("Municipality Name"; "Municipality Name") { ApplicationArea = all; Editable = false; }
            field("MZ-Code"; "MZ-Code") { ApplicationArea = all; Editable = false; }
            field("MZ Name"; "MZ Name") { ApplicationArea = all; Editable = false; }

            field("Home No."; "Home No.") { ApplicationArea = all; Editable = false; }
            field("Apartment No."; "Apartment No.") { ApplicationArea = all; Editable = false; }
            field(Floor; Floor) { ApplicationArea = all; Editable = false; }
            field("Measuring Point Stroke"; "Measuring Point Stroke") { ApplicationArea = all; Editable = false; }
            field("Measuring Point string"; "Measuring Point string") { ApplicationArea = all; Editable = false; }
            field("Zone stroke"; "Zone stroke") { ApplicationArea = all; Editable = false; }


        }
        moveafter("Municipality Name"; City)
        moveafter(City; "Post Code")
        modify(Code) { Visible = false; }
        modify("Country/Region Code") { Visible = false; }
        modify("Service Zone Code") { Visible = false; }
        modify("Location Code") { Visible = false; }
        modify(Address) { Editable = false; }
        modify(GLN) { Visible = false; }
        modify(Contact) { Visible = false; }
        modify("Address 2") { Visible = false; }
        modify("Fax No.") { Visible = false; }
        modify("E-Mail") { Visible = false; }
        modify("Home Page") { Visible = false; }
        modify("Shipping Agent Service Code") { Visible = false; }
        modify("Shipping Agent Code") { Visible = false; }
        modify("Shipment Method Code") { Visible = false; }
        modify("Phone No.") { Visible = false; }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}