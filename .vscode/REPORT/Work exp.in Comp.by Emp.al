report 50024 "Work exp.in Comp.by Emp"
{
    Caption = 'Ukupni obracun staža';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1; Employee)
        {
            column(BroughtYearsofExperience_Employee; DataItem1."Brought Years of Experience")
            {
            }
            column(BroughtMonthsofExperience_Employee; DataItem1."Brought Months of Experience")
            {
            }
            column(BroughtDaysofExperience_Employee; DataItem1."Brought Days of Experience")
            {
            }
            column(YearsofExperienceinCompany_Employee; DataItem1."Years of Experience in Company")
            {
            }
            column(MonthsofExpinCompany_Employee; DataItem1."Months of Exp. in Company")
            {
            }
            column(DaysofExperienceinCompany_Employee; DataItem1."Days of Experience in Company")
            {
            }
            column(YearsofExperience_Employee; DataItem1."Years of Experience")
            {
            }
            column(MonthsofExperience_Employee; DataItem1."Months of Experience")
            {
            }
            column(DaysofExperience_Employee; DataItem1."Days of Experience")
            {
            }

            trigger OnAfterGetRecord()
            var
                EmployeeCL: Record "Work Booklet";
            begin
                //HR01
                SETFILTER(Status, '%1|%2|%3|%4', 0, 1, 2, 3);
                //SETFILTER(Status,'%1|%2',0,1);

                IF EndingDate = 0D THEN EndingDate := EndingDate;
                wb.SETFILTER("Employee No.", '%1', "No.");
                wb.SETFILTER("Current Company", '%1', TRUE);
                IF wb.FindLast() THEN BEGIN
                    wb.CALCFIELDS(Status);
                    IF ((wb.Status.AsInteger() = 0) OR (wb.Status.AsInteger() = 1) OR (wb.Status.AsInteger() = 2) OR (wb.Status.AsInteger() = 3)) THEN BEGIN
                        IF ((wb."Current Company")) THEN
                            wb.VALIDATE("Ending Date", EndingDate);


                        wb.VALIDATE(Coefficient, wb.Coefficient);
                        wb.MODIFY;

                    END;
                    /*ELSE BEGIN
                      ECL.SETFILTER("Employee No.",'%1',"No.");
                      ECL.SETFILTER("Grounds for Term. Code",'<>%1','');
                      IF ECL.FIND('-') THEN BEGIN
                      IF ((wb."Current Company")) THEN
                    wb.VALIDATE("Ending Date",ECL."Ending Date");
                    wb.MODIFY;
                    END;
                      END;*/
                END;


                UkupnoGodine := 0;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                t_WorkBooklet.SETFILTER("Current Company", '%1', TRUE);
                IF t_WorkBooklet.FINDFIRST THEN BEGIN
                    REPEAT
                        UkupniDani += t_WorkBooklet.Days;
                        UkupniMjeseci += t_WorkBooklet.Months;
                        UkupnoGodine += t_WorkBooklet.Years;
                    UNTIL t_WorkBooklet.NEXT = 0;

                    t_WorkBookletCurrent.SETFILTER("Employee No.", "No.");
                    t_WorkBookletCurrent.SETFILTER("Current Company", '%1', TRUE);

                    IF t_WorkBookletCurrent.FINDLAST THEN BEGIN
                        TrenutniDani := t_WorkBookletCurrent.Days;
                        TrenutniMjeseci := t_WorkBookletCurrent.Months;
                        TrenutneGodine := t_WorkBookletCurrent.Years;
                    END;
                    HumanResourcesSetup.GET;

                    /*
                    "Days of Experience in Company":=UkupniDani MOD 30;
                    "Months of Exp. in Company":=(UkupniMjeseci+(UkupniDani DIV 30)) MOD 12;
                    "Years of Experience in Company":=UkupnoGodine+ ((UkupniMjeseci+(UkupniDani DIV 30)) DIV 12);*/

                    "Current Days Total" := UkupniDani MOD 30;
                    "Current Months Total" := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                    "Current Years Total" := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);

                    "Days of Experience in Company" := TrenutniDani MOD 30;
                    "Months of Exp. in Company" := (TrenutniMjeseci + (TrenutniDani DIV 30)) MOD 12;
                    "Years of Experience in Company" := TrenutneGodine + ((TrenutniMjeseci + (TrenutniDani DIV 30)) DIV 12);

                    /*"Brought Years of Exp. in Curr.":=("Current Years Total"-"Years of Experience in Company")+((("Current Months Total"-"Months of Exp. in Company")+(("Current Days Total"-"Days of Experience in Company") DIV 30)) DIV 12);

                    "Brought Months of Exp.in Curr.":=(("Current Months Total"-"Months of Exp. in Company")+(("Current Days Total"-"Days of Experience in Company") DIV 30)) MOD 12;
                    "Brought Days of Exp.in Curr.":=("Current Days Total"-"Days of Experience in Company") MOD 30;

                    BroughtTotal:= "Brought Years of Exp. in Curr."*365+"Brought Months of Exp.in Curr."*12+"Brought Days of Exp.in Curr.";*/

                    "Brought Days of Exp.in Curr." := (UkupniDani - TrenutniDani) MOD 30;
                    "Brought Months of Exp.in Curr." := ((UkupniMjeseci - TrenutniMjeseci) + ((UkupniDani - TrenutniDani) DIV 30)) MOD 12;
                    "Brought Years of Exp. in Curr." := (UkupnoGodine - TrenutneGodine) + (((UkupniMjeseci - TrenutniMjeseci) + ((UkupniDani - TrenutniDani) DIV 30)) DIV 12);
                END ELSE BEGIN
                    "Days of Experience in Company" := 0;
                    "Months of Exp. in Company" := 0;
                    "Years of Experience in Company" := 0;

                    "Brought Years of Exp. in Curr." := 0;
                    "Brought Months of Exp.in Curr." := 0;
                    "Brought Days of Exp.in Curr." := 0;

                    "Current Days Total" := 0;
                    "Current Months Total" := 0;
                    "Current Years Total" := 0;
                END;

                UkupnoGodine := 0;
                UkupniDani := 0;
                UkupniMjeseci := 0;
                MODIFY;


                t_WorkBooklet.RESET;
                t_WorkBooklet.SETFILTER("Employee No.", "No.");
                IF t_WorkBooklet.FINDFIRST THEN BEGIN
                    REPEAT
                        UkupniDani += t_WorkBooklet.Days;
                        UkupniMjeseci += t_WorkBooklet.Months;
                        UkupnoGodine += t_WorkBooklet.Years;
                    UNTIL t_WorkBooklet.NEXT = 0;


                    HumanResourcesSetup.GET;

                    UkupniDani += "Brought Days of Experience";
                    UkupniMjeseci += "Brought Months of Experience";
                    UkupnoGodine += "Brought Years of Experience";

                    "Days of Experience" := UkupniDani MOD 30;
                    "Months of Experience" := (UkupniMjeseci + (UkupniDani DIV 30)) MOD 12;
                    "Years of Experience" := UkupnoGodine + ((UkupniMjeseci + (UkupniDani DIV 30)) DIV 12);
                END ELSE BEGIN
                    "Days of Experience" := 0;
                    "Months of Experience" := 0;
                    "Years of Experience" := 0;
                END;

                //"Brought Years Total":=(UkupnoGodine) +((UkupniMjeseci) +((UkupniDani) div 30) ) div 12;
                "Brought Years Total" := ("Brought Years of Exp. in Curr." + "Brought Years of Experience") +
                (("Brought Months of Exp.in Curr." + "Brought Months of Experience") + (("Brought Days of Exp.in Curr." + "Brought Days of Experience") DIV 30)) DIV 12;
                "Brought Months Total" := (("Brought Months of Exp.in Curr." + "Brought Months of Experience") + (("Brought Days of Exp.in Curr." + "Brought Days of Experience") DIV 30)) MOD 12;
                "Brought Days Total" := (("Brought Days of Exp.in Curr." + "Brought Days of Experience") MOD 30);




                IF WageSetup.GET THEN BEGIN
                    IF "Org Entity Code" = 'FBIH' THEN BEGIN
                        IF WageSetup."Type Of Work Percentage Calc." = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage";
                    END;

                    IF "Org Entity Code" = 'BD' THEN BEGIN
                        //BD

                        IF WageSetup."Type Of Work Percentage Cal BD" = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage BD"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage BD";

                    END;


                    IF "Org Entity Code" = 'RS' THEN BEGIN
                        // RS
                        IF WageSetup."Type Of Work Percentage Cal RS" = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage RS"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage RS";
                    END;


                    IF "Contribution Category Code" = 'FBIHRS' THEN BEGIN
                        IF WageSetup."Type Of Work Percentage Calc." = 0 THEN
                            "Work Experience Percentage" := "Current Years Total" * WageSetup."Work Percentage"
                        ELSE
                            "Work Experience Percentage" := "Years of Experience" * WageSetup."Work Percentage";
                    END;

                    if "Work Experience Percentage" > 20 then
                        "Work Experience Percentage" := 20;
                    MODIFY;
                END;
                ECL.SETFILTER("Employee No.", '%1', "No.");
                ECL.SETFILTER(Active, '%1', TRUE);
                IF ECL.FIND('-') THEN
                    ECL.VALIDATE(Brutto, ECL.Brutto);

            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER(Status,'%1',Status::Active);
                SETFILTER(Status, '%1|%2', 0, 1);
                SETFILTER("No.", '%1', EmployeeNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

        //MESSAGE(Text0001);
        //BH proba update
        WorkBooklet.RESET;
        WorkBooklet.SETFILTER(Coefficient, '<>%1', 1);
        WorkBooklet.SETFILTER(Status, '<>%1', WorkBooklet.Status::Terminated);
        IF WorkBooklet.FINDSET THEN
            REPEAT
                IF WorkBooklet."Ending Date" = 0D THEN
                    WorkBooklet."Ending Date" := WorkDate();
                WorkBooklet.VALIDATE(Coefficient, WorkBooklet.Coefficient);
                WorkBooklet.MODIFY;

            UNTIL WorkBooklet.NEXT = 0;
        //MESSAGE(Text0001);
        MESSAGE('Završeno');
        //BH proba update
    end;

    var
        zadnji: Text[100];
        Str: Text[100];
        position: Integer;
        lenght: Integer;
        UkupniDani: Integer;
        UkupnoGodine: Integer;
        t_WorkBooklet: Record "Work Booklet";
        UkupniMjeseci: Integer;
        UkupniDaniBEZ: Integer;
        UkupnoGodineBEZ: Integer;
        UkupniMjeseciBEZ: Integer;
        EmployeeCL: Record "Work Booklet";
        DateRec: Date;
        EmployeeRec: Record "Employee";
        Text0001: Label 'Employee Card is updated.';
        wb: Record "Work Booklet";
        HumanResourcesSetup: Record "Human Resources Setup";
        EndingDate: Date;
        WageSetup: Record "Wage Setup";
        t_WorkBookletCurrent: Record "Work Booklet";
        WorkBooklet: Record "Work Booklet";
        TrenutniDani: Integer;
        TrenutniMjeseci: Integer;
        TrenutneGodine: Integer;
        BroughtTotal: Integer;
        BroughtTotalDays: Integer;
        BroughtTotalMonths: Integer;
        BroughtTotalYears: Integer;
        ECL: Record "Employee Contract Ledger";
        EmployeeNo: Code[10];

    procedure SetEndingDate(Date: Date)
    begin

        EndingDate := Date;
        //HR01
    end;

    procedure SetEmpNo(EmpNo: Code[10])
    begin

        EmployeeNo := EmpNo;
        //HR01
    end;
}

