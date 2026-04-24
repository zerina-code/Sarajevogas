/*table 50178 "Union Employees"
{
    Caption = 'Union Employees';
    DrillDownPageID = "Union Employees";
    LookupPageID = "Union Employees";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = Union.Code;

            trigger OnValidate()
            begin
                Union.RESET;
                Union.SETFILTER(Code, Code);
                IF Union.FINDFIRST THEN
                    "Union Name" := Union.Name;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(3; "Date From"; Date)
        {
            Caption = 'Date From';

            trigger OnValidate()
            begin
                IF "Date To" <> 0D THEN BEGIN
                    IF "Date From" = 0D THEN
                        ERROR(Text001);
                    IF "Date To" < "Date From" THEN
                        ERROR(Text002);
                END;
            end;
        }
        field(4; "Date To"; Date)
        {
            Caption = 'Date To';

            trigger OnValidate()
            begin
                IF "Date To" <> 0D THEN BEGIN
                    IF "Date From" = 0D THEN
                        ERROR(Text001);
                    IF "Date To" < "Date From" THEN
                        ERROR(Text002);
                END;
                IF "Date To" <> 0D THEN BEGIN
                    IF "Date To" < WORKDATE THEN BEGIN
                        Active := FALSE;

                    END
                    ELSE BEGIN
                        Active := TRUE;
                    END;
                END
                ELSE BEGIN
                    Active := TRUE;

                END;
            end;
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(6; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(7; "Union Name"; Text[50])
        {
            Caption = 'Union Name';
            Editable = false;
        }
        field(41; "Employee Name"; Text[81])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No."),
                                                                                   Active = FILTER(true)));
            Caption = 'Employee Name';

        }
        field(42; "Sector Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector';
            Editable = false;

        }
        field(43; "Group Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group';
            Editable = false;

        }
        field(45; "Team Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team';
            Editable = false;

        }
        field(46; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Category Description';
            Editable = false;

        }
        field(47; Dosje; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Employee No.", "Date From", "Date To")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        Employee.RESET;
        Employee.SETFILTER("No.", "Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            Employee."Union Member" := FALSE;
            Employee."Union Code" := '';
            Employee."Union Membership No." := '';
            Employee.MODIFY;
        END;
    end;

    trigger OnInsert()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        Employee.RESET;
        Employee.SETFILTER("No.", "Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            Employee."Union Member" := TRUE;
            Employee."Union Code" := Code;
            Employee."Union Membership No." := "Union Membership No.";
            Employee.MODIFY;
        END;

        UnionEmployees.RESET;
        UnionEmployees.SETFILTER("Employee No.", "Employee No.");
        IF UnionEmployees.FINDFIRST THEN BEGIN
            REPEAT
                UnionEmployees.Active := FALSE;
                UnionEmployees.MODIFY;
            UNTIL UnionEmployees.NEXT = 0;
        END;

        Active := TRUE;
    end;

    trigger OnModify()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        IF Active = TRUE THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Union Member" := TRUE;
                Employee."Union Code" := Code;
                Employee."Union Membership No." := "Union Membership No.";
                Employee.MODIFY;
            END;
        END;
    end;

    trigger OnRename()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;
    end;

    var
        Employee: Record "Employee";
        UnionEmployees: Record "Union Employees";
        Union: Record "Union";
        Text001: Label 'Start Date must have value.';
        Text002: Label 'End Date must not be before Start date.';
        UserPersonalization: Record "User Personalization";
}

*/