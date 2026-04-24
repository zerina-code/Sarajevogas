pageextension 50112 "Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here

        addafter("Vendor Shipment No.")
        {

            field("Vendor Date"; "Vendor Date") { ApplicationArea = all; Editable = false; }

        }
        modify("Location Code")
        {
            Visible = true;
        }





    }

    actions
    {
        addafter("&Print")
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
        PrintSmallCardsReport: Report PrintSmallCardsOrder;
        PrintLargeCardsReport: Report PrintLargeCardsOrder;


    var
        myInt: Integer;
}