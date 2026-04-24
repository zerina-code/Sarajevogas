tableextension 50003 Resource extends Resource
{
    fields
    {
        field(50000; "Request Resource Type"; Enum "Request Resource Type")
        {
            Caption = 'Request Resource Type';
            DataClassification = CustomerContent;
        }
        field(50001; "Catalog Sheet"; Code[30]) //ED za import usluga 
        {
            Caption = 'Catalog Sheet';
        }

        field(50002; "Order"; Integer)
        {
            Caption = 'Order';
        }

        modify("Unit Price")
        {
            trigger OnBeforeValidate()
            var
                RP: Record "Resource Price";
            begin
                RP.Reset();
                RP.SetRange(Code, Rec."No.");
                RP.SetRange(Type, Rec.Type);
                if RP.FindFirst() then begin
                    if RP."Unit Price" <> Rec."Unit Price" then begin
                        RP."Unit Price" := Rec."Unit Price";
                        RP.Modify();
                        Commit();
                    end;
                end else begin
                    RP.Init();
                    RP.Validate(Type, Rec.Type);
                    RP.Validate(Code, Rec."No.");
                    RP.Validate("Unit Price", Rec."Unit Price");
                    RP.Insert();
                    Commit();
                end;
            end;
        }

    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Resource Update", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;
        if control = false then
            Error('Nemate dozvolu da modifikujete ovu karticu.');
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Resource Update", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;
        if control = false then
            Error('Nemate dozvolu da modifikujete ovu karticu.');
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Resource Update", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;
        if control = false then
            Error('Nemate dozvolu da modifikujete ovu karticu.');
    end;

    var

        US: Record "User Setup";
        Control: Boolean;
}
