pageextension 50258 "Customer Lookup Ext" extends "Customer Lookup"
{
    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin
        UserSetup.GET(UserID);
        IF ((USerSetup."CNG User") OR (UserSetup."CNG Administrator"))
        then
            rec.SETFILTER("Customer Category", '%1', rec."Customer Category"::CNG);


    end;
}
