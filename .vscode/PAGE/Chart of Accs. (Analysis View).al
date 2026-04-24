pageextension 50024 ChartOfAccs extends "Chart of Accs. (Analysis View)"
{
    layout
    {
        // Add changes to page layout here
        addafter("Balance at Date")
        {

            field("Debit Amount"; "Debit Amount")
            {
                ApplicationArea = All;
            }


            field("Credit Amount"; "Credit Amount")
            {
                ApplicationArea = All;
            }

        }
    }
}
