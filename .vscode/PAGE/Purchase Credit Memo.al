pageextension 50068 PurchaseCreditMemo extends "Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("VAT Date"; "VAT Date")
            {

            }
        }
        addafter(Status)
        {
            field(Correction; Correction) { }
            field(KUF; KUF) { }
        }
        modify("Vendor Authorization No.") { ApplicationArea = all; }
        modify("No.")
        {
            Visible = true;
        }
        modify("Payment Discount %") { Visible = false; }
        modify("Pmt. Discount Date") { Visible = false; }
        modify("Prices Including VAT") { Visible = false; }
        modify("Tax Liable") { Visible = false; }


        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                Validate(Rec."Posting Date", Rec."Document Date");
                //Rec."Posting Date" := Rec."Document Date";
            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}