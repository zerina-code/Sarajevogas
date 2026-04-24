/*table 50128 "Cashier Cue"
{
    Caption = 'Cashier Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

       
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        UserSetup: Record "User Setup";
        BankAccount: Record "Bank Account";
        GenJournalBatch: Record "Gen. Journal Batch";
}

*/