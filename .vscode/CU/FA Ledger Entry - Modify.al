/*codeunit 50009 "FA Ledger Entry - Modify"
{
    Permissions = TableData "FA Ledger Entry" = m;

    TableNo = "FA Ledger Entry";

    trigger OnRun()
    var
        Entry: Integer;
    begin



        FALedgEntry := Rec;
        Entry := Rec."Entry No.";


        FALedgEntry.LockTable();
        FALedgEntry.Activation := true;

        if FALedgEntry."Entry No." = Entry then
            FALedgEntry.Modify();

    end;

    var
        FALedgEntry: Record "FA Ledger Entry";


}

*/