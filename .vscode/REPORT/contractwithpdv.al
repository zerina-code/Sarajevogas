report 50204 contractwithpdv //stari id je bio 50178. 50178 ce biti ispis za inventuru, a ovo je sačuvano za poslije.
{
    Caption = 'contractwithpdv', Locked = true;
    DefaultLayout = Word;
    //WordLayout = './contractwithpdv.docx';
    dataset
    {
        dataitem("Standard Text"; "Customer Ledger Entry")
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
            column(godina; format("Starting Date", 2)) { }
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
            column(MjestoIsporuke; "Address 2")
            {

            }
            column(Description; Description) { }
            column(Customer_Category; "Customer Category")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }

            column(MainAc; BankAccountNo)
            {

            }
            column(PictureTest; companyinfo.Picture)
            {

            }
            column(CEO; Head."Employee Name")
            {

            }
            column(Position; Head."Position Description")
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

                Customer.SetFilter("No.", '%1', "Standard Text"."Customer No.");
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
                    if "Customer Category" = "Customer Category"::"CNG" then
                        Description := 'CNG'
                    ELSE
                        if "Customer Category" = "Customer Category"::"Small Economy" then
                            Description := 'MP'
                        else
                            if "Customer Category" = "Customer Category"::Household then
                                Description := 'D'
                            else
                                if "Customer Category" = "Customer Category"::"KJKP Heating plant" then
                                    Description := ' '
                                else
                                    if "Customer Category" = "Customer Category"::"Large Economy" then
                                        Description := 'VP'
                                    else
                                        if "Customer Category" = "Customer Category"::"Special Customer" then
                                            Description := 'SL'
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
        CEO: Text[100];
        Position: Text[150];
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        Number_Field: code[20];
        Name_Title: Text[100];
        Job_Title: Text[30];
        Contact: Record Contact;
        CustomerBankAccount: Record "Customer Bank Account";
        BankAccountNo: text[100];
        BankName: text[100];
        BrojStavke: Code[20];

}
