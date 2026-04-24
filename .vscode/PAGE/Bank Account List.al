pageextension 50014 "Bank Account List" extends "Bank Account List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(List)
        {
            action(List1)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedOnly = true;
                RunObject = Report "Cash Book";
                ToolTip = 'View a list of general information about bank accounts, such as posting group, currency code, minimum balance, and balance.';
            }
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        UserSetup: Record "User Setup";

    trigger OnOpenPage()
    var
        myInt: Integer;
        GenJournalBatch: Record "Gen. Journal Batch";


    begin

        //Bank Account List
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            //If NOT UserSetup."Main Cashier" then begin        
            GenJournalBatch.Reset();
            GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
            if GenJournalBatch.FindFirst() then
                SETFILTER("No.", '%1', GenJournalBatch."Bal. Account No.");
        end;


    end;
}