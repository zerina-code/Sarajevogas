report 50176 Safetyofuniggascontract
{
    Caption = 'Safetyofuniggascontract', Locked = true;
    DefaultLayout = Word;
    WordLayout = './Safetyofuniggascontract.docx';
    dataset
    {
        dataitem("Customer Ledger Entry"; "Customer Ledger Entry")
        {
            column(BrUgovora; Code)
            {

            }
            column(BrKorisnika; "Customer No.")
            {

            }
            column(Name_Title; Name_Title)
            {

            }
            column(Job_Title; Job_Title)
            {

            }
            column(godina; format("Starting Date", 3)) { }
            column(DatumSklapanja; FORMAT("Starting Date", 0, '<day,2>.<month,2>.<year4>'))
            {

            }
            column(Hod; "Customer Stroke")
            {

            }
            column(Niz; "Customer String")
            {

            }
            column(NazivKupca; "Customer Name")
            {

            }
            column(AdresaSjedista; Address)
            {

            }
            column(AdresaDostave; "Street Name Customer")
            {

            }

            column(Description; Description) { }
            column(Customer_Category; Customer_Category)
            {

            }


            column(MainAc; BankAccountNo)
            {

            }
            column(picture; companyinfo.Picture)
            {

            }
            column(CompanyLogo; companyinfo.Picture1)
            {

            }
            column(CEO; Head."Employee Name")
            {

            }
            column(Position; Head."Position Description")
            {

            }
            COLUMN(Address_2; "Address 2")
            {

            }
            column(Registration_No; Customer."Registration No.")
            {

            }
            column(BankName; BankName)
            {

            }

            column(Number_Field; Number_Field)
            {

            }

            column(Address; CompanyInfo.Address)
            {

            }

            column(Name; CompanyInfo.Name)
            {

            }
            column(Registration_No_; CompanyInfo."Registration No.")
            {

            }
            column(Tax_No_; CompanyInfo."Tax No.")
            {

            }
            column(Bank_Account_No_; CompanyInfo."Bank Account No.")
            {

            }
            column(AdditionPic; companyinfo.Picture2)
            {


            }
            column(AdditionPic2; companyinfo.Picture3)
            {

            }
            column(Bank_Name; CompanyInfo."Bank Name")
            {

            }
            column(Home_Page; CompanyInfo."Home Page")
            {

            }




            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if BrojStavke <> '' then
                    SetFilter(Code, '%1', BrojStavke);
                CompanyInfo.Get();

            end;

            trigger OnAfterGetRecord()
            begin

                ORG.Reset();
                ORG.SetFilter("Date From", '<=%1', Today);
                ORG.SetCurrentKey("Date From");
                ORG.Ascending;
                ORG.FindFirst();

                Head.Reset();
                Head.SetFilter("Management Level", '%1', Head."Management Level"::CEO);
                Head.SetFilter("ORG Shema", '%1', ORG.Code);
                if Head.FindFirst() then begin
                    Head.CalcFields("Employee Name", "Employee Last Name");
                    Head.CalcFields("Position Description");
                    CEO := Head."Employee Name";
                    Position := Head."Position Description";
                end;
                Customer.Reset();

                Customer.SetFilter("No.", '%1', "Customer Ledger Entry"."Customer No.");
                if Customer.FindFirst() then begin
                    Contact.Reset();
                    Contact.SetFilter("No.", '%1', Customer."Primary Contact No.");
                    if Contact.FindFirst() then begin
                        Name_Title := Contact.Name;
                        Job_Title := Contact."Job Title";
                    end
                    else begin
                        Name_Title := '';
                        Job_Title := '';
                    end;
                end;
                Customer.Reset();
                Customer.SetFilter("No.", '%1', "Customer No.");
                if Customer.FindFirst() then begin
                    CustomerBankAccount.Reset();
                    CustomerBankAccount.SetFilter(Code, '%1', Customer."Preferred Bank Account Code");
                    if CustomerBankAccount.FindFirst() then begin
                        BankName := CustomerBankAccount.Name;
                        BankAccountNo := CustomerBankAccount."Bank Account No.";
                    end
                    else begin
                        BankName := '';
                        BankAccountNo := '';
                    end;
                end;



                Customer.Reset();
                Customer.SetFilter("No.", '%1', "Customer No.");
                if Customer.FindFirst() then begin
                    if "Customer Category" = "Customer Category"::"CNG" then begin
                        Customer_Category := 'CNG Punionice';
                        Description := 'CNG'
                    end
                    ELSE
                        if "Customer Category" = "Customer Category"::"Small Economy" then begin
                            Customer_Category := 'MALA PRIVREDA';
                            Description := 'MP'
                        end
                        else
                            if "Customer Category" = "Customer Category"::Household then begin
                                Customer_Category := 'DOMAĆINSTVA';
                                Description := 'D'
                            END
                            else
                                if "Customer Category" = "Customer Category"::"KJKP Heating plant" then
                                    Description := ' '
                                else
                                    if "Customer Category" = "Customer Category"::"Large Economy" then begin

                                        Customer_Category := 'VELIKA PRIVREDA';
                                        Description := 'VP'
                                    END
                                    else
                                        if "Customer Category" = "Customer Category"::"Special Customer" then begin
                                            Customer_Category := 'POSEBNI KUPCI';
                                            Description := 'SL'
                                        end

                                        else
                                            Description := '';



                END;
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
        CompanyAddress: text[100];
        ORG: Record "ORG Shema";
        Head: Record "Head Of's";
        Number_Field: code[20];
        CEO: Text[100];
        Position: Text[150];
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        Name_Title: Text[100];
        Job_Title: Text[30];
        Contact: Record Contact;
        CustomerBankAccount: Record "Customer Bank Account";
        BankAccountNo: text[100];
        Customer_Category: text[50];
        BankName: text[100];
        BrojStavke: Code[20];


}
