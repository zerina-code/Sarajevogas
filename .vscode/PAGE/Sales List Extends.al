pageextension 50080 SalesListExtends extends "Sales List"
{
    //ED

    layout
    {
        addbefore("Document Date")
        {
            field("Payment Type Invoice"; "Payment Type Invoice")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                Caption = 'Payment Type Invoice';
            }

        }

    }

    actions
    {

    }

    trigger OnAfterGetRecord()
    begin
        LocationF := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if UserSetup."CNG User" = true then begin

                LocationT.Reset();
                LocationT.SetFilter("CNG MP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';

                LocationT.Reset();
                LocationT.SetFilter("CNG VP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';


            end
            else begin

                WE.Reset();
                WE.SetFilter("User ID", '%1', UserId);
                if WE.FindSet() then
                    repeat
                        LocationF += we."Location Code" + '|';

                    until WE.Next() = 0;


            end;

            if (LocationF <> '') and (StrLen(LocationF) >= 2) then begin
                LocationF := CopyStr(LocationF, 1, StrLen(LocationF) - 1);
            end

        end;
        //
        if LocationF <> '' then begin
            SetFilter("Location Filter", LocationF);
        end;

    end;

    trigger OnOpenPage()
    begin

        LocationF := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if UserSetup."CNG User" = true then begin

                LocationT.Reset();
                LocationT.SetFilter("CNG MP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';

                LocationT.Reset();
                LocationT.SetFilter("CNG VP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';


            end
            else begin

                WE.Reset();
                WE.SetFilter("User ID", '%1', UserId);
                if WE.FindSet() then
                    repeat
                        LocationF += we."Location Code" + '|';

                    until WE.Next() = 0;


            end;

            if (LocationF <> '') and (StrLen(LocationF) >= 2) then begin
                LocationF := CopyStr(LocationF, 1, StrLen(LocationF) - 1);
            end

        end;
        //
        if LocationF <> '' then begin
            SetFilter("Location Filter", LocationF);
        end;


    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    var
        WE: Record "Warehouse Employee";
        UserSetup: Record "User Setup";
        LocationF: text[10000];
        LocationT: Record Location;

}