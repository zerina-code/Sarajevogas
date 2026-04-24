report 50104 "SG-TU-03-09-03"
{
    Caption = 'SG-TU-03-09-03', Locked = true;
    DefaultLayout = Word;
    WordLayout = '.\.vscode\REPORT\WORD\SG-TU-03-09-03.docx';
    dataset
    {
        dataitem(ServiceHeader; "Service Header")
        {
            CalcFields = "CZK Date";
            column(No_; "No.")
            {

            }
            column(CZK_Request_No_; "CZK Request No.")
            {

            }
            column(RD; "Responsible Department")
            {

            }
            column(Name; Name)
            {

            }
            column(Street; Address)
            {

            }
            column(Municipality; "Municipality Name")
            {

            }
            column(City; City)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            column(Designer; StrSubstNo('%1 / %2', "Designer Phone No.", "Designer Email"))
            {

            }
            column(CZK_Date; Format("CZK Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Document_Date; Format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Request_Due_Date; "Request Due Date")
            {

            }
            column(kW_Power; "kW Power")
            {

            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
