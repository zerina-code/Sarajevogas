table 50064 "Employee Diseases"
{
    Caption = 'Employee Diseases';
    DrillDownPageID = "Employee Diseases";
    LookupPageID = "Employee Diseases";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            TableRelation = "Types Of Diseases".Code;

            trigger OnValidate()
            begin
                TypesOfDiseases.RESET;
                TypesOfDiseases.SETFILTER(Code, Code);
                IF TypesOfDiseases.FINDFIRST THEN
                    "Disease Name" := TypesOfDiseases.Description
                ELSE
                    "Disease Name" := '';
            end;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(3; "Disease Name"; Text[50])
        {
            Caption = 'Disease Name';
            Editable = false;
        }
        field(41; "Employee Name"; Text[81])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No.")));
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
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group';
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Team Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Department Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Category Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "Types"; Option)
        {
            OptionMembers = "Employee Bood Donations","Employee Diseases","Union Employees","Employee languages";
            OptionCaption = 'Employee Bood Donations,Employee Diseases,Union Employees,Employee languages';
        }
        field(50000; Date; Date)
        {
            Caption = 'Date';

            trigger OnValidate()
            begin
                Year := DATE2DMY(CALCDATE('0D', Date), 3);
            end;
        }
        field(50001; Year; Integer)
        {
            Caption = 'Year';
        }
        field(50002; "Code_Union"; Code[10])
        {
            Caption = 'Code';
            TableRelation = Union.Code;

            trigger OnValidate()
            var
                Union: Record Union;
            begin
                Union.RESET;
                Union.SETFILTER(Code, Code);
                IF Union.FINDFIRST THEN
                    "Union Name" := Union.Name;
            end;
        }
        field(50007; "Union Name"; Text[50])
        {
            Caption = 'Union Name';
            Editable = false;
        }
        field(50006; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(50003; "Date From"; Date)
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
        field(50004; "Date To"; Date)
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
        field(50005; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(50008; "Language Code"; Code[10])
        {
            Caption = 'Language code';
        }
        field(50009; Level; Option)
        {
            Caption = 'Level';
            OptionCaption = 'A1,A2,B1,B2,C1,C2';
            OptionMembers = A1,A2,B1,B2,C1,C2;
        }
        field(50010; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line no.';
        }
    }

    keys
    {
        key(Key1; "Code", "Employee No.", Types, Code_Union, "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        Emo: Record Employee;
        EmployeeDi: Record "Employee Diseases";
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        if Rec.Types = Rec.Types::"Employee Bood Donations" then begin
            EmployeeDi.Reset();
            EmployeeDi.SetFilter("Employee No.", '%1', Rec."Employee No.");
            EmployeeDi.SetFilter(Date, '<>%1', Rec.Date);
            if not EmployeeDi.FindFirst() then begin
                Emo.Get("Employee No.");
                Emo."Blood Donor" := false;
                Emo.Modify();
            end;
        end;
    end;

    trigger OnInsert()
    var
        Emo: Record Employee;
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        if Rec.Types = Rec.Types::"Employee Bood Donations" then begin
            Emo.Get("Employee No.");
            Emo."Blood Donor" := true;
            Emo.Modify();

        end;
    end;

    trigger OnModify()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
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
    end;



    var
        TypesOfDiseases: Record "Types Of Diseases";
        UserPersonalization: Record "User Personalization";
        Employee: Record "Employee";

        Union: Record "Union";
        Text001: Label 'Start Date must have value.';
        Text002: Label 'End Date must not be before Start date.';

}

