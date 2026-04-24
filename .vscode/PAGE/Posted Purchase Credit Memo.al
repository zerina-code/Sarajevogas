pageextension 50000 PostedPurchaseCreditMemo extends "Posted Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Posted Order confirmation")
            {
                Caption = 'Posted Purchase Order confirmation action';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    Report.RunModal(4444, true, true, Rec);
                end;
            }

        }
    }

    var
        myInt: Integer;
}