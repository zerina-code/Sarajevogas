page 50110 "Cashier Activities"
{
    Caption = 'Cashier Activities';
    PageType = CardPart;
    SourceTable = "Payroll Cue";
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }
            field("Centar za kupce"; "Centar za kupce")
            {
                Caption = 'Centar za kupce';
                ApplicationArea = all;
                Visible = NOT (VisibleMainCashier);

                trigger OnDrillDown()
                begin
                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        GenJournalBatch.Reset();
                        GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
                        if GenJournalBatch.FindFirst() then begin
                            BankAccount.Reset();
                            BankAccount.SetFilter("No.", '%1', GenJournalBatch."Bal. Account No.");
                            Rec."Centar za kupce" := GenJournalBatch."Bal. Account No.";
                            BankAccountCard.SetTableView(BankAccount);
                            BankAccountCard.Run();
                        end;
                    end;
                end;
            }

            cuegroup(BankAccounts)
            {
                Caption = 'Bank Accounts';
                field("All Bank Accounts"; "All Bank Accounts")
                {
                    ApplicationArea = all;
                    Visible = VisibleMainCashier;
                }
                field("Bank Accounts"; "Bank Accounts")
                {
                    ApplicationArea = all;
                    Visible = VisibleMainCashier;
                }
                field(CZK; CZK)
                {
                    ApplicationArea = all;
                    Visible = VisibleMainCashier;
                }
            }

            /*cuegroup(AllCustomers)
            {
                Caption = 'Customers';
                field(Customers; Customers)
                {
                    ApplicationArea = all;
                }
            }*/
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            if UserSetup."Main Cashier" then
                VisibleMainCashier := true
            else
                VisibleMainCashier := false;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            //If NOT UserSetup."Main Cashier" then begin        
            GenJournalBatch.Reset();
            GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
            if GenJournalBatch.FindFirst() then
                Rec."Centar za kupce" := GenJournalBatch."Bal. Account No.";

        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            if UserSetup."Main Cashier" then
                VisibleMainCashier := true
            else
                VisibleMainCashier := false;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            //If NOT UserSetup."Main Cashier" then begin        
            GenJournalBatch.Reset();
            GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
            if GenJournalBatch.FindFirst() then
                Rec."Centar za kupce" := GenJournalBatch."Bal. Account No.";

        end;
    end;

    var
        CashReceiptJournal: Page "Cash Receipt Journal";
        GenJournalBatch: Record "Gen. Journal Batch";
        UserSetup: Record "User Setup";
        VisibleMainCashier: Boolean;
        BankAccount: Record "Bank Account";
        BankAccountCard: Page "Bank Account Card";
}

