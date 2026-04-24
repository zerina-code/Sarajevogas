report 50077 "Payment Slip"
{
    //ED
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    RDLCLayout = './Payment Slip.rdl';


    dataset
    {
        dataitem(DataItem21; "Gen. Journal Line")
        {
            column(BatchName; DataItem21."Journal Batch Name")
            {
            }
            column(PostingDate; DataItem21."Posting Date")
            {
            }
            column(AppliesToDocNo; DataItem21."Applies-to Doc. No.")
            {
            }
            column(PaymentDT; DataItem21."Payment DT")
            {
            }
            column(DocumentNo; DataItem21."Document No.")
            {
            }
            column(Amound; DataItem21.Amount)
            {
            }
            column(Description; DataItem21.Description)
            {
            }
            column(PaymentMethod; DataItem21."Payment Method")
            {
            }
            column(LineNo; DataItem21."Line No.")
            {
            }
            column(Address_Customer; DataItem21.Address_Cust)
            {
            }
            column(AccountNo; DataItem21."Account No.")
            {
            }
            column(RegistrationNo_Cust; DataItem21.RegistrationNo_Cust)
            {
            }
            column(VATRegistrationNo_Cust; DataItem21.VATRegistrationNo_Cust)
            {
            }
            column(PM; DataItem21."Payment Method Code")
            {
            }
            column(Adress_CompanyInfo; CompanyInformation.Address)
            {
            }
            column(City_CompanyInfo; CompanyInformation.City)
            {
            }
            column(Name; CompanyInformation.Name)
            {
            }
            column(Phone1_CompanyInfo; CompanyInformation."Phone No.")
            {
            }
            column(Phone2_CompanyInfo; CompanyInformation."Phone No. 2")
            {
            }
            column(Fax_CompanyInfo; CompanyInformation."Fax No.")
            {
            }
            column(Email_CompanyInfo; CompanyInformation."E-Mail")
            {
            }
            column(Homepage_CompanyInfo; CompanyInformation."Home Page")
            {
            }
            column(RegistrationNo_CompanyInfo; CompanyInformation."Registration No.")
            {
            }
            column(Postcode_CompanyInfo; CompanyInformation."Post Code")
            {
            }
            column(VATRegistrationNo_CompanyInfo; CompanyInformation."VAT Registration No.")
            {
            }
            column(GiroNo_CompanyInfo; CompanyInformation."Giro No.")
            {
            }
            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(Country; Country)
            {
            }
            column(City; City)
            {
            }
            column(CName; ContName)
            {
            }
            column(CAddress; ContAddress)
            {
            }
            column(CCity; ContCity)
            {
            }
            column(User; USERID)
            {
            }
            column(IndustrialClassification_CompanyInfo; CompanyInformation."Industrial Classification")
            {
            }
            column(MBS; CompanyInformation.MBS)
            {
            }
            column(MunicipalityName; CompanyInformation."Municipality Name")
            {
            }
            column(Registration_CompanyInfo; CompanyInformation."Registration Text")
            {
            }
            column(Tax_CompanyInfo; CompanyInformation."Tax No.")
            {
            }
            column(City_Cust; City_Cust)
            {
            }


            trigger OnAfterGetRecord()
            begin
            end;

            trigger OnPreDataItem()
            begin

                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

                CountryRegion.SETFILTER(Code, CompanyInformation."Country/Region Code");
                IF CountryRegion.FINDFIRST THEN
                    Country := CountryRegion.Name;

            end;
        }
        dataitem(DataItem22; "Bank Account")
        {
            column(BankNo; DataItem22."No.")
            {
            }
            column(BankName; DataItem22.Name)
            {
            }
            column(BankAccNo; DataItem22."Bank Account No.")
            {
            }
            column(Counter; Counter)
            {
            }
            column(BankSWIFT; BankSWIFT)
            {
            }
            column(BankIBAN; BankIBAN)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Counter := Counter + 1;
                if Name = 'UniCredit Bank' then begin
                    BankSWIFT := "SWIFT Code";
                    BankIBAN := IBAN;
                end;

            end;

            trigger OnPreDataItem()
            begin
                Counter := 0;
            end;
        }

    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        BankAccTemp: Record "Bank Account" temporary;
        CompanyInformation: Record "Company Information";
        GJLine: Record "Gen. Journal Line";
        BankAccount: Record "Bank Account";
        BankSWIFT: Code[20];
        BankIBAN: Code[50];
        Country: Text[100];
        City: Text[100];
        CountryRegion: Record "Country/Region";
        Location: Record Location;
        Cont: Record Contact;
        Counter: Integer;
        ContName: Text[100];
        ContAddress: Text[100];
        ContCity: Text[100];
        emp: Record Employee;
        Cust: Record Customer;
}

