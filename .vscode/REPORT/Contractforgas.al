report 50175 "Contractforgas"
{
    Caption = 'Contract for gas', Locked = true;
    DefaultLayout = Word;
    WordLayout = './contractofgas.docx';
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
            column(DatumSklapanja; "Starting Date")
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
            column(Customer_Category; "Customer Category")
            {

            }
            dataitem("Company Information"; "Company Information")
            {
                column(Address; "Company Information".Address)
                {

                }
                column(Name; "Company Information".Name)
                {

                }
                column(Registration_No_; "Company Information"."Registration No.")
                {

                }
                column(Tax_No_; "Company Information"."Tax No.")
                {

                }
                column(Bank_Account_No_; "Company Information"."Bank Account No.")
                {

                }
                column(Bank_Name; "Company Information"."Bank Name")
                {

                }


            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if BrojStavke <> '' then
                    SetFilter(Code, '%1', BrojStavke);
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
    procedure SetParam(Code_20: Code[20])
    var

    begin
        BrojStavke := Code_20;

    end;

    var
        BrojStavke: Code[20];

}



