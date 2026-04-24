page 50237 NewWorkOrderDialogCNG
{
    Caption = 'Work Order Type';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(DialogItems)
            {

                field(AddressType; AddressType)
                {
                    ApplicationArea = all;
                    Caption = 'Reason for Description';
                    TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for Service Order"));
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

            }
        }
    }
    var
        WorkOrderType: Enum "Request Type";
        Description: Text[250];
        ReasonDesc: text[250];
        AddressType: Option " ","Adresa dostave","Adresa sjedišta";
        US: Record "User Setup";
        CopyEntireWorkOrder: Boolean;
        HideIfCalledFromEmpty: Boolean;

    procedure GetSelectedWorkOrderType(var SelectedAddressType: Option " ","Adresa dostave","Adresa sjedišta"; SelectedDesc: TExt[250]; SelectedRason: Text[250]; IsCopyWorkOrder: Boolean)
    begin
        SelectedDesc := Description;
        SelectedRason := ReasonDesc;
        SelectedAddressType := AddressType;
        IsCopyWorkOrder := CopyEntireWorkOrder;
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);

        if us.FindFirst() then begin
            us.Reason := ReasonDesc;
            us.Remark := Description;
            us.AddressType := AddressType;
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
