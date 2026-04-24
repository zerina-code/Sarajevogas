table 50065 "Employee Level Of Disability"
{
    Caption = 'Employee Level Of Disability';
    DrillDownPageID = "Employee Level Of Disability";
    LookupPageID = "Employee Level Of Disability";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF Code<>'' THEN BEGIN
                  DisabilityLevel.SETFILTER(Code,Code);
                  IF DisabilityLevel.FINDFIRST THEN BEGIN
                    Description:=DisabilityLevel.Description;
                    "Level of Disability":=DisabilityLevel."Level of Disability";
                    END;
                  END;*/

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
            end;
        }
        field(5; "Decision On Disability"; Text[30])
        {
            Caption = 'Decision On Disability';
        }
        field(6; Remark; Text[200])
        {
            Caption = 'Remark';
        }
        field(7; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
            Editable = true;
            TableRelation = "Types Of Diseases".Description where(types = filter("Disability Level"));

            trigger OnValidate()
            begin
                IF Description <> '' THEN BEGIN

                    DisabilityLevel.SETFILTER(Description, Description);
                    DisabilityLevel.SetFilter(Types, '%1', DisabilityLevel.Types::"Disability Level");
                    IF DisabilityLevel.FINDFIRST THEN BEGIN
                        Code := DisabilityLevel.Code;
                        "Level of Disability" := DisabilityLevel."Level of Disability";
                    END;
                END;
                IF Description = '' THEN BEGIN
                    Code := '';
                    "Level of Disability" := '';
                END;
                /*IF Code<>'' THEN BEGIN
                  DisabilityLevel.SETFILTER(Code,Code);
                  IF DisabilityLevel.FINDFIRST THEN BEGIN
                    Description:=DisabilityLevel.Description;
                    "Level of Disability":=DisabilityLevel."Level of Disability";
                    END;
                  END;*/

            end;
        }
        field(9; "Level of Disability"; Text[10])
        {
            Caption = 'Level of Disability';
            Editable = false;
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
        field(50010; "Internal ID"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Internal ID" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Internal ID';

        }
        field(50011; "Employee Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Name';
            Editable = false;

        }
        field(50012; "Employee Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Last Name';
            Editable = false;

        }
    }

    keys
    {
        key(Key1; "Code", "Employee No.", "Date From", "Date To", Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Employee No.", "Code", Description, "Level of Disability")
        {
        }
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
            Employee."Disabled Person" := FALSE;
            Employee."Disability Level" := '';
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
            Employee."Disabled Person" := TRUE;
            Employee."Disability Level" := Code;
            Employee.MODIFY;
        END;

        EmployeeDisability.RESET;
        EmployeeDisability.SETFILTER("Employee No.", "Employee No.");
        IF EmployeeDisability.FINDFIRST THEN BEGIN
            REPEAT
                EmployeeDisability.Active := FALSE;
                EmployeeDisability.MODIFY;
            UNTIL EmployeeDisability.NEXT = 0;
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
                Employee."Disabled Person" := TRUE;
                Employee."Disability Level" := Code;
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
        EmployeeDisability: Record "Employee Level Of Disability";
        DisabilityLevel: Record "Types Of Diseases";
        Text001: Label 'Start Date must have value.';
        Text002: Label 'End Date must not be before Start date.';
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        UserPersonalization: Record "User Personalization";
}

