pageextension 50129 Posted_Sales_Shipments extends "Posted Sales Shipments"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    begin
        LocationF := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if UserSetup."CNG User" = true then begin

                SetFilter(CNG, '%1', true);

            end;
        end;
    end;

    trigger OnOpenPage()
    begin


        LocationF := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if UserSetup."CNG User" = true then begin

                SetFilter(CNG, '%1', true);

            end;
        end;
    end;




    var
        myInt: Integer;
        WE: Record "Warehouse Employee";
        UserSetup: Record "User Setup";
        LocationF: text[10000];
        LocationT: Record Location;
}