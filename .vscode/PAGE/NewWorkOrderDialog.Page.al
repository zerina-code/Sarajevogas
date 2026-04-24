page 50145 NewWorkOrderDialog
{
    Caption = 'Work Order Type';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(DialogItems)
            {
                field(NewWorkOrderType; WorkOrderType)
                {
                    ApplicationArea = All;
                    Caption = 'Work Order Type';
                    ValuesAllowed = "General Work Order", "General Geo. Work Order", "General Geo. Work Order Office";
                }
                field(NewRemark; ReasonDesc)
                {
                    ApplicationArea = all;
                    Caption = 'Reason for Description';
                    TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for Service Order"));
                }
                field(NewReason; Description)
                {
                    Caption = 'Remark';
                }
                field(CopyEntireWorkOrder; CopyEntireWorkOrder)
                {
                    ApplicationArea = All;
                    Caption = 'Copy the entire Work Order';
                    ToolTip = 'Select this if you want to copy the current Work Order into the newly created one.';
                    Visible = HideIfCalledFromEmpty;
                }

            }
        }
    }
    var
        WorkOrderType: Enum "Request Type";
        Description: Text[250];
        ReasonDesc: text[250];
        US: Record "User Setup";
        CopyEntireWorkOrder: Boolean;
        HideIfCalledFromEmpty: Boolean;

    procedure GetSelectedWorkOrderType(var SelectedWorkOrderType: Enum "Request Type"; SelectedDesc: TExt[250]; SelectedRason: Text[250]; IsCopyWorkOrder: Boolean)
    begin
        SelectedWorkOrderType := WorkOrderType;
        SelectedDesc := Description;
        SelectedRason := ReasonDesc;
        IsCopyWorkOrder := CopyEntireWorkOrder;
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            us.Reason := ReasonDesc;
            us.Remark := Description;
            us.IsCopyWorkOrder := CopyEntireWorkOrder;
            us.Modify();
        end;
    end;

    procedure SetInitialWorkOrderType(InitialWorkOrderType: Enum "Request Type"; Descr: Text[250]; Reason: Text[250]; IsCopyWorkOrder: Boolean; HideOnEmpty: Boolean)
    begin
        WorkOrderType := InitialWorkOrderType;
        Description := Descr;
        ReasonDesc := Reason;
        CopyEntireWorkOrder := IsCopyWorkOrder;
        HideIfCalledFromEmpty := HideOnEmpty;
    end;
}
