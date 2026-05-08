codeunit 50027 "Travel Status Management"
{
    procedure ChangeStatus(var TravelHeader: Record "Travel Order Header SG"; NewStatus: Enum "Travel Order Status")
    var
        OldStatus: Enum "Travel Order Status";
    begin
        OldStatus := TravelHeader."Travel Status";
    end;
}