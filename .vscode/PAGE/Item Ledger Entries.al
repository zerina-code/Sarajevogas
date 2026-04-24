pageextension 50124 Item_Ledger_Entries extends "Item Ledger Entries"
{
    layout
    {
        // Add changes to page layout here

        addafter("Document No.")
        {
            field("SKLOT No."; "SKLOT No.") { }
            field("Receipt No."; "Receipt No.") { }
        }
        addbefore(Open)
        {
            field("Retail Unit Price"; "Retail Unit Price")
            {

            }
            field("Total Retail Amount"; "Total Retail Amount") { }
            field("Retail RUC"; "Retail RUC") { }
            field("Retail VAT"; "Retail VAT") { }
            field("Retail Unit Price with VAT"; "Retail Unit Price with VAT") { }
            field("T.Retail Unit Price with VAT"; "T.Retail Unit Price with VAT") { }



            field("Wholesale Unit Price"; "Wholesale Unit Price")
            {

            }
            field("Total Wholesale Amount"; "Total Wholesale Amount") { }
            field("Wholesale RUC"; "Wholesale RUC") { }
            field("Wholesale VAT"; "Wholesale VAT") { }
            field("Wholesale Unit Price with VAT"; "Wholesale Unit Price with VAT") { }
            field("T.Wholesale Unit Price with V"; "T.Wholesale Unit Price with V") { }
            field("Employee No."; "Employee No.") { }
            field("Employee Name"; "Employee Name") { }
            field("Org Name"; "Org Name") { }



        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields("SKLOT No.", "Receipt No.");

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CalcFields("SKLOT No.", "Receipt No.");

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("SKLOT No.", "Receipt No.");

    end;

    var
        myInt: Integer;
}