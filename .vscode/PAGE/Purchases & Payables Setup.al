pageextension 50134 purchase_Payables_Setup extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posted Prepmt. Cr. Memo Nos.")
        {
            field("Advance No. Series"; "Advance No. Series") { ApplicationArea = all; }
            field("Prepayment Invoice Nos."; "Prepayment Invoice Nos.") { ApplicationArea = all; }
            field("Corr. Prepayment Invoice Nos."; "Corr. Prepayment Invoice Nos.") { ApplicationArea = all; }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}