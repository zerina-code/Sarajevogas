report 50005 "Pregled Bolovanja"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Pregled Bolovanja';
    RDLCLayout = './Pregled Bolovanja.rdl';
    PreviewMode = Normal;

    dataset
    {
        dataitem(Brojevi; "Integer")
        {
            column(Godine; Godine)
            {

            }

            column(Column_No; Column_No)
            {

            }

            column(Second_Column_No; Second_Column_No)
            {

            }

            dataitem(Employee_Absence; "Employee Absence")
            {
                column(Employee_No; "Employee No.")
                {

                }

                column(First_Name; First_Name)
                {

                }

                column(Last_Name; Last_Name)
                {

                }

                column(Department_Code; Department_Code)
                {

                }

                column(EmployeeOrder; EmployeeOrder)
                {

                }

                column(EmployeeExperience; EmployeeExperience)
                {

                }

                column(EmployeeAge; EmployeeAge)
                {

                }

                column(EmployeeGender; EmployeeGender)
                {

                }

                column(Sprema; Sprema)
                {

                }

                column(RedniBroj; RedniBroj)
                {

                }

                column(Sati; Sati)
                {

                }

                column(Dani; Dani)
                {

                }

                column(TotalDani; TotalDani)
                {

                }

                column(TotalSati; TotalSati)
                {

                }

                trigger OnPreDataItem()
                begin
                    RedniBroj := 0;
                    SifreBolovanja := GetCOACodes();
                    Employee_Absence.SetFilter("From Date", '>=%1', FromDate);
                    Employee_Absence.SetFilter("To Date", '<=%1', ToDate);
                    Employee_Absence.SetFilter("Cause of Absence Code", SifreBolovanja);
                    PreviousEmployeeNo := '';
                end;

                trigger OnAfterGetRecord();
                begin

                    if Employee_Absence."Employee No." <> PreviousEmployeeNo then begin
                        RedniBroj += 1;
                    end;
                    PreviousEmployeeNo := Employee_Absence."Employee No.";

                    EmpAbs.Reset();
                    EmpAbs.SetFilter("From Date", '>=%1', FromDate);
                    EmpAbs.SetFilter("To Date", '<=%1', ToDate);
                    EmpAbs.SetFilter("Employee No.", '%1', "Employee No.");
                    EmpAbs.SetFilter("Cause of Absence Code", SifreBolovanja);
                    if EmpAbs.FindSet() then begin
                        EmpAbs.CalcSums(Quantity);
                        TotalSati := EmpAbs.Quantity;

                        TotalDani := TotalSati / 8;
                    end;

                    EmpAbs.Reset();
                    EmpAbs.SetFilter("From Date", '>=%1', YearStartDate);
                    EmpAbs.SetFilter("To Date", '<=%1', YearEndDate);
                    EmpAbs.SetFilter("Employee No.", '%1', "Employee No.");
                    EmpAbs.SetFilter("Cause of Absence Code", SifreBolovanja);
                    if EmpAbs.FindFirst() then begin
                        EmpAbs.CalcSums(Quantity);
                        Sati := EmpAbs.Quantity;
                        Dani := Sati / 8;
                    end
                    else begin
                        Sati := 0;
                        Dani := 0;
                    end;

                    EmployeeRecord.Reset();
                    EmployeeRecord.SetFilter("No.", '%1', Employee_Absence."Employee No.");

                    if EmployeeRecord.FindFirst() then begin
                        First_Name := EmployeeRecord."First Name";
                        Last_Name := EmployeeRecord."Last Name";
                        EmployeeOrder := EmployeeRecord.Order;
                        EmployeeExperience := EmployeeRecord."Years of Experience";
                        EmployeeAge := EmployeeRecord.Age;
                        if (EmployeeRecord.Gender = EmployeeRecord.Gender::Male) then begin
                            EmployeeGender := 'M'
                        end
                        else
                            if (EmployeeRecord.Gender = EmployeeRecord.Gender::Female) then begin
                                EmployeeGender := 'Ž'
                            end
                            else begin
                                EmployeeGender := ''
                            end;

                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"I stepen NK(nekvalifikovani radnik)") OR
                                               (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"I EQF nivo  NK (nekvalificirani radnik)") then begin
                            Sprema := 'NK';
                        end;
                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"II stepen  PKV (polukvalificirani radnik)") OR
                        (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"II EQF nivo  NKR (niskokvalificirani radnik)") then begin
                            Sprema := 'PK';
                        end;

                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"III stepen  KV (kvalificirani radnik - SSS III stepen)") OR
                           (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"III EQF nivo  KV (kvalificirani radnik - SSS III stepen)") then begin
                            Sprema := 'KV';
                        end;
                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"IV stepen  SSS (srednja stručna sprema - SSS IV stepen)") or
                        (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"IV EQF nivo  SKR (opće ili specijalizirani kvalificirani radnik)") then begin
                            Sprema := 'SSS';
                        end;

                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"V stepen  VKV (visokokvalificiran radnik)") or
                           (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"V EQF nivo  VKV (visokokvalificiran radnik specijaliziran za određeno zanimanje)") then begin
                            Sprema := 'VKV';
                        end;
                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VI stepen  VŠS (viša stručna sprema)") or
                        (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 180 ECTS)") or
                           (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VI EQF nivo  BA (prvi ciklus visokog obrazovanja - 240 ECTS)") then begin
                            Sprema := 'VŠS';
                        end;
                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VII./1 stepen  VSS (visoka stručna sprema)") or
                        (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VII./1 stepen  MR.spec (magistar specijalist)") or
                           (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VII./2 stepen  MR (magistar nauka)") or
                           (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VII EQF nivo  MA (drugi ciklus visokog obrazovanja - 300 ECTS)") or
                           (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VIII stepen  DR (doktor nauka)") or
                           (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::"VIII EQF nivo  DR.sci (treći ciklus visokog obrazovanja - 480 ECTS)") then begin
                            Sprema := 'VSS';
                        end;

                        if (EmployeeRecord."Education Level" = EmployeeRecord."Education Level"::Empty) then begin
                            Sprema := '';
                        end;

                    end
                    else begin
                        First_Name := '';
                        Last_Name := '';
                        EmployeeOrder := 0;
                        EmployeeExperience := 0;
                        EmployeeAge := 0;
                    end;

                    EmpConLedg.Reset();
                    if NOT (FromDate = 0D) OR NOT (ToDate = 0D) then begin
                        EmpConLedg.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                        EmpConLedg.SetFilter("Starting Date", '<=%1', ToDate);
                        EmpConLedg.SetFilter("Ending Date", '>=%1 |%2', FromDate, 0D);
                        EmpConLedg.SetCurrentKey("Starting Date");
                        EmpConLedg.Ascending(False);
                        if EmpConLedg.FindFirst() then begin
                            Department_Code := EmpConLedg."Department Code";
                        end
                        else begin
                            Department_Code := '';
                        end
                    end
                    else begin
                        EmpConLedg.SetFilter("Employee No.", '%1', Employee_Absence."Employee No.");
                        EmpConLedg.SetFilter("Starting Date", '<%1', Today());
                        EmpConLedg.SetCurrentKey("Starting Date");
                        EmpConLedg.Ascending(False);
                        if EmpConLedg.FindFirst() then begin
                            Department_Code := EmpConLedg."Department Code";
                        end
                        else
                            Department_Code := '';
                    end;

                end;
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Column_No := 6;
                Second_Column_No := 7;
                PreviousYear := 0;
                myInt := EndYear - StartYear + 1;
                SetFilter(Number, '%1..%2', 1, myInt);
                CurrentYear := StartYear;
            end;

            trigger OnAfterGetRecord()
            begin
                Godine := CurrentYear;

                YearStartDate := DMY2DATE(1, 1, Godine);
                YearEndDate := DMY2DATE(31, 12, Godine);

                if Godine = StartYear then
                    YearStartDate := DMY2DATE(StartDay, StartMonth, Godine);

                if Godine = EndYear then
                    YearEndDate := DMY2DATE(EndDay, EndMonth, Godine);

                if CurrentYear < EndYear then begin
                    CurrentYear += 1;
                end;

                if Godine <> PreviousYear then begin
                    Column_No += 2;
                    Second_Column_No += 2;
                end;
                PreviousYear := Godine;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Odaberi datume")
                {
                    field("FromDate"; FromDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Od datuma';
                        ToolTip = 'Enter the start date.';
                        NotBlank = true;

                        trigger OnValidate()
                        begin
                            if (ToDate <> 0D) AND (FromDate <> 0D) then begin
                                if FromDate > ToDate then
                                    Error('Datum početka ne može biti veći od datuma završetka');

                            end;
                        end;
                    }

                    field("ToDate"; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Do datuma';
                        ToolTip = 'Enter the end date. (not mandatory)';

                        trigger OnValidate()
                        begin
                            if (ToDate <> 0D) AND (FromDate <> 0D) then begin
                                if ToDate < FromDate then
                                    Error('Datum završetka ne može biti manji od datuma početka');
                            end;
                            StartYear := Date2DMY(FromDate, 3);
                            EndYear := Date2DMY(ToDate, 3);

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
            FromDate := DMY2DATE(1, 1, ThisYear - 2);
            ToDate := DMY2DATE(31, 12, ThisYear);
        end;
    }

    trigger OnPreReport()
    begin
        if FromDate = 0D then begin
            Error('Od datuma je obavezno');
        end else begin
            StartDay := Date2DMY(FromDate, 1);
            StartMonth := Date2DMY(FromDate, 2);
            StartYear := Date2DMY(FromDate, 3);
        end;

        if ToDate = 0D then begin
            EndDay := StartDay;
            EndMonth := StartMonth;
            EndYear := StartYear
        end else begin
            EndDay := Date2DMY(ToDate, 1);
            EndMonth := Date2DMY(ToDate, 2);
            EndYear := Date2DMY(ToDate, 3);
        end;
        RedniBroj := 0;
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

    var
        EmployeeRecord: Record Employee;
        EmpConLedg: Record "Employee Contract Ledger";
        EmpAbs: Record "Employee Absence";
        First_Name: Text[100];
        Last_Name: Text[100];
        Department_Code: Text;
        EmployeeOrder: Integer;
        EmployeeExperience: Integer;
        EmployeeAge: Integer;
        EmployeeGender: Text;
        Sprema: Text;
        Godine: Integer;
        RedniBroj: Integer;
        FromDate: Date;
        ToDate: Date;
        StartYear: Integer;
        EndYear: Integer;
        StartDay: Integer;
        StartMonth: Integer;
        EndDay: Integer;
        EndMonth: Integer;
        CurrentYear: Integer;
        YearStartDate: Date;
        YearEndDate: Date;
        SifreBolovanja: Text[256];
        TotalDani: Decimal;
        Sati: Decimal;
        Dani: Decimal;
        TotalSati: Decimal;
        PreviousEmployeeNo: Code[10];
        Column_No: Integer;
        PreviousYear: Integer;
        Second_Column_No: Integer;
}