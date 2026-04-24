pageextension 50050 ItemLookup extends "Item Lookup"
{


    trigger OnOpenPage()
    var
        ItemL: Record item;
        Contract: Record "Contract Scope";
    begin
        /*UserSetup.Reset(); //ĐK
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Contract No." <> '' then begin
                Contract.Reset();
                Contract.SetFilter("Contract Entry No.", '%1', UserSetup."Contract No.");
                if Contract.FindSet() then
                    repeat

                        ItemL.reset;
                        ItemL.SetFilter("No.", '%1', Contract."Item No.");
                        if ItemL.FindFirst() then begin
                            ItemL.Show := true;
                            ItemL.Modify();

                        end;
                    until Contract.Next() = 0;

                setfilter(Show, '%1', true);


            end;
        end;*/

        UserSetup.Reset(); //ED
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Contract No." <> '' then begin //upisan je broj ugovora, odnosno postoji opseg za ovaj ugovor

                ItemL.Reset();
                if ItemL.FindFirst() then
                    repeat
                        Contract.Reset();
                        Contract.SetFilter("Contract Entry No.", '%1', UserSetup."Contract No.");
                        Contract.SetFilter("Item No.", '%1', ItemL."No.");
                        if Contract.FindFirst() then begin
                            ItemL.Show := true;
                            ItemL.Modify();
                        end else begin
                            ItemL.Show := false;
                            ItemL.Modify();
                        end;
                    until ItemL.Next() = 0;

                // if UserSetup."Contract No." <> '' then
                setfilter(Show, '%1', true);

                if UserSetup."Contract No." = '' then begin //upisan je broj ugovora, odnosno postoji opseg za ovaj ugovor

                    ItemL.Reset();
                    if ItemL.FindFirst() then
                        repeat
                            Contract.Reset();
                            Contract.SetFilter("Contract Entry No.", '%1', UserSetup."Contract No.");
                            Contract.SetFilter("Item No.", '%1', ItemL."No.");
                            if Contract.FindFirst() then begin
                                ItemL.Show := true;
                                ItemL.Modify();
                            end else begin
                                ItemL.Show := false;
                                ItemL.Modify();
                            end;
                        until ItemL.Next() = 0;

                    // if UserSetup."Contract No." <> '' then
                    setfilter(Show, '%1', true);


                end;
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    begin


    end;

    var
        UserSetup: Record "User Setup";
}