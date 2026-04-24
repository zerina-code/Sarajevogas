table 50031 Error
{
    Caption = 'Error';

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            Description = 'Primary Key';
        }
        field(5; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(6; "Table"; Text[250])
        {
            Caption = 'Table';
        }
        field(10; Value; Text[250])
        {
            Caption = 'Value';
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Error,Possible Error,Notification';
            OptionMembers = "Greška","Moguća Greška",Notification;
        }
        field(16; "Transport Amount"; Decimal)
        {
            Caption = 'Transport Amount';

            trigger OnValidate()
            begin
                Employee.SETFILTER("No.", '%1', Value);
                IF Employee.FINDFIRST THEN BEGIN
                    Employee.VALIDATE("Transport Temp", Employee."Transport Amount");
                    Employee.MODIFY;
                    Employee.VALIDATE("Transport Amount", "Transport Amount");
                    Employee.MODIFY;
                END;
            end;
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

    var
        Employee: Record "Employee";
}

