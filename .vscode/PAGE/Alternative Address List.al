pageextension 50009 AlternativeAddressList extends "Alternative Address List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Code)
        {
            field("Employee No."; "Employee No.")
            {
                ApplicationArea = all;

            }
        }
        modify(Code)
        {
            Visible = false;
        }
        addafter("Name 2")
        {
            field("Address CIPS"; "Address CIPS")
            {
                ApplicationArea = all;
            }
            field("Post Code CIPS"; "Post Code CIPS")
            {
                ApplicationArea = all;
            }
            field("Municipality Code CIPS"; "Municipality Code CIPS")
            {
                ApplicationArea = all;
            }
            field("Municipality Name CIPS"; "Municipality Name CIPS")
            {
                ApplicationArea = all;
            }
            field("City CIPS"; "City CIPS")
            {
                ApplicationArea = all;
            }
            field("Place Of Living"; "Place Of Living")
            {
                ApplicationArea = all;
            }
            field("County CIPS"; "County CIPS")
            {
                ApplicationArea = all;
            }
            field("Entity Code CIPS"; "Entity Code CIPS")
            {
                ApplicationArea = all;
            }
            field("Country/Region Code CIPS"; "Country/Region Code CIPS")
            {
                ApplicationArea = all;

            }
            field("Date From (CIPS)"; "Date From (CIPS)")
            {
                ApplicationArea = all;
            }
            field("Date To (CIPS)"; "Date To (CIPS)")
            {
                ApplicationArea = all;
            }
        }
        moveafter("Date To (CIPS)"; Address)
        moveafter(Address; "Post Code")
        addafter("Post Code")
        {
            field("Municipality Code"; "Municipality Code")
            {
                ApplicationArea = all;
            }
            field("Municipality Name"; "Municipality Name")
            {
                ApplicationArea = all;
            }
        }
        addafter(County)
        {
            field("Entity Code"; "Entity Code")
            {
                ApplicationArea = all;
            }
            field("Country/Region Code"; "Country/Region Code")
            {
                ApplicationArea = all;
            }
            field("Date From"; "Date From")
            {
                ApplicationArea = all;
            }
            field("Date To"; "Date To")
            {
                ApplicationArea = all;
            }
            field(Active; Active)
            {
                ApplicationArea = all;
            }
        }

        moveafter("Municipality Name"; City)
        moveafter(City; County)





        modify("Name 2")
        {
            Visible = true;
        }
        moveafter(Name; "Name 2")




    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}