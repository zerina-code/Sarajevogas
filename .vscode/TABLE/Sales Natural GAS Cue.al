/*table 50106 "Sales Natural GAS Cue"
{
    Caption = 'Sales Natural GAS';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }





        field(11; "Customers - Active"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE("Customer Status" = FILTER('Active')));
            Caption = 'Customers - Active';

        }
        field(12; "Customers - all"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer);
            Caption = 'Customers - Active';

        }
        field(13; "Customers - Terminated"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE("Customer Status" = FILTER('Terminated')));
            Caption = 'Customers - Terminated';

        }
        field(14; "Customers - Potential"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE("Customer Status" = FILTER('Potential')));
            Caption = 'Customers - Potential';

        }
        field(20; "Measuring Point - Active"; Integer)
        {
            Caption = 'Measuring Point';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item" WHERE("Status MM" = FILTER('Active')));

        }
        field(21; "Measuring Point - all"; Integer)
        {
            Caption = 'Measuring Point-all ';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item");

        }
        field(22; "Measuring Point - TR"; Integer)
        {
            Caption = 'Measuring Point- temporery registered ';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item" WHERE("Status MM" = FILTER('Temporarily deregistered')));

        }

        field(23; "Measuring Point - PR"; Integer)
        {
            Caption = 'Measuring Point- Permanently deregistered ';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item" WHERE("Status MM" = FILTER('Permanently deregistered')));

        }
        field(24; "Calculation Header - Open"; Integer)
        {
            Caption = 'Calculation Header - Open';
            FieldClass = FlowField;
            CalcFormula = Count("Calcuation Header" WHERE(Status = filter(Open)));

        }
        field(25; "Calculation Header - Locked"; Integer)
        {
            Caption = 'Calculation Header - Locked';
            FieldClass = FlowField;
            CalcFormula = Count("Calcuation Header" WHERE(Status = filter(Locked)));

        }


    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

*/