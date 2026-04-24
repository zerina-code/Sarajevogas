report 50016 VacationDecision
{
    Caption = 'Rješenje GO';
    DefaultLayout = RDLC;
    RDLCLayout = './VacatonDecision.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    EnableExternalAssemblies = true;
    PreviewMode = PrintLayout;


    dataset
    {

        dataitem(DataItem5; "Vacation Ground 2")
        {
            RequestFilterFields = "Date of report", "Employee No.";

            column(FirstName; "First Name")
            {

            }
            column(Employee_No_; "Employee No.")
            {

            }



            column(WorkEXpDays; "Days based on Work experience")
            {

            }
            column(FirstPart; FirstPart)
            {

            }

            column(LastName; "Last Name")
            {

            }

            column(Year1; Year1)
            {
            }
            column(BrojDokumenta; BrojDokumenta)
            {
            }
            column(ShortYear; ShortYear) { }
            column(DatumRjesenjaT; DatumRjesenjaT)
            {
            }
            column(Date_of_report; "Date of report")
            {

            }
            column(Company_logo; CompanyInformation.Picture)
            {
            }
            column(YearofVac; "Year")
            {

            }
            column(Disability; "Days based on Disability")
            {
            }
            column(Millitary; "Days based on Military service")
            {

            }
            column(MotherWithMoreCH; MotherWithMoreCH)
            {

            }
            column(SingleParent; SingleParent)
            {

            }
            column(SpecialCircumstances; SpecialCircumstances)
            {

            }
            column(Total_days; "Total days")
            {

            }
            column(Legal_Grounds; "Legal Grounds")
            {

            }
            column(StartFirstpart; format("Starting Date of I part", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(EndFirstpart; format("Ending Date of I part", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(Start2part; format("Starting Date of II part", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(End2part; format("Ending Date of II part", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(Position; "Position Name")
            {
            }
            column(Sector; Sector)
            {

            }
            column(BrojDanaPrviDio; BrojDanaPrviDio)
            {

            }
            column(DanJavljanjanaposao; DanJavljanjanaposao)
            {

            }
            column(DrugiDioDana; DrugiDioDana)
            {

            }
            column(RanijeIskoristeniDani; RanijeIskoristeniDani)
            {

            }
            column(StartFirstpartT; StartFirstpartT)
            {

            }
            column(EndFirstpartT; EndFirstpartT)
            {

            }
            column(StartSecondpartT; StartSecondpartT)
            {

            }
            column(EndSecondpartT; EndSecondpartT)
            {

            }
            column(DanJavljanjanaposaoT; DanJavljanjanaposaoT)
            {

            }
            column(Used_Days; Used_Days)
            {

            }
            column(Director; Director)
            {

            }
            column(Izvrsni; Izvrsni)
            {

            }
            column(CEODa; CEODa)
            { }


            trigger OnAfterGetRecord()
            begin


                if "Document No." <> '' then
                    BrojDokumenta := DataItem5."Document No."
                else
                    BrojDokumenta := DataItem5."Document Text";

                ShortYear := format(copystr(format(Date2DMY("Date of report", 3)), strlen(format(Date2DMY("Date of report", 3))) - 1, strlen(format(Date2DMY("Date of report", 3)))));


                CompanyInformation.get;
                CompanyInformation.CalcFields(Picture);
                DatumRjesenjaT := FORMAT("Date of report", 0, '<Day,2>.<Month,2>.<Year4>.');
                Year1 := FORMAT("Date of report", 0, '<Year4>.');



                DanJavljanjanaposao := "Ending Date of I part";
                DanJavljanjanaposao := CALCDATE('<+1D>', "Ending Date of I part");
                Datum.Reset();
                Datum.SetFilter("Period Type", '%1', Datum."Period Type"::Date);
                Datum.SetFilter("Period Start", '%1', DanJavljanjanaposao);
                Datum.FindFirst();
                if Datum."Period No." = 6 then
                    DanJavljanjanaposao := CALCDATE('<+3D>', "Ending Date of I part");
                if Datum."Period No." = 7 then
                    DanJavljanjanaposao := CALCDATE('<+2D>', "Ending Date of I part");

                //Message(FORMAT(DanJavljanjanaposao));

                StartFirstpartT := FORMAT("Starting Date of I part", 0, '<Day,2>.<Month,2>.<Year4>.');
                EndFirstpartT := FORMAT("Ending Date of I part", 0, '<Day,2>.<Month,2>.<Year4>.');
                StartSecondpartT := FORMAT("Starting Date of II part", 0, '<Day,2>.<Month,2>.<Year4>.');
                EndSecondpartT := FORMAT("Ending Date of II part", 0, '<Day,2>.<Month,2>.<Year4>.');
                DanJavljanjanaposaoT := FORMAT(DanJavljanjanaposao, 0, '<Day,2>.<Month,2>.<Year4>.');

                OrgShema.Reset();
                OrgShema.SetFilter("Date From", '<=%1', "Date of report");
                OrgShema.SetCurrentKey("Date From");
                OrgShema.Ascending;
                OrgShema.FindLast();

                Position.Reset();
                Position.SetFilter("Management Level", '%1', Position."Management Level"::CEO);
                Position.SetFilter("ORG Shema", '%1', OrgShema.Code);

                if Position.FindFirst()
                then begin
                    Position.CalcFields("Employee Name", "Employee Last Name");
                    Director := Position."Employee Name";
                end;
                CEODa := false;


                ExeManager.Reset();
                ExeManager.SetFilter("Subordinate Org Description", '%1', Sector);
                ExeManager.SetFilter("ORG Shema", '%1', OrgShema.Code);

                VacationSe.Get('', Date2DMY("Date of report", 3));

                //ĐK  ExeManager.SetFilter("Position Description",'%1',);
                if ExeManager.FindFirst() then begin

                    ExeDescr := StrPos(ExeManager."Position Description", VacationSe."Part of Position Description");
                    Izvrsni := CopyStr(ExeManager."Position Description", ExeDescr + 4, StrLen(ExeManager."Position Description"));
                    Izvrsni := VacationSe."Vacation Decision Exe" + Izvrsni;

                end
                else begin
                    Izvrsni := '';
                    Izvrsni := VacationSe."Vacation Decision CEO";
                    //ako je CEO.
                end;

                //Po
                Pos.Reset();
                Pos.SetFilter(Description, '%1', DataItem5."Position Name");
                Pos.SetFilter("Org. Structure", '%1', OrgShema.Code);
                if Pos.FindFirst() then begin
                    if Pos."Management Level" = Pos."Management Level"::CEO then begin
                        Izvrsni := '';
                        CEODa := true;
                    end;
                end;

                //Izvrsni




                EmployeeRec.Reset();
                EmployeeRec.SetFilter("No.", '%1', DataItem5."Employee No.");
                if EmployeeRec.FindFirst() then begin

                    FirstPart := (AbsenceFill.GetHourPoolForVacation(DataItem5."Starting Date of I part", DataItem5."Ending Date of I part", EmployeeRec."Hours In Day") / EmployeeRec."Hours In Day");
                    DrugiDioDana := "Total days" - FirstPart;
                end;

                EmployeeAbsence.Reset();
                EmployeeAbsence.SetFilter("Employee No.", '%1', DataItem5."Employee No.");
                EmployeeAbsence.SetFilter("Vacation from Year", '%1', DataItem5.Year);
                if EmployeeAbsence.FindFirst() then
                    Used_Days := EmployeeAbsence.Count;

                //ĐK













            end;








            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter("Starting Date of I part", '<>%1', 0D);
                SetFilter("Ending Date of I part", '<>%1', 0D);


            end;

        }


    }

    requestpage
    {


        layout
        {
            area(content)
            {
                /* field(BrojDokumenta; BrojDokumenta)
                 {
                     Caption = 'Broj dokumenta';
                 }*/
                /*field(DatumRjesenja; DatumRjesenja)
                {
                    Caption = 'Datum rješenja';
                }

                field(BrojDanaPrviDio; BrojDanaPrviDio)
                {
                    Caption = 'Broj dana prvog dijela';
                }
                field(RanijeIskoristeniDani; RanijeIskoristeniDani)
                {
                    Caption = 'Ranije iskorišteni dani odmora';
                }*/

            }


        }


        actions
        {

        }

    }
    labels
    {
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin


    end;

    procedure SetParam(ReportDateInit: Date)
    begin
        ReportD := ReportDateInit;

    end;

    var

        Year1: Text;
        Datum: Record date;
        CEODa: Boolean;
        Pos: Record "Position Menu";
        VacationSe: Record "Vacation Setup history";
        ExeManager: Record "Exe Manager";

        ExeDescr: Integer;

        ShortYear: Text[2];
        ReportD: Date;

        OrgShema: Record "ORG Shema";

        DatumRjesenja: Date;
        DatumRjesenjaT: Text;
        BrojDokumenta: Text;
        BrojDanaPrviDio: Integer;
        Izvrsni: Text[250];
        DanJavljanjanaposao: Date;
        DanJavljanjanaposaoT: Text;
        StartFirstpartT: Text;
        EndFirstpartT: Text;
        StartSecondpartT: Text;
        EndSecondpartT: Text;
        DrugiDioDana: Integer;
        RanijeIskoristeniDani: Integer;
        EmployeeRec: Record Employee;

        CompanyInformation: Record "Company Information";
        VacMgmt: Codeunit "VacationMgmt2";
        CurrDaysUsed: Integer;

        PlanGO: Record "Vacation Ground 2";
        VACSetup: Record "Vacation Setup history";
        FirstPart: Integer;
        AbsenceFill: Codeunit "Absence Fill";


        Vacation: Record "Vacation Ground 2";
        Director: Text;

        Position: Record "Head Of's";
        Used_Days: Integer;
        EmployeeAbsence: record "Employee Absence";



}
