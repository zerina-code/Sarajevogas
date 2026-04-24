pageextension 50038 FixedAssetSetup extends "Fixed Asset Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Insurance Nos.")
        {
            field("Activation Nos."; "Activation Nos.")
            {
                ApplicationArea = all;
            }
            field("A. Journal Template Name"; "A. Journal Template Name") { }
            field("A. Journal Batch Name"; "A. Journal Batch Name") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}