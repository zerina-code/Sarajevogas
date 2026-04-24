page 50104 NewRequestDialog
{
    Caption = 'New Request';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(DialogItems)
            {
                field(NewRequestType; NewRequestType)
                {
                    ApplicationArea = All;
                    Caption = 'Request Type';
                    Visible = RequestTypeVisible;
                    trigger OnValidate()
                    begin
                        // if NewRequestType = NewRequestType::"Others" then
                        //   Error(RequestTypeErr);
                    end;
                }
            }
        }
    }
    var
        NewRequestType: Enum "Request Type";
        RequestTypeErr: Label 'You must select Request Type';
        RequestTypeVisible: Boolean;

    procedure GetSelectedData(var SelectedRequestType: Enum "Request Type")
    begin
        SelectedRequestType := NewRequestType;
    end;

    procedure SetOriginNewRequest()
    begin
        RequestTypeVisible := true;
    end;

    trigger OnOpenPage()
    var
    begin
        NewRequestType := Enum::"Request Type"::"General Work Order";
    end;
}
