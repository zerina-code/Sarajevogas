page 50008 "Warehouse Transporter"
{
    //ED

    Caption = 'Warehouse Transporter';
    PageType = List;
    SourceTable = "Warehouse Transporter";
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Name"; "Shipping Agent Name")
                {
                    ApplicationArea = All;
                }
                field(Driver; Driver)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        WarehouseTransporter.Reset();
        if WarehouseTransporter.FindLast() then
            Rec."Entry No." := WarehouseTransporter."Entry No." + 1
        else
            Rec."Entry No." := 1;

    end;

    var
        WarehouseTransporter: Record "Warehouse Transporter";
}

