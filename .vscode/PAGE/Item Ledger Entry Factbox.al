page 50209 "Item Ledger Entry Factbox"
{
    Caption = 'Item Ledger Entry Factbox';
    PageType = ListPart;
    SourceTable = "Item Ledger Entry";
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
