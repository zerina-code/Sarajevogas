tableextension 50112 "Warehouse Shipment Line" extends "Warehouse Shipment Line"
{
    fields
    {
        // Add changes to table fields here
        field(50114; "Sales Header No."; Code[20])
        {
            Caption = 'Sales Header No.';

        }
        field(501156; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group";
            Caption = 'G/L Account No.';
        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }


    }

    var
        myInt: Integer;
}