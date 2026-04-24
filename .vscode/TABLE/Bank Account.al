tableextension 50170 CustomerBankAccount extends "Customer Bank Account"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Bank Prefix"; code[3])
        {
            Caption = 'Bank Prefix';
        }

        modify(Code)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                CustB: Record "Customer Bank Account";
            begin

                "Bank Account No." := code;
                CustB.Reset();
                CustB.SetFilter("Bank Prefix", '%1', CopyStr(Code, 1, 3));
                if CustB.FindFirst() then begin
                    Name := CustB.Name;
                    Address := CustB.Address;
                    "Post Code" := CustB."Post Code";
                    City := CustB.City;
                    "Country/Region Code" := CustB."Country/Region Code";
                    "Phone No." := CustB."Phone No.";
                    Contact := CustB.Contact;
                    "Currency Code" := CustB."Currency Code";
                    "Telex Answer Back" := CustB."Telex Answer Back";
                    "Telex No." := CustB."Telex No.";
                    "Bank Branch No." := CustB."Bank Branch No.";
                    "SWIFT Code" := CustB."SWIFT Code";
                    "Name 2" := CustB."Name 2";
                    "Address 2" := CustB."Address 2";
                    "Bank Clearing Standard" := CustB."Bank Clearing Standard";
                    "Bank Clearing Code" := CustB."Bank Clearing Code";
                    "E-Mail" := CustB."E-Mail";
                    "Fax No." := CustB."Fax No.";

                end;

            end;

        }
    }

    var
        myInt: Integer;
}