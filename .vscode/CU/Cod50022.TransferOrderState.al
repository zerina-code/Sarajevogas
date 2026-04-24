codeunit 50022 "Transfer Order State"
{
    SingleInstance = true;

    var
        IsCalledFromTO: Boolean;

    procedure SetCalledFromTransferOrder(Value: Boolean)
    begin
        IsCalledFromTO := Value;
    end;

    procedure GetCalledFromTransferOrder(): Boolean
    begin
        exit(IsCalledFromTO);
    end;

    procedure ClearState()
    var
        Page: Page "Service Orders";
    begin
        IsCalledFromTO := False;
    end;
}
