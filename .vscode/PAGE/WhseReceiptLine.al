pageextension 50100 WhseReceiptLine extends "Whse. Receipt Lines"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("&Line") { Visible = false; }
        addbefore("&Line")
        {
            action("Show &Whse. Document2")
            {
                ApplicationArea = Warehouse;
                Caption = 'Show &Whse. Document';
                Image = ViewOrder;
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View the related warehouse document.';

                trigger OnAction()
                var
                    WhseRcptHeader: Record "Warehouse Receipt Header";
                begin
                    WhseRcptHeader.Get("No.");
                    PAGE.Run(PAGE::"Warehouse Receipt", WhseRcptHeader);
                end;
            }
            action("&Show Source Document Line2")
            {
                ApplicationArea = Warehouse;
                Caption = '&Show Source Document Line';
                Image = ViewDocumentLine;
                ToolTip = 'View the source document line that the receipts is related to. ';

                trigger OnAction()
                var
                    WMSMgt: Codeunit "WMS Management";
                begin
                    WMSMgt.ShowSourceDocLine(
                      "Source Type", "Source Subtype", "Source No.", "Source Line No.", 0)
                end;
            }
        }

    }

    var
        myInt: Integer;
}