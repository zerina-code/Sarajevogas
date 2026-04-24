tableextension 50001 FALedgerEntry extends "Fa Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Activation"; Boolean)
        {
            Caption = 'Activation';
        }
    }

    var
        myInt: Integer;
}