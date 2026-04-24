pageextension 50066 PostedWhseReceipt extends "Posted Whse. Receipt"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Employee No."; "Employee No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Employee Name"; "Employee Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Assignment Time")
        {
            field("Vendor Date"; "Vendor Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Order Date"; "Order Date")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = false;
            }
            field("Driver No."; "Driver No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Driver Name"; "Driver Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Shipping Agent Name"; "Shipping Agent Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Transport Document No."; "Transport Document No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Supplier; Supplier)
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Truck Number"; "Truck Number")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Vendor No."; "Vendor No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Vendor Name"; "Vendor Name")
            {
                ApplicationArea = all;
                Editable = false;

            }
            field("CD Number"; "CD Number")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        modify("Assigned User ID")
        {
            Visible = false;

        }
        modify("Assignment Date")
        {
            Visible = false;
        }
        modify("Assignment Time")
        {
            Visible = false;
        }

        addfirst(factboxes)
        {
            part(ItemLedgerEntry; "Item Ledger Entry Factbox")
            {
                ApplicationArea = Warehouse;
                Caption = 'Serial numbers';
                Provider = PostedWhseRcptLines;
                SubPageLink = "Item No." = field("Item No."), "Document No." = field("Posted Source No.");
            }
        }

    }
    actions
    {
        addafter("Put-away List")
        {

            action("Print Small Identification Cards")
            {
                Caption = 'Print Small Identification Cards';
                Image = Card;
                Promoted = true;
                // PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PrintSmallCardsReport.SetParam("No.");

                    PrintSmallCardsReport.Run();
                end;
            }
            action("Print Large Identification Cards")
            {
                Caption = 'Print Large Identification Cards';
                Image = Card;
                Promoted = true;
                //PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PrintLargeCardsReport.SetParam("No.");
                    PrintLargeCardsReport.Run();
                end;
            }
        }
    }

    var
        PrintSmallCardsReport: Report PrintSmallCardsCopy;
        PrintLargeCardsReport: Report PrintLargeCardsCopy;
}
