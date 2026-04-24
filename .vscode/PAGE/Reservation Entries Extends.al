pageextension 50147 "Reservation Entries Extends" extends "Reservation Entries"
{
    layout
    {
        addbefore("Reservation Status")
        {
            field("Serial Number"; "Serial No.")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Item Number"; "Item No.")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        modify("Reservation Status") { Visible = false; }
        modify("Location Code") { Visible = false; }
        modify("Quantity (Base)") { Visible = false; }
        modify("Description") { Visible = false; }
        modify("Source Batch Name") { Visible = false; }
        modify(ReservedFrom) { Visible = false; }
        modify("Transferred from Entry No.") { Visible = false; }
        modify("Entry No.") { Visible = false; }
        modify("ReservEngineMgt.CreateForText(Rec)") { Visible = false; }
        modify("Item No.") { Visible = false; }
    }


    actions
    {
        // Add changes to page actions here
    }
    /*
        trigger OnAfterGetCurrRecord()
        begin
            CurrPage.Update();
        end;
    */
    var
        myInt: Integer;
}