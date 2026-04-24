tableextension 50093 Item_Ledger_Entry extends "Item Ledger Entry"
{
    fields
    {
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
        // Add changes to table fields here
        field(50018; "Sales Header No."; COde[20])
        {
            Caption = 'Sales Header No.';
            AutoFormatType = 2;

        }


        field(50007; "Total Wholesale Amount"; Decimal)
        {
            Caption = 'Total Wholesale Amout';
            AutoFormatType = 2;
        }
        field(50008; "Wholesale RUC"; Decimal)
        {
            Caption = 'Wholesale RUC';
            AutoFormatType = 2;
        }
        field(50009; "Wholesale Unit Price"; Decimal)
        {
            Caption = 'Wholesale Unit Price';
            AutoFormatType = 2;

        }

        field(50010; "Wholesale Unit Price with VAT"; Decimal)
        {
            Caption = 'Wholesale Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50011; "Wholesale VAT"; Decimal)
        {
            Caption = 'Wholesale VAT';
            AutoFormatType = 2;

        }
        field(50012; "T.Wholesale Unit Price with V"; Decimal)
        {
            Caption = 'Total Wholesale Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50031; "Employee No."; code[20])
        {

            Caption = 'Employee No.';
            TableRelation = Employee."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                EMp: Record Employee;
            begin
                EMp.reset;
                EMp.SetFilter("No.", '%1', "Employee No.");
                if EMp.FindFirst() then
                    "Employee Name" := EMp."First Name" + ' ' + EMp."Last Name"
                else
                    "Employee Name" := '';

            end;

        }
        field(50032; "Employee Name"; text[250])
        {

            Caption = 'Employee Name';

        }
        field(50033; "Org Name"; text[250])
        {

            Caption = 'Org Name';

        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
        field(50034; "SKLOT No."; code[20])
        {
            Caption = 'SKLOT No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Shipment Line"."No." where("Posted Source No." = field("Document No.")));
        }
        field(50035; "Receipt No."; code[20])
        {
            Caption = 'Receipt No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Receipt Line"."No." where("Posted Source No." = field("Document No.")));
        }

        field(50024; "Sales Line No."; integer)
        {
            Caption = 'Sales Line No.';

        }


    }



    var
        myInt: Integer;
}