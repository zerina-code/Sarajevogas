pageextension 50131 Posted_Transfer_Receipts extends "Posted Transfer Receipts"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Sales Header No."; "Sales Header No.") { ApplicationArea = all; }
            field("Calculation Number"; "Calculation Number") { ApplicationArea = all; }
            field("Group Calculation Number"; "Group Calculation Number") { ApplicationArea = all; }
        }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }

        addafter("&Receipt")
        {
            action("TransferCalculation")
            {
                ApplicationArea = All;
                Caption = 'Transfer Calculation';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    TransferCalculation.SetParam(Rec."No.");
                    TransferCalculation.Run();

                end;
            }
        }
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

                LocationT.Reset();
                LocationT.SetFilter("CNG VL", '%1', true);
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
            SetFilter("Transfer-to Code", LocationF);


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


                LocationT.Reset();
                LocationT.SetFilter("CNG VL", '%1', true);
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
            SetFilter("Transfer-to Code", LocationF);


        end;


    end;

    var
        myInt: Integer;
        WE: Record "Warehouse Employee";
        UserSetup: Record "User Setup";
        LocationF: text[10000];
        LocationT: Record Location;
        TransferCalculation: Report "Retail Calculation";
}