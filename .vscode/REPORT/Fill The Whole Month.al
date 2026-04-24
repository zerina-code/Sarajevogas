/*report 50041 "Fill The Whole Month"
{
    //ED 

    Caption = 'Fill The Whole Month';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Employee")
        {
            

            trigger OnAfterGetRecord()
            begin
                Employee.SetFilter("For Calculation", '%1', true);
                if Employee.FindFirst() then
                    repeat
                        EmployeeAbsence.SetFilter("Employee No.", '%1', Employee."No."); //trazim odsustvo za jednog zaposlenog
                        EmployeeAbsence.SetFilter("From Date", '%1..%2', StartingDate, EndingDate); //filter na unesene datume u request page-u
                        EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                        if NOT EmployeeAbsence.FindFirst() then begin //u tabeli nema nijednog odsustva za ovog zaposlenog
                            WageSetup.Get();
                            AbsenceFill.EmployeeAbsence(StartingDate, EndingDate, Employee, WageSetup."Workday Code", Employee."Hours In Day");
                        end
                        else begin //pronađeno je barem 1 odsustvo

                            Datum.RESET;
                            Datum.SETFILTER("Period Type", '%1', 0);
                            Datum.SETRANGE("Period Start", StartingDate, EndingDate); //uzimam dane izmedju unesenih datuma
                            Datum.FINDFIRST;

                            repeat
                                EmployeeAbsence.Reset();
                                EmployeeAbsence.SetFilter("Employee No.", '%1', Employee."No.");
                                EmployeeAbsence.SetFilter("From Date", '%1', Datum."Period Start"); //jedan dan
                                EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                                if NOT EmployeeAbsence.FindFirst() then begin //nije pronadjeno odustvo na ovaj dan
                                    WageSetup.Get();
                                    AbsenceFill.EmployeeAbsence(Datum."Period Start", Datum."Period Start", Employee, WageSetup."Workday Code", Employee."Hours In Day");
                                end;
                            until Datum.NEXT = 0; //sljedeći datum
                        end;
                    until Employee.Next() = 0; //sljedeci zaposlenik

            end;

            trigger OnPreDataItem()
            begin

            end;
        }
    }

    requestpage
    {
        Caption = 'Insert Dates';
        ShowFilter = false;

        layout
        {
            area(content)
            {

                field(StartingDate; StartingDate)
                {
                    ApplicationArea = all;
                    Caption = 'Starting Date';
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = all;
                    Caption = 'Ending Date';
                }

            }
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
        MESSAGE(Text0000);
    end;


    var
        Employee: Record Employee;
        EmployeeAbsence: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        AbsenceFill: Codeunit "Absence Fill";
        CauseOfAbsence: Record "Cause of Absence";
        Datum: Record "Date";
        StartingDate: Date;
        EndingDate: Date;
        LastEntry: Integer;
        Text0000: Label 'Registration of absences is completed.';

}
*/