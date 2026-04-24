pageextension 50133 DetailedCustLedgerEntry extends "Detailed Cust. Ledg. Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("Entry No.")
        {
            field(Prepayment; Prepayment)
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}