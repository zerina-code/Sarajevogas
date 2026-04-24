report 50105 ComplaintReport
{

    //ED
    
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './Complaint.docx';
    Caption = 'Complaint Report';

    dataset
    {
    }

    trigger OnPreReport()
    begin
    end;
}