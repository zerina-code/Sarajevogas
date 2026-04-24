/*page 50148 "Apoeni FactBox"
{
    PageType = CardPart;
    Caption = 'Apoeni FactBox';
    Editable = false;
    LinksAllowed = false;
    UsageCategory = Administration;
    SourceTable = "Gen. Journal Line";


    layout
    {
        area(Content)
        {
            field(Apoeni; Apoeni)
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    Today: Date;
                begin
                    Counter := 1;

                    if Counter < 13 then //uzimam 13 jer apoeni enum ima 13 polja, odnosno apoena
                        repeat
                            ApoeniTable.Reset(); //provjeravam da li vec taj record postoji u tabeli
                            ApoeniTable.SetFilter("Posting Date", '%1', System.Today);
                            UserSetup.Reset();
                            UserSetup.SetFilter("User ID", '%1', UserId);

                            if UserSetup.FindFirst() then begin
                                GenJournalBatch.Reset();
                                GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
                                if GenJournalBatch.FindFirst() then
                                    ApoeniTable.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");

                            end;
                            ApoeniTable.SetFilter(Apoeni, '%1', Counter);

                            if NOT ApoeniTable.FindFirst() then begin //insertujem novi red ako nije pronadjen
                                ApoeniTable.Reset();
                                ApoeniTable.Init();
                                ApoeniTable."Posting Date" := System.Today;

                                UserSetup.Reset();
                                UserSetup.SetFilter("User ID", '%1', UserId);
                                if UserSetup.FindFirst() then begin
                                    GenJournalBatch.Reset();
                                    GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
                                    if GenJournalBatch.FindFirst() then
                                        ApoeniTable."Bal. Account No." := GenJournalBatch."Bal. Account No.";
                                end;

                                ApoeniTable.Apoeni := Counter;
                                ApoeniTable.Quantity := 0;
                                ApoeniTable.Insert();
                            end;

                            Counter += 1;
                        until Counter = 13;

                    Today := System.Today;
                    ApoeniTable.Reset();
                    ApoeniTable.SetFilter("Posting Date", '%1', Today);
                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        GenJournalBatch.Reset();
                        GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
                        if GenJournalBatch.FindFirst() then
                            ApoeniTable.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");
                    end;

                    ApoeniPage.SetTableView(ApoeniTable);
                    ApoeniPage.Run();
                end;
            }
        }
    }

    var
        GJLine: Record "Gen. Journal Line";
        ApoeniTable: Record Apoeni;
        ApoeniPage: Page "Apoeni Page";
        ApoeniEnum: Enum "Apoeni Enum";
        Counter: Integer;
        GenJnlManagement: Codeunit GenJnlManagement;
        GenJournalBatch: Record "Gen. Journal Batch";
        UserSetup: Record "User Setup";
}*/