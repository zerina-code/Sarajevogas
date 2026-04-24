/*report 50136 TimeSheet2
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "Company Information")
        {

        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Dates)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;

                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }



        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
        trigger OnAfterGetRecord()
        begin
            // ExportExcel.SetParam(StartDate, EndDate);
            // ExportExcel.Run();
 
        end;
    }

    var
        myInt: Integer;
        EndDate: Date;
        StartDate: Date;
        ExportExcel: Codeunit "Export TimeSheet 2 Excel";
}*/