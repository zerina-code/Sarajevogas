pageextension 50001 "Warehouse Receipt Extends" extends "Warehouse Receipt"
{

    //ED 

    layout
    {

        addafter("Posting Date")
        {
            field("Employee No."; "Employee No.")
            {
                ApplicationArea = All;
            }
            field("Employee Name"; "Employee Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sorting Method")
        {
            field("Driver No."; "Driver No.")
            {
                ApplicationArea = All;
            }
            field("Driver Name"; "Driver Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Shipping Agent Name"; "Shipping Agent Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Transport Document No."; "Transport Document No.")
            {
                ApplicationArea = All;
            }
            field(Supplier; Supplier)
            {
            }
            field("Truck Number"; "Truck Number")
            {
                ApplicationArea = All;
            }
            field("Vendor No."; "Vendor No.") { ApplicationArea = all; Editable = false; }
            field("Vendor Name"; "Vendor Name") { ApplicationArea = all; Editable = false; }
            field("CD Number"; "CD Number")
            {
                ApplicationArea = All;
            }
            field("Sales Header No."; "Sales Header No.") { ApplicationArea = All; }
            field("RN Source"; "RN Source") { ApplicationArea = All; }
            field(Address; Address) { ApplicationArea = All; }

        }
        addafter("Assignment Time")
        {
            field("Vendor Date"; "Vendor Date")
            {
                ApplicationArea = All;

            }
            field("Order Date"; "Order Date")
            {
                ApplicationArea = All;
                Visible = false;



            }

        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Zone Code")
        {
            Visible = false;
        }
        modify("Sorting Method")
        {
            Visible = false;
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

        /*  addfirst(factboxes)
          {
              part(Control1; "Item Tracking Lines")
              {
                  ApplicationArea = Warehouse;
                  //Provider = WhseReceiptLines;
                  //SubPageLink = "Item No." = FIELD("Item No.");
                  //  Visible = true;
              }
          }
          */
        addfirst(factboxes)
        {
            part(ResEntr; "Reservation Entries")
            {
                ApplicationArea = Warehouse;
                Caption = 'Serial numbers';
                Provider = WhseReceiptLines;
                SubPageLink = "Item No." = FIELD("Item No."), "Source ID" = FIELD("Source No."), Positive = filter(true);
                //  Visible = true;
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action("Quality Quantity Report")
            {
                Caption = 'Quality Quantity Report';
                Image = InventoryCalculation;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(WarehouseReceiptHeader);
                    Report.RunModal(50078, true, false, WarehouseReceiptHeader);
                end;
            }
            action("Complaint Report")
            {
                Caption = 'Complaint Report';
                Image = UntrackedQuantity;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ComplaintReport: Report ComplaintReport;
                begin
                    ComplaintReport.Run();
                end;
            }
            action("Print Small Identification Cards")
            {
                Caption = 'Print Small Identification Cards';
                Image = Card;
                Promoted = true;
                PromotedCategory = Category4;
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
                PromotedCategory = Category4;
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
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";

        PrintSmallCardsReport: Report PrintSmallCards;
        PrintLargeCardsReport: Report PrintLargeCards;
        PostedSubform: Page "Posted Whse. Receipt Subform";
        Posted: Record "Posted Whse. Receipt Line";
}
