pageextension 50259 "Purchase Invoice List" extends "Purchase Invoices"
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date"; "VAT Date")
            {
                ApplicationArea = All;
            }

        }
    }
}