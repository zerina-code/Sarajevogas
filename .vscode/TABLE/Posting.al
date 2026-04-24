/*table 50138 Posting
{
    Caption = 'Posting ';
    DrillDownPageID = "Posting List";
    LookupPageID = "Posting List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No';
            Editable = false;
        }
        field(2; "Hiring Manager"; Text[150])
        {
            Caption = 'Hiring Manager';
            TableRelation = "Employee Contract Ledger"."Employee Name" WHERE("Management Level" = FILTER(3 | 4 | 5),
                                                                              "Org. Structure" = FIELD("Org Sheme"),
                                                                              Active = FILTER(true));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin

                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee Name", '%1', "Hiring Manager");
                IF EmployeeContractLedger.COUNT() = 0 THEN
                    ERROR('Uneseni Hiring manager nije pronaden u bazi!');


            end;
        }
        field(3; "Contact Person"; Text[150])
        {
            Caption = 'Contact Person';
        }
        field(4; "Number of Candidates"; Integer)
        {
            Caption = 'Number of Candidates';
        }
        field(5; "Published Date"; Date)
        {
            Caption = 'Published Date';
        }
        field(6; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
        }
       
        field(8; Position; Text[250])
        {
            Caption = 'Position';
            TableRelation = "Position Menu".Description WHERE("Org. Structure" = FIELD("Org Sheme"));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PositionMenu.RESET;
                PositionMenu.SETFILTER(Description, '%1', Position);
                IF PositionMenu.FINDFIRST THEN BEGIN
                    "Position Code" := PositionMenu.Code;
                    Grade := PositionMenu.Grade;
                    "Roll Code" := PositionMenu.Role;
                    "Management Level" := PositionMenu."Management Level";
                    Department.RESET;

                    Department.RESET;
                    Department.SETFILTER("ORG Shema", '%1', "Org Sheme");
                    Department.SETFILTER(Code, '%1', PositionMenu."Department Code");
                    IF Department.FINDFIRST THEN
                        "Department Name" := Department.Description;
                END ELSE BEGIN
                    "Position Code" := '';
                    Grade := 0;
                    "Roll Code" := '';
                    "Management Level" := PositionMenu."Management Level"::Empty;
                    "Department Name" := '';
                END;
            end;
        }
        field(9; Grade; Integer)
        {
            Caption = 'Grade';
            Editable = false;
        }
        field(10; "Roll Code"; Code[20])
        {
            Caption = 'Roll Code';
            Editable = false;
        }
        field(11; Benefits; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Position Benefits" WHERE("Position Code" = FIELD("Position Code"),
                                                           "Position Name" = FIELD(Position),
                                                           "Org. Structure" = FIELD("Org Sheme")));
            Caption = 'Benefits';
            Editable = false;

        }
        field(12; "Department Name"; Text[250])
        {
            Caption = 'Department Name';
            Editable = false;
            TableRelation = Department.Description WHERE("ORG Shema" = FIELD("Org Sheme"));
        }
        field(13; "Management Level"; Enum "Management Level")
        {
            Caption = 'Management Level';
            Editable = false;

        }
        field(14; "Name of the Company"; Text[30])
        {
            Caption = 'Name of the Company';
            TableRelation = Company.Name;
        }
       
        field(16; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = "Position Menu"."Department Code" WHERE("Code" = FIELD("Position Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(17; "Org. Structure"; Code[1])
        {
        }
        field(18; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            TableRelation = "Position Menu".Code;
            ValidateTableRelation = false;
        }
        field(19; "Org Sheme"; Text[50])
        {
        }
        field(20; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
            Editable = false;
        }
        field(21; Selection; Text[30])
        {
            Caption = 'Selection';
            Editable = false;
        }
        field(22; "Selection Number"; Integer)
        {
            Caption = 'Selection Number';
        }
        field(23; "HR Posting No."; Text[20])
        {
            Caption = 'HR Posting No.';
        }
    }

    keys
    {
        key(Key1; "No.", "HR Posting No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Position)
        {
        }
    }

    trigger OnInsert()
    begin
        ActivatedOrPreparationORGSheme();
     

        "Selection Number" := 1;
        Selection := 'SEL1';

    end;

    trigger OnModify()
    begin
        ActivatedOrPreparationORGSheme();
    end;

    var
        PositionMenu: Record "Position Menu";
        Department: Record "Department";
        "OrgŠeme": Text;
        ORGShema: Record "ORG Shema";
        i: Integer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        Selections: Record "Selection";
        EmployeeContractLedger: Record "Employee Contract Ledger";

    local procedure ActivatedOrPreparationORGSheme()
    begin
        ORGShema.RESET;
        //ORGShema.SETFILTER(ORGShema.Status, '%1|%2', ORGShema.Status::Active, ORGShema.Status::Preparation);
        ORGShema.SETFILTER(ORGShema.Status, '%1', ORGShema.Status::Active);
        i := 1;
        IF ORGShema.FINDFIRST THEN
            REPEAT

                IF i = 1 THEN
                    OrgŠeme += ORGShema.Code
                ELSE
                    OrgŠeme += '|' + ORGShema.Code;

            UNTIL ORGShema.NEXT = 0;

        "Org Sheme" := OrgŠeme;
    end;
}

*/