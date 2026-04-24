/*report 50207 "Contract template 2"
{
    DefaultLayout = Word;
    PreviewMode = Normal;
    WordLayout = './Contract2.docx';

    dataset
    {
        dataitem(DataItemName; "Employee Contract Ledger")
        {
            column(Comp_Name; Comp.Name) { }
            column(Comp_Adress; Comp.Address) { }
            column(Employee_Name; "Employee Name") { }
            column(Contract_Type; "Contract Type Name") { }
            column(Starting_date; format("Starting date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Ending_date; format("Ending date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Position_Description; "Position Description") { }
            column(Sector_Description; "Sector Description") { }
            column(Position_Code; "Position Code") { }
            column(CEO; Head."Employee Name") { }
            column(Working_Hours_Description; WorkingHoursDescription) { }
            column(Hours_Amount; Hours_Amount) { }
            column(Position_Coefficient_for_Wage; "Position Coefficient for Wage") { }
            column(Today_Date; format(Today, 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Contract_Number; "Contract Number") { }
            column(Comp_Picture1; Comp.Picture1) { }
            column(Emp_Adress; emp."Address CIPS") { }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Comp.get;
                Comp.CalcFields(Picture, Picture1, Picture2);

                ORG.Reset();
                ORG.SetFilter("Date From", '<=%1', Today);
                ORG.SetFilter(Status, '%1', ORG.Status::Active);
                ORG.SetCurrentKey("Date From");
                ORG.Ascending;
                if ORG.FindFirst() then begin
                    Head.Reset();
                    Head.SetFilter("Management Level", '%1', Head."Management Level"::CEO);
                    Head.SetFilter("ORG Shema", '%1', ORG.Code);
                    if Head.FindFirst() then begin
                        Head.CalcFields("Employee Name", "Employee Last Name", "Employee No.", "Position Description");
                        emp.Reset();
                        emp.SetFilter("No.", '%1', Head."Employee No.");
                    end;
                end;
                emp.Reset();
                emp.SetFilter("No.", '%1', "Employee No.");
                if emp.FindFirst() then begin
                    if emp."Hours In Day" = 8 then
                        WorkingHoursDescription := 'puno'
                    else
                        if emp."Hours In Day" < 8 then
                            WorkingHoursDescription := 'nepuno';

                end;
                Hours_Amount := emp."Hours In Day" * 5
            end;


        }
    }

    var
        Comp: Record "Company Information";
        ORG: Record "ORG Shema";
        Head: Record "Head Of's";
        emp: Record Employee;
        WorkingHoursDescription: Text[10];
        Hours_amount: integer;


} */
