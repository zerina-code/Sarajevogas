page 50213 "Transfer Line Factbox"
{
    Caption = 'Transfer Line Factbox';
    PageType = ListPart;
    SourceTable = "Transfer Line";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number that is associated with the line or entry.';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        if TransferHeader.Get(Rec."Document No.") then
                            Page.Run(PAGE::"Transfer Order", TransferHeader);
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of the item that will be processed as the document stipulates.';
                }
                field("Quantity Shipped"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item that is transferred.';
                }
                field(ItemName; ItemName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the transferred item.';
                    Caption = 'Item Name';
                }
            }
        }
    }

    var
        Item: Record Item;
        ItemName: Text[100];
        TransferHeader: Record "Transfer Header";
        CurrentTransferOrderNo: Code[20];

    trigger OnAfterGetRecord()
    begin
        If Item.Get(Rec."Item No.") then
            ItemName := Item.Description;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange("Derived From Line No.", 0);
    end;
}
