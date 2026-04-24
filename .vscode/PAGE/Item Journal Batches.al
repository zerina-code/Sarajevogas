pageextension 50046 ItemJournalBatches extends "Item Journal Batches"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                //nermina
            }
            field(Nivelacija; Nivelacija) { ApplicationArea = all; }
            field(Transfer; Transfer) { }

        }
    }
}
