table 50103 Nationallity
{
    Caption = 'Nationallity';
    DrillDownPageID = "Nationallity";
    LookupPageID = "Nationallity";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(50000; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50239; "Number Of Employees"; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Active),
                                                Nationallity = CONST('<>''')));
            Caption = 'Number Of Employees';
            FieldClass = FlowField;
        }
        field(50240; "Number per Nationality"; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Active),
                                                Nationallity = FIELD(Code)));
            Caption = 'Number per Nationality';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code")
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

