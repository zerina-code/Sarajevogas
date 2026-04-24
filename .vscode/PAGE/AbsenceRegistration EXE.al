pageextension 50008 AbsenceRegistration extends "Absence Registration"

{


    layout
    {
        addafter(Quantity)
        {


            field("Vacation from Year"; "Vacation from Year")
            {
                Visible = false;
                ApplicationArea = all;


            }
        }
        addafter("Employee No.")
        {
            field("Sorting Emp No."; Rec."Sorting Emp No.")
            {
                ToolTip = 'Used only to properly sort by the Employee No.';
            }
            field("First Name"; "First Name") { }
            field("Last Name"; "Last Name") { }
        }
        addafter("Unit of Measure Code")
        {
            field("Department Code"; "Department Code") { }
            field("Department Name"; "Department Name") { }
            field("B-1 Description"; "B-1 Description") { }
            field("B-1 (with regions) Description"; "B-1 (with regions) Description") { }
            field("Stream Description"; "Stream Description") { }
            field("Author UserName"; "Author UserName") { Editable = false; }
            field(SystemCreatedAt; SystemCreatedAt) { Editable = false; }
            field(SystemModifiedAt; SystemModifiedAt) { Editable = false; }
            field(SystemModifiedBy; SystemModifiedBy) { Editable = false; Visible = false; }
            field("Modify UserName"; "Modify UserName") { Editable = false; }


        }
    }

    actions
    {

        addbefore("A&bsence")
        {

            action(BaseChange)
            {

                ApplicationArea = BasicHR;
                Caption = 'BaseChange';
                Image = CalendarChanged;
                //    RunObject = report "Employee Absence Reg";
                trigger OnAction()
                var
                    myInt: Integer;
                    BaseCHange: Record "Base Calendar Change";
                    BaseCHangePage: page "Base Calendar Changes";
                    WS: Record "Wage Setup";
                begin

                    WS.get;
                    BaseCHange.Reset();
                    BaseCHange.SetFilter("Base Calendar Code", '%1', ws."Wage Calendar Code");
                    BaseCHangePage.SetTableView(BaseCHange);
                    BaseCHangePage.Run();


                end;


            }
            action("Populate Integer No.")
            {
                Caption = 'Populate Sorting Employee No.';
                Promoted = true;
                trigger OnAction()
                var
                    Confirmed: Boolean;
                begin
                    Confirmed := false;
                    if Confirm(ConfirmLbl) then begin
                        Confirmed := true;
                        PopulateIntegerEmployeeNo();
                    end;
                    if Confirmed then
                        Message(Text001);
                end;
            }
        }




        addbefore("Overview by &Categories")

        {
            action("Employee Abs Reg Sum")
            {
                ApplicationArea = BasicHR;
                Caption = 'Employee Abs Reg Sum';
                Image = AbsenceCategory;
                RunObject = report "Employee Absence Reg";

            }

            action("EmployeeAbsenceAnalysisReport")
            {
                ApplicationArea = BasicHR;
                Caption = 'Employee Abs Analysis - Sick leave paid by company';
                Image = AbsenceCategory;
                RunObject = report "EmployeeAbsenceAnalysisReport";
            }

        }
    }

    procedure PopulateIntegerEmployeeNo()
    var
        EmployeeAbsence: Record "Employee Absence";
        EmployeeNoAsInt: Integer;
    begin
        // procedura za ažuriranje / unos polja Sorting Employee No za postojeće redove u tabeli
        EmployeeAbsence.Reset();
        if EmployeeAbsence.FindSet() then begin
            repeat
                clear(EmployeeNoAsInt);
                if EVALUATE(EmployeeNoAsInt, EmployeeAbsence."Employee No.") then
                    EmployeeAbsence."Sorting Emp No." := EmployeeNoAsInt
                else
                    EmployeeAbsence."Sorting Emp No." := 0;
                EmployeeAbsence.Modify();
                clear(EmployeeNoAsInt);
            until EmployeeAbsence.Next() = 0;
        end;
    end;

    var
        myInt: Integer;
        ConfirmLbl: Label 'Do you want to copy the Employee No value to Sorting Employee No field for all rows?';
        Text001: Label 'Sorting Emp No. field has been populated for all existing records.';


}