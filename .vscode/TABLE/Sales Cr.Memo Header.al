tableextension 50060 SalesCrMemoHeaderExtends extends "Sales Cr.Memo Header"
{
    fields
    {
        //    VAT Base (retro.)
        field(50006; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                Cust: Record Customer;
            begin
                cust.Reset();
                cust.SetFilter("No.", '%1', rec."Sell-to Customer No.");
                if cust.FindFirst() then begin
                    rec."Customer Category" := cust."Customer Category";
                end
                else begin
                    rec."Customer Category" := rec."Customer Category"::" ";
                end;

            end;
        }


        //Fiscal DateTime

        field(50001; "Fiscal DateTime"; DateTime)
        {
            Caption = 'Fiscal DateTime';
            DataClassification = ToBeClassified;

        }
        field(50102; "CZK Request"; code[20])
        {
            Caption = 'CZK Request';
        }

        field(50002; "Fiscal User"; COde[250])
        {
            Caption = 'Fiscal User';
            DataClassification = ToBeClassified;

        }

        field(50003; "Fiscal No."; COde[20])
        {
            Caption = 'Fiscal No.';
            DataClassification = ToBeClassified;

        }

        field(50004; "Fiscal No. Printed"; Boolean)
        {
            Caption = 'Fiscal No. Printed';
            DataClassification = ToBeClassified;

        }

        field(50005; "Fiscal Printer Code"; Code[20])
        {
            Caption = 'Fiscal Printer Code';
            DataClassification = ToBeClassified;

        }
        field(50007; "Internal Correction"; Boolean)
        {

        }
        field(50008; Prepayment; Boolean)
        {

        }
        field(50009; KUF_Entry; Integer)
        {
            Caption = 'KUF Entry';

        }
        field(50050; "Bill type"; Code[20])
        {

        }
        field(50011; "Posting Employee USERID"; code[250])

        {
            Caption = 'Posting Employee USERID';

        }
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }
        field(50012; "Control Employee USERID"; code[250])

        {
            Caption = 'Control Employee USERID';
            TableRelation = User."User Name";

        }
        field(50013; "Exe Employee USERID"; code[20])

        {
            Caption = 'Exe Employee USERID';

        }
        field(50014; "Remark for CR Memo"; Text[250])

        {
            Caption = 'Remark for CR Memo';

        }
        field(50099; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }





    }

    trigger OnInsert()
    var
        myInt: Integer;
        CO: Record "Company Information";
    begin
        "Language Code" := 'HRV';
        "Posting Employee USERID" := "User ID";
        CO.get;
        "Exe Employee USERID" := co."Employee Signatory";

    end;

}