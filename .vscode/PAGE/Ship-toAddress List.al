pageextension 50090 ShipAddressList extends "Ship-to Address List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Address)
        {

            field("Municipality Code"; "Municipality Code") { ApplicationArea = all; }
            field("Municipality Name"; "Municipality Name") { ApplicationArea = all; }
            field("MZ-Code"; "MZ-Code") { ApplicationArea = all; }
            field("MZ Name"; "MZ Name") { ApplicationArea = all; }
            field(Street; Street) { ApplicationArea = all; }
            field("Street Name"; "Street Name") { ApplicationArea = all; }
            field("Street No."; "Street No.") { ApplicationArea = all; }
            field("Home No."; "Home No.") { ApplicationArea = all; }
            field("Apartment No."; "Apartment No.") { ApplicationArea = all; }
            field(Floor; Floor) { ApplicationArea = all; }



        }
        moveafter("Municipality Name"; City)
        moveafter(City; "Post Code")
        modify(Code) { Visible = false; }
        modify("Country/Region Code") { Visible = false; }
        modify("Location Code") { Visible = false; }
        modify(Address) { Editable = false; }
        modify(GLN) { Visible = false; }
        modify(Contact) { Visible = false; }
        modify("Address 2") { Visible = false; }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}