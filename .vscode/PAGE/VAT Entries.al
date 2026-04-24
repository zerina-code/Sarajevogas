pageextension 50094 VATEntries extends "VAT Entries"
{
    layout
    {
        // Add changes to page layout here
        //comment test
        addafter("VAT Calculation Type")
        {

            field("VAT Base (retro.)"; "VAT Base (retro.)")
            {
                ApplicationArea = All;
            }

            field("VAT Amount (retro.)"; "VAT Amount (retro.)")
            {
                ApplicationArea = All;
            }
            field("Total Entry No."; "Total Entry No.")
            {


            }
            field("VAT Date"; "VAT Date")
            {

            }

            field("Prepayment"; "Prepayment")
            {

            }

        }
    }
}
