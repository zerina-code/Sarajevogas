pageextension 50126 "Customer Template" extends "Customer Templ. List"
{
    layout
    {
        // Add changes to page layout here
        modify(Description) { Visible = false; }
        addafter(Code)
        {
            field("Description 2"; "Description 2") { ApplicationArea = all; }
            field("Bill Category"; "Bill Category") { }
        }
        modify("Contact Type") { Visible = false; }





    }


    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."CNG User" = true then begin
                Rec.SetFilter(CNG, '%1', true);
            end;


        end;

    end;





}