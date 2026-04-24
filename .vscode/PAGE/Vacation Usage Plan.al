page 50059 "Vacation Usage Plan"
{
    Caption = 'Vacation Usage Plan';
    PageType = List;
    SourceTable = "Vacation Ground 2";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    Caption = 'Employee No.';
                }
                field("First Name"; "First Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                //ED 02 START
                field("Position Name"; "Position Name")
                {
                    Editable = false;
                }
                field(Sector; Sector)
                {
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    Visible = Simple;

                }
                field("Document Text"; "Document Text")
                {
                    ApplicationArea = all;
                    Visible = not Simple;
                }
                //ED 02 END
                field("Work experience"; "Work experience")
                {
                    Editable = false;
                }
                field("Legal Grounds"; "Legal Grounds")
                {
                    Editable = false;
                }
                field("Days based on Work experience"; "Days based on Work experience")
                {
                    Editable = false;
                }
                field("Days based on Disability"; "Days based on Disability")
                {
                    Editable = false;
                }
                //ED 02 START
                field("Days based on Military service"; "Days based on Military service")
                {
                    Editable = false;
                }
                field("Days based on Working conditi"; "Days based on Working conditi")
                {
                    Editable = false;
                }
                field("Used days at previous employer"; "Used days at previous employer")
                {
                    trigger OnValidate()
                    begin

                        Rec."Total days" := Rec."Legal Grounds" + Rec."Days based on Military service" + Rec."Days based on Working conditi" + Rec."Days based on Work experience" + Rec."Days based on Disability" - Rec."Number of days" - Rec."Used days at previous employer";
                        IF Rec."Total days" > 35
                        then
                            Rec."Total days" := 35;

                    end;
                }
                //ED 02 END
                field("Total days"; "Total days")
                {
                    Editable = false;
                }
                field(Year; Year)
                {
                    Editable = false;
                }
                field("Date of report"; "Date of report")
                {
                    Editable = false;
                }
                field("Starting Date of I part"; "Starting Date of I part")
                {
                }
                field("Ending Date of I part"; "Ending Date of I part")
                {
                }
                field("Starting Date of II part"; "Starting Date of II part")
                {
                    Editable = true;
                }
                field("Ending Date of II part"; "Ending Date of II part")
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Vacation Usage Plan Calculation")
            {
                Caption = 'Vacation Usage Plan Calculation';
                Image = PlanningWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = report "Vacation Calculation2"; //ED 

                trigger OnAction()
                begin
                    CurrPage.UPDATE;
                end;
            }
            action("Annual Leave Resolution")
            {
                Caption = 'Annual Leave Resolution';
                Image = Report2;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Vacation: Record "Vacation Ground 2";
                    VacationDecisionR: Report VacationDecision;

                begin
                    Vacation.Reset();
                    Vacation.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    Vacation.SetFilter("Date of report", '%1', Rec."Date of report");


                    Report.RUN(50016, TRUE, TRUE, Vacation);


                    //SM start
                    /*ĐK  Selection := STRMENU(Text0004,1);
                              IF Selection = 0 THEN
                                EXIT;
                              IF  Selection IN [1] THEN BEGIN
                              t_VG.SETCURRENTKEY("Employee No.");
                                  t_VG.SETFILTER("Employee No.",xRec."Employee No.");
                                  t_VG.SETFILTER(Year,FORMAT(xRec.Year));
                                  R_AnnualLeave.SETTABLEVIEW(t_VG);
                                  R_AnnualLeave.RUN;

                              END;
                              IF Selection IN [2] THEN BEGIN
                              t_VG.SETCURRENTKEY("Employee No.");
                                  t_VG.SETFILTER("Employee No.",xRec."Employee No.");
                                  t_VG.SETFILTER(Year,FORMAT(xRec.Year));

                                  R_AnnualLeave2.SETTABLEVIEW(t_VG);
                                  R_AnnualLeave2.RUN;

                              END;


                      //SMend





                      /*Temp:=CONFIRM(Text0002);

                      IF Temp=TRUE THEN BEGIN
                        IF t_emp.GET("Employee No.") THEN BEGIN
                        IF (("Ending Date of I part" = 0D)  OR  ("Starting Date of I part" = 0D)) THEN
                          ERROR(Text0001,t_emp."First Name",t_emp."Last Name");
                          t_VG.SETCURRENTKEY("Employee No.");
                          t_VG.GET("Employee No.",Year);
                          R_AnnualLeave.SETTABLEVIEW(t_VG);
                          R_AnnualLeave.RUN;
                        END;
                      END;

                      Temp:=CONFIRM(Text0003);
                      IF Temp=TRUE THEN BEGIN
                        IF t_emp.GET("Employee No.") THEN BEGIN
                        IF (("Ending Date of II part" = 0D)  OR  ("Starting Date of II part" = 0D)) THEN
                          ERROR(Text0001,t_emp."First Name",t_emp."Last Name");
                          t_VG.SETCURRENTKEY("Employee No.");
                          t_VG.GET("Employee No.",Year);
                          R_AnnualLeave2.SETTABLEVIEW(t_VG);
                          R_AnnualLeave2.RUN;
                        END;
                      END;
                             */

                    /*
                    IF t_emp.GET("Employee No.") THEN BEGIN
                      IF (("Starting Date of II part" = 0D) AND ("Ending Date of II part" <> 0D)) THEN
                        MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name")  ;
                      IF (("Ending Date of I part" = 0D)  AND  ("Starting Date of I part" = 0D)) THEN
                        MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name");
                      ELSE IF "Ending Date of II part" = 0D THEN
                         MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name")
                      ELSE IF "Ending Date of I part" = 0D THEN
                         MESSAGE(Text0001,t_emp."First Name",t_emp."Last Name")
                    END;
                    */

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        GeneralL: Record "General Ledger Setup";
    begin
        CurrentYear := (DATE2DMY(TODAY, 3));
        LastYear := (DATE2DMY(TODAY, 3) - 1);
        SETRANGE(Year, LastYear, CurrentYear);
        GeneralL.Get();
        if GeneralL."Is Simple Page" = false
        then
            Simple := false
        else
            Simple := true;


    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        GeneralL: Record "General Ledger Setup";
    begin
        GeneralL.Get();
        if GeneralL."Is Simple Page" = false
        then
            Simple := false
        else
            Simple := true;


    end;


    var
        //ĐKR_AnnualLeave: Report "50044";
        //ĐK R_AnnualLeave2: Report "50045";
        Text0001: Label 'Vacation period is not entered for %1 %2.';

        Simple: Boolean;
        t_emp: Record "Employee";
        Temp: Boolean;
        Text0002: Label 'Do you want to print Annual Leave Resolution for first part of leave?';
        Text0003: Label 'Do you want to print Annual Leave Resolution for second part of leave?';
        //t_VG: Record "Vacation Grounds2";
        VG: Record "Vacation Ground 2";
        Selection: Integer;
        Text0004: Label 'Annual Leave Resolution for I part,Annual Leave Resolution for II part';
        t: Text;
        CurrentYear: Integer;
        LastYear: Integer;
}

