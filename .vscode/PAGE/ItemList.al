pageextension 50115 ItemList extends "Item List"

{


    layout
    {
        addafter(InventoryField)
        {
            field(InventoryGL; InventoryGL)
            {


                ApplicationArea = Basic, Suite, Invoicing;
                HideValue = IsNonInventoriable;
                ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
            }

        }
    }
    actions
    {
        addafter("Inventory - List")
        {
            action("&Import")
            {
                Caption = '&Import';
                Image = Import;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = xmlport "Item Posting Groups Import";

            }
            action("Import Plan consumption")
            {

                Caption = 'Import Plan consumptiont';
                Image = Import;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                trigger onaction()
                var
                    myInt: Integer;
                    AreaR: Record "Area";
                    AreaP: page Areas;

                begin
                    AreaR.Reset();
                    AreaR.SetFilter(Year, '%1', Date2DMY(today, 3));
                    AreaP.SetTableView(AreaR);
                    AreaP.Run();
                end;


            }

            action(ImportItemsEE2)
            {
                ApplicationArea = all;
                Caption = 'Import Items EE2';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportItemsEE2: XmlPort "ImportArtikalaSaGas";

                begin
                    ImportItemsEE2.RUN;
                end;
            }

        }
    }
    trigger OnOpenPage()
    var
        TransferOrderState: Codeunit "Transfer Order State";
    begin
        TransferOrderState.ClearState();
    end;

    var
        myInt: Integer;
}