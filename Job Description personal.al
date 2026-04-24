/*ĐK table 50092 "Job description personal"
{
    Caption = 'Job description';
    DrillDownPageID = 429;

    fields
    {
        field(1; "Job position ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Job description ID';
        }
        field(2; "Job position"; Text[250])
        {
            Caption = 'Job position';
            Editable = true;
        }
        field(3; "Req. qualifications and skills"; Text[250])
        {
            Caption = 'Req. qualifications and skills';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; "Job position Code"; Code[20])
        {
            Caption = 'Job position Code';
        }
        field(6; Manager; Code[20])
        {
            Caption = 'Manager';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                IF Manager <> '' THEN BEGIN
                    IF T_Employee.GET(Manager) THEN
                        "Manager Name" := T_Employee."First Name" + ' ' + T_Employee."Last Name";
                END;
            end;
        }
        field(7; "Manager Name"; Text[61])
        {
            Caption = 'Manager Name';
            Editable = false;
        }
        field(8; "Perpose of job"; Text[250])
        {
            Caption = 'Perpose of job';
        }
        field(9; "Contract No"; Integer)
        {
            Caption = 'Contract No';
        }
        field(10; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
    }

    keys
    {
        key(Key1; "Job position ID", "Job position Code", "Org Shema")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
      

    end;

    var
        T_Position: Record "Position";
        T_Employee: Record "Employee";
}*/

