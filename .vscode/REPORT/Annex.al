report 50140 Annex1Contract
{
    ApplicationArea = All;
    Caption = 'Annex1Contract';
    UsageCategory = ReportsAndAnalysis;
    WordLayout = 'Annex I Contract.docx';
    DefaultLayout = Word;
    dataset
    {
        dataitem(StandardText; "Customer Ledger Entry")
        {
            RequestFilterFields = Code;

            column(StartingDate; Format("Starting Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(Address; Address)
            {
            }
            column(City; City)
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(StreetNameCustomer; "Street Name Customer")
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
            }
            column(RegistrationNo; "Registration No.")
            {
            }
            column(Street_No_; "Street No.")
            {

            }
            column(Municipality_Name_Customer; "Municipality Name Customer")
            {

            }
            column(Code; Code)
            {

            }
            column(Responsible_Person_Name; "Responsible Person Name")
            {

            }
            column(Responsible_Person_Job_Title; "Responsible Person_Job Title")
            {

            }
            column(Customer_Contract_Code; "Contract Reason")
            {

            }
            column(Starting_date_for_unit_price; Format("Starting date for unit price", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Unit_Price_Includes_VAT; "Unit Price Includes VAT")
            {

            }
            column(Price_Description; "Price Description")
            {

            }
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(CompanyAddress; CompanyInfo.Address)
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }
            column(CompanyPost_Code; CompanyInfo."Post Code")
            {

            }
            column(CompanyMunicipality_Name; CompanyInfo."Municipality Name")
            {

            }
            column(CompanyIDNumber; CompanyInfo."Registration No.")
            {

            }
            column(CompanyVATNumber; CompanyInfo."VAT Registration No.")
            {

            }
            column(CEO; HeadOfs."Employee Name")
            {

            }
            column(CEOPositionDescr; HeadOfs."Position Description")
            {

            }

            trigger OnPreDataItem()
            var
            begin


                if BrojStavke <> '' then
                    SetFilter(Code, '%1', BrojStavke);
                CompanyInfo.Get();






            end;

            trigger OnAfterGetRecord()
            var
            begin

                OrgShema.Reset();
                OrgShema.SetFilter("Date From", '<=%1', Today);
                OrgShema.SetCurrentKey("Date From");
                OrgShema.Ascending;
                OrgShema.FindLast();

                HeadOfs.Reset();
                HeadOfs.SetFilter("Management Level", '%1', HeadOfs."Management Level"::CEO);
                HeadOfs.SetFilter("ORG Shema", '%1', OrgShema.Code);
                if HeadOfs.FindFirst() then begin
                    HeadOfs.CalcFields("Employee Name", "Employee Last Name");
                    HeadOfs.CalcFields("Position Description");
                    CEO := HeadOfs."Employee Name";
                    CEOPositionDescr := HeadOfs."Position Description";
                end;

                Customer.Reset();
                Customer.SetFilter("No.", '%1', StandardText."Customer No.");
                if Customer.FindFirst() then begin
                    Contact.Reset();
                    Contact.SetFilter("No.", '%1', Customer."Primary Contact No.");
                    if Contact.FindFirst() then begin
                        Name := Contact.Name;
                        Job_Title := Contact."Job Title";
                    end
                    else begin
                        Name := '';
                        Job_Title := '';
                    end;
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

    trigger OnPreReport()
    begin
        CompanyInfo.get;

    end;

    procedure SetParam(Code_10: Code[20])
    var

    begin
        BrojStavke := Code_10;

    end;


    var
        Customer: Record Customer;
        Contact: Record Contact;
        BrojStavke: code[20];
        CompanyInfo: Record "Company Information";
        org: Record "ORG Dijelovi";
        OrgShema: Record "ORG Shema";
        HeadOfs: Record "Head Of's";


        CEO: Text[100];
        CEOPositionDescr: Text[50];
        StartingDate: Text[20];
        Address: Text[100];
        City: Text[30];
        CountryRegionCode: Code[10];
        PostCode: Code[10];
        CustomerName: Text[250];
        StreetNameCustomer: Text[250];
        VATRegistrationNo: Text[20];
        RegistrationNo: Code[250];
        Street_No_: Code[20];
        Municipality_Name_Customer: Text[250];
        Code: Code[20];
        Name: Text[100];
        Job_Title: Text[30];

}