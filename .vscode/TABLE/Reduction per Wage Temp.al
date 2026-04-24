table 50025 "Reduction per Wage Temp"
{
    Caption = 'Reduction per Wage Temp';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Reduction No."; Code[20])
        {
            Caption = 'Reduction No.';
        }
        field(10; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
        }
        field(11; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
        field(15; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(25; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(30; "Date of Calculation"; Date)
        {
            Caption = 'Date of Calculation';
        }
        field(35; Locked; Boolean)
        {
            Caption = 'Locked';
        }
        field(40; Type; Code[10])
        {
            Caption = 'Type';
        }
        field(45; SGC; Code[10])
        {
        }
        field(46; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(47; "Year of Wage"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Header"."Year Of Wage" WHERE("No." = FIELD("Wage Header No.")));
            Caption = 'Year of Wage';

        }
        field(48; "Month of Wage"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Header"."Month Of Wage" WHERE("No." = FIELD("Wage Header No.")));
            Caption = 'Month of Wage';

        }
        field(49; "Reduction Name"; Text[50])
        {
            Caption = 'Reduction Name';
        }
        field(50; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := USERID;
    end;

    trigger OnModify()
    begin
        "User ID" := USERID;
    end;
}

