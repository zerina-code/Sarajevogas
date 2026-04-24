codeunit 50013 "Insert Permissions"
{
    // Version BCGOLIVE -- DELETE TABLES FOR GO-LIVE (TRANSACTIONAL,ASSIGN YOUR TABLES)
    Permissions = TableData "Item Ledger Entry" = rimd, TableData "Value Entry" = rimd,
    TableData "G/L Entry" = rimd;

    TableNo = "G/L Entry";

    //... ADD COUNTRY LOCALIZATION TABLES, FA, SERVICE etc. etc.
    trigger OnRun()
    var
        GLEntryNEw: Record "G/L Entry";
        EntryNo: Integer;
        CU: Codeunit "Gen. Jnl.-Post Line";
        GenJournalLine: Record "Gen. Journal Line";

    //InsertGLEntry(GenJnlLine, GLEntry, true);
    begin


        GLEntryNEw := Rec;

        GenJournalLine.Amount := GLEntryNEw.Amount;
        GenJournalLine."Document No." := GLEntryNEw."Document No.";
        GenJournalLine."Document Type" := GLEntryNEw."Document Type";
        GenJournalLine."Amount (LCY)" := GLEntryNEw.Amount;
        GenJournalLine."Debit Amount" := GLEntryNEw."Debit Amount";
        GenJournalLine."Credit Amount" := GLEntryNEw."Credit Amount";

        CU.InsertGLEntry(GenJournalLine, GLEntryNEw, true);
        GLEntryNEw.Insert();


    end;




    var
        Text0001: Label 'Delete Records?';
        Text0002: Label 'Deleting Records!\Table: #1#######';






}