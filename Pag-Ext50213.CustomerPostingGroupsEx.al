pageextension 50213 "Customer Posting Groups Ex" extends "Customer Posting Groups"
{
    layout
    {
        addafter("Receivables Account")
        {
            field("Expense G/L Account"; "Expense G/L Account")
            {
                ApplicationArea = Basic, Suite;
            }

            field("Correction G/L Account"; "Correction G/L Account")
            {
                ApplicationArea = Basic, Suite;

            }
        }
    }
}
