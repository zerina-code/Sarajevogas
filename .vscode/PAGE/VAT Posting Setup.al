pageextension 50101 VATPOstingSetup extends "VAT Posting Setup"
{

    layout
    {
        // Add changes to page layout here
        addafter("VAT Calculation Type")
        {

            field("VAT % (retrograde)"; "VAT % (retrograde)")
            {
                ApplicationArea = All;
            }

        }
    }
}
