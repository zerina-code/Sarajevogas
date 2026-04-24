page 50086 "Employee Absence"
//ED 01 START
{
    Caption = 'Employee Absence';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = List;
    SaveValues = true;
    SourceTable = "Employee Absence Reg";
    SourceTableView = SORTING("Sorting Emp No.");
    layout
    {

        area(content)
        {


            field(CountV; CountV)
            {

                Caption = 'Count';
                Style = Unfavorable;
            }

            repeater(s)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Employee No."; "Employee No.")
                {
                    trigger OnValidate()
                    var
                        ECL: Record "Employee Contract Ledger";
                    begin

                        EditableHours := false;
                    end;
                }
                field("Sorting Emp No."; Rec."Sorting Emp No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Used only to properly sort by the Employee No.';
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field("From Date"; "From Date")
                {

                }
                field("To Date"; "To Date")
                {

                }
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    trigger OnValidate()
                    begin
                        CauseOfAbsence.Get("Cause of Absence Code");
                        /*   if CauseOfAbsence."Added To Hour Pool" then
                               EditableHours := true
                           else begin
                               EditableHours := false;
                               Hours := 0;
                           end;*/
                        EditableHours := true;
                        /*WageSetup.Get();
                        if Rec."Cause of Absence Code"= WageSetup."Overtime Code" then
                            EditableHours := true;*/
                    end;
                }
                field(Description; Description)
                {

                }
                field(Hours; Hours)
                {
                    Editable = EditableHours;
                    BlankZero = true;
                }
                field(Approved; Approved)
                {
                    Editable = true;
                }
                field("Department Code"; "Department Code") { Editable = false; }
                field("Department Name"; "Department Name") { Editable = false; }
                field("B-1 Description"; "B-1 Description") { Editable = false; }
                field("B-1 (with regions) Description"; "B-1 (with regions) Description") { Editable = false; }
                field("Stream Description"; "Stream Description") { Editable = false; }
                field("Author UserName"; "Author UserName") { Editable = false; }
                field(SystemCreatedAt; SystemCreatedAt) { Editable = false; }
                field(SystemModifiedAt; SystemModifiedAt) { Editable = false; }
                field(SystemModifiedBy; SystemModifiedBy) { Editable = false; Visible = false; }
                field("Modify UserName"; "Modify UserName") { Editable = false; }


                field("Calculated Hours by Entry"; "Calculated Hours by Entry")
                {
                    Visible = false;
                }
                field("Sum by Cause of absence"; "Sum by Cause of absence") { }
                field("Sum by Cause of Org"; "Sum by Cause of Org") { }
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action("&Approve All")
            {
                Caption = '&Approve All';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin

                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Approved" = FALSE THEN BEGIN
                            REPEAT
                                Validate(Rec."Approved", TRUE);
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        /*ELSE BEGIN
                            REPEAT
                                Rec."Approved" := FALSE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0
                        END;*/
                    END;
                end;
            }

            action("&Unapprove All")
            {
                Caption = '&Unapprove All';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F9';

                trigger OnAction()
                var
                    EA: Record "Employee Absence";
                begin

                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Approved" = TRUE THEN BEGIN
                            REPEAT
                                Validate(Rec."Approved", FALSE);

                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        /*ELSE BEGIN
                            REPEAT
                                Rec."Approved" := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0
                        END;*/
                    END;
                end;
            }
            action("Insert Work Performance")
            {
                Caption = 'Insert Work Performance';
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                var

                    WP: Record "Work performance";
                    WPPage: Page "Work Performance";
                begin
                    WP.Reset();
                    WP.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    WP.SetFilter("Month Of Performance", '%1', Date2DMY(Rec."From Date", 2));
                    WP.SetFilter("Year Of Performance", '%1', Date2DMY(Rec."From Date", 3));
                    WPPage.SetTableView(WP);
                    WPPage.Run();
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
                        Message(Text009);
                end;
            }

        }
        area(processing)
        {

        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF "Cause of Absence Code" = '' then
            Error(Text007);

        CauseOfAbsence.Get("Cause of Absence Code");
        if CauseOfAbsence."Added To Hour Pool" then
            if Hours = 0 then
                Error(Text008);
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
        RecFilters: text;
        AbsF: Record "Employee Absence Reg";
        AbsenceFill: Codeunit "Absence Fill";
        FromDate: date;
        ToDate: date;
    begin

        CountV := rec.Count;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        RecFilters: text;
        AbsF: Record "Employee Absence Reg";
        AbsenceFill: Codeunit "Absence Fill";
        FromDate: date;
        ToDate: date;
    begin
        CountV := rec.Count;

    end;


    trigger OnModifyRecord(): Boolean
    begin
        IF "From Date" = 0D then
            Error(Text001);

        IF "To Date" = 0D then
            ERROR(Text004);
    end;

    procedure PopulateIntegerEmployeeNo()
    var
        EmployeeAbsenceReg: Record "Employee Absence Reg";
        EmployeeNoAsInt: Integer;
    begin
        // procedura za ažuriranje / unos polja Sorting Employee No za postojeće redove u tabeli
        EmployeeAbsenceReg.Reset();
        if EmployeeAbsenceReg.FindSet() then begin
            repeat
                clear(EmployeeNoAsInt);
                if EVALUATE(EmployeeNoAsInt, EmployeeAbsenceReg."Employee No.") then
                    EmployeeAbsenceReg."Sorting Emp No." := EmployeeNoAsInt
                else
                    EmployeeAbsenceReg."Sorting Emp No." := 0;
                EmployeeAbsenceReg.Modify();
                clear(EmployeeNoAsInt);
            until EmployeeAbsenceReg.Next() = 0;
        end;
    end;

    var
        Employee: Record "Employee";
        WageSetup: Record "Wage Setup";
        EditableHours: Boolean;
        EmployeeAbsenceReg: Record "Employee Absence Reg";
        recEmplAbsence: Record "Employee Absence";
        recEmplAbsenceTemp: Record "Employee Absence" temporary;
        Text001: Label 'Set filters do not allow entry';
        Text004: Label 'Ending Date field cannot be blank.';
        Text007: Label 'Cause of Absence Code field cannot be blank.';
        Text008: Label 'Hours field cannot be blank.';
        Text009: Label 'Sorting Emp No. field has been populated for all existing records.';
        CauseOfAbsence: Record "Cause of Absence";
        ConfirmLbl: Label 'Do you want to copy the Employee No value to Sorting Employee No field for all rows?';
        CountV: Integer;
    //ED 01 END
}