/*codeunit 50022 GenJNLPostLine
{




    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertVAT', '', true, true)]
    procedure OnBeforeInsertVAT(GenJournalLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; UnrealizedVAT: Boolean; AddCurrencyCode: Code[10]; VATPostingSetup: Record "VAT Posting Setup")

    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
    begin



    end;


    //OnB
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnBeforeInsertVATEntry', '', true, true)]
    procedure OnBeforeInsertVATEntry(VATEntry: record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")

    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
    // VATEntry2: Record "VAT Entry";
    begin


    end;

}*/