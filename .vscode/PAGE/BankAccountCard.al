pageextension 50015 BankAccountCard extends "Bank Account Card"
{

    //ED

    layout
    {
        /*addafter(Description)
        {
            field("Source No."; "Source No.")
            {
                ApplicationArea = All;
            }
        }*/
        addafter("No.") { field(CZK; CZK) { ApplicationArea = all; } }
        addafter(Name)
        {
            field(Showondocument; Showondocument)
            {
                ApplicationArea = all;

            }
        }

        addafter("Payment Export Format")
        {
            field("Transit G/L account"; "Transit G/L account")
            {
                ApplicationArea = All;
            }
        }
        addafter("Home Page")
        {
            field("Path for fiscal printer"; "Path for fiscal printer") { ApplicationArea = all; }
            field("No. series FIscal No."; "No. series FIscal No.") { ApplicationArea = all; }
            field("No. series R. FIscal No."; "No. series R. FIscal No.") { ApplicationArea = all; }
        }

        modify("No.")
        {
            Visible = true;
            Editable = true;
        }
        addbefore("Bank Acc. Posting Group")
        {
            field("No. series for Payment"; "No. series for Payment")
            {
                ApplicationArea = all;
                Visible = VisibleCZK;
            }
            field("No. series for Payment Card"; "No. series for Payment Card")
            {

                ApplicationArea = all;
                Visible = VisibleCZK;

            }
        }
    }

    actions
    {
        addafter(List)
        {
            action("Izvještaj porto blagajne")
            {
                Caption = 'Izvještaj porto blagajne';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IzvjestajPortoBlagajne.SetParam(1, Rec."No.");
                    IzvjestajPortoBlagajne.Run();
                end;
            }

            action("POS terminali - dnevni izvještaj")
            {
                Caption = 'POS terminali - dnevni izvještaj';
                Image = CreditCard;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IzvjestajPortoBlagajne.SetParam(2, Rec."No.");
                    IzvjestajPortoBlagajne.Run();
                end;
            }

            action("Specifikacija karticnog placanja")
            {
                Caption = 'Specifikacija karticnog placanja';
                Image = CreditCard;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    BankAccount.Reset();
                    BankAccount.SetFilter("No.", '%1', 'CZK*');
                    SpecifikacijaKarticnog.SetTableView(BankAccount);
                    SpecifikacijaKarticnog.Run();
                end;
            }

            action("Izvještaj o prometu na dan")
            {
                Caption = 'Izvještaj o prometu na dan';
                Image = CreditCardLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    GLEntry.SetFilter("Bal. Account No.", '%1', Rec."No.");
                    //GLEntry.SetFilter("Posting Date", '%1', System.Today);

                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin

                        GLEntry.SetFilter("Cashier Code", '%1', UserSetup."Cashier Table"); //filtiram GLEntry i za blagajnika, ne samo za CZK
                    end;

                    "IzvještajOPrometuNaDan".SetTableView(GLEntry);
                    "IzvještajOPrometuNaDan".SetParam(Rec."No.");
                    "IzvještajOPrometuNaDan".Run();
                end;
            }

            action("Rekapitulacija uplata/isplata")
            {
                Caption = 'Rekapitulacija uplata/isplata';
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    /*BankAccount.Reset();
                    BankAccount.SetFilter("No.", '%1', 'CZK*');
                    RekapitulacijaUplataIsplata.SetTableView(BankAccount);*/
                    RekapitulacijaUplataIsplata.Run();
                end;
            }

            action("Cash Diary")
            {
                Caption = 'Cash Diary';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // GLEntry.Reset();
                    //GLEntry.SetFilter("Bal. Account No.", Rec."No.");
                    //BlagajnickiDnevnik.SetTableView(GLEntry);
                    BlagajnickiDnevnik.Run();
                end;
            }
            action("Daily Billing By Centers")
            {
                Caption = 'Daily Billing By Centers';
                Image = BankAccountLedger;
                Tooltip = 'Open the Daily Billing By Centers Report';
                trigger OnAction()
                var
                    GenJournalBatch: Record "Gen. Journal Batch";
                    DailyBillingByCenters: Report "Daily Billing By Centers";
                begin
                    GenJournalBatch.Reset();
                    GenJournalBatch.SetRange("Bal. Account Type", Enum::"Gen. Journal Account Type"::"Bank Account");
                    Report.Run(50135, true, true, GenJournalBatch);
                end;
            }
        }
        modify("Detail Trial Balance")
        {
            Visible = VisibleReport;
        }
        modify("Check Details")
        {
            Visible = VisibleReport;
        }
        modify(Statistics)
        {
            Visible = VisibleReport;
        }
        modify(Dimensions)
        {
            Visible = VisibleReport;
        }
        modify(Statements)
        {
            Visible = VisibleReport;
        }
        modify("Ledger E&ntries")
        {
            Visible = VisibleReport;
        }
        modify("Co&mments")
        {
            Visible = VisibleReport;
        }
        modify("Chec&k Ledger Entries")
        {
            Visible = VisibleReport;
        }
        modify("&Bank Acc.")
        {
            Visible = VisibleReport;
        }
        modify("Receivables-Payables")
        {
            Visible = VisibleReport;
        }
        modify(List)
        {
            Visible = VisibleReport;
        }
        modify("Cash Receipt Journals")
        {
            Visible = VisibleReport;
        }
        modify("Payment Journals")
        {
            Visible = VisibleReport;
        }
        modify("C&ontact")
        {
            Visible = VisibleReport;
        }
        modify(BankAccountReconciliations)
        {
            Visible = VisibleReport;
        }
        modify("Bank Account Balance")
        {
            Visible = VisibleReport;
        }
        modify(Action1906306806)
        {
            Visible = VisibleReport;
        }


    }

    trigger OnOpenPage()
    var
        myInt: Integer;

    begin

        Showondocument := true;
        if StrPos(Rec."No.", 'CZK') <> 0 then
            VisibleCZK := true
        else
            VisibleCZK := false;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            if UserSetup."Main Cashier" then
                VisibleReport := true
            else
                VisibleReport := false;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if StrPos(Rec."No.", 'CZK') <> 0 then
            VisibleCZK := true
        else
            VisibleCZK := false;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            if UserSetup."Main Cashier" then
                VisibleReport := true
            else
                VisibleReport := false;

    end;

    var
        BankAccount: Record "Bank Account";
        GenJournalBatch: Record "Gen. Journal Batch";
        VisibleCZK: Boolean;
        GLEntry: Record "G/L Entry";
        IzvjestajPortoBlagajne: Report Report2Cash;
        BlagajnickiDnevnik: Report "Cash Book";
        SpecifikacijaKarticnog: Report "Card Payment Specification";
        RekapitulacijaUplataIsplata: Report Recapitulation;
        IzvještajOPrometuNaDan: Report "Daily Payment Report";
        UserSetup: Record "User Setup";
        VisibleReport: Boolean;




}