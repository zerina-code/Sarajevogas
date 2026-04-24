/*table 50073 "Engagement Type"
{
    // //

    Caption = 'Engagement type';
    DrillDownPageID = "Engagement Type";
    LookupPageID = "Engagement Type";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "No. of Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = CONST(Active),
                                                "Emplymt. Contract Code" = FIELD(Code)));
            Caption = 'No. of Contracts';
            Editable = false;

        }
        field(8; n; Code[10])
        {
        }
        field(50000; "Hours in Day"; Decimal)
        {
            Caption = 'Hours in Day';
        }
        field(50001; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Worker,Board,Supervisor,Trainee';
            OptionMembers = Worker,Board,Supervisor,Trainee;
        }
        field(50002; "Termination Date Mandatory"; Boolean)
        {
            Caption = 'Termination Date Mandatory';
        }
        field(50003; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50004; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Todo2: Record "To-do";
    begin
    end;

    trigger OnModify()
    var
        Todo: Record "To-do";
    begin
    end;

    var
        Text001: Label 'A to-do organizer must always be a salesperson.';
        Text002: Label 'You cannot have more than one to-do organizer.';
        Text003: Label 'This attendee already exists.';
        Attendee: Record "Engagement Type";
        Todo: Record "To-do";
        Text004: Label 'You cannot select the %1 for %2 because he/she does not have an e-mail address.';
        Text005: Label 'You cannot delete a to-do organizer.';
        Text006: Label 'You cannot change an %1 for a to-do organizer.';
        Text007: Label 'The %1 option is not available for a to-do organizer.';
        Text008: Label 'You cannot change the to-do organizer.';
        Text011: Label 'You cannot set %1 as organizer because he/she does not have e-mail address.';
}

*/