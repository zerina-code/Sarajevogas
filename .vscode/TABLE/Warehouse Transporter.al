table 50138 "Warehouse Transporter"
{

    //ED

    Caption = 'Warehouse Transporter';
    DrillDownPageID = "Warehouse Transporter";
    LookupPageID = "Warehouse Transporter";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent".Code;

            trigger OnValidate()
            begin
                ShippingAgent.Reset();
                ShippingAgent.SetFilter(Code, '%1', Rec."Shipping Agent Code");
                if ShippingAgent.FindFirst() then
                    Rec."Shipping Agent Name" := ShippingAgent.Name;
            end;
        }
        field(3; "Shipping Agent Name"; Text[50])
        {
            Caption = 'Shipping Agent Name';
        }
        field(4; "Driver"; Text[50])
        {
            Caption = 'Driver';
        }
    }

    keys
    {
        key(PrimaryKey; "Entry No.", Driver)
        {
        }
    }

    var
        ShippingAgent: Record "Shipping Agent";
}





