tableextension 50023 EmployeeQualification extends "Employee Qualification"

{
    LookupPageId = Employee_Qualifications_HR;
    DrillDownPageId = Employee_Qualifications_HR;

    fields
    {
        modify("To Date")
        {
            trigger OnAfterValidate()
            begin
                if "To Date" < "From Date" then begin
                    Error('Datum kraja ne može biti manji od datuma početka.');
                end;
            end;
        }
        modify("Expiration Date")
        {
            trigger OnAfterValidate()
            begin
                if "Expiration Date" <= "To Date" then begin
                    Error('Datum isteka certifikata ne može biti manji od datuma početka važenja certifikata.');
                end;
            end;
        }
        modify("Qualification Code")
        {
            trigger OnAfterValidate()
            var
                Qualif: Record Qualification;
            begin
                Qualif.Reset();
                Qualif.SetFilter(Code, '%1', Rec."Qualification Code");
                if Qualif.FindFirst() then
                    Description2 := Qualif."Description 2"
                else
                    Description2 := '';

            end;

        }
        // Add changes to table fields here
        field(50000; Active; Boolean)
        {

        }
        field(50001; Switch; Option)
        {
            OptionMembers = " ","Computer Knowledge",Languages,Certification;
        }
        field(50002; "Computer Knowledge Code"; Code[10])
        {
            Caption = 'Computer Knowledge Code';
            TableRelation = "Computer Knowledge"."Program Code";

            trigger OnValidate()
            begin
                IF "Computer Knowledge Code" <> '' THEN BEGIN
                    ComputerKnowledge.RESET;
                    ComputerKnowledge.SETFILTER("Program Code", "Computer Knowledge Code");
                    IF ComputerKnowledge.FINDFIRST THEN
                        "Computer Knowledge Description" := ComputerKnowledge.Description;
                END
                ELSE
                    "Computer Knowledge Description" := '';
            end;
        }
        field(50003; "Computer Knowledge Description"; Text[100])
        {
            Caption = 'Computer Knowledge Description';
            Editable = false;
        }
        field(50004; "Language Code"; Code[10])
        {
            Caption = 'Language code';
            TableRelation = "Types Of Diseases" where(Types = filter(Languages));

            trigger OnValidate()
            begin
                IF "Language Code" <> '' THEN BEGIN
                    Languages.RESET;
                    Languages.SETFILTER(Code, "Language Code");
                    Languages.SetFilter(Types, '%1', Languages.Types::Languages);
                    IF Languages.FINDFIRST THEN
                        "Language Name" := Languages.Description;
                END
                ELSE
                    "Language Name" := '';
            end;
        }
        field(50005; "Language Level"; Option)
        {
            Caption = 'Level';
            OptionCaption = 'Basic,Medium,Advanced,Active';
            OptionMembers = Basic,Medium,Advanced,Active;
        }
        field(50006; "Language Name"; Text[50])
        {
            Caption = 'Language Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Types Of Diseases".Description where(Code = field("Language Code"), Types = filter(Languages)));
            Editable = false;
        }
        field(50007; "Exam Passed"; Boolean)
        {
            Caption = 'Exam Passed';
        }
        field(50008; "Decision No."; Code[30])
        {
            Caption = 'Decision No.';
        }
        field(50009; Status; enum "Employee Status"
        )
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';

        }
        field(50011; "Employee First Name"; Text[50])
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
        field(41; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false
        ;
        }

        field(42; "Sector Description"; Text[250])
        {
            Caption = 'Sector Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }
        field(43; "Department Category"; Text[250])
        {
            Caption = 'Department Category';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }
        field(44; "Group Description"; Text[250])
        {
            Caption = 'Group Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Department Name" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }
        field(45; "Position"; Text[250])
        {
            Caption = 'Team Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Position Description" WHERE("Employee No." = FIELD("Employee No."), Active = filter(true)));
            Editable = false;
        }
        field(46; "Evidence of certification"; enum "Type certificate")
        {

            Caption = 'Evidence of certification';

        }
        field(50010; "Description2"; Text[300])
        {
            Caption = 'Description 2';
        }




    }
    trigger OnInsert()
    var
        myInt: Integer;
        UserS: Record "User Setup";
    begin
        EMployeeQ.Reset();
        EMployeeQ.SetFilter("Line No.", '<>%1', 0);
        EMployeeQ.SetCurrentKey("Line No.");
        EMployeeQ.Ascending;
        if EMployeeQ.FindLast() then
            Rec."Line No." += EMployeeQ."Line No." + 1
        else
            Rec."Line No." := 1;

        UserS.Reset();
        UserS.SetFilter("User ID", '%1', UserId);
        if UserS.FindFirst() then begin
            if UserS."Qualification Type" = UserS."Qualification Type"::Certification then
                Rec.Switch := Rec.Switch::Certification;
            if UserS."Qualification Type" = UserS."Qualification Type"::"Computer Knowledge" then
                Rec.Switch := Rec.Switch::"Computer Knowledge";

            if UserS."Qualification Type" = UserS."Qualification Type"::Languages then
                Rec.Switch := Rec.Switch::Languages;

        end;





    end;

    var
        myInt: Integer;
        EMployeeQ: Record "Employee Qualification";
        Text000: Label 'You cannot delete employee qualification information if there are comments associated with it.';
        Qualification: Record "Qualification";
        Employee: Record "Employee";
        DA: page "Document Attachment Details";
        EmployeeQualification: Record "Employee Qualification";
        Languages: Record "Types Of Diseases";
        ComputerKnowledge: Record "Computer Knowledge";
        Text001: Label 'Start Date must have value.';
        Text002: Label 'End Date must not be before Start date.';
        UserPersonalization: Record "User Personalization";
        UserS: Record "User Setup";
}