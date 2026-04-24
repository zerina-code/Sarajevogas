/*ĐK TEST table 50111 OpRisk
{
    Caption = 'Production Forecast Entry';
    //DrillDownPageID = 99000922;
    //LookupPageID = 99000922;

    fields
    {
        field(1; Name; Code[10])
        {
            Caption = 'Production Forecast Name';
        }
        field(2; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Forecast Date';
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Forecast Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
        field(7; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(8; "Forecast Quantity (Base)"; Decimal)
        {
            Caption = 'Forecast Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(10; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(12; "Component Forecast"; Boolean)
        {
            Caption = 'Component Forecast';
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; Name, "Employee No.", "Location Code", "Start Date", "Component Forecast")
        {
            SumIndexFields = "Forecast Quantity (Base)";
        }
        key(Key3; Name, "Employee No.", "Component Forecast", "Start Date", "Location Code")
        {
            SumIndexFields = "Forecast Quantity (Base)";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        ForecastEntry: Record "OpRisk";
    begin
    end;

    var
        ItemUnitofMeasure: Record "Item Unit of Measure";
        Item: Record "Item";

}

*/