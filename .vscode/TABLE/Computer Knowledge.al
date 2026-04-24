table 50095 "Computer Knowledge"
{
    Caption = 'Computer Knowledge';
    DrillDownPageID = "Computer Knowledge";
    LookupPageID = "Computer Knowledge";

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;

            trigger OnValidate()
            begin
                CALCFIELDS("Location Name");
            end;
        }
        field(2; "Location Name"; Text[100])
        {
            CalcFormula = Lookup(Location.Name WHERE("Code" = FIELD("Location Code")));
            Caption = 'Location Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource;

            trigger OnValidate()
            begin
                CALCFIELDS("Resource Name");
            end;
        }
        field(4; "Resource Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Resource.Name WHERE("No." = FIELD("Resource No.")));
            Caption = 'Resource Name';
            Editable = false;

        }
        field(5; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(50000; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(50002; "Program Code"; Code[10])
        {
            Caption = 'Program Code';
        }
        field(50003; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Program Code")
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

