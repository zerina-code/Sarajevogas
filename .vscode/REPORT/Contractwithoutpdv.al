report 50125 "Contractwithoutpdv"
{
    Caption = 'Contract without pdv', Locked = true;
    DefaultLayout = Word;
    WordLayout = './ugovor_bez_pdv.docx';
    dataset
    {
        dataitem("Standard Text"; "Customer Ledger Entry")
        {
            column(BrUgovora; Code)
            {

            }

            column(PriceDecimal; PriceDecimal) { }
            column(UnitM; UnitM) { }
            column(SlovimaRez; SlovimaRez) { }
            column(Floor_Customer; "Floor Customer") { }
            column(Floor_Customer_2; "Floor Customer 2") { }
            column(City; City)
            {

            }
            column(CompanyInfoCity; CompanyInfo.City) { }
            column(CompanyInfoPostCode; CompanyInfo."Post Code") { }
            column(CompanyInfoMunName; CompanyInfo."Municipality Name") { }
            column(vat; vat) { }

            column(BrKorisnika; "Customer No.")
            {

            }
            column(Street_No_2_Text; "Street No.2 Text") { }
            column(Apartment_No__Customer_2; "Apartment No. Customer 2") { }
            column(Name_Title; Name_Title)
            {

            }
            column(Job_Title; Job_Title)
            {

            }
            column(godina; format("Starting Date", 4, '<year4>')) { }
            column(DatumSklapanja; FORMAT("Starting Date", 0, '<day,2>.<month,2>.<year4>'))
            {

            }
            column(IDPreviousContract; CustomerPrevious.Description) { }
            column(IDPreviousContractStart; FORMAT(CustomerPrevious."Starting Date", 0, '<day,2>.<month,2>.<year4>'))
            {

            }
            column(IDPreviousPriceStart; FORMAT(PriceStart, 0, '<day,2>.<month,2>.<year4>'))
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
            column(AdresaSjedista; AddresaSjedista)
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
            column(CompanyLogo; companyinfo.Picture1)
            {

            }
            column(CEO; Head."Employee Name")
            {

            }
            column(Position; Head."Position Description")
            {

            }
            COLUMN(Address_2; Address2)
            {

            }
            column(Registration_No; RegistrtionF)
            {

            }
            column(BankName; BankName)
            {

            }
            column(Contract_Name; ContractName) { }
            column(MjestoIsporuke; MjestoIsporuke) { }
            column(Number_Field; Number_Field)
            {

            }

            column(Address; CompanyInfo.Address)
            {

            }

            column(Name; CompanyInfo.Name)
            {

            }
            column(Name2; CompanyInfo."Name 2")
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
            column(id_number; CustomerID.Code)
            {
            }
            column(id_issuer; CustomerID."Identity card issuer")
            {
            }
            column(id_date_from; format(CustomerID."Date From", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(LicneKarteNiz; LicneKarteNiz) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin




                if BrojStavke <> '' then
                    SetFilter(Code, '%1', BrojStavke);
                CompanyInfo.Get();
                LicneKarteNiz := '';
            end;

            trigger OnAfterGetRecord()
            var
                AdresaBB: Text;
                BrojacUlica: Integer;
                AdresaBB2: Text;
                SalesP: Record "Sales Price";
                Cug: Record customer;
                PDVSetup: Record "VAT Posting Setup";
                ItemF: Record Item;


            begin


                ContractName := "Contract Name";
                if "Contract Name" = '' then
                    ContractName := "Customer Name";

                CalcSetup.get;
                if "Standard Text"."Customer Category" = "Standard Text"."Customer Category"::CNG then begin

                    if "Standard Text"."Contract Reason" = 'ANEX' then begin
                        CustomerPrevious.Reset();
                        CustomerPrevious.SetFilter("Customer No.", '%1', "Standard Text"."Customer No.");
                        CustomerPrevious.SetFilter("Starting Date", '<%1', "Standard Text"."Starting Date");
                        CustomerPrevious.SetFilter("Contract Reason", '<>%1', 'ANEX');
                        CustomerPrevious.SetCurrentKey("Starting Date");
                        CustomerPrevious.Ascending;
                        if CustomerPrevious.FindLast() then begin

                        end;
                    end;
                    SalesP.Reset();
                    SalesP.SetFilter("Item No.", '%1', CalcSetup."Item No.");
                    SalesP.SetFilter("Sales Type", '%1', SalesP."Sales Type"::Customer);
                    SalesP.SetFilter("Sales Code", '%1', "Standard Text"."Customer No.");
                    SalesP.SetFilter("Starting Date", '<=%1', "Standard Text"."Starting Date");
                    SalesP.SetCurrentKey("Starting Date");
                    SalesP.Ascending;
                    if SalesP.FindLast() then begin
                        PriceDecimal := SalesP."Unit Price";
                        PriceStart := SalesP."Starting Date";
                    end
                    else begin
                        SalesP.Reset();
                        SalesP.SetFilter("Item No.", '%1', CalcSetup."Item No.");
                        SalesP.SetFilter("Sales Type", '%1', SalesP."Sales Type"::"Customer Price Group");
                        Cug.Reset();
                        Cug.SetFilter("No.", '%1', "Standard Text"."Customer No.");
                        if Cug.FindFirst() then
                            SalesP.SetFilter("Sales Code", '%1', Cug."Customer Price Group");
                        SalesP.SetFilter("Starting Date", '<=%1', "Standard Text"."Starting Date");
                        SalesP.SetCurrentKey("Starting Date");
                        SalesP.Ascending;
                        if SalesP.FindLast() then begin
                            PriceDecimal := SalesP."Unit Price";
                            PriceStart := SalesP."Starting Date";

                        end;
                    end;
                    PDVSetup.Reset();
                    PDVSetup.SetFilter("VAT Bus. Posting Group", '%1', Cug."VAT Bus. Posting Group");
                    ItemF.Reset();
                    ItemF.SetFilter("No.", '%1', CalcSetup."Item No.");
                    if ItemF.FindFirst() then
                        PDVSetup.SetFilter("VAT Prod. Posting Group", '%1', ItemF."VAT Prod. Posting Group");
                    UnitM := ItemF."Sales Unit of Measure";
                    if PDVSetup.FindFirst() then begin
                        if PDVSetup."VAT %" <> 0 then begin
                            PriceDecimal := round(PriceDecimal + PriceDecimal * PDVSetup."VAT %" / 100, 0.01, '=');
                        end;
                    end;


                    SlovimaRez := MyCU.NumberToWords(round(PriceDecimal), TRUE);

                end;


                AdresaBB := '';
                BrojacUlica := 0;
                MM_Rec.Reset;
                MM_Rec.SetFilter("Customer No.", '%1', "Standard Text"."Customer No.");
                MM_Rec.SetFilter("Status MM", '%1|%2|%3', MM_Rec."Status MM"::Active, MM_Rec."Status MM"::Terminated, MM_Rec."Status MM"::Potential);
                if MM_Rec.FindSet() then
                    repeat
                        MM_Rec.CalcFields(City);
                        AdresaBB := MM_Rec."Address MM";
                        AdresaBB2 := MM_Rec."Address MM";
                        ;
                        if MM_Rec."Street No. Text" <> '' then
                            AdresaBB += '\' + MM_Rec."Street No. Text";

                        if MM_Rec."Street No. Text" <> '' then
                            AdresaBB2 += '\' + MM_Rec."Street No. Text";


                        if MM_Rec.Floor <> '' then
                            AdresaBB += '\' + MM_Rec.Floor;



                        if MM_Rec."Apartment No." <> '' then
                            AdresaBB += '\' + MM_Rec."Apartment No.";


                        if MM_Rec."City MM" <> '' then
                            AdresaBB += ', ' + MM_Rec."City MM";


                        //if MM_Rec."Apartment No." <> '' thenp
                        //  AdresaBB += '\' + MM_Rec."Apartment No.";

                        if StrPos(MjestoIsporuke, AdresaBB2) = 0 then begin
                            if StrLen(MjestoIsporuke + AdresaBB) < 100 then
                                MjestoIsporuke += AdresaBB;
                            BrojacUlica += 1;
                        end;

                    until MM_Rec.Next() = 0;

                if BrojacUlica > 1 then
                    MjestoIsporuke := CompanyInfo.City;



                CustomerID.Reset();
                CustomerID.SETFILTER(Active, '%1', true);
                CustomerID.SETFILTER("Customer No.", '%1', "Standard Text"."Customer No.");
                CustomerID.Ascending;
                if CustomerID.FINDLAST then;

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
                        Name_Title := Contact."Responsible Contact";
                        //  Job_Title := ', ' + Contact."Job Title";
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
                    end
                    ELSE
                        if "Customer Category" = "Customer Category"::"Small Economy" then begin
                            Customer_Category := 'MALA PRIVREDA';

                        end
                        else
                            if "Customer Category" = "Customer Category"::Household then begin
                                Customer_Category := 'DOMAĆINSTVA';
                            END
                            else
                                if "Customer Category" = "Customer Category"::"KJKP Heating plant" then
                                    Customer_Category := 'KJKP TOPLANE'

                                else
                                    if "Customer Category" = "Customer Category"::"Large Economy" then begin

                                        Customer_Category := 'VELIKA PRIVREDA';
                                    END
                                    else
                                        if "Customer Category" = "Customer Category"::"Special Customer" then begin
                                            Customer_Category := 'POSEBNI KUPCI';
                                        end

                                        else
                                            Customer_Category := '';



                END;
                //Anisa
                LK.Reset();
                LK.SETFILTER(Active, '%1', true);
                LK.SETFILTER("Customer No.", '%1', "Standard Text"."Customer No.");
                IF LK.FindSet() then
                    repeat
                        if LicneKarteNiz = '' then
                            LicneKarteNiz := LK.Code + ', ' + LK."Identity card issuer" + ', ' + Format(LK."Date From", 0, '<day,2>.<month,2>.<year4>')
                        else
                            LicneKarteNiz += '; ' + LK.Code + ', ' + LK."Identity card issuer" + ', ' + Format(LK."Date From", 0, '<day,2>.<month,2>.<year4>');
                    until LK.Next() = 0;

                RegistrtionF := Customer."Registration No.";

                vat := Customer."VAT Registration No.";


                if vat = '' then
                    vat := LicneKarteNiz;

                if "Street No. Text" <> '' then
                    AddresaSjedista := Address + '\' + "Street No. Text" + ', ' + City
                else
                    AddresaSjedista := Address + ', ' + City;


                if "Street No.2 Text" <> '' then
                    Address2 := "Address 2" + '\' + "Street No.2 Text" + ', ' + "City 2"
                else
                    Address2 := "Address 2" + ', ' + "City 2";


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
        UnitM: text;
        MM_Rec: Record "Service Item";
        CEO: Text[100];
        Position: Text[150];
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        RegistrtionF: text[250];
        Name_Title: Text[100];
        Job_Title: Text[30];
        Contact: Record Contact;
        CustomerBankAccount: Record "Customer Bank Account";
        BankAccountNo: text[100];
        Customer_Category: text[50];
        PriceDecimal: Decimal;
        PriceStart: date;
        CalcSetup: Record "Calculation Setup";
        vat: TEXT[250];
        BankName: text[100];
        BrojStavke: Code[20];
        CustomerID: record "Customer ID";
        LicneKarteNiz: Text;
        MyCU: Codeunit TestSubsCu;
        SlovimaRez: Text;
        LK: Record "Customer ID";
        MjestoIsporuke: text[250];
        AddresaSjedista: text;

        Address2: Text;
        CustomerPrevious: Record "Customer Ledger Entry";
        ContractName: text;

}
