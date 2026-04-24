pageextension 50020 ChartOFAccountG_L extends "Chart of Accounts (G/L)"
{
    layout
    {
        // Add changes to page layout here
        addafter("Net Change")
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