/*codeunit 50023 GenJNLPostLine2
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInsertVAT', '', true, true)]
    procedure OnAfterInsertVAT(GenJournalLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; UnrealizedVAT: Boolean; AddCurrencyCode: Code[10]; VATPostingSetup: Record "VAT Posting Setup")

    //(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)



    var
        myInt: Integer;
        VATEntry2: Record "VAT Entry";
    begin

        // VATEntry."VAT Date" := GenJournalLine."VAT Date";


        InsertDetailedVATEntry(VATEntry);//BH1.03  



    end;



    local procedure InsertDetailedVATEntry(VATEntryToInsert: Record "vat entry")
    var
        myInt: Integer;
    begin
        WITH VATEntryToInsert DO BEGIN
            IF NOT (Type IN [Type::Sale, Type::Purchase]) THEN
                EXIT;

            InsertDetailedVATEntryData(VATEntryToInsert);
            IF (Type = Type::Purchase)
              AND
               ("VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT")
            THEN BEGIN
                Type := Type::Sale;
                InsertDetailedVATEntryData(VATEntryToInsert);
            END;
        END

    end;

    local procedure InsertDetailedVATEntryData(VATEntryToInsert: Record "VAT Entry")
    var
        myInt: Integer;
        VATBooksSetup: Record "VAT Books Setup";
        DetailedAmount: Decimal;
        DetailedVATEntry: Record "Detailed VAT Entry";
    begin
        WITH VATEntryToInsert DO BEGIN
            CASE Type OF
                Type::Sale:
                    VATBooksSetup.SETRANGE(Type, VATBooksSetup.Type::Sale);
                Type::Purchase:
                    VATBooksSetup.SETRANGE(Type, VATBooksSetup.Type::Purchase);
            END;
            VATBooksSetup.SETRANGE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
            VATBooksSetup.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
            IF VATBooksSetup.FINDSET THEN
                REPEAT
                    IF (VATBooksSetup.Value1 + VATBooksSetup.Value2) > 0 THEN BEGIN
                        DetailedAmount := 0;
                        IF VATBooksSetup.Value1 > 0 THEN
                            AddDetailedValue(VATEntryToInsert, VATBooksSetup.Operator1, VATBooksSetup.Value1, DetailedAmount);
                        IF VATBooksSetup.Value2 > 0 THEN
                            AddDetailedValue(VATEntryToInsert, VATBooksSetup.Operator2, VATBooksSetup.Value2, DetailedAmount);

                        IF VATBooksSetup.Value3 > 0 THEN
                            AddDetailedValue(VATEntryToInsert, VATBooksSetup.Operator3, VATBooksSetup.Value3, DetailedAmount);


                        IF DetailedAmount <> 0 THEN BEGIN
                            IF NOT DetailedVATEntry.GET("Entry No.", Type) THEN BEGIN
                                DetailedVATEntry.INIT;
                                DetailedVATEntry."VAT Entry No." := "Entry No.";
                                DetailedVATEntry.Type := Type;
                                DetailedVATEntry.INSERT;
                            END;
                            CASE VATBooksSetup."Column Name" OF
                                0:
                                    DetailedVATEntry.Column1 := DetailedVATEntry.Column1 + DetailedAmount;
                                1:
                                    DetailedVATEntry.Column2 := DetailedVATEntry.Column2 + DetailedAmount;
                                2:
                                    DetailedVATEntry.Column3 := DetailedVATEntry.Column3 + DetailedAmount;
                                3:
                                    DetailedVATEntry.Column4 := DetailedVATEntry.Column4 + DetailedAmount;
                                4:
                                    DetailedVATEntry.Column5 := DetailedVATEntry.Column5 + DetailedAmount;
                                5:
                                    DetailedVATEntry.Column6 := DetailedVATEntry.Column6 + DetailedAmount;
                                6:
                                    DetailedVATEntry.Column7 := DetailedVATEntry.Column7 + DetailedAmount;
                                7:
                                    DetailedVATEntry.Column8 := DetailedVATEntry.Column8 + DetailedAmount;
                                8:
                                    DetailedVATEntry.Column9 := DetailedVATEntry.Column9 + DetailedAmount;
                                9:
                                    DetailedVATEntry.Column10 := DetailedVATEntry.Column10 + DetailedAmount;
                            END;
                            DetailedVATEntry.MODIFY;
                        END;
                    END;
                UNTIL VATBooksSetup.NEXT = 0;
        END;
        //-BH1.03

    end;

    local procedure AddDetailedValue(VATEntryToInsert: Record "VAT Entry"; Operator: Option " ","+","-"; Value: Option " ",Base,Amount,"VAT Base (retro)","VAT Amount (retro)"; var DetailedAmount: Decimal)
    var
        TempAmount: Decimal;
    begin
        //+BH1.03
        CASE Value OF
            Value::Base:
                TempAmount := VATEntryToInsert.Base;
            Value::Amount:
                TempAmount := VATEntryToInsert.Amount;
            Value::"VAT Base (retro)":
                TempAmount := VATEntryToInsert."VAT Base (retro.)";
            Value::"VAT Amount (retro)":
                TempAmount := VATEntryToInsert."VAT Amount (retro.)";
        END;
        IF Operator = Operator::"-" THEN
            TempAmount := -TempAmount;

        DetailedAmount := DetailedAmount + TempAmount;
        //-BH1.03
    end;

    //  [EventSubscriber (ObjectType::Codeunit,Database::"Gen. Jnl.-Post Line",OnAfterInsertVAT)]
}*/