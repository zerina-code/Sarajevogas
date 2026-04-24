tableextension 50073 Value_EntryExtends extends "Value Entry"
{
    fields
    {

        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50110; "VAT Difference CNG"; Decimal)
        {
            Caption = 'VAT Difference CNG';
            DecimalPlaces = 1 : 10;
        }
        field(50001; "Total Retail Amount"; Decimal)
        {
            Caption = 'Total Retail Amout';
            AutoFormatType = 2;
        }
        field(50002; "Retail RUC"; Decimal)
        {
            Caption = 'Retail RUC';
            AutoFormatType = 2;
        }
        field(50048; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }

        field(50003; "Retail Unit Price"; Decimal)
        {
            Caption = 'Retail Unit Price';
            AutoFormatType = 2;

        }

        field(50004; "Retail Unit Price with VAT"; Decimal)
        {
            Caption = 'Retail Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50005; "Retail VAT"; Decimal)
        {
            Caption = 'Retail VAT';
            AutoFormatType = 2;

        }
        field(50006; "T.Retail Unit Price with VAT"; Decimal)
        {
            Caption = 'Total Retail Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50007; "CNG MP"; Boolean)
        {
            Caption = 'CNG MP';
        }
        field(50008; "CNG VP"; Boolean)
        {
            Caption = 'CNG VP';
        }
        field(50009; "Payment Method Code"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Method Code';



        }

        field(50010; "Total Wholesale Amount"; Decimal)
        {
            Caption = 'Total Wholesale Amout';
            AutoFormatType = 2;
        }
        field(50011; "Wholesale RUC"; Decimal)
        {
            Caption = 'Wholesale RUC';
            AutoFormatType = 2;
        }
        field(50012; "Wholesale Unit Price"; Decimal)
        {
            Caption = 'Wholesale Unit Price';
            AutoFormatType = 2;

        }

        field(50013; "Wholesale Unit Price with VAT"; Decimal)
        {
            Caption = 'Wholesale Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50014; "Wholesale VAT"; Decimal)
        {
            Caption = 'Wholesale VAT';
            AutoFormatType = 2;

        }
        field(50015; "T.Wholesale Unit Price with V"; Decimal)
        {
            Caption = 'Total Wholesale Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50016; "Calculate Retail VAT"; Decimal)
        {
            Caption = 'Calculate Retail VAT';
            AutoFormatType = 2;

        }
        field(50017; "Calculate Wholesale VAT"; Decimal)
        {
            Caption = 'Calculate Wholesale VAT';
            AutoFormatType = 2;

        }
        field(50018; "Sales Header No."; COde[20])
        {
            Caption = 'Sales Header No.';
            AutoFormatType = 2;

        }
        field(50019; "CNG VL"; Boolean)
        {
            Caption = 'CNG VL';
        }
        field(50020; "Gen Bus Posting"; Code[20])
        {
            Caption = 'Gen Bus Posting';
        }
        field(50021; "Prod Bus Posting"; Code[20])
        {
            Caption = 'Prod Bus Posting';
        }

        field(50022; "Nivelacija"; Boolean)
        {
            Caption = 'Nivelacija';
        }
        field(50023; "Nivelacija No."; Code[20])
        {
            Caption = 'Nivelacija No.';
        }
        field(50024; "Nivelacija No Series"; Code[20])
        {
            Caption = 'Nivelacija No Series';
        }
        field(50025; "Prepare Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Prepare Employee No.';
        }
        field(50026; "Prepare Employee Name"; Text[250])
        {
            Caption = 'Prepare Employee Name';

        }

        field(50027; "Control Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Control Employee No.';
        }
        field(50028; "Control Employee Name"; Text[250])
        {

            Caption = 'Control Employee Name';

        }
        field(50029; "Verif Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Verif Employee No.';
        }
        field(50030; "Verif Employee Name"; Text[250])
        {

            Caption = 'Verif Employee Name';

        }
        field(50031; "Hide CNG MP"; Boolean)
        {
            Caption = 'Hide CNG MP';
        }

        field(50032; "R. CNG MP"; Boolean)
        {
            Caption = 'R. CNG MP';
        }






    }

    procedure GetCostAmt(): Decimal
    begin
        //+BH1.00
        IF "Cost Amount (Actual)" = 0 THEN
            EXIT("Cost Amount (Expected)");
        EXIT("Cost Amount (Actual)");
        //-BH1.00
    end;
}