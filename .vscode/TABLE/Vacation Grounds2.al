table 50062 "Vacation Grounds2"
{

    fields
    {
        field(1; "Employee No."; Code[10])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                t_Employee: Record Employee;
            begin
                t_Employee.SETFILTER("No.", '%1', "Employee No.");
                IF t_Employee.FIND('-') THEN BEGIN
                    //"Work experience":=employee."Years of Experience";
                    "First Name" := t_Employee."First Name";
                    "Last Name" := t_Employee."Last Name";
                    // "Work experience":=t_Employee."Years of Experience";
                END;
            end;
        }
        field(2; "Work experience"; Integer)
        {
            Caption = 'Work experience';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(3; "Legal Grounds"; Integer)
        {
            Caption = 'Legal Grounds';
            InitValue = 18;

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(4; "Days based on Work experience"; Integer)
        {
            Caption = 'Days based on Work experience';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(8; "Days based on Disability"; Integer)
        {
            Caption = 'Days based on Disability';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(9; "Total days"; Integer)
        {
            Caption = 'Total Days';
            Editable = true;
        }
        field(10; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = "U cjelini","U dva dijela";
        }
        field(11; Year; Integer)
        {
            Caption = 'Year';
        }
        field(12; "First Name"; Text[50])
        {
            Caption = 'Ime';
        }
        field(13; "Last Name"; Text[50])
        {
            Caption = 'Prezime';
        }
        field(14; "Starting Date of I part"; Date)
        {
            Caption = 'Starting Date of I part';
        }
        field(15; "Ending Date of I part"; Date)
        {
            Caption = 'Ending Date of I part';
        }
        field(16; "Starting Date of II part"; Date)
        {
            Caption = 'Starting Date of II part';
        }
        field(17; "Ending Date of II part"; Date)
        {
            Caption = 'Ending Date of II part';
        }
        field(19; "Based on Working Conditions"; Integer)
        {
            Caption = 'Based on Working Conditions';

            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;
        }
        field(20; "Position"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Position Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                 Active = CONST(true)));
            Caption = 'Position ID';

        }
        field(21; Sector; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                 Active = CONST(true)));
            Caption = 'Position ID';

        }
        field(22; SpecialCircumstances; integer)
        {
            Caption = 'Special Circumstances';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
        field(23; SingleParent; integer)
        {
            Caption = 'Single Parent';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
        field(24; MotherWithMoreCH; integer)
        {
            Caption = 'Mother with more children';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
        field(25; Millitary; integer)
        {
            Caption = 'Millitary';
            trigger OnValidate()
            begin
                "Total days" := "Legal Grounds" + "Days based on Work experience" + "Based on Working Conditions" + "Days based on Disability" + SpecialCircumstances + MotherWithMoreCH + Millitary + SingleParent;
            end;

        }
    }

    keys
    {
        key(Key1; "Employee No.", Year)
        {
        }
    }

    fieldgroups
    {
    }

    var
        t_Employee: Record "Employee";
        PositionRec: Record "Position";
        EmployeeRec: Record "Employee";




}

