pageextension 50150 "Item Tracking Lines Ext" extends "Item Tracking Lines"
{
    trigger OnClosePage()
    var
        RE: Record "Reservation Entry";
    begin
        RE.Reset();
        RE.SetFilter("Item No.", '%1', Rec."Item No.");
        RE.SetFilter("Source ID", '%1', Rec."Source ID");
        RE.SetFilter(Positive, '%1', true);
        if RE.FindFirst() then begin
            CurrPage.Update(false);
        end;
    end;
}
