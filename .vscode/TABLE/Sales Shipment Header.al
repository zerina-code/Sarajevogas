tableextension 50084 "Sales Shipment Header" extends "Sales Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(50108; "Document No."; Code[20])
        {
            Caption = 'Dobavljačev broj dokumenta';
            Editable = true;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50109; "CNG"; boolean)
        {
            Caption = 'CNG';
        }

        field(50110; "Quantity"; decimal)
        {
            Caption = 'Quantity';
            CalcFormula = Sum("Sales Shipment Line".Quantity WHERE("Document No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70212; "RN Source"; enum "RN Source")
        {
            Caption = 'RN Source';
        }


    }

    var
        myInt: Integer;
}