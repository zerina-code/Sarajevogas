table 50180 "Contract Phase t"
{
    Caption = 'Contract phase';
    DrillDownPageID = "Contract Phase";
    LookupPageID = "Contract Phase";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry  No.';
            Editable = false;
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin


            end;
        }
        field(50367; "Contract Phase"; Option)
        {
            Caption = 'Contract Phase';
            OptionCaption = ' ,Control,Management-Signature,Worker-Signature,Delayed';
            OptionMembers = " ",Control,"Management-Signature","Worker-Signature",Delayed;

            trigger OnValidate()
            begin
                "Contract Phase Date" := TODAY;
                "Contract Phase Time" := TIME;
            end;
        }
        field(50368; "Contract Phase Date"; Date)
        {
            Caption = 'Contract Phase Date';
            Editable = false;
            FieldClass = Normal;
        }
        field(50369; "Contract Phase Time"; Time)
        {
            Caption = 'Contract Phase Time';
            Editable = false;
            FieldClass = Normal;
        }
        field(50370; Active; Boolean)
        {
            Caption = 'Active';
            InitValue = true;
        }
        field(50371; "Contract Ledger Entry No."; Integer)
        {
            Caption = 'Contract Ledger Entry No.';
        }
        field(50372; "Starting Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Starting Date" WHERE("No." = FIELD("Contract Ledger Entry No.")));

        }
        field(50373; "Employee Full Name"; Text[81])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No.")));

        }
        field(50374; "Internal ID"; Integer)
        {
            FieldClass = Normal;
        }
        field(50375; "Sector description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                        "No." = FIELD("Contract Ledger Entry No.")));

        }
        field(50376; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", "Employee No.", "Contract Ledger Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //ERROR(text000);
    end;

    trigger OnInsert()
    begin
        IF FORMAT("Contract Phase") <> '' THEN BEGIN
            ContractPhase.SETFILTER("Employee No.", "Employee No.");
            // ContractPhase.SETFILTER("Contract Ledger Entry No.",'<>%1',"Contract Ledger Entry No.");
            ContractPhase.SETFILTER(Active, '%1', TRUE);
            IF ContractPhase.FINDLAST THEN BEGIN
                REPEAT
                    ContractPhase.Active := FALSE;
                    ContractPhase.MODIFY;
                UNTIL ContractPhase.NEXT = 0;
            END;
            IF "Contract Phase" = 4 THEN
                Active := FALSE;
        END;

        //ContractPhase.Active:=TRUE;
        Employee.RESET;
        Employee.SETFILTER("No.", '%1', "Employee No.");
        IF Employee.FINDFIRST THEN
            "Internal ID" := Employee."Internal ID";







        "Operator No." := COPYSTR(USERID, 1, 15)

    end;

    trigger OnModify()
    begin

        "Contract Phase Date" := TODAY;
        "Contract Phase Time" := TIME;
        //ContractPhase."Contract Phase Date":=TODAY;
        //ContractPhase."Contract Phase Time":=TIME;
        "Operator No." := COPYSTR(USERID, 1, 15)
    end;

    var
        HRSetup: Record "Human Resources Setup";
        text000: Label 'You can''t edit date or time contract phase';
        Employee: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        ContractPhase: Record "Contract Phase t";
}

