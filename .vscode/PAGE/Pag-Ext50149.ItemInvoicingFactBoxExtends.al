pageextension 50149 "Item Invoicing FactBox Extends" extends "Item Invoicing FactBox"
{
    layout
    {
        modify("No.")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Costing Method")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Cost is Adjusted")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Standard Cost")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Unit Cost")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Overhead Rate")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Indirect Cost %")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Last Direct Cost")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Profit %")
        {
            Visible = not IsCalledFromTransferOrder;
        }
        modify("Unit Price")
        {
            Visible = not IsCalledFromTransferOrder;
        }

        addlast(content)
        {
            field(InventoryGL; Rec.InventoryGL)
            {
                ApplicationArea = Basic, Suite;
                Visible = IsCalledFromTransferOrder;
            }
        }
    }


    trigger OnOpenPage()
    var
        TransferOrderState: Codeunit "Transfer Order State";
    begin
        IsCalledFromTransferOrder := TransferOrderState.GetCalledFromTransferOrder();
    end;

    trigger OnClosePage()
    var
        TransferOrderState: Codeunit "Transfer Order State";
    begin
        TransferOrderState.ClearState();
    end;

    var
        IsCalledFromTransferOrder: Boolean;

    procedure SetCalledFromTransferOrder(Value: Boolean)
    begin
        IsCalledFromTransferOrder := Value;
        CurrPage.Update(false);
    end;

}
