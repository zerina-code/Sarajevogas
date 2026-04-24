report 50187 "Report Sum"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    PreviewMode = Normal;
    WordLayout = './Sum Service Order.docx';

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {
            column(Document_Date; "Document Date") { }

            column(Address; Address) { }
            column(Address_2; "Address 2") { }
            column(Activity; Activity) { }

        }
    }






    var
        myInt: Integer;
}