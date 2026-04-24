page 50212 "Apoeni Page"
{
    //ED
    Caption = 'Apoeni';
    PageType = List;
    SourceTable = Apoeni;
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Apoeni; Apoeni)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }

    }

    actions
    {
        area(navigation)
        {
            action("Zapisnik o primopredaji UniCredit")
            {
                Caption = 'Zapisnik o primopredaji UniCredit';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Today: Date;
                begin
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
                    ZapisnikOPrimopredaji.SetTableView(ApoeniTable);
                    ZapisnikOPrimopredaji.Run();
                end;

            }
        }
    }

    var
        GLEntry: Record "G/L Entry";
        ApoeniTable: Record Apoeni;
        IzvjestajPortoBlagajne: Report Report2Cash;
        ZapisnikOPrimopredaji: Report "Handover Report UniCredit";
        CashReceiptJournal: Page "Cash Receipt Journal";
        GenJournalBatch: Record "Gen. Journal Batch";
        UserSetup: Record "User Setup";
}

