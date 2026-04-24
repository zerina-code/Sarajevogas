report 50198 EmployeeAbsenceAnalysisReport
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Employee Absence Analysis report';
    RDLCLayout = './EmployeeAbsenceAnalysis.rdl';

    dataset
    {
        dataitem(Totals; "Integer")
        {
            column(TotalDays; TotalDays) { }
            column(TotalDaysZene; TotalDaysZene) { }
            column(TotalDaysMuskarci; TotalDaysMuskarci) { }
            column(DaysPercentageZene; DaysPercentageZene) { }
            column(DaysPercentageMuskarci; DaysPercentageMuskarci) { }
            column(CountZene; CountZene) { }
            column(CountMuskarci; CountMuskarci) { }
            column(CountTotal; CountTotal) { }
            column(PercentageZene; PercentageZene) { }
            column(PercentageMuskarci; PercentageMuskarci) { }
            column(ProcessingYear; ProcessingYear) { }
            column(PreviousYear; PreviousYear) { }
            column(Selected; Selected) { }
            column(WorkExp_1_5_NoOfAbsentEmployees; WorkExp_1_5_NoOfAbsentEmployees) { }
            column(WorkExp_6_10_NoOfAbsentEmployees; WorkExp_6_10_NoOfAbsentEmployees) { }
            column(WorkExp_11_15_NoOfAbsentEmployees; WorkExp_11_15_NoOfAbsentEmployees) { }
            column(WorkExp_16_20_NoOfAbsentEmployees; WorkExp_16_20_NoOfAbsentEmployees) { }
            column(WorkExp_21_25_NoOfAbsentEmployees; WorkExp_21_25_NoOfAbsentEmployees) { }
            column(WorkExp_26_30_NoOfAbsentEmployees; WorkExp_26_30_NoOfAbsentEmployees) { }
            column(WorkExp_31_35_NoOfAbsentEmployees; WorkExp_31_35_NoOfAbsentEmployees) { }
            column(WorkExp_36_40_NoOfAbsentEmployees; WorkExp_36_40_NoOfAbsentEmployees) { }
            column(WorkExp_over_40_NoOfAbsentEmployees; WorkExp_over_40_NoOfAbsentEmployees) { }

            column(WorkExp_1_5_TotalNoOfDays; WorkExp_1_5_TotalNoOfDays) { }
            column(WorkExp_6_10_TotalNoOfDays; WorkExp_6_10_TotalNoOfDays) { }
            column(WorkExp_11_15_TotalNoOfDays; WorkExp_11_15_TotalNoOfDays) { }
            column(WorkExp_16_20_TotalNoOfDays; WorkExp_16_20_TotalNoOfDays) { }
            column(WorkExp_21_25_TotalNoOfDays; WorkExp_21_25_TotalNoOfDays) { }
            column(WorkExp_26_30_TotalNoOfDays; WorkExp_26_30_TotalNoOfDays) { }
            column(WorkExp_31_35_TotalNoOfDays; WorkExp_31_35_TotalNoOfDays) { }
            column(WorkExp_36_40_TotalNoOfDays; WorkExp_36_40_TotalNoOfDays) { }
            column(WorkExp_over_40_TotalNoOfDays; WorkExp_over_40_TotalNoOfDays) { }

            column(Age_18_to_30_NoOfAbsentEmployees; Age_18_to_30_NoOfAbsentEmployees) { }
            column(Age_31_to_35_NoOfAbsentEmployees; Age_31_to_35_NoOfAbsentEmployees) { }
            column(Age_36_to_40_NoOfAbsentEmployees; Age_36_to_40_NoOfAbsentEmployees) { }
            column(Age_41_to_45_NoOfAbsentEmployees; Age_41_to_45_NoOfAbsentEmployees) { }
            column(Age_46_to_50_NoOfAbsentEmployees; Age_46_to_50_NoOfAbsentEmployees) { }
            column(Age_51_to_55_NoOfAbsentEmployees; Age_51_to_55_NoOfAbsentEmployees) { }
            column(Age_56_to_60_NoOfAbsentEmployees; Age_56_to_60_NoOfAbsentEmployees) { }
            column(Age_61_to_65_NoOfAbsentEmployees; Age_61_to_65_NoOfAbsentEmployees) { }

            column(Age_18_to_30_TotalNoOfDays; Age_18_to_30_TotalNoOfDays) { }
            column(Age_31_to_35_TotalNoOfDays; Age_31_to_35_TotalNoOfDays) { }
            column(Age_36_to_40_TotalNoOfDays; Age_36_to_40_TotalNoOfDays) { }
            column(Age_41_to_45_TotalNoOfDays; Age_41_to_45_TotalNoOfDays) { }
            column(Age_46_to_50_TotalNoOfDays; Age_46_to_50_TotalNoOfDays) { }
            column(Age_51_to_55_TotalNoOfDays; Age_51_to_55_TotalNoOfDays) { }
            column(Age_56_to_60_TotalNoOfDays; Age_56_to_60_TotalNoOfDays) { }
            column(Age_61_to_65_TotalNoOfDays; Age_61_to_65_TotalNoOfDays) { }

            column(VSS_NoOfAbsentEmployees; VSS_NoOfAbsentEmployees) { }
            column(VSHS_NoOfAbsentEmployees; VSHS_NoOfAbsentEmployees) { }
            column(SSS_NoOfAbsentEmployees; SSS_NoOfAbsentEmployees) { }
            column(VKV_NoOfAbsentEmployees; VKV_NoOfAbsentEmployees) { }
            column(KV_NoOfAbsentEmployees; KV_NoOfAbsentEmployees) { }
            column(PK_NK_NoOfAbsentEmployees; PK_NK_NoOfAbsentEmployees) { }

            column(VSS_TotalNoOfDays; VSS_TotalNoOfDays) { }
            column(VSHS_TotalNoOfDays; VSHS_TotalNoOfDays) { }
            column(SSS_TotalNoOfDays; SSS_TotalNoOfDays) { }
            column(VKV_TotalNoOfDays; VKV_TotalNoOfDays) { }
            column(KV_TotalNoOfDays; KV_TotalNoOfDays) { }
            column(PK_NK_TotalNoOfDays; PK_NK_TotalNoOfDays) { }

            column(Duration_1_to_5_NoOfAbsentEmployees; Duration_1_to_5_NoOfAbsentEmployees) { }
            column(Duration_6_to_10_NoOfAbsentEmployees; Duration_6_to_10_NoOfAbsentEmployees) { }
            column(Duration_11_to_15_NoOfAbsentEmployees; Duration_11_to_15_NoOfAbsentEmployees) { }
            column(Duration_16_to_20_NoOfAbsentEmployees; Duration_16_to_20_NoOfAbsentEmployees) { }
            column(Duration_21_to_25_NoOfAbsentEmployees; Duration_21_to_25_NoOfAbsentEmployees) { }
            column(Duration_26_to_30_NoOfAbsentEmployees; Duration_26_to_30_NoOfAbsentEmployees) { }
            column(Duration_31_to_35_NoOfAbsentEmployees; Duration_31_to_35_NoOfAbsentEmployees) { }
            column(Duration_36_to_41_NoOfAbsentEmployees; Duration_36_to_41_NoOfAbsentEmployees) { }
            column(Duration_42_to_60_NoOfAbsentEmployees; Duration_42_to_60_NoOfAbsentEmployees) { }
            column(Duration_61_to_100_NoOfAbsentEmployees; Duration_61_to_100_NoOfAbsentEmployees) { }
            column(Duration_over_101_NoOfAbsentEmployees; Duration_over_101_NoOfAbsentEmployees) { }

            column(Average_1_to_5; Average_1_to_5) { }
            column(Average_6_to_10; Average_6_to_10) { }
            column(Average_11_to_15; Average_11_to_15) { }
            column(Average_16_to_20; Average_16_to_20) { }
            column(Average_21_to_25; Average_21_to_25) { }
            column(Average_26_to_30; Average_26_to_30) { }
            column(Average_31_to_35; Average_31_to_35) { }
            column(Average_36_to_41; Average_36_to_41) { }
            column(Average_42_to_60; Average_42_to_60) { }
            column(Average_61_to_100; Average_61_to_100) { }
            column(Average_over_101; Average_over_101) { }

            column(PeriodLabel; PeriodLabel) { }
            column(TotalNumberOfWorkingDaysForAllEmployees; TotalNumberOfWorkingDaysForAllEmployees) { }
            column(TotalNumberOfAbsentDays; TotalNumberOfAbsentDays) { }
            column(AchievedSickLeaveRate; AchievedSickLeaveRate) { }
            column(AchievedTotalNumberOfWorkingDays; AchievedTotalNumberOfWorkingDays) { }
            column(PercentageOfAvailableStaff; PercentageOfAvailableStaff) { }

            column(VSS_MR_DR_NoOfEmployees; VSS_MR_DR_NoOfEmployees) { }
            column(VSHS_NoOfEmployees; VSHS_NoOfEmployees) { }
            column(VKV_NoOfEmployees; VKV_NoOfEmployees) { }
            column(SSS_NoOfEmployees; SSS_NoOfEmployees) { }
            column(KV_NoOfEmployees; KV_NoOfEmployees) { }
            column(PK_i_NK_NoOfEmployees; PK_i_NK_NoOfEmployees) { }
            column(ToDateFilterFormattedIntegerTbl; FORMAT(ToDateFilter, 0, 4)) { }
            column(FromDateFilterFormattedIntegerTbl; FORMAT(FromDateFilter, 0, 4)) { }
            column(ProcessingYearIterationCounter; ProcessingYearIterationCounter) { }
            column(CountOfEmployees; CountOfEmployees) { }
            column(CountOfAbsentEmployees; CountOfAbsentEmployees) { }
            column(PercentageOfAbsentEmployees; PercentageOfAbsentEmployees) { }

            dataitem(Departments; "Department")
            {
                column(Code; Code) { }
                column(Description; Description) { }
                column(TotalWorkingDays; TotalWorkingDays) { }
                column(RowCounter; RowCounter) { }
                column(EmployeeCount; EmployeeCount) { }
                column(TotalNoWorkingDaysAllEmployees; TotalNoWorkingDaysAllEmployees) { }
                column(TotalDaysAllEmployees; TotalDaysAllEmployees) { }
                column(RealizedPercentageOfAbsences; RealizedPercentageOfAbsences) { }
                column(PercentageOfWorkersAvailability; PercentageOfWorkersAvailability) { }
                column(AverageNumberOfWorkersAtWork; AverageNumberOfWorkersAtWork) { }
                column(NumberOfWorkersWhoDidntWorkEntireYear; NumberOfWorkersWhoDidntWorkEntireYear) { }
                column(TextTitle; TextTitle) { }

                column(Recruited; Recruited) { }
                column(Departed; Departed) { }
                column(Reassigned; Reassigned) { }
                column(DifferenceIncreaseDecrease; DifferenceIncreaseDecrease) { }

                column(DeptFilters; DeptFilters) { }
                column(DeptTableCaptDeptFilter; TABLECAPTION + ': ' + DeptFilters) { }
                column(ToDateFilterFormattedDepartmentTbl; FORMAT(ToDateFilter, 0, 4)) { }
                column(FromDateFilterFormattedDepartmentTbl; FORMAT(FromDateFilter, 0, 4)) { }


                trigger OnPreDataItem()
                var
                    ORGShema: Record "ORG Shema";
                begin
                    RowCounter := 0;
                    TextTitle := '';
                    //ORGShema.SetRange("Date From", FromDateFilter, ToDateFilter); // treba da koristi operator <= i gledam ovaj TODATE
                    // kako bi prikazao zadnju važeću org shemu
                    ORGShema.SetFilter("Date From", '<=%1', ToDateFilter);
                    ORGShema.SetCurrentKey("Date From");
                    ORGShema.Ascending := true;

                    if ORGShema.FindLast() then begin
                        SetRange("ORG Shema", ORGShema.Code);
                        CurrentORGSchema := ORGShema.Code;
                    end else begin
                        SetRange("ORG Shema", '');
                    end;

                    if Selected = Selected::kvalifikacionaStrukturaKadrova then begin
                        SetFilter("Department Type", '%1|%2', "Department Type"::Sector, "Department Type"::CEO); //u prijevodu, dept types: Sektor i Uprava
                        SetFilter("ORG Shema", '%1', CurrentORGSchema);
                    end else
                        if (Selected = Selected::poOrgJed) or (Selected = Selected::povecanjeSmanjenjeBrojaRadnika) then begin
                            //
                        end else begin
                            SetRange("Code", '');
                        end;
                end;

                trigger OnAfterGetRecord()
                begin
                    RowCounter += 1;

                    if Selected = Selected::poOrgJed then begin
                        CalculateTotalsDepartment(YearStartDate, YearEndDate, ProcessingYear);
                    end else
                        if Selected = Selected::kvalifikacionaStrukturaKadrova then begin
                            CalculateTotalsQualificationStructureOfPersonnel(YearStartDate, YearEndDate);
                            TextTitle += Format(RowCounter + 1) + '+';
                        end else
                            if Selected = Selected::povecanjeSmanjenjeBrojaRadnika then begin
                                OverviewIncreaseDecreaseNumberOfWorkers(YearStartDate, YearEndDate);
                            end;
                end;
            }
            dataitem("Cause of Absence Tbl"; "Cause of Absence")
            {
                column(COACode; Code) { }
                column(Basis_of_Absence; "Basis of Absence") { }
                column(NumberOfRealizedHours; NumberOfRealizedHours) { }
                column(RealizedValueKM; RealizedValueKM) { }
                column(Sick_Leave_Paid_By_Company; "Sick Leave Paid By Company") { }
                column(COA_RowCounter; COA_RowCounter) { }
                column(CurrentPeriodStartMonthText; CurrentPeriodStartMonthText) { }
                column(CurrentPeriodEndMonthText; CurrentPeriodEndMonthText) { }

                column(TotalEAQuantity; TotalEAQuantity) { }
                column(TotalWVEValue; TotalWVEValue) { }
                column(ProcessingYearIterationCounterCol1; ProcessingYearIterationCounterCol1) { }
                column(ProcessingYearIterationCounterCol2; ProcessingYearIterationCounterCol2) { }
                column(ProcessingYearIterationCounterCol3; ProcessingYearIterationCounterCol3) { }
                column(NumberOfRealizedHours_Index; NumberOfRealizedHours_Index) { }
                column(RealizedValueKM_Index; RealizedValueKM_Index) { }
                column(TotalEAQuantity_Index; TotalEAQuantity_Index) { }
                column(TotalWVEValue_Index; TotalWVEValue_Index) { }

                trigger OnPreDataItem()
                begin
                    //ovaj if je da spriječi ulazak u ovaj dataitem kada vrtim izvjestaje iz Departments dataitema. 
                    if (Selected = Selected::kvalifikacionaStrukturaKadrova) or (Selected = Selected::povecanjeSmanjenjeBrojaRadnika) then begin
                        CurrReport.SKIP;
                        SetRange("Cause of Absence Tbl".Code, '');
                    end;
                    SetFilter("Basis of Absence", '<>%1', "Basis of Absence"::Empty);
                    SetCurrentKey("Sick Leave Paid By Company");
                    Ascending(false); //mogu li se ovdje staviti dva sortinga, prvo po sick leave paid by company, a poslije basis of absence asc?
                    COA_RowCounter := 0;
                    TotalEAQuantity := 0;
                    TotalWVEValue := 0;
                    TotalEAQuantity_Index := 0;
                    TotalWVEValue_Index := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    //ovaj if je da spriječi ulazak u ovaj dataitem kada vrtim izvjestaje iz Departments dataitema. 
                    if (Selected = Selected::kvalifikacionaStrukturaKadrova) or (Selected = Selected::povecanjeSmanjenjeBrojaRadnika) then begin
                        CurrReport.SKIP;
                        SetRange("Cause of Absence Tbl".Code, '');
                    end;
                    if not ProcessedBasisOfAbsenceList.Contains("Basis of Absence") then begin
                        ProcessedBasisOfAbsenceList.Add("Basis of Absence");

                        COA_RowCounter += 1;

                        BasisOfAbsenceCOACodes := GetCOACodesForBasisOfAbsence("Basis of Absence");

                        if Selected = Selected::ostvareniSatiOdsustvaSaRadaINaknada then begin
                            CalculateTotalsAchievedHoursOfAbsenceFromWorkAndBenefits(YearStartDate, YearEndDate, BasisOfAbsenceCOACodes, "Basis of Absence", ProcessingYear);
                        end;

                    end;
                end;
            }


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                TempGLE.Init();
                ProcessingYearIterationCounter := 0;
                ProcessingYearIterationCounterCol1 := 3;
                ProcessingYearIterationCounterCol2 := 4;
                ProcessingYearIterationCounterCol3 := 5;
                PreviousYear := StartYear - 1;

                if (Selected = Selected::poOrgJed) or
                  (Selected = Selected::kvalifikacionaStrukturaKadrova) or
                   (Selected = Selected::povecanjeSmanjenjeBrojaRadnika) then
                    myInt := 1 //ako je po organizacionim jedinicama, tada ogranici na jedno izvrsavanje
                else
                    myInt := EndYear - StartYear + 1;
                SetFilter(Number, '%1..%2', 1, myInt);
                CurrentYear := StartYear;
            end;

            trigger OnAfterGetRecord()
            var
                baseNumber: Integer;
            begin
                Clear(ProcessedBasisOfAbsenceList);

                ProcessingYearIterationCounter += 1;

                //izračunaj broj kolone po iteracijama: 
                baseNumber := 3 + ((ProcessingYearIterationCounter - 1) * 3);

                ProcessingYearIterationCounterCol1 := baseNumber;
                ProcessingYearIterationCounterCol2 := baseNumber + 1;
                ProcessingYearIterationCounterCol3 := baseNumber + 2;

                ProcessingYear := CurrentYear; //Prvo isprocesiraj ProcessingYear, pa tek onda dodijeli iducu godinu nakon što se završi ovaj ciklus

                PreviousYear := ProcessingYear - 1;

                YearStartDate := DMY2DATE(1, 1, ProcessingYear);
                YearEndDate := DMY2DATE(31, 12, ProcessingYear);

                if ProcessingYear = StartYear then
                    YearStartDate := DMY2DATE(StartDay, StartMonth, ProcessingYear);

                if ProcessingYear = EndYear then
                    YearEndDate := DMY2DATE(EndDay, EndMonth, ProcessingYear);

                if Selected = Selected::poSpolu then
                    CalculateTotalsGender(YearStartDate, YearEndDate)
                else
                    if Selected = Selected::poDuziniRadnogStaza then
                        CalculateTotalsPerLengthOfWorkExperience(YearStartDate, YearEndDate)
                    else
                        if Selected = Selected::poZivotnojDobi then
                            CalculateTotalsPerAge(YearStartDate, YearEndDate)
                        else
                            if Selected = Selected::poStrucnojSpremi then
                                CalculateTotalsPerQualifications(YearStartDate, YearEndDate)
                            else
                                if Selected = Selected::poTrajanjuIzostanaka then
                                    CalculateTotalsPerDurationOfAbsences(YearStartDate, YearEndDate)
                                else
                                    if (Selected = Selected::ostvarenaStopaBolovanja) or (Selected = Selected::raspoloziviRadniKadar) then
                                        CalculateTotalsAchievedSickLeaveRate(YearStartDate, YearEndDate)
                                    else
                                        // if Selected = Selected::kvalifikacionaStrukturaKadrova then
                                        //   CalculateTotalsQualificationStructureOfPersonnel(YearStartDate, YearEndDate)
                                        //else
                                        if Selected = Selected::brojRadnikaKojiSuImaliIzostanke then
                                            CalculateTotalsOverviewOfNumberOfAbsentWorkers(YearStartDate, YearEndDate);

                if CurrentYear < EndYear then begin
                    CurrentYear += 1;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("SelectReport")
                {
                    Caption = 'Select a report';
                    field(Selected; Selected)
                    {
                        Caption = 'Select';
                        OptionCaption = ' ,Per gender,Per department,Per length of work experience,Per age,Per qualifications,Per duration of absences,Achieved sick leave rate,Available staff,Qualification structure of personnel,Overview of the increase/decrease in the number of workers,Achieved hours of absence from work and benefits,Overview of number of absent workers';

                        trigger OnValidate()
                        var
                            ThisYear: Integer;
                        begin
                            ThisYear := Date2DMY(Today, 3);

                            if Selected = Selected::poOrgJed then begin
                                FromDateFilter := DMY2Date(1, 1, ThisYear);
                            end else begin
                                FromDateFilter := DMY2DATE(1, 1, ThisYear - 2);
                            end;

                        end;
                    }
                }

                group("GroupCaption")
                {
                    Caption = 'Choose dates';

                    field("FromDate"; FromDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Date from';
                        ToolTip = 'Enter the start date.';
                        NotBlank = true;

                        trigger OnValidate()
                        begin
                            if FromDateFilter > ToDateFilter then
                                Error(ErrorLbl1);
                        end;
                    }
                    field("ToDate"; ToDateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Date to';
                        ToolTip = 'Enter the end date. (not mandatory)';

                        trigger OnValidate()
                        begin
                            if ToDateFilter < FromDateFilter then
                                Error(ErrorLbl2);

                            StartYear := Date2DMY(FromDateFilter, 3);
                            EndYear := Date2DMY(ToDateFilter, 3);
                            if Selected = Selected::poOrgJed then begin
                                if EndYear <> StartYear then begin
                                    Error(ErrorLbl4);
                                end;
                            end;
                        end;
                    }
                }
            }
        }
        trigger OnInit()
        var
            ThisYear: Integer;
        begin
            ThisYear := Date2DMY(Today, 3);
            FromDateFilter := DMY2DATE(1, 1, ThisYear - 2);
            ToDateFilter := DMY2DATE(31, 12, ThisYear);
        end;
    }

    trigger OnPreReport()
    begin
        DeptFilters := Departments.GETFILTERS;
        DepartmentTypeFilter := Departments.GetFilter("Department Type");

        if FromDateFilter = 0D then begin
            Error(ErrorLbl3);
        end else begin
            StartDay := Date2DMY(FromDateFilter, 1);
            StartMonth := Date2DMY(FromDateFilter, 2);
            StartYear := Date2DMY(FromDateFilter, 3);
        end;

        if ToDateFilter = 0D then begin
            EndDay := StartDay;
            EndMonth := StartMonth;
            EndYear := StartYear
        end else begin
            EndDay := Date2DMY(ToDateFilter, 1);
            EndMonth := Date2DMY(ToDateFilter, 2);
            EndYear := Date2DMY(ToDateFilter, 3);
        end;
        RowCounter := 0;
    end;

    local procedure CalculateTotalsGender(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        COA: Record "Cause of Absence";
        EA: Record "Employee Absence";
        E: Record "Employee";
        UniqueMaleEmployeeIDs: List of [Code[20]];
        UniqueFemaleEmployeeIDs: List of [Code[20]];
        HoursInDay, StandardFullDayHours : Integer;
    begin
        TotalDays := 0;
        TotalDaysZene := 0;
        TotalDaysMuskarci := 0;
        SpolMuskarac := Enum::"Employee Gender"::Male;
        SpolZena := Enum::"Employee Gender"::Female;
        CountZene := 0;
        CountMuskarci := 0;
        CountTotal := 0;
        HoursInDay := 0;
        StandardFullDayHours := 8;

        COA.Reset();
        COA.SetFilter("Sick Leave Paid By Company", '%1', true);
        if COA.FindSet() then
            repeat
                EA.Reset();
                EA.SetFilter("Cause of Absence Code", '%1', COA.Code);
                EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);
                if EA.FindSet() then
                    repeat
                        if E.Get(EA."Employee No.") then begin
                            if E."Hours in Day" = 0 then
                                HoursInDay := StandardFullDayHours
                            else
                                HoursInDay := E."Hours in Day";

                            if E.Gender = SpolMuskarac then begin
                                TotalDaysMuskarci += EA.Quantity / HoursInDay;
                                if not UniqueMaleEmployeeIDs.Contains(E."No.") then begin
                                    UniqueMaleEmployeeIDs.Add(E."No.");
                                end;
                            end else
                                if E.Gender = SpolZena then begin
                                    TotalDaysZene += EA.Quantity / HoursInDay;
                                    if not UniqueFemaleEmployeeIDs.Contains(E."No.") then begin
                                        UniqueFemaleEmployeeIDs.Add(E."No.");
                                    end;
                                end;
                        end;
                        TotalDays += EA.Quantity / HoursInDay;
                    until EA.Next() = 0;
            until COA.Next() = 0;

        CountMuskarci := UniqueMaleEmployeeIDs.Count();
        CountZene := UniqueFemaleEmployeeIDs.Count();
        CountTotal := CountZene + CountMuskarci;

        // Izracunnaj procente i ukupne brojeve dana po spolu: 
        if CountTotal > 0 then begin
            PercentageZene := (CountZene / CountTotal) * 100;
            PercentageMuskarci := (CountMuskarci / CountTotal) * 100;
        end else begin
            PercentageZene := 0;
            PercentageMuskarci := 0;
        end;

        if TotalDays > 0 then begin
            DaysPercentageZene := (TotalDaysZene / TotalDays) * 100;
            DaysPercentageMuskarci := (TotalDaysMuskarci / TotalDays) * 100;
        end else begin
            DaysPercentageZene := 0;
            DaysPercentageMuskarci := 0;
        end;
    end;

    local procedure CalculateTotalsDepartment(StartDateToProcess: Date; EndDateToProcess: Date; YearToProcess: Integer)
    var
        DateRec: Record "Date";
        COA: Record "Cause of Absence";
        E: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        EA: Record "Employee Absence";
        EmployeeCountLocal: Integer;
        TotalDaysLocal: Decimal;
        TotalDaysPerCOA: Decimal;
        HoursInDay, StandardFullDayHours : Decimal;
    begin
        TotalWorkingDays := 0;
        EmployeeCountLocal := 0;
        HoursInDay := 0;
        StandardFullDayHours := 8;
        TotalDaysAllEmployees := 0;
        TotalDaysLocal := 0;

        //isfiltriraj period tip = datum
        DateRec.SetRange("Period Type", DateRec."Period Type"::Date);
        DateRec.SetRange("Period Start", DMY2DATE(1, 1, YearToProcess), DMY2DATE(31, 12, YearToProcess));
        DateRec.SetRange("Period No.", 1, 5);
        if DateRec.FindSet() then
            repeat
                TotalWorkingDays += 1;
            until DateRec.Next() = 0;

        // treba prvo da ide kroz E, pa onda ECL
        // E findset
        // ECL findlast

        E.Reset();
        if E.FindSet() then
            repeat
                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', E."No.");
                ECL.SetFilter("Department Name", Departments.Description);
                ECL.SetFilter("Department Code", Departments.Code); //ostaviti i po sifri i po nazivu ..
                ECL.SetFilter("Org. Structure", Departments."ORG Shema");
                ECL.SetFilter("Starting Date", '<=%1', ToDateFilter); //važeća stavka ugovora
                ECL.SetCurrentKey("Starting Date");
                ECL.Ascending := true;

                if ECL.FindLast() then begin
                    EmployeeCountLocal += 1;

                    //saznaj broj sati u danu koje radnik radi:

                    if E."Hours in Day" = 0 then
                        HoursInDay := StandardFullDayHours
                    else
                        HoursInDay := E."Hours in Day";

                    TotalDaysPerCOA := 0;
                    COA.Reset();
                    COA.SetFilter("Sick Leave Paid By Company", '%1', true);
                    if COA.FindSet() then
                        repeat
                            TotalDaysLocal := 0;
                            EA.Reset();
                            EA.SetFilter("Cause of Absence Code", '%1', COA.Code);
                            EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);
                            EA.SetRange("Employee No.", E."No.");
                            if EA.FindSet() then
                                repeat
                                    TotalDaysLocal += EA.Quantity / HoursInDay;
                                until EA.Next() = 0;
                            TotalDaysPerCOA += TotalDaysLocal;
                        until COA.Next() = 0;
                    TotalDaysAllEmployees += TotalDaysPerCOA;

                end;

                EmployeeCount := EmployeeCountLocal;
                TotalNoWorkingDaysAllEmployees := TotalWorkingDays * EmployeeCount; //Predviđeni ukupan broj radnih dana svih radnika

                if TotalNoWorkingDaysAllEmployees = 0 then begin
                    RealizedPercentageOfAbsences := 0;
                    PercentageOfWorkersAvailability := 0;
                end else begin
                    RealizedPercentageOfAbsences := TotalDaysAllEmployees / TotalNoWorkingDaysAllEmployees; //Ostvarena stopa bolovanja u Preduzeću
                    PercentageOfWorkersAvailability := (TotalNoWorkingDaysAllEmployees - TotalDaysAllEmployees) / TotalNoWorkingDaysAllEmployees * 100; //Procenat raspoloživog radnog kadra
                end;

                AverageNumberOfWorkersAtWork := EmployeeCount * PercentageOfWorkersAvailability / 100; // Prosječan broj radnika koji su prisutni u Preduzeću - kolona8
                NumberOfWorkersWhoDidntWorkEntireYear := AverageNumberOfWorkersAtWork - EmployeeCount; //Broj radnika koji nisu radili cijelu godinu  -kolona9
            until E.Next() = 0;
    end;

    local procedure CalculateTotalsPerLengthOfWorkExperience(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        EA: Record "Employee Absence";
        E: Record "Employee";
        HoursInDay, StandardFullDayHours : Integer;
        YearsWithMilitary: Integer;
    begin
        HoursInDay := 0;
        StandardFullDayHours := 8;

        WorkExp_1_5_NoOfAbsentEmployees := 0;
        WorkExp_6_10_NoOfAbsentEmployees := 0;
        WorkExp_11_15_NoOfAbsentEmployees := 0;
        WorkExp_16_20_NoOfAbsentEmployees := 0;
        WorkExp_21_25_NoOfAbsentEmployees := 0;
        WorkExp_26_30_NoOfAbsentEmployees := 0;
        WorkExp_31_35_NoOfAbsentEmployees := 0;
        WorkExp_36_40_NoOfAbsentEmployees := 0;
        WorkExp_over_40_NoOfAbsentEmployees := 0;

        WorkExp_1_5_TotalNoOfDays := 0;
        WorkExp_6_10_TotalNoOfDays := 0;
        WorkExp_11_15_TotalNoOfDays := 0;
        WorkExp_16_20_TotalNoOfDays := 0;
        WorkExp_21_25_TotalNoOfDays := 0;
        WorkExp_26_30_TotalNoOfDays := 0;
        WorkExp_31_35_TotalNoOfDays := 0;
        WorkExp_36_40_TotalNoOfDays := 0;
        WorkExp_over_40_TotalNoOfDays := 0;


        //Prvo saznaj Šifre bolovanja i smjesti ih u varijablu COA_Codes
        COA_Codes := '';
        COA_Codes := GetCOACodes();

        E.Reset();

        if E.FindSet() then
            repeat
                EA.Reset();
                EA.SetFilter("Cause of Absence Code", COA_Codes);
                EA.SetFilter("Employee No.", E."No.");
                EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);
                if EA.FindFirst() then begin
                    if E."Hours in Day" = 0 then
                        HoursInDay := StandardFullDayHours
                    else
                        HoursInDay := E."Hours in Day";


                    EA.CalcSums(Quantity);
                    TotalDays := EA.Quantity / HoursInDay;

                    // poziv na izracun staza
                    //proslijediti samo emp
                    R_BroughtExperience.SetEmp(EA."Employee No.");
                    R_BroughtExperience.RUN;
                    R_WorkExperience.SetEmp(EA."Employee No.", EndDateToProcess);
                    R_WorkExperience.RUN;
                    Commit();

                    YearsWithMilitary := E."Years with military";

                    if (YearsWithMilitary >= 1) and (YearsWithMilitary <= 5) then begin
                        WorkExp_1_5_NoOfAbsentEmployees += 1;
                        WorkExp_1_5_TotalNoOfDays += TotalDays;
                    end else
                        if (YearsWithMilitary >= 6) and (YearsWithMilitary <= 10) then begin
                            WorkExp_6_10_NoOfAbsentEmployees += 1;
                            WorkExp_6_10_TotalNoOfDays += TotalDays;
                        end else
                            if (YearsWithMilitary >= 11) and (YearsWithMilitary <= 15) then begin
                                WorkExp_11_15_NoOfAbsentEmployees += 1;
                                WorkExp_11_15_TotalNoOfDays += TotalDays;
                            end else
                                if (YearsWithMilitary >= 16) and (YearsWithMilitary <= 20) then begin
                                    WorkExp_16_20_NoOfAbsentEmployees += 1;
                                    WorkExp_16_20_TotalNoOfDays += TotalDays;
                                end else
                                    if (YearsWithMilitary >= 21) and (YearsWithMilitary <= 25) then begin
                                        WorkExp_21_25_NoOfAbsentEmployees += 1;
                                        WorkExp_21_25_TotalNoOfDays += TotalDays;
                                    end else
                                        if (YearsWithMilitary >= 26) and (YearsWithMilitary <= 30) then begin
                                            WorkExp_26_30_NoOfAbsentEmployees += 1;
                                            WorkExp_26_30_TotalNoOfDays += TotalDays;
                                        end else
                                            if (YearsWithMilitary >= 31) and (YearsWithMilitary <= 35) then begin
                                                WorkExp_31_35_NoOfAbsentEmployees += 1;
                                                WorkExp_31_35_TotalNoOfDays += TotalDays;
                                            end else
                                                if (YearsWithMilitary >= 36) and (YearsWithMilitary <= 40) then begin
                                                    WorkExp_36_40_NoOfAbsentEmployees += 1;
                                                    WorkExp_36_40_TotalNoOfDays += TotalDays;
                                                end else
                                                    if (YearsWithMilitary > 40) then begin
                                                        WorkExp_over_40_NoOfAbsentEmployees += 1;
                                                        WorkExp_over_40_TotalNoOfDays += TotalDays;
                                                    end;

                    //Na kraju, vrati radni staz na danasnji dan
                    //izvršiti ovdje kako bi se to odradilo samo za afektane uposlenike (onPostReport bi to odradio za sve, što bi bilo previše)
                    R_WorkExperience.SetEmp(EA."Employee No.", Today);
                    R_WorkExperience.RUN;
                    Commit();

                end;

            until E.Next() = 0;
    end;

    local procedure CalculateTotalsPerAge(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        EA: Record "Employee Absence";
        E: Record "Employee";
        HoursInDay, StandardFullDayHours : Integer;
        AgeT: Decimal;
        Age: Integer;
    begin
        HoursInDay := 0;
        StandardFullDayHours := 8;
        COA_Codes := '';
        COA_Codes := GetCOACodes();

        Age_18_to_30_TotalNoOfDays := 0;
        Age_31_to_35_TotalNoOfDays := 0;
        Age_36_to_40_TotalNoOfDays := 0;
        Age_41_to_45_TotalNoOfDays := 0;
        Age_46_to_50_TotalNoOfDays := 0;
        Age_51_to_55_TotalNoOfDays := 0;
        Age_56_to_60_TotalNoOfDays := 0;
        Age_61_to_65_TotalNoOfDays := 0;

        Age_18_to_30_NoOfAbsentEmployees := 0;
        Age_31_to_35_NoOfAbsentEmployees := 0;
        Age_36_to_40_NoOfAbsentEmployees := 0;
        Age_41_to_45_NoOfAbsentEmployees := 0;
        Age_46_to_50_NoOfAbsentEmployees := 0;
        Age_51_to_55_NoOfAbsentEmployees := 0;
        Age_56_to_60_NoOfAbsentEmployees := 0;
        Age_61_to_65_NoOfAbsentEmployees := 0;

        E.Reset();
        if E.FindSet() then
            repeat
                EA.Reset();
                EA.SetFilter("Cause of Absence Code", COA_Codes);
                EA.SetFilter("Employee No.", E."No.");
                EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);
                if EA.FindFirst() then begin
                    if E."Hours in Day" = 0 then
                        HoursInDay := StandardFullDayHours
                    else
                        HoursInDay := E."Hours in Day";

                    EA.CalcSums(Quantity);
                    TotalDays := EA.Quantity / HoursInDay;

                    //saznaj zivotnu dob uposlenika za datu godinu
                    if E."Birth Date" <> 0D then begin
                        AgeT := (EndDateToProcess - E."Birth Date") / 365.2425;
                        Age := AgeT DIV 1;
                        //Provjera ako se rodjendan jos nije desio u godini EndDateToProcess varijable
                        if (Date2DMY(E."Birth Date", 2) > Date2DMY(EndDateToProcess, 2)) or
                           ((Date2DMY(E."Birth Date", 2) = Date2DMY(EndDateToProcess, 2)) and
                            (Date2DMY(E."Birth Date", 1) > Date2DMY(EndDateToProcess, 1))) then
                            Age := Age - 1;
                    end else begin
                        Age := 0;
                    end;

                    if (Age >= 18) and (Age <= 30) then begin
                        Age_18_to_30_NoOfAbsentEmployees += 1;
                        Age_18_to_30_TotalNoOfDays += TotalDays;
                    end else
                        if (Age >= 31) and (Age <= 35) then begin
                            Age_31_to_35_NoOfAbsentEmployees += 1;
                            Age_31_to_35_TotalNoOfDays += TotalDays;
                        end else
                            if (Age >= 36) and (Age <= 40) then begin
                                Age_36_to_40_NoOfAbsentEmployees += 1;
                                Age_36_to_40_TotalNoOfDays += TotalDays;
                            end else
                                if (Age >= 41) and (Age <= 45) then begin
                                    Age_41_to_45_NoOfAbsentEmployees += 1;
                                    Age_41_to_45_TotalNoOfDays += TotalDays;
                                end else
                                    if (Age >= 46) and (Age <= 50) then begin
                                        Age_46_to_50_NoOfAbsentEmployees += 1;
                                        Age_46_to_50_TotalNoOfDays += TotalDays;
                                    end else
                                        if (Age >= 51) and (Age <= 55) then begin
                                            Age_51_to_55_NoOfAbsentEmployees += 1;
                                            Age_51_to_55_TotalNoOfDays += TotalDays;
                                        end else
                                            if (Age >= 56) and (Age <= 60) then begin
                                                Age_56_to_60_NoOfAbsentEmployees += 1;
                                                Age_56_to_60_TotalNoOfDays += TotalDays;
                                            end else
                                                if (Age >= 61) and (Age <= 65) then begin
                                                    Age_61_to_65_NoOfAbsentEmployees += 1;
                                                    Age_61_to_65_TotalNoOfDays += TotalDays;
                                                end;
                end;
            until E.Next() = 0;
    end;

    local procedure CalculateTotalsPerQualifications(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        EA: Record "Employee Absence";
        E: Record "Employee";
        AE: Record "Additional Education";
        HoursInDay, StandardFullDayHours : Integer;
    begin
        HoursInDay := 0;
        StandardFullDayHours := 8;
        COA_Codes := '';
        COA_Codes := GetCOACodes();

        VSS_TotalNoOfDays := 0;
        VSHS_TotalNoOfDays := 0;
        SSS_TotalNoOfDays := 0;
        VKV_TotalNoOfDays := 0;
        KV_TotalNoOfDays := 0;
        PK_NK_TotalNoOfDays := 0;

        VSS_NoOfAbsentEmployees := 0;
        VSHS_NoOfAbsentEmployees := 0;
        SSS_NoOfAbsentEmployees := 0;
        VKV_NoOfAbsentEmployees := 0;
        KV_NoOfAbsentEmployees := 0;
        PK_NK_NoOfAbsentEmployees := 0;

        E.Reset();
        if E.FindSet() then
            repeat
                EA.Reset();
                EA.SetFilter("Cause of Absence Code", COA_Codes);
                EA.SetFilter("Employee No.", '%1', E."No.");
                EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);
                if EA.FindFirst() then begin
                    if E."Hours in Day" = 0 then
                        HoursInDay := StandardFullDayHours
                    else
                        HoursInDay := E."Hours in Day";

                    EA.CalcSums(Quantity);
                    TotalDays := EA.Quantity / HoursInDay;

                    AE.Reset();
                    AE.SetFilter("Employee No.", '%1', E."No.");
                    AE.SetFilter(Active, '%1', true);
                    if AE.FindFirst() then begin
                        if (AE."Education Level" = AE."Education Level"::"I stepen NK(nekvalifikovani radnik)") or
                           (AE."Education Level" = AE."Education Level"::"I EQF nivo  NK (nekvalificirani radnik)") or
                           (AE."Education Level" = AE."Education Level"::"II stepen  PKV (polukvalificirani radnik)") or
                           (AE."Education Level" = AE."Education Level"::"II EQF nivo  NKR (niskokvalificirani radnik)") then begin
                            PK_NK_NoOfAbsentEmployees += 1;
                            PK_NK_TotalNoOfDays += TotalDays;
                        end;

                        if (AE."Education Level" = AE."Education Level"::"III stepen  KV (kvalificirani radnik - SSS III stepen)") or
                           (AE."Education Level" = AE."Education Level"::"III EQF nivo  KV (kvalificirani radnik - SSS III stepen)") then begin
                            KV_NoOfAbsentEmployees += 1;
                            KV_TotalNoOfDays += TotalDays;
                        end;

                        if (AE."Education Level" = AE."Education Level"::"IV stepen  SSS (srednja stručna sprema - SSS IV stepen)") or
                           (AE."Education Level" = AE."Education Level"::"IV EQF nivo  SKR (opće ili specijalizirani kvalificirani radnik)") then begin
                            SSS_NoOfAbsentEmployees += 1;
                            SSS_TotalNoOfDays += TotalDays;
                        end;

                        if (AE."Education Level" = AE."Education Level"::"V stepen  VKV (visokokvalificiran radnik)") or
                           (AE."Education Level" = AE."Education Level"::"V EQF nivo  VKV (visokokvalificiran radnik specijaliziran za određeno zanimanje)") then begin
                            VKV_NoOfAbsentEmployees += 1;
                            VKV_TotalNoOfDays += TotalDays;
                        end;

                        if (AE."Education Level" = AE."Education Level"::"VI stepen  VŠS (viša stručna sprema)") or
                           (AE."Education Level" = AE."Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 180 ECTS)") or
                           (AE."Education Level" = AE."Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 240 ECTS)") then begin
                            VSHS_NoOfAbsentEmployees += 1;
                            VSHS_TotalNoOfDays += TotalDays;
                        end;

                        if (AE."Education Level" = AE."Education Level"::"VII./1 stepen  VSS (visoka stručna sprema)") or
                           (AE."Education Level" = AE."Education Level"::"VII./1 stepen  MR.spec (magistar specijalist)") or
                           (AE."Education Level" = AE."Education Level"::"VII EQF nivo  MA (drugi ciklus visokog obrazovanja - 300 ECTS)") or
                           (AE."Education Level" = AE."Education Level"::"VII./2 stepen  MR (magistar nauka)") or
                           (AE."Education Level" = AE."Education Level"::"VIII stepen  DR (doktor nauka)") or
                           (AE."Education Level" = AE."Education Level"::"VIII EQF nivo  DR.sci (treći ciklus visokog obrazovanja - 480 ECTS)") then begin
                            VSS_NoOfAbsentEmployees += 1;
                            VSS_TotalNoOfDays += TotalDays;
                        end;

                    end;
                end;
            until E.Next() = 0;
    end;

    local procedure CalculateTotalsPerDurationOfAbsences(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        EA: Record "Employee Absence";
        E: Record "Employee";
        HoursInDay, StandardFullDayHours : Integer;
        CountOfEmployeeAbsences: Integer;
        TotalDaysForAllEmployees: Decimal;

        Duration_1_to_5_TotalNoOfDays,
        Duration_6_to_10_TotalNoOfDays,
        Duration_11_to_15_TotalNoOfDays,
        Duration_16_to_20_TotalNoOfDays,
        Duration_21_to_25_TotalNoOfDays,
        Duration_26_to_30_TotalNoOfDays,
        Duration_31_to_35_TotalNoOfDays,
        Duration_36_to_41_TotalNoOfDays,
        Duration_42_to_60_TotalNoOfDays,
        Duration_61_to_100_TotalNoOfDays,
        Duration_over_101_TotalNoOfDays : Decimal;
    begin
        HoursInDay := 0;
        StandardFullDayHours := 8;
        COA_Codes := '';
        COA_Codes := GetCOACodes();

        TotalDaysForAllEmployees := 0;

        Duration_1_to_5_TotalNoOfDays := 0;
        Duration_6_to_10_TotalNoOfDays := 0;
        Duration_11_to_15_TotalNoOfDays := 0;
        Duration_16_to_20_TotalNoOfDays := 0;
        Duration_21_to_25_TotalNoOfDays := 0;
        Duration_26_to_30_TotalNoOfDays := 0;
        Duration_31_to_35_TotalNoOfDays := 0;
        Duration_36_to_41_TotalNoOfDays := 0;
        Duration_42_to_60_TotalNoOfDays := 0;
        Duration_61_to_100_TotalNoOfDays := 0;
        Duration_over_101_TotalNoOfDays := 0;

        Duration_1_to_5_NoOfAbsentEmployees := 0;
        Duration_6_to_10_NoOfAbsentEmployees := 0;
        Duration_11_to_15_NoOfAbsentEmployees := 0;
        Duration_16_to_20_NoOfAbsentEmployees := 0;
        Duration_21_to_25_NoOfAbsentEmployees := 0;
        Duration_26_to_30_NoOfAbsentEmployees := 0;
        Duration_31_to_35_NoOfAbsentEmployees := 0;
        Duration_36_to_41_NoOfAbsentEmployees := 0;
        Duration_42_to_60_NoOfAbsentEmployees := 0;
        Duration_61_to_100_NoOfAbsentEmployees := 0;
        Duration_over_101_NoOfAbsentEmployees := 0;

        Average_1_to_5 := 0;
        Average_6_to_10 := 0;
        Average_11_to_15 := 0;
        Average_16_to_20 := 0;
        Average_21_to_25 := 0;
        Average_26_to_30 := 0;
        Average_31_to_35 := 0;
        Average_36_to_41 := 0;
        Average_42_to_60 := 0;
        Average_61_to_100 := 0;
        Average_over_101 := 0;

        E.Reset();
        if E.FindSet() then
            repeat
                TotalDays := 0;
                CountOfEmployeeAbsences := 0;
                EA.Reset();
                EA.SetFilter("Cause of Absence Code", COA_Codes);
                EA.SetFilter("Employee No.", '%1', E."No.");
                EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);

                if E."Hours in Day" = 0 then
                    HoursInDay := StandardFullDayHours
                else
                    HoursInDay := E."Hours in Day";

                CountOfEmployeeAbsences := EA.Count();

                if EA.FindFirst() then begin
                    EA.CalcSums(Quantity);
                    TotalDays := EA.Quantity / HoursInDay;
                end;

                if (CountOfEmployeeAbsences >= 1) and (CountOfEmployeeAbsences <= 5) then begin
                    Duration_1_to_5_NoOfAbsentEmployees += 1;
                    Duration_1_to_5_TotalNoOfDays += TotalDays;
                end else
                    if (CountOfEmployeeAbsences >= 6) and (CountOfEmployeeAbsences <= 10) then begin
                        Duration_6_to_10_NoOfAbsentEmployees += 1;
                        Duration_6_to_10_TotalNoOfDays += TotalDays;
                    end else
                        if (CountOfEmployeeAbsences >= 11) and (CountOfEmployeeAbsences <= 15) then begin
                            Duration_11_to_15_NoOfAbsentEmployees += 1;
                            Duration_11_to_15_TotalNoOfDays += TotalDays;
                        end else
                            if (CountOfEmployeeAbsences >= 16) and (CountOfEmployeeAbsences <= 20) then begin
                                Duration_16_to_20_NoOfAbsentEmployees += 1;
                                Duration_16_to_20_TotalNoOfDays += TotalDays;
                            end else
                                if (CountOfEmployeeAbsences >= 21) and (CountOfEmployeeAbsences <= 25) then begin
                                    Duration_21_to_25_NoOfAbsentEmployees += 1;
                                    Duration_21_to_25_TotalNoOfDays += TotalDays;
                                end else
                                    if (CountOfEmployeeAbsences >= 26) and (CountOfEmployeeAbsences <= 30) then begin
                                        Duration_26_to_30_NoOfAbsentEmployees += 1;
                                        Duration_26_to_30_TotalNoOfDays += TotalDays;
                                    end else
                                        if (CountOfEmployeeAbsences >= 31) and (CountOfEmployeeAbsences <= 35) then begin
                                            Duration_31_to_35_NoOfAbsentEmployees += 1;
                                            Duration_31_to_35_TotalNoOfDays += TotalDays;
                                        end else
                                            if (CountOfEmployeeAbsences >= 36) and (CountOfEmployeeAbsences <= 41) then begin
                                                Duration_36_to_41_NoOfAbsentEmployees += 1;
                                                Duration_36_to_41_TotalNoOfDays += TotalDays;
                                            end else
                                                if (CountOfEmployeeAbsences >= 42) and (CountOfEmployeeAbsences <= 60) then begin
                                                    Duration_42_to_60_NoOfAbsentEmployees += 1;
                                                    Duration_42_to_60_TotalNoOfDays += TotalDays;
                                                end else
                                                    if (CountOfEmployeeAbsences >= 61) and (CountOfEmployeeAbsences <= 100) then begin
                                                        Duration_61_to_100_NoOfAbsentEmployees += 1;
                                                        Duration_61_to_100_TotalNoOfDays += TotalDays;
                                                    end else
                                                        if (CountOfEmployeeAbsences >= 101) then begin
                                                            Duration_over_101_NoOfAbsentEmployees += 1;
                                                            Duration_over_101_TotalNoOfDays += TotalDays;
                                                        end;
            until E.Next() = 0;

        if Duration_1_to_5_NoOfAbsentEmployees <> 0 then
            Average_1_to_5 := Duration_1_to_5_TotalNoOfDays / Duration_1_to_5_NoOfAbsentEmployees
        else
            Average_1_to_5 := 0;

        if Duration_6_to_10_NoOfAbsentEmployees <> 0 then
            Average_6_to_10 := Duration_6_to_10_TotalNoOfDays / Duration_6_to_10_NoOfAbsentEmployees
        else
            Average_6_to_10 := 0;

        if Duration_11_to_15_NoOfAbsentEmployees <> 0 then
            Average_11_to_15 := Duration_11_to_15_TotalNoOfDays / Duration_11_to_15_NoOfAbsentEmployees
        else
            Average_11_to_15 := 0;

        if Duration_16_to_20_NoOfAbsentEmployees <> 0 then
            Average_16_to_20 := Duration_16_to_20_TotalNoOfDays / Duration_16_to_20_NoOfAbsentEmployees
        else
            Average_16_to_20 := 0;

        if Duration_21_to_25_NoOfAbsentEmployees <> 0 then
            Average_21_to_25 := Duration_21_to_25_TotalNoOfDays / Duration_21_to_25_NoOfAbsentEmployees
        else
            Average_21_to_25 := 0;

        if Duration_26_to_30_NoOfAbsentEmployees <> 0 then
            Average_26_to_30 := Duration_26_to_30_TotalNoOfDays / Duration_26_to_30_NoOfAbsentEmployees
        else
            Average_26_to_30 := 0;

        if Duration_31_to_35_NoOfAbsentEmployees <> 0 then
            Average_31_to_35 := Duration_31_to_35_TotalNoOfDays / Duration_31_to_35_NoOfAbsentEmployees
        else
            Average_31_to_35 := 0;

        if Duration_36_to_41_NoOfAbsentEmployees <> 0 then
            Average_36_to_41 := Duration_36_to_41_TotalNoOfDays / Duration_36_to_41_NoOfAbsentEmployees
        else
            Average_36_to_41 := 0;

        if Duration_42_to_60_NoOfAbsentEmployees <> 0 then
            Average_42_to_60 := Duration_42_to_60_TotalNoOfDays / Duration_42_to_60_NoOfAbsentEmployees
        else
            Average_42_to_60 := 0;

        if Duration_61_to_100_NoOfAbsentEmployees <> 0 then
            Average_61_to_100 := Duration_61_to_100_TotalNoOfDays / Duration_61_to_100_NoOfAbsentEmployees
        else
            Average_61_to_100 := 0;

        if Duration_over_101_NoOfAbsentEmployees <> 0 then
            Average_over_101 := Duration_over_101_TotalNoOfDays / Duration_over_101_NoOfAbsentEmployees
        else
            Average_over_101 := 0;

    end;

    local procedure CalculateTotalsAchievedSickLeaveRate(StartDateToProcess: Date; EndDateToProcess: Date)
    //ovaj proc se izvršava za 2 reporta: 
    //Ostvarena stopa bolovanja u Preduzeću, tj. uslov je: Selected = Selected::ostvarenaStopaBolovanja
    //Raspoloživi radni kadar, tj. uslov je: Selected = Selected::raspoloziviRadniKadar
    var
        E: Record "Employee";
        EA: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        HoursInDay, StandardFullDayHours : Integer;
        StartMonthForIteration, EndMonthForIteration, Year : Integer;
        WorkingDaysInMonth: Integer;
        CurrentMonth: Integer;
        CurrentMonthStartInt, CurrentMonthEndInt : Integer;
        CountOfEmployees: Integer;
        NoOfAbsentDays: Decimal;
    begin
        HoursInDay := 0;
        StandardFullDayHours := 8;
        COA_Codes := '';
        COA_Codes := GetCOACodes();

        PeriodLabel := '';
        TotalNumberOfWorkingDaysForAllEmployees := 0;
        TotalNumberOfAbsentDays := 0;
        AchievedSickLeaveRate := 0;
        WorkingDaysInMonth := 0;
        NoOfAbsentDays := 0;

        //oformi Period label:
        StartMonthForIteration := Date2DMY(StartDateToProcess, 2);
        EndMonthForIteration := Date2DMY(EndDateToProcess, 2);
        Year := Date2DMY(StartDateToProcess, 3);
        PeriodLabel := ConvertMonthToRoman(StartMonthForIteration) + ' - ' + ConvertMonthToRoman(EndMonthForIteration) + ' ' + Format(Year) + '. godina';

        if ProcessingYear = StartYear then
            CurrentMonthStartInt := StartMonthForIteration
        else
            CurrentMonthStartInt := 1;

        if ProcessingYear = EndYear then
            CurrentMonthEndInt := EndMonthForIteration
        else
            CurrentMonthEndInt := 12;

        // Idi kroz svaki mjesec u trenutnoj godini i saznaj ukupan broj radnih dana za te mjesece:
        for CurrentMonth := CurrentMonthStartInt to CurrentMonthEndInt do begin
            WageSetup.Get;
            WorkingDaysInMonth += AbsenceFill.GetHourPool(CurrentMonth, ProcessingYear, WageSetup."Hours in Day");
        end;

        E.Reset();
        if E.FindSet() then
            repeat
                TotalDays := 0;
                EA.Reset();
                EA.SetFilter("Cause of Absence Code", COA_Codes);
                EA.SetFilter("Employee No.", '%1', E."No.");
                EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);

                if E."Hours in Day" = 0 then
                    HoursInDay := StandardFullDayHours
                else
                    HoursInDay := E."Hours in Day";

                if EA.FindFirst() then begin
                    EA.CalcSums(Quantity);
                    TotalDays := EA.Quantity / HoursInDay;
                end;
                NoOfAbsentDays += TotalDays;
            until E.Next() = 0;
        CountOfEmployees := E.Count;
        TotalNumberOfWorkingDaysForAllEmployees := WorkingDaysInMonth * CountOfEmployees;
        TotalNumberOfAbsentDays := NoOfAbsentDays;
        AchievedTotalNumberOfWorkingDays := TotalNumberOfWorkingDaysForAllEmployees - TotalNumberOfAbsentDays; //Za raspolozivi radni kadar izvj.
        if TotalNumberOfWorkingDaysForAllEmployees <> 0 then begin
            AchievedSickLeaveRate := TotalNumberOfAbsentDays / TotalNumberOfWorkingDaysForAllEmployees * 100;
            PercentageOfAvailableStaff := AchievedTotalNumberOfWorkingDays / TotalNumberOfWorkingDaysForAllEmployees * 100; //Za raspolozivi radni kadar izvj.
        end else begin
            AchievedSickLeaveRate := 0;
            PercentageOfAvailableStaff := 0;
        end;
    end;

    local procedure CalculateTotalsQualificationStructureOfPersonnel(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        E: Record "Employee";
        ECL: Record "Employee Contract Ledger";
    begin
        VSS_MR_DR_NoOfEmployees := 0;
        VSHS_NoOfEmployees := 0;
        VKV_NoOfEmployees := 0;
        SSS_NoOfEmployees := 0;
        KV_NoOfEmployees := 0;
        PK_i_NK_NoOfEmployees := 0;

        E.Reset();
        if E.FindSet() then
            repeat
                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', E."No.");
                ECL.SetFilter("Org. Structure", CurrentORGSchema);
                ECL.SetFilter(Sector, Departments."Sector Code"); //nisam siguran jel polje SEctor ili SEctor Code? na dept tabeli
                ECL.SetFilter("Starting Date", '<=%1', ToDateFilter); //važeća stavka ugovora
                ECL.SetCurrentKey("Starting Date");
                ECL.Ascending := true;
                if ECL.FindLast() then begin
                    if (ECL."Employee Education Level" = ECL."Employee Education Level"::"I stepen NK(nekvalifikovani radnik)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"I EQF nivo  NK (nekvalificirani radnik)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"II stepen  PKV (polukvalificirani radnik)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"II EQF nivo  NKR (niskokvalificirani radnik)") then begin
                        PK_i_NK_NoOfEmployees += 1;
                    end;

                    if (ECL."Employee Education Level" = ECL."Employee Education Level"::"III stepen  KV (kvalificirani radnik - SSS III stepen)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"III EQF nivo  KV (kvalificirani radnik - SSS III stepen)") then begin
                        KV_NoOfEmployees += 1;
                    end;

                    if (ECL."Employee Education Level" = ECL."Employee Education Level"::"IV stepen  SSS (srednja stručna sprema - SSS IV stepen)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"IV EQF nivo  SKR (opće ili specijalizirani kvalificirani radnik)") then begin
                        SSS_NoOfEmployees += 1;
                    end;

                    if (ECL."Employee Education Level" = ECL."Employee Education Level"::"V stepen  VKV (visokokvalificiran radnik)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"V EQF nivo  VKV (visokokvalificiran radnik specijaliziran za određeno zanimanje)") then begin
                        VKV_NoOfEmployees += 1;
                    end;

                    if (ECL."Employee Education Level" = ECL."Employee Education Level"::"VI stepen  VŠS (viša stručna sprema)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 180 ECTS)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 240 ECTS)") then begin
                        VSHS_NoOfEmployees += 1;
                    end;

                    if (ECL."Employee Education Level" = ECL."Employee Education Level"::"VII./1 stepen  VSS (visoka stručna sprema)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"VII./1 stepen  MR.spec (magistar specijalist)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"VII EQF nivo  MA (drugi ciklus visokog obrazovanja - 300 ECTS)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"VII./2 stepen  MR (magistar nauka)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"VIII stepen  DR (doktor nauka)") or
                       (ECL."Employee Education Level" = ECL."Employee Education Level"::"VIII EQF nivo  DR.sci (treći ciklus visokog obrazovanja - 480 ECTS)") then begin
                        VSS_MR_DR_NoOfEmployees += 1;
                    end;
                end;
            until E.Next() = 0;
    end;

    local procedure OverviewIncreaseDecreaseNumberOfWorkers(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        E: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        ECL_Current_DepartmentCode, ECL_Previous_DepartmentCode : Code[20];
        YearOfCurrentContract: Integer;
    begin
        Recruited := 0;
        Departed := 0;
        Reassigned := 0;
        DifferenceIncreaseDecrease := 0;

        E.Reset();
        if E.FindSet() then
            repeat
                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', E."No.");
                ECL.SetFilter("Org. Structure", CurrentORGSchema);

                //Ako je odabrana VrstaOJ, (npr. Uprava Sektor), tada filtriraj ovako
                if DepartmentTypeFilter <> '' then begin
                    ECL.SetFilter("Sector", Departments.code);
                end else begin
                    ECL.SetFilter("Department Code", Departments.Code);
                end;

                ECL.SetFilter("Starting Date", '<=%1', ToDateFilter); //važeća stavka ugovora
                ECL.SetCurrentKey("Starting Date");
                ECL.Ascending := true;
                if ECL.FindLast() then begin
                    if (ECl."Reason for Change" = ECL."Reason for Change"::"New Contract") then
                        Recruited += 1;
                    if (ECL."Grounds for Term. Description" <> '') then
                        Departed += 1;

                    //saznaj ako ima prethodni ugovor
                    ECL_Current_DepartmentCode := ECL."Department Code";
                    YearOfCurrentContract := Date2DMY(ECL."Starting Date", 3);

                    ECL.SetFilter("Starting Date", '<%1&>=%2', ECL."Starting Date", DMY2DATE(1, 1, YearOfCurrentContract));
                    //ECL.SetFilter("Employee No.", '%1', E."No.");
                    //ECL.SetFilter("Org. Structure", CurrentORGSchema);
                    ECL.SetCurrentKey("Starting Date");
                    ECL.Ascending := false;       //potrebno da bi uslo u prethodni redak
                    if ECL.Next(-1) > 0 then begin  //nadji prethodni red
                        ECL_Previous_DepartmentCode := ECL."Department Code";
                        if ECL_Previous_DepartmentCode <> ECL_Current_DepartmentCode then
                            Reassigned += 1;
                    end;

                end;
            until E.Next() = 0;

        DifferenceIncreaseDecrease := Recruited - Departed;
    end;

    local procedure CalculateTotalsAchievedHoursOfAbsenceFromWorkAndBenefits(StartDateToProcess: Date; EndDateToProcess: Date; COACodes_Filter: Text; BasisOfAbsence: Enum "Basis of Absence"; ProcessingYear: Integer)
    var
        WVE: Record "Wage Value Entry";
        EA: Record "Employee Absence";
        EAQuantity: Decimal;
        WVEValue: Decimal;
    begin
        CurrentPeriodStartMonthText := Format(StartDateToProcess, 0, '<Month Text>');
        CurrentPeriodEndMonthText := Format(EndDateToProcess, 0, '<Month Text>');

        EAQuantity := 0;
        WVEValue := 0;
        NumberOfRealizedHours := 0;
        RealizedValueKM := 0;

        TempGLE."Entry No." := TempGLE."Entry No." + 1;
        TempGLE."Document No." := Format(ProcessingYear); //ovo je da zadovolji KEY requirement
        TempGLE.Description := Format(TempGLE."Entry No." + 2); // i ovo je za KEY

        TempGLE.Year := ProcessingYear;
        TempGLE."Basis of Absence" := BasisOfAbsence;

        EA.Reset();
        EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);
        EA.SetFilter("Cause of Absence Code", COACodes_Filter);
        if EA.FindFirst() then begin
            EA.CalcSums(Quantity);
            EAQuantity := EA.Quantity;
            NumberOfRealizedHours += EAQuantity;
            TempGLE.NumberOfRealizedHours := NumberOfRealizedHours;
        end;

        WVE.Reset();
        WVE.SetRange("Document Date", StartDateToProcess, EndDateToProcess);
        WVE.SetFilter(Description, COACodes_Filter);
        if WVE.FindFirst() then begin
            WVE.CalcSums("Cost Amount (Actual)");
            WVEValue := WVE."Cost Amount (Actual)";
            RealizedValueKM += WVEValue;
            TempGLE.RealizedValueKM := RealizedValueKM;
        end;


        TempGLE.Insert();

        if ProcessingYearIterationCounter >= 2 then begin
            TempGLE.Reset();
            TempGLE.SetRange(Year, ProcessingYear - 1);
            TempGLE.SetRange("Basis of Absence", BasisOfAbsence);
            if TempGLE.FindFirst() then begin
                if TempGLE.NumberOfRealizedHours <> 0 then
                    NumberOfRealizedHours_Index := NumberOfRealizedHours / TempGLE.NumberOfRealizedHours * 100
                else
                    NumberOfRealizedHours_Index := 0;
                if TempGLE.RealizedValueKM <> 0 then
                    RealizedValueKM_Index := RealizedValueKM / TempGLE.RealizedValueKM * 100
                else
                    RealizedValueKM_Index := 0;
            end;
        end;

        TotalEAQuantity += NumberOfRealizedHours;
        TotalWVEValue += RealizedValueKM;

        //TODO:
        //Ovaj dio bi trebao da izračuna total za prethodnu godinu
        //Nakon toga, u RDL bih trebao izračunati TotalTrenutni/TotalPrethodni * 100
        //Međutim, ovaj dio mi ne daje tačne podatke i potrebno je ovo pregledati. 
        if ProcessingYearIterationCounter >= 2 then begin
            TempGLE.Reset();
            TempGLE.SetRange(Year, ProcessingYear - 1);
            TempGLE.SetRange("Basis of Absence", BasisOfAbsence);
            if TempGLE.FindSet() then
                repeat
                    TotalEAQuantity_Index += TempGLE.NumberOfRealizedHours;
                    TotalWVEValue_Index += TempGLE.RealizedValueKM;
                until TempGLE.Next() = 0;
        end;
    end;

    local procedure CalculateTotalsOverviewOfNumberOfAbsentWorkers(StartDateToProcess: Date; EndDateToProcess: Date)
    var
        ORGShema: Record "ORG Shema";
        E: Record "Employee";
        EA: Record "Employee Absence";
        ECL: Record "Employee Contract Ledger";
        COA: Record "Cause of Absence";
        EmployeeCountLocal: Integer;
        CurrentORGSchemaLocal: Code[20];
        CountOfAbsentEmployeesLocal: Integer;
        StartMonthForIteration, EndMonthForIteration, Year : Integer;
    begin
        EmployeeCountLocal := 0;
        CountOfAbsentEmployeesLocal := 0;
        COA_Codes := '';
        COA_Codes := GetCOACodes();
        //oformi Period label:
        PeriodLabel := '';
        StartMonthForIteration := Date2DMY(StartDateToProcess, 2);
        EndMonthForIteration := Date2DMY(EndDateToProcess, 2);
        Year := Date2DMY(StartDateToProcess, 3);
        PeriodLabel := ConvertMonthToRoman(StartMonthForIteration) + ' - ' + ConvertMonthToRoman(EndMonthForIteration) + ' ' + Format(Year) + '. godina';

        //Saznaj važeću ORG Shemu za period:
        ORGShema.SetFilter("Date From", '<=%1', EndDateToProcess);
        ORGShema.SetCurrentKey("Date From");
        ORGShema.Ascending := true;
        if ORGShema.FindLast() then begin
            CurrentORGSchemaLocal := ORGShema.Code;
        end;

        E.Reset();
        if E.FindSet() then
            repeat
                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', E."No.");
                ECL.SetFilter("Org. Structure", CurrentORGSchemaLocal);
                ECL.SetFilter("Starting Date", '<=%1', EndDateToProcess); //važeća stavka ugovora
                ECL.SetCurrentKey("Starting Date");
                ECL.Ascending := true;

                if ECL.FindLast() then begin
                    EmployeeCountLocal += 1;

                    EA.Reset();
                    EA.SetFilter("Cause of Absence Code", COA_Codes);
                    EA.SetRange("From Date", StartDateToProcess, EndDateToProcess);
                    EA.SetRange("Employee No.", E."No.");
                    if EA.FindFirst() then begin
                        CountOfAbsentEmployeesLocal += 1;
                    end;
                end;
            until E.Next() = 0;

        CountOfEmployees := EmployeeCountLocal;
        CountOfAbsentEmployees := CountOfAbsentEmployeesLocal;
        if CountOfEmployees <> 0 then
            PercentageOfAbsentEmployees := CountOfAbsentEmployees / CountOfEmployees * 100
        else
            PercentageOfAbsentEmployees := 0;
    end;

    procedure GetCOACodes() ResultCOACodes: Text
    var
        COA: Record "Cause of Absence";
    begin
        ResultCOACodes := '';
        COA.Reset();
        COA.SetFilter("Sick Leave Paid By Company", '%1', true);
        if COA.FindSet() then
            repeat
                ResultCOACodes += COA.Code + '|';
            until COA.Next() = 0;

        if StrLen(ResultCOACodes) > 0 then
            ResultCOACodes := DelStr(ResultCOACodes, StrLen(ResultCOACodes), 1);
    end;

    procedure GetCOACodesForBasisOfAbsence(BasisOfAbsenceValue: Enum "Basis of Absence"): Text
    var
        COA: Record "Cause of Absence";
        ResultCOACodes: Text;
    begin
        ResultCOACodes := '';
        COA.Reset();
        COA.SetRange("Basis of Absence", BasisOfAbsenceValue);
        if COA.FindSet() then
            repeat
                ResultCOACodes += COA.Code + '|';
            until COA.Next() = 0;

        if StrLen(ResultCOACodes) > 0 then
            ResultCOACodes := DelStr(ResultCOACodes, StrLen(ResultCOACodes), 1);

        exit(ResultCOACodes);
    end;

    procedure ConvertMonthToRoman(month: Integer) Result: Text
    begin
        case month of
            1:
                exit('I');
            2:
                exit('II');
            3:
                exit('III');
            4:
                exit('IV');
            5:
                exit('V');
            6:
                exit('VI');
            7:
                exit('VII');
            8:
                exit('VIII');
            9:
                exit('IX');
            10:
                exit('X');
            11:
                exit('XI');
            12:
                exit('XII');
            else
                Error('Invalid month');
        end;
    end;

    var
        YearStartDate, YearEndDate : Date; //za pravilno određivanje perioda za procesiranje
        TotalDaysZene, TotalDaysMuskarci, TotalDays : Decimal;
        SpolMuskarac, SpolZena : Enum "Employee Gender";
        CountZene, CountMuskarci, CountTotal : Integer;
        PercentageZene, PercentageMuskarci : Decimal;
        DaysPercentageZene, DaysPercentageMuskarci : Decimal;
        FromDateFilter, ToDateFilter : Date; // filteri
        StartDay, StartMonth, StartYear, EndDay, EndMonth, EndYear, CurrentYear, ProcessingYear : Integer;

        //labels for error messages:
        ErrorLbl1: Label 'The "From Date" cannot be after the "To Date".';
        ErrorLbl2: Label 'The "To Date" cannot be before the "From Date".';
        ErrorLbl3: Label 'The "From Date" is mandatory';
        ErrorLbl4: Label 'The selected period cannot be greater than one year';

        //Select a report
        Selected: Option " ","poSpolu","poOrgJed","poDuziniRadnogStaza","poZivotnojDobi","poStrucnojSpremi","poTrajanjuIzostanaka","ostvarenaStopaBolovanja","raspoloziviRadniKadar","kvalifikacionaStrukturaKadrova","povecanjeSmanjenjeBrojaRadnika","ostvareniSatiOdsustvaSaRadaINaknada","brojRadnikaKojiSuImaliIzostanke";

        TotalWorkingDays: Integer;
        RowCounter: Integer;
        EmployeeCount: Integer;
        TotalNoWorkingDaysAllEmployees: Integer;
        TotalDaysAllEmployees: Decimal;
        RealizedPercentageOfAbsences: Decimal;
        PercentageOfWorkersAvailability: Decimal;
        AverageNumberOfWorkersAtWork: Decimal;
        NumberOfWorkersWhoDidntWorkEntireYear: Decimal;

        //per length of work experience:
        COA_Codes: Text[256]; //string koji ce sadrzati kodove bolovanja
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        WorkExp_1_5_NoOfAbsentEmployees,
        WorkExp_6_10_NoOfAbsentEmployees,
        WorkExp_11_15_NoOfAbsentEmployees,
        WorkExp_16_20_NoOfAbsentEmployees,
        WorkExp_21_25_NoOfAbsentEmployees,
        WorkExp_26_30_NoOfAbsentEmployees,
        WorkExp_31_35_NoOfAbsentEmployees,
        WorkExp_36_40_NoOfAbsentEmployees,
        WorkExp_over_40_NoOfAbsentEmployees : Integer;

        //per Age
        WorkExp_1_5_TotalNoOfDays,
        WorkExp_6_10_TotalNoOfDays,
        WorkExp_11_15_TotalNoOfDays,
        WorkExp_16_20_TotalNoOfDays,
        WorkExp_21_25_TotalNoOfDays,
        WorkExp_26_30_TotalNoOfDays,
        WorkExp_31_35_TotalNoOfDays,
        WorkExp_36_40_TotalNoOfDays,
        WorkExp_over_40_TotalNoOfDays : Decimal;

        //per Age
        Age_18_to_30_TotalNoOfDays,
        Age_31_to_35_TotalNoOfDays,
        Age_36_to_40_TotalNoOfDays,
        Age_41_to_45_TotalNoOfDays,
        Age_46_to_50_TotalNoOfDays,
        Age_51_to_55_TotalNoOfDays,
        Age_56_to_60_TotalNoOfDays,
        Age_61_to_65_TotalNoOfDays : Decimal;

        Age_18_to_30_NoOfAbsentEmployees,
        Age_31_to_35_NoOfAbsentEmployees,
        Age_36_to_40_NoOfAbsentEmployees,
        Age_41_to_45_NoOfAbsentEmployees,
        Age_46_to_50_NoOfAbsentEmployees,
        Age_51_to_55_NoOfAbsentEmployees,
        Age_56_to_60_NoOfAbsentEmployees,
        Age_61_to_65_NoOfAbsentEmployees : Integer;

        //per Qualifications
        VSS_TotalNoOfDays,
        VSHS_TotalNoOfDays,
        SSS_TotalNoOfDays,
        VKV_TotalNoOfDays,
        KV_TotalNoOfDays,
        PK_NK_TotalNoOfDays : Decimal;

        VSS_NoOfAbsentEmployees,
        VSHS_NoOfAbsentEmployees,
        SSS_NoOfAbsentEmployees,
        VKV_NoOfAbsentEmployees,
        KV_NoOfAbsentEmployees,
        PK_NK_NoOfAbsentEmployees : Integer;

        //per duration of absences
        Average_1_to_5,
        Average_6_to_10,
        Average_11_to_15,
        Average_16_to_20,
        Average_21_to_25,
        Average_26_to_30,
        Average_31_to_35,
        Average_36_to_41,
        Average_42_to_60,
        Average_61_to_100,
        Average_over_101 : Decimal;

        Duration_1_to_5_NoOfAbsentEmployees,
        Duration_6_to_10_NoOfAbsentEmployees,
        Duration_11_to_15_NoOfAbsentEmployees,
        Duration_16_to_20_NoOfAbsentEmployees,
        Duration_21_to_25_NoOfAbsentEmployees,
        Duration_26_to_30_NoOfAbsentEmployees,
        Duration_31_to_35_NoOfAbsentEmployees,
        Duration_36_to_41_NoOfAbsentEmployees,
        Duration_42_to_60_NoOfAbsentEmployees,
        Duration_61_to_100_NoOfAbsentEmployees,
        Duration_over_101_NoOfAbsentEmployees : Integer;

        //Per achieved sick leave rate + Available Staff report
        AbsenceFill: Codeunit "Absence Fill";
        PeriodLabel: Text;
        TotalNumberOfWorkingDaysForAllEmployees: Integer;
        TotalNumberOfAbsentDays: Decimal;
        AchievedSickLeaveRate: Decimal;
        AchievedTotalNumberOfWorkingDays: Decimal;
        PercentageOfAvailableStaff: Decimal;

        //Qualification structure of personnel
        VSS_MR_DR_NoOfEmployees,
        VSHS_NoOfEmployees,
        VKV_NoOfEmployees,
        SSS_NoOfEmployees,
        KV_NoOfEmployees,
        PK_i_NK_NoOfEmployees : Integer;
        CurrentORGSchema: Code[20];
        TextTitle: Text;
        TotalRecords: Integer;

        //Increase/decrease in number of workers
        DeptFilters: Text[250];
        DepartmentTypeFilter: Text[100];
        Recruited,
        Departed,
        Reassigned,
        DifferenceIncreaseDecrease : Integer; //koloneu izvještaju: Primljeno; Napustilo preduzeće; Preraspoređeno

        //Achieved hours of absence from work and benefits - Ostvareni sati odsustva sa rada i naknada
        CurrentPeriodStartMonthText,
        CurrentPeriodEndMonthText : Text; //za prikaz mjeseca slovima na izvj Ostvareni sati odsustva sa rada i naknada po tom osnovu
        ProcessingYearIterationCounter,
        ProcessingYearIterationCounterCol1,
        ProcessingYearIterationCounterCol2,
        ProcessingYearIterationCounterCol3 : Integer;
        PreviousYear: Integer;
        //za prethodne vrijednosti 
        NumberOfRealizedHours_Index,
        RealizedValueKM_Index,
        TotalEAQuantity_Index,
        TotalWVEValue_Index : Decimal;
        //NOVO i krace:
        NumberOfRealizedHours: Integer;
        RealizedValueKM: Decimal;
        COA_RowCounter: Integer;

        TotalEAQuantity: Decimal;
        TotalWVEValue: Decimal;
        BasisOfAbsenceCOACodes: Text;
        ProcessedBasisOfAbsenceList: List of [Enum "Basis of Absence"];
        TempGLE: Record "TempGLE" temporary;
        CountOfEmployees: Integer;
        CountOfAbsentEmployees: Integer;
        PercentageOfAbsentEmployees: Decimal;
}