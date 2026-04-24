pageextension 50095 VATPOstingSetupCard extends "VAT Posting Setup Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Adjust for Payment Discount")
        {

            field("VAT % (retrograde)"; "VAT % (retrograde)")
            {
                ApplicationArea = All;
            }

        }
    }
}
