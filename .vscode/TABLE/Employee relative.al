tableextension 50024 Employee_Relative_Ext extends "Employee Relative"
{
    fields
    {
        // Add changes to table fields here
        modify("Birth Date")
        {
            trigger OnAfterValidate();
            begin
                IF "Birth Date" <> 0D THEN
                    Age := ROUND((TODAY - "Birth Date") / 365.2425, 1, '<');

            end;
        }

        modify("Relative Code")
        {
            trigger OnAfterValidate()
            var
                Relative: Record Relative;
            begin

                Relative.Reset();
                Relative.SetFilter(Code, '%1', "Relative Code");
                if Relative.FindFirst() then begin
                    Relation := Relative.Relation;
                    Sex := Relative.Sex;

                end
                else begin
                    Relation := Relation::" ";
                    Sex := Sex::" ";

                end;

            end;


        }


        field(50000; Sex; enum "Employee Gender")
        {
            Caption = 'Sex';

        }
        field(50001; "Vacation Ease"; Boolean)
        {
            Caption = 'Vacation Ease';
        }
        field(50002; Age; Integer)
        {
            Caption = 'Age';
        }
        field(50003; "Health Insurance"; Boolean)
        {
            Caption = 'Health insurance';
        }
        field(50004; Relation; Option)
        {
            Caption = 'Relation';
            Editable = true;
            OptionCaption = ' ,Mother,Father,Child,Spouse,Other';
            OptionMembers = " ",Mother,Father,Child,Spouse,Other;

            trigger OnValidate()
            begin

                Employee.RESET;
                Employee.SETFILTER("No.", '%1', "Relative's Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                    IF Relation = Relation::Other THEN BEGIN
                        "Relative's Employee Full Name" := Employee."First Name" + ' ' + Employee."Last Name";
                    END;
                END
                ELSE BEGIN
                    "Relative's Employee Full Name" := '';
                END;
            end;
        }
        field(50005; "Mother's Maiden Name"; Text[30])
        {
            Caption = 'Mother''s Maiden Name';

            trigger OnValidate()
            begin
                IF Relation = Relation::Mother THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        Employee."Mother Name" := "First Name";
                        Employee."Mother Maiden Name" := "Mother's Maiden Name";
                        Employee.MODIFY;
                    END;
                END;
            end;
        }
        field(50006; "Parent Relation"; Option)
        {
            Caption = 'Parent Relation';
            OptionCaption = ' ,Father,Mother';
            OptionMembers = " ",Father,Mother;
        }
        field(50007; Spouse; Boolean)
        {
            Caption = 'Spouse';
        }
        field(50008; JMBG; Code[30])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Employee ID" WHERE("No." = FIELD("Employee No.")));

        }
        /* field(50009; Status; Enum "Employee Status")
         {
             FieldClass = FlowField;
             CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
             Caption = 'Status';


         }*/
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
        field(50013; "Date Of Input Info"; Date)
        {
            Caption = 'Date of input information';
        }
        field(50015; "Sector Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                        Active = FILTER(true)));
            Caption = 'Sector';
            Editable = false;

        }
        field(50016; "Group Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                       Active = FILTER(TRUE)));
            Caption = 'Group';
            Editable = false;

        }
        field(50017; "Team Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Name" WHERE("Employee No." = FIELD("Employee No."),
                                                                                      Active = FILTER(TRUE)));
            Caption = 'Department';
            Editable = false;


        }
        field(50018; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No."),
                                                                                                 Active = FILTER(true)));
            Caption = 'Department Category Description';
            Editable = false;

        }
        field(50158; "Disabled Child"; Boolean)
        {
            Caption = 'Disabled Child';
        }
        field(50159; "Number of Child"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Relative" WHERE(Relation = CONST(Child),
                                                           "Employee No." = FIELD("Employee No.")));

        }
        field(50160; "Relative's Employee Full Name"; Text[250])
        {
        }
        field(50161; "Relative Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Relative.Description WHERE(Code = FIELD("Relative Code")));
            Caption = 'Relative Code';

        }
        field(50162; "Place of work"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Phisical Department Desc" WHERE("Employee No." = FIELD("Employee No."),
                                                                                              Active = FILTER(true)));
            Caption = 'Place of work';
            Editable = false;

        }




    }
    trigger OnInsert()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Open Value" = 'Father' then
                Rec.Relation := Rec.Relation::Father;
            if UserSetup."Open Value" = 'Mother' then
                Rec.Relation := Rec.Relation::Mother;
            if UserSetup."Open Value" = 'Spouse' then
                Rec.Relation := Rec.Relation::Spouse;
            if UserSetup."Open Value" = 'Child' then
                Rec.Relation := Rec.Relation::Child;



        end;



    end;



    var
        myInt: Integer;
        Employee: Record "Employee";
        EmployeeRelative: Record "Employee Relative";
        Relative: Record "Relative";
        UserPersonalization: Record "User Personalization";

    trigger OnModify()
    begin

        IF Relation = Relation::Spouse THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Spouse Name" := "First Name";
                Employee.MODIFY;
            END;
        END;

        IF Relation = Relation::Mother THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Mother Name" := "First Name";
                Employee."Mother Maiden Name" := "Mother's Maiden Name";
                Employee.MODIFY;
            END;
        END;

        IF Relation = Relation::Father THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Father Name" := "First Name";
                Employee.MODIFY;
            END;
        END;
        "Date Of Input Info" := TODAY;

    end;

}