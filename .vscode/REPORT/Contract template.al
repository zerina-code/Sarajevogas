report 50206 "Contract template"
{
    DefaultLayout = Word;
    PreviewMode = Normal;
    WordLayout = './Contract.docx';

    dataset
    {
        dataitem(DataItemName; "Employee Contract Ledger")
        {
            column(Employee_Name; "Employee Name") { }
            column(Contract_Type; "Contract Type Name") { }
            column(Starting_date; format("Starting date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Today_Date; format(Today, 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Position_Description; "Position Description") { }
            column(Sector_Description; "Sector Description") { }
            column(Position_Coefficient_for_Wage; "Position Coefficient for Wage") { }
            column(Department_City; "Department City") { }
            column(Position_Code; "Position Code") { }
            column(Comp_Picture1; Comp.Picture) { }
            column(Comp_Name; Comp.Name) { }
            column(Comp_Adress; Comp.Address) { }
            column(CEO; Head."Employee Name") { }
            column(Emp_Adress; emp."Address CIPS") { }
            column(Emp_Place_Of_Living; emp."Place Of Living") { }
            column(Contract_Number; "Contract Number") { }
            column(Working_Hours_Description; WorkingHoursDescription) { }
            column(Hours_Amount; Hours_Amount) { }
            column(Ending_date; format("Ending date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Place_Of_Work; "Place of work") { }
            column(Title; emp.Title) { }
            column(Type_of_engagement; "Type of Engagement Description") { }


            dataitem(Job_DescriptionT; "Job Description")
            {

                column(Description; Description) { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin

                    ORG.Reset();
                    ORG.SetFilter("Date From", '<=%1', Today);
                    ORG.SetFilter(Status, '%1', ORG.Status::Active);
                    ORG.SetCurrentKey("Date From");
                    ORG.Ascending;
                    if ORG.FindFirst() then begin
                        Job_DescriptionT.SetFilter("Job position Code", '%1', DataItemName."Position Code");
                        Job_DescriptionT.SetFilter("Org Shema", '%1', ORG.Code);

                    end;

                end;
            }

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
                Hours_Amount := emp."Hours In Day" * 5;



            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if EntryNo <> 0 then begin
                    SetFilter("No.", '%1', EntryNo);
                end;

            end;
        }


    }


    trigger OnInitReport()
    var
        myInt: Integer;
    begin

    end;

    var
        Comp: Record "Company Information";
        Head: Record "Head Of's";
        ORG: Record "ORG Shema";
        emp: Record Employee;
        myInt: Integer;
        WorkingHoursDescription: Text[10];
        Hours_Amount: Integer;
        Pos: Record "Position";
        Job_Description: Text;
        JD: Record "Job description";
        EntryNo: Integer;

    procedure SetParam(NoFilter: Integer)
    begin
        EntryNo := NoFilter;
    end;


    var


}
