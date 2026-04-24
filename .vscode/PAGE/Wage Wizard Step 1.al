page 50020 "Wage Wizard Step 1"
{
    Caption = 'Wage Wizard Step 1-Wage parameters';
    PageType = Card;
    SourceTable = "Wage Header";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Entry No."; "Entry No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                group(Period)
                {
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;

                    field("Month Of Wage"; "Month Of Wage")
                    {
                        BlankZero = true;
                        Style = Unfavorable;
                        StyleExpr = true;
                        ApplicationArea = all;


                        trigger OnValidate()
                        var
                            EndDate: Date;
                        begin
                            IF (WHeader."Month Of Wage" <> "Month Of Wage") AND (WHeader."Month Of Wage" <> 0) THEN
                                ERROR(Txt008, WHeader."No.", WageHeader."Entry No.", WHeader."Month Of Wage", WHeader."Year Of Wage");

                            RecWageHeader3.SETRANGE("No.", Rec."No.");
                            IF RecWageHeader3.FIND('+') THEN BEGIN
                                RecWageHeader3."Month Of Wage" := Rec."Month Of Wage";
                                RecWageHeader3."Year Of Wage" := Rec."Year Of Wage";
                                HeaderDescription := Txt012;
                                RecWageHeader3.Description := HeaderDescription + ' ' + FORMAT("Month Of Wage") + '.' + FORMAT("Year Of Wage");
                                RecWageHeader3.MODIFY;
                                CurrPage.UPDATE(FALSE);
                                RecWageHeader3."Hour Pool" := AbsenceFill.GetHourPool(Rec."Month Of Wage", Rec."Year Of Wage", WageSetup."Hours in Day");
                                RecWageHeader3.MODIFY;
                            END;

                            wc.SETFILTER("Month Of Wage", '%1', Rec."Month Of Wage");
                            wc.SETFILTER("Year of Wage", '%1', Rec."Year Of Wage");
                            wc.SETFILTER("Wage Calculation Type", '%1', wc."Wage Calculation Type"::Regular);
                            IF wc.FIND('-') THEN ERROR(Txt011);

                            /*wc2.SETFILTER("Month Of Wage",'%1',Rec."Month Of Wage");
                            wc2.SETFILTER("Year of Wage",'%1', Rec."Year Of Wage");
                            wc2.SETFILTER("Wage Calculation Type",'<>%1', wc2."Wage Calculation Type"::Regular);
                             IF wc2.FIND('-') THEN    BEGIN
                           // Rec."No.":=wc2."Wage Header No.";
                            WH.SETFILTER("Month Of Wage",'%1',Rec."Month Of Wage");
                            WH.SETFILTER("Year Of Wage",'%1', Rec."Year Of Wage");
                              IF WH.FIND('-') THEN    BEGIN
                                 CurrPage.CLOSE;
                            NewPage.SETRECORD(WH);
                            NewPage.RUN;


                            END;

                              END
                            ELSE BEGIN
                            wc3.SETFILTER("No.",'<>%1','');
                            IF  wc3.FINDLAST THEN
                            Rec."No.":=INCSTR(wc3."Wage Header No.")
                            ELSE
                            Rec."No.":='000000000';
                             END;


                         WageSetup.GET;
                         RecWageHeader."No.":=Rec."No.";
                         RecWageHeader."Average Yearly Hour Pool":=WageSetup."Average Yearly Hour Pool";
                         RecWageHeader."Work Experience Basis":=WageSetup."Work Experience Basis";
                         RecWageHeader.StatuOns:= RecWageHeader.Status::Open;
                         RecWageHeader."Month Of Wage":=InitMonth;
                         RecWageHeader."Year Of Wage":=InitYear;
                         RecWageHeader."Month of Calculation":=DATE2DMY(WORKDATE,2);
                         RecWageHeader."Year of Calculation":=DATE2DMY(WORKDATE,3);
                         RecWageHeader."Date Of Calculation":=WORKDATE;

                         IF RecWageHeader."Wage Calculation Type" = RecWageHeader."Wage Calculation Type"::Normal THEN BEGIN
                          RecWageHeader.Meal := TRUE;
                          RecWageHeader.Taxable := TRUE;
                          RecWageHeader.Transportation := TRUE;
                          RecWageHeader.Reduction := TRUE;
                         END;

                         //RecWageHeader."Hour Pool":=AbsenceFill.GetHourPool(InitMonth,InitYear,WageSetup."Hours in Day");
                         RecWageHeader."User ID":=USERID;
                         RecWageHeader."General Coefficient":=WageSetup."General Coefficient";
                         RecWageHeader."Coefficient Increase":=WageSetup."Coefficient Increase";


                         RecWageHeader."Monthly Minimum Wage":=WageSetup."Min. wage on state level"*RecWageHeader."Hour Pool";
                         RecWageHeader2.SETRANGE("Month Of Wage",Rec."Month Of Wage");
                         RecWageHeader2.SETRANGE("Year Of Wage",Rec."Year Of Wage");
                         //RecWageHeader2.SETRANGE(Status,RecWageHeader2.Status::Open);
                         IF NOT RecWageHeader2.FIND('+') THEN
                         // IF  RecWageHeader2.FIND('-') THEN

                         RecWageHeader.INSERT
                         ELSE
                         RecWageHeader.MODIFY;


                         Rec."Hour Pool":=AbsenceFill.GetHourPool("Month Of Wage","Year Of Wage",WageSetup."Hours in Day");
                         WageSetup.GET;
                         Rec.MODIFY;
                         Rec."Hour Pool":=AbsenceFill.GetHourPool("Month Of Wage","Year Of Wage",WageSetup."Hours in Day");
                         Rec.MODIFY;     */
                            EndDate := AbsenceFill.GetMonthRange("Month Of Wage", "Year Of Wage", FALSE);
                            "Closing Date" := EndDate;
                            "Date Of Calculation" := EndDate;

                            //ĐK


                        end;
                    }
                    field("Year Of Wage"; "Year Of Wage")
                    {
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                        ApplicationArea = all;


                        trigger OnValidate()
                        begin
                            IF (WHeader."Year Of Wage" <> "Year Of Wage") AND (WHeader."Month Of Wage" <> 0) THEN
                                ERROR(Txt008, WHeader."No.", WageHeader."Entry No.", WHeader."Month Of Wage", WHeader."Year Of Wage");

                            /*
                            Rec."Hour Pool":=AbsenceFill.GetHourPool("Month Of Wage","Year Of Wage",WageSetup."Hours in Day");
                            Rec.MODIFY;
                               WH.SETFILTER("Month Of Wage",'%1',Rec."Month Of Wage");
                               WH.SETFILTER("Year Of Wage",'%1', Rec."Year Of Wage");
                                IF WH.FIND('-') THEN ERROR(Txt011)  ;*/

                            RecWageHeader4.SETRANGE("No.", Rec."No.");
                            IF RecWageHeader4.FIND('+') THEN BEGIN
                                RecWageHeader4."Month Of Wage" := Rec."Month Of Wage";
                                RecWageHeader4."Year Of Wage" := Rec."Year Of Wage";
                                RecWageHeader4.MODIFY;
                                CurrPage.UPDATE(FALSE);
                                RecWageHeader4."Hour Pool" := AbsenceFill.GetHourPool(Rec."Month Of Wage", Rec."Year Of Wage", WageSetup."Hours in Day");
                                RecWageHeader4.Description := HeaderDescription + ' ' + FORMAT("Month Of Wage") + '.' + FORMAT("Year Of Wage");
                                RecWageHeader4.MODIFY;
                            END;

                        end;
                    }
                }
            }
            group("Wage Calculation")
            {
                Caption = 'Wage Calculation';
                field("Wage Calculation Type"; "Wage Calculation Type")
                {
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF "Wage Calculation Type" = "Wage Calculation Type"::Normal THEN BEGIN
                            Meal := TRUE;
                            Taxable := TRUE;
                            Transportation := TRUE;
                            Reduction := TRUE;
                            RecWageHeader.Meal := TRUE;
                            RecWageHeader.Taxable := TRUE;
                            RecWageHeader.Transportation := TRUE;
                            RecWageHeader.Reduction := TRUE;
                        END
                        ELSE BEGIN
                            Meal := FALSE;
                            Taxable := FALSE;
                            Transportation := FALSE;
                            Reduction := FALSE;
                            RecWageHeader.Meal := FALSE;
                            RecWageHeader.Taxable := FALSE;
                            RecWageHeader.Transportation := FALSE;
                            RecWageHeader.Reduction := FALSE;
                        END;
                    end;
                }
                field("Closing Date"; "Closing Date")
                {
                    Visible = true;
                    ApplicationArea = all;
                }


                field(Status; Status)
                {
                    Editable = false;
                }

                field("Date Of Calculation"; "Date Of Calculation")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Hour Pool"; "Hour Pool")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Average Yearly Hour Pool"; "Average Yearly Hour Pool")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Year of Calculation"; "Year of Calculation")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Month of Calculation"; "Month of Calculation")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group("Wage Setup")
            {
                Caption = 'Wage Setup';
                field("General Coefficient"; "General Coefficient")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Taxable; Taxable)
                {
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        RecWageHeader.Taxable := Taxable;
                    end;
                }
                field(Reduction; Reduction)
                {
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        RecWageHeader.Reduction := Reduction;
                    end;
                }
                field(Meal; Meal)
                {
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        RecWageHeader.Meal := Meal;

                    end;
                }
                field(Transportation; Transportation)
                {
                    Editable = false;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        RecWageHeader.Transportation := Transportation;

                    end;
                }
                field("Average Add Period Start"; "Average Add Period Start")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Average Add Period End"; "Average Add Period End")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Average Add Amount"; "Average Add Amount")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Average Add Percentage"; "Average Add Percentage")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Brutto Sum"; "Brutto Sum")
                {
                    Caption = 'Brutto Sum';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                var
                    EmployeeUpdateREd: Record Employee;
                    EmployeeAbsence: Record "Employee Absence";
                    StartingDate: Date;
                    EndingDate: Date;
                    AbsFill: Codeunit "Absence Fill";
                    Datum: Record Date;
                    EU: Record Employee;
                    WU: Record "Work Booklet";
                    ECLU: Record "Employee Contract Ledger";
                    HourPollTotal: Integer;
                    COARed: Record "Employee Absence";
                    NotInsert: boolean;
                    TotalSUm: decimal;
                begin
                    IF Rec."Wage Calculation Type" = "Wage Calculation Type"::Normal THEN BEGIN
                        EndingDate := AbsFill.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", false);

                        EU.Reset();
                        EU.SetFilter("For Calculation", '%1', true);
                        if EU.FindSet() then
                            repeat
                                WU.Reset();
                                WU.SetFilter("Employee No.", '%1', EU."No.");
                                WU.SetFilter("Current Company", '%1', true);
                                WU.SetFilter("Hours change", '%1', false);
                                WU.SetFilter("Starting Date", '<=%1', EndingDate);
                                WU.SetCurrentKey("Starting Date");
                                WU.Ascending;
                                if WU.FindLast() then begin
                                    if WU."Starting Date" <> EU."Employment Date" then
                                        EU."Employment Date" := WU."Starting Date";

                                    ECLU.Reset();
                                    ECLU.SetFilter("Employee No.", '%1', EU."No.");
                                    ECLU.SetFilter("Starting Date", '<=%1', EndingDate);
                                    ECLU.SetCurrentKey("Starting Date");
                                    ECLU.Ascending;
                                    if ECLU.FindLast() then begin
                                        if ECLU."Grounds for Term. Description" <> '' then
                                            EU."Termination Date" := ECLU."Ending Date"
                                        else
                                            EU."Termination Date" := 0D;
                                        EU.Modify();
                                    end;

                                end;


                            until EU.Next() = 0;


                        Commit();
                        R_BroughtExperience.RUN;
                        R_WorkExperience.SetEndingDate(Rec."Date Of Calculation");
                        R_WorkExperience.RUN;
                        Commit();
                        //ĐEMINA OVDJE DODATI

                        //EC01
                        /*R_BroughtExperience.RUN;
                        R_WorkExperience.SetEndingDate(Rec."Date Of Calculation");
                        R_WorkExperience.RUN;

                        COMMIT;
                        TCReport.SetParam("Month Of Wage","Year Of Wage");
                        TCReport.RUN;
                        COMMIT;*/
                        //EC01e
                        StartingDate := AbsFill.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", true);
                        EndingDate := AbsFill.GetMonthRange(Rec."Month Of Wage", Rec."Year Of Wage", false);

                        EmployeeUpdateREd.reset;
                        EmployeeUpdateREd.SetFilter("For Calculation", '%1', true);
                        if EmployeeUpdateREd.FindFirst() then
                            repeat
                                NotInsert := False;
                                TotalSum := 0;
                                WageSetup.get;
                                HourPollTotal := AbsFill.GetHourPool(Rec."Month Of Wage", Rec."Year Of Wage", WageSetup."Hours in Day");
                                COARed.Reset();
                                COARed.SetFilter("From Date", '%1..%2', StartingDate, EndingDate);
                                COARed.SetFilter("Employee No.", '%1', EmployeeUpdateREd."No.");
                                COARed.SetFilter("Payment Type", '%1', COARed."Payment Type"::"Regular Work");
                                if COARed.FindFirst() then begin
                                    COARed.calcsums(Quantity);
                                    totalsum := COARed.Quantity;
                                end
                                else begin
                                    totalsum := 0;
                                end;

                                if totalsum < HourPollTotal then begin

                                    EmployeeAbsence.SetFilter("Employee No.", '%1', EmployeeUpdateREd."No."); //trazim odsustvo za jednog zaposlenog
                                    if (EmployeeUpdateREd."Termination Date" <> 0D) and (EmployeeUpdateREd."Termination Date" >= StartingDate)
                                and (EmployeeUpdateREd."Termination Date" <= EndingDate) then
                                        EmployeeAbsence.SetFilter("From Date", '%1..%2', StartingDate, EmployeeUpdateREd."Termination Date")
                                    else
                                        EmployeeAbsence.SetFilter("From Date", '%1..%2', StartingDate, EndingDate); //filter na unesene datume u request page-u
                                    EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                                    EmployeeAbsence.SetFilter(Unpaid, '%1', false);
                                    if NOT EmployeeAbsence.FindFirst() then begin //u tabeli nema nijednog odsustva za ovog zaposlenog
                                        WageSetup.Get();
                                        if (EmployeeUpdateREd."Termination Date" <> 0D) and (EmployeeUpdateREd."Termination Date" >= StartingDate)
                               and (EmployeeUpdateREd."Termination Date" <= EndingDate) then begin


                                            AbsenceFill.EmployeeAbsence(StartingDate, EmployeeUpdateREd."Termination Date", EmployeeUpdateREd, WageSetup."Workday Code", EmployeeUpdateREd."Hours In Day")

                                        end else begin
                                            AbsenceFill.EmployeeAbsence(StartingDate, EndingDate, EmployeeUpdateREd, WageSetup."Workday Code", EmployeeUpdateREd."Hours In Day");

                                        end;
                                    end
                                    else begin //pronađeno je barem 1 odsustvo

                                        Datum.RESET;
                                        Datum.SETFILTER("Period Type", '%1', 0);
                                        if (EmployeeUpdateREd."Termination Date" <> 0D) and (EmployeeUpdateREd."Termination Date" >= StartingDate)
                                and (EmployeeUpdateREd."Termination Date" <= EndingDate) then
                                            Datum.SETRANGE("Period Start", StartingDate, EmployeeUpdateREd."Termination Date")
                                        else
                                            Datum.SETRANGE("Period Start", StartingDate, EndingDate); //uzimam dane izmedju unesenih datuma
                                        Datum.FINDFIRST;

                                        repeat
                                            EmployeeAbsence.Reset();
                                            EmployeeAbsence.SetFilter("Employee No.", '%1', EmployeeUpdateREd."No.");
                                            EmployeeAbsence.SetFilter("From Date", '%1', Datum."Period Start"); //jedan dan
                                            EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                                            EmployeeAbsence.SetFilter(Unpaid, '%1', false);
                                            if NOT EmployeeAbsence.FindFirst() then begin //nije pronadjeno odustvo na ovaj dan
                                                WageSetup.Get();
                                                AbsenceFill.EmployeeAbsence(Datum."Period Start", Datum."Period Start", EmployeeUpdateREd, WageSetup."Workday Code", EmployeeUpdateREd."Hours In Day");
                                            end;
                                        until Datum.NEXT = 0; //sljedeći datum
                                    end;
                                end;
                            until EmployeeUpdateREd.Next() = 0; //sljedeci zaposlenik

                        //isto uraditi za punjenje praznika

                        //isto uraditi za punjenje praznika


                        Response := CONFIRM(Txt006);
                        IF Response THEN BEGIN
                            ConfirmClose := FALSE;
                            CurrPage.SAVERECORD;
                            HasError := FALSE;
                            IF CalcType = 2 THEN
                                WagePrecalculation.RunPrecalculation(Rec, HasError)
                            ELSE
                                WagePrecalculation.RunPrecalculation(Rec, HasError);
                            IF HasError THEN BEGIN
                                CurrPage.SAVERECORD;

                                COMMIT;
                                ErrorsForm.SETRECORD(Rec);
                                ErrorsForm.RUNMODAL;
                            END
                            ELSE BEGIN
                                CurrPage.SAVERECORD;

                                CLEAR(CalcWage);
                                CalcWage.DeleteTemps;
                                CalcWage.RUN(Rec);
                                CurrPage.EDITABLE(FALSE);
                                COMMIT;
                                FinalForm.SETRECORD(Rec);
                                FinalForm.RUNMODAL;
                            END;
                            CurrPage.CLOSE;
                        END;
                    END;
                    IF (Rec."Wage Calculation Type" = "Wage Calculation Type"::"Fixed Add") OR (Rec."Wage Calculation Type" = "Wage Calculation Type"::"Average Amount Add") THEN BEGIN

                        Response := CONFIRM(Txt006);
                        IF Response THEN BEGIN
                            ConfirmClose := FALSE;
                            CurrPage.SAVERECORD;
                            HasError := FALSE;
                            IF CalcType = 2 THEN
                                WagePrecalculation.RunPrecalculationAdditions(Rec, HasError)
                            ELSE
                                WagePrecalculation.RunPrecalculationAdditions(Rec, HasError);
                            IF HasError THEN BEGIN
                                CurrPage.SAVERECORD;

                                COMMIT;
                                ErrorsForm.SETRECORD(Rec);
                                ErrorsForm.RUNMODAL;
                            END
                            ELSE BEGIN
                                CurrPage.SAVERECORD;

                                CLEAR(CalcWage);
                                CalcWage.DeleteTemps;
                                CalcWage.RUN(Rec);
                                CurrPage.EDITABLE(FALSE);
                                COMMIT;
                                FinalForm.SETRECORD(Rec);
                                FinalForm.RUNMODAL;
                            END;
                            CurrPage.CLOSE;
                        END;
                    END;

                end;
            }
            action(Cancel)
            {
                Image = Cancel;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Status IN [Status::Closed, Status::Locked]
         THEN
            NextEnable := FALSE
        ELSE
            NextEnable := TRUE;

    end;

    trigger OnClosePage()
    begin
        WageHeader.RESET;
        WageHeader.SETFILTER(Status, FORMAT(WageHeader.Status::Open));
        IF WageHeader.FIND('-') THEN BEGIN
            WageHeader.CALCFIELDS(Brutto, "Addition Sum");
            IF (WageHeader.Brutto = 0) AND (WageHeader."Addition Sum" = 0) THEN
                WageHeader.DELETE;
        END;
    end;

    trigger OnInit()
    begin

        CopyLastHeader := FALSE;
        ConfirmClose := TRUE;
        IF NOT WageSetup.GET THEN
            ERROR(Txt001);
        //WS.GET();
    end;

    trigger OnOpenPage()
    var
        TypeOption: Label 'Normal,Fixed Add,Average Add,Average Coefficient Add;';
    begin

        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);

        //WageHeader.RESET;
        /*WageHeader.SETRANGE(Status,0);
        IF WageHeader.FIND('-') THEN
          WageHeader.DELETE;       */

        WageHeader.SETFILTER(Status, '%1', Status::Open);
        IF WageHeader.FIND('-') THEN BEGIN
            WHeader := WageHeader;
        END;

        //WageHeader.RESET;

        WageHeader.SETFILTER(Status, '%1', Status::Open);

        IF WageHeader.FINDSET THEN BEGIN

            Rec := WageHeader;
            WageHeader.VALIDATE("Wage Calculation Type", 0);
            FILTERGROUP(10);
            Rec.SETRANGE("No.", Rec."No.");
            Rec.SETRANGE("Entry No.", Rec."Entry No.");
            FILTERGROUP(0);
            Rec."General Coefficient" := WageSetup."General Coefficient";
            Rec."Coefficient Increase" := WageSetup."Coefficient Increase";

            Rec."Monthly Minimum Wage" := WageSetup."Min. wage on state level" * Rec."Hour Pool";
            Rec.MODIFY;

            FormatWageCalcTypeFields;
            EXIT;
        END
        ELSE BEGIN
            WageSetup.GET;
            RecWageHeader."No." := Rec."No.";


            RecWageHeader."Average Yearly Hour Pool" := WageSetup."Average Yearly Hour Pool";
            RecWageHeader."Work Experience Basis" := WageSetup."Work Experience Basis";
            RecWageHeader.Status := RecWageHeader.Status::Open;

            //RecWageHeader."Month Of Wage":=  5;
            RecWageHeader."Year Of Wage" := DATE2DMY(WORKDATE, 3);


            wc2.SETFILTER("Month Of Wage", '%1', RecWageHeader."Month Of Wage");
            wc2.SETFILTER("Year of Wage", '%1', RecWageHeader."Year Of Wage");
            wc2.SETFILTER("Wage Calculation Type", '<>%1', wc2."Wage Calculation Type"::Regular);
            IF wc2.FIND('-') THEN BEGIN
                RecWageHeader."No." := wc2."Wage Header No.";


            END
            ELSE BEGIN
                wc3.SETFILTER("No.", '<>%1', '');
                IF wc3.FINDLAST THEN
                    RecWageHeader."No." := INCSTR(wc3."Wage Header No.")
                ELSE
                    RecWageHeader."No." := '000000000';
            END;


            RecWageHeader."Month of Calculation" := DATE2DMY(WORKDATE, 2);
            RecWageHeader."Year of Calculation" := DATE2DMY(WORKDATE, 3);
            RecWageHeader."Date Of Calculation" := CALCDATE('1M', CALCDATE('-SM-1D', WORKDATE));
            RecWageHeader."Closing Date" := CALCDATE('1M', CALCDATE('-SM-1D', WORKDATE));


            IF RecWageHeader."Wage Calculation Type" = RecWageHeader."Wage Calculation Type"::Normal THEN BEGIN
                RecWageHeader.Meal := TRUE;
                RecWageHeader.Taxable := TRUE;
                RecWageHeader.Transportation := TRUE;
                RecWageHeader.Reduction := TRUE;
                HeaderDescription := Txt012;
                RecWageHeader.Description := HeaderDescription + ' ';
            END
            ELSE BEGIN
                HeaderDescriptionAddition := Txt013;
                RecWageHeader.Description := HeaderDescriptionAddition + ' ';
            END;

            RecWageHeader."Hour Pool" := AbsenceFill.GetHourPool(RecWageHeader."Month of Calculation", RecWageHeader."Year of Calculation", WageSetup."Hours in Day");
            RecWageHeader."User ID" := USERID;
            RecWageHeader."General Coefficient" := WageSetup."General Coefficient";
            RecWageHeader."Coefficient Increase" := WageSetup."Coefficient Increase";


            RecWageHeader."Monthly Minimum Wage" := WageSetup."Min. wage on state level" * RecWageHeader."Hour Pool";
            RecWageHeader2.SETRANGE("Month Of Wage", InitMonth);
            RecWageHeader2.SETRANGE("Year Of Wage", InitYear);
            //RecWageHeader2.SETRANGE(Status,RecWageHeader2.Status::Open);
            IF NOT RecWageHeader2.FIND('+') THEN
                // IF  RecWageHeader2.FIND('-') THEN

                RecWageHeader.INSERT

        END;

        /*WageHeader.RESET;
        WageHeader.SETRANGE(Status, Status::Open);
        IF WageHeader.FIND('+') THEN
          ERROR(Txt008, WageHeader."No.", WageHeader."Entry No.", WageHeader."Month Of Wage",WageHeader."Year Of Wage");    */

        //FILTERGROUP(10);
        Rec.SETFILTER(Status, '<>%1', Status::Closed);
        FILTERGROUP(0);
        //WagePrecalculation.InitRecord(Rec);
        FormatWageCalcTypeFields;

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //bt
        IF ConfirmClose THEN BEGIN
            Response := CONFIRM(Txt002);
            EXIT(Response);
        END
        ELSE
            EXIT(TRUE);
        Response := CONFIRM(Txt006);
        //bt
        //IF Response THEN
        BEGIN
            ConfirmClose := FALSE;
            CurrPage.SAVERECORD;
            HasError := FALSE;
            WagePrecalculation.RunPrecalculation(Rec, HasError);
            IF HasError THEN BEGIN
                CurrPage.SAVERECORD;
                COMMIT;
                ErrorsForm.SETRECORD(Rec);
                ErrorsForm.RUNMODAL;
            END
            ELSE BEGIN
                CurrPage.SAVERECORD;
                CLEAR(CalcWage);
                CalcWage.DeleteTemps;
                CalcWage.RUN(Rec);
                CurrPage.EDITABLE(FALSE);
                COMMIT;
                FinalForm.SETRECORD(Rec);
                FinalForm.RUNMODAL;
            END;
            CurrPage.CLOSE;
        END;
    end;

    var
        HeaderDescriptionAddition: Text[250];
        HeaderDescription: Text[250];
        WH: Record "Wage Header";
        //NK BCTCReport: Report "Employee Contract Ledger";
        WageSetup: Record "Wage Setup";
        HourPool: Integer;
        CopyLastHeader: Boolean;
        WageHeader: Record "Wage Header";
        AbsenceFill: Codeunit "Absence Fill";
        Response: Boolean;
        Employee: Record "Employee";
        WageCalcTemp: Record "Wage Calculation Temp";
        PostCity: Record "Post Code";
        Step2: Page "Wage Wizard Step 2";
        ReductionTemp: Record "Reduction per Wage Temp";
        WageCalc: Record "Wage Calculation";
        ConfirmClose: Boolean;
        TransHeader: Record "Transport Header";
        TransTemp: Record "Transport Line Temp";
        TransNo: Code[10];
        ATTemp: Record "Contribution Per Employee Temp";
        TaxTemp: Record "Tax Per Employee Temp";
        InitMonth: Integer;
        InitYear: Integer;
        InitRec: Boolean;
        EMPCoeff: Record "Employee";
        ErrFile: File;
        ErrFileName: Text[150];
        WPClose: Codeunit "Wage Precalculation";
        WagePrecalculation: Codeunit "Wage Precalculation";
        HasError: Boolean;
        FinalForm: Page "Wage Wizard Step 5";
        ErrorsForm: Page "Wage Wizard Step 4n";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

        CalcWage: Codeunit "Wage Calculation";
        Txt001: Label 'Postavke plaća nisu unesene!';
        Txt002: Label 'Do you want to quit wage calculation?';
        Txt003: Label 'Da li želite otvoriti postojeći obračun plaća za mjesec , godinu';
        Txt004: Label 'Ne postoji ni jedan zaključen Obračun plaće koji bi mogli prekopirati.';
        Txt005: Label 'Da li želite prekopirati posljednji obračun plaće?';
        Txt006: Label 'Do you want to proceed with the next step?';
        Txt007: Label 'Označili ste obračun prijevoza. Nema otvorenih Obračuna prijevoza za zadani mjesec i godinu plaće.';
        Txt008: Label 'Imate otvorenih, a nezaključenih obračuna. \Prvo zaključite obračun broj: %1, broj obrade: %2, za mjesec: %3, godinu: %4, pa onda otvorite novi.';
        Txt009: Label 'Postoje djelatnici koji su uključeni u obračun ali im koeficijent nije potvrđen!';
        Txt010: Label '\Izvještaj o ovim radnicima pogledajte u %1.';
        Err01: Label 'Polje %2 mora biti veće ili jednako polju %1';
        NextEnable: Boolean;
        AverageAddPeriodStartVisible: Boolean;
        "Average Add Period EndVisible": Boolean;
        "Average Add AmountVisible": Boolean;
        "Average Add PercentageVisible": Boolean;
        Txt011: Label 'Calculation for chosen period already exists!';
        wc: Record "Wage Calculation";
        wc2: Record "Wage Calculation";
        Rec2: Record "Wage Header";
        wc3: Record "Wage Calculation";
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        RecWageHeader: Record "Wage Header";
        RecWageHeader2: Record "Wage Header";
        Month: Integer;
        NewPage: Page "Wage Wizard Step 1";
        CalcType: Integer;
        RecWageHeader3: Record "Wage Header";
        RecWageHeader4: Record "Wage Header";
        WHeader: Record "Wage Header" temporary;
        Txt012: Label 'Wage for';
        Txt013: Label 'Additions for';

    procedure FormatWageCalcTypeFields()
    begin


        CASE Rec."Wage Calculation Type" OF
            "Wage Calculation Type"::Normal, "Wage Calculation Type"::"Fixed Add":
                BEGIN
                    AverageAddPeriodStartVisible := FALSE;
                    "Average Add Period EndVisible" := FALSE;
                    "Average Add AmountVisible" := FALSE;
                    "Average Add PercentageVisible" := FALSE;
                END;
            "Wage Calculation Type"::"Average Amount Add":
                BEGIN
                    AverageAddPeriodStartVisible := FALSE; //TRUE;
                    "Average Add Period EndVisible" := FALSE; //TRUE;
                    "Average Add AmountVisible" := FALSE; //TRUE;
                    "Average Add PercentageVisible" := FALSE;
                END;
            "Wage Calculation Type"::"Average Percentage Add":
                BEGIN
                    AverageAddPeriodStartVisible := TRUE;
                    "Average Add Period EndVisible" := TRUE;
                    "Average Add AmountVisible" := FALSE;
                    "Average Add PercentageVisible" := TRUE;
                END;
        END;
    end;
}

