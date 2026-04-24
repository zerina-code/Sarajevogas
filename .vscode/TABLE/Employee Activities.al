table 50111 "Employee Activities"
{
    Caption = 'Employee Activities';
    DrillDownPageID = "Employee Activities";
    LookupPageID = "Employee Activities";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Types Of Diseases".Code where(Types = filter("Types of Activities"));

            trigger OnValidate()
            begin
                IF Code <> '' THEN BEGIN
                    TypesOfActivities.RESET;
                    TypesOfActivities.SETFILTER(Code, Code);
                    TypesOfActivities.setfilter("Types", '%1', TypesOfActivities.types::"Types of Activities");
                    IF TypesOfActivities.FINDFIRST THEN
                        Description := TypesOfActivities.Description
                    ELSE
                        Description := '';
                END;
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(3; "Decision No."; Text[30])
        {
            Caption = 'Decision No.';
        }
        field(4; Remark; Text[250])
        {
            Caption = 'Remark';
        }
        field(6; "Date From"; Date)
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
        field(7; "Date To"; Date)
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
            end;
        }
        field(8; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(10; "Employee Name"; Text[81])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No.")));


        }
        field(11; "Sector Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector';
            Editable = false;

        }
        field(12; "Group Name"; Text[250])
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
            Employee."Additional Work Activity" := FALSE;
            Employee."Additional Work Activity Code" := '';
            Employee."Additional Work Activity Res." := '';
            Employee."Add. Work Activity Remark" := '';
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
            Employee."Additional Work Activity" := TRUE;
            Employee."Additional Work Activity Code" := Code;
            Employee."Additional Work Activity Res." := "Decision No.";
            Employee."Add. Work Activity Remark" := Remark;
            Employee.MODIFY;
        END;

        EmployeeActivities.RESET;
        EmployeeActivities.SETFILTER("Employee No.", "Employee No.");
        IF EmployeeActivities.FINDFIRST THEN BEGIN
            REPEAT
                EmployeeActivities.Active := FALSE;
                EmployeeActivities.MODIFY;
            UNTIL EmployeeActivities.NEXT = 0;
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
                Employee."Additional Work Activity" := TRUE;
                Employee."Additional Work Activity Code" := Code;
                Employee."Additional Work Activity Res." := "Decision No.";
                Employee."Add. Work Activity Remark" := Remark;
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
        EmployeeActivities: Record "Employee Activities";
        TypesOfActivities: Record "Types Of Diseases";
        Text001: Label 'Start Date must have value.';
        Text002: Label 'End Date must not be before Start date.';
        UserPersonalization: Record "User Personalization";
}

