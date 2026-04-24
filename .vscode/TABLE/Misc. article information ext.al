tableextension 50048 MiscExten extends "Misc. Article Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(50001; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
        }
        field(50002; "Emp. Contract Ledg. Entry No."; Integer)
        {
            //ĐK AutoIncrement = false;
            Caption = 'Emp. Contract Ledg. Entry No.';
        }
        field(50003; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50004; Active; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger".Active WHERE("No." = FIELD("Emp. Contract Ledg. Entry No."),
                                                                          "Org. Structure" = FIELD("Org Shema"),
                                                                          Active = CONST(TRUE),
                                                                          "Employee No." = FIELD("Employee No.")));
            Caption = 'Active';

        }
        field(50005; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';

        }
        modify("Employee No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                E: Record Employee;
            begin
                e.Get("Employee No.");
                "Employee Name" := e."First Name" + ' ' + e."Last Name";

            end;
        }
        modify("Misc. Article Code")
        {

            trigger OnBeforeValidate()
            var
                myInt: Integer;
                set: Record "Sales Line";
            begin
                Rec.SetHideValidationDialog(true);





            end;
        }

    }

    trigger OnInsert()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin
        //"Emp. Contract Ledg. Entry No."
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            "Emp. Contract Ledg. Entry No." := UserSetup."Last ECL No.";
            "Org Shema" := UserSetup."Last Org Shema";

        end;


    end;

    var
        myInt: Integer;
        HideValidationDialog: Boolean;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;
}