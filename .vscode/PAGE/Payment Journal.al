pageextension 50119 "Payment Journal" extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here



        modify("External Document No.")
        {
            Visible = PaymentVisible;
        }
        modify("Recipient Bank Account") { Visible = PaymentVisible; }

        addafter("Applies-to Ext. Doc. No.") { field("Bill type"; "Bill type") { } }


        modify("Payment Reference") { Visible = PaymentVisible; }
        modify("Creditor No.") { Visible = false; }
        modify("Debit Amount") { Visible = PaymentVisible; }
        modify("Credit Amount") { Visible = PaymentVisible; }
        modify("Amount (LCY)") { Visible = PaymentVisible; }
        modify("Applied (Yes/No)") { Visible = PaymentVisible; }
        modify("Applies-to Doc. Type") { Visible = PaymentVisible; }
        modify("Applies-to Ext. Doc. No.") { Visible = PaymentVisible; }

        modify("Applies-to ID") { Visible = PaymentVisible; }
        modify("Bank Payment Type") { Visible = false; }
        modify("Exported to Payment File") { Visible = false; }
        modify(TotalExportedAmount) { Visible = false; }
        modify("Payment File Errors") { Visible = false; }


        addafter(Correction)
        {
            field(Prepayment; Prepayment) { ApplicationArea = all; }
        }

        moveafter(Description; "Message to Recipient")
        addbefore(Amount)
        {
            field("Posting Group"; "Posting Group") { ApplicationArea = all; Editable = true; }
        }

        addafter("Account No.")
        {
            field(Employee; Employee) { ApplicationArea = all; Visible = PaymentVisible; }
            field(Contact; Contact) { ApplicationArea = all; Visible = PaymentVisible; }
        }
        addafter(Correction) { field("Court Boolean"; "Court Boolean") { Visible = PaymentVisible; } }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Reconcile)
        {
            action("Import Bank Statement")
            {
                ApplicationArea = all;
                Caption = 'Import Bank Statement';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Import Bank Statement for selected journal batch.';

                trigger OnAction()
                var
                    BS: Report "Bank Statement Tab";
                    GBN: Record "Gen. Journal Batch";
                begin
                    GBN.Reset();
                    GBN.SetFilter(Name, '%1', Rec."Journal Batch Name");
                    GBN.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    if GBN.FindFirst() then begin

                        if GBN.TAB = GBN.TAB::TAB then
                            BS.SetParam(Rec."Journal Batch Name", Rec."Journal Template Name", true)
                        else
                            BS.SetParam(Rec."Journal Batch Name", Rec."Journal Template Name", false);
                    end
                    else begin
                        BS.SetParam(Rec."Journal Batch Name", Rec."Journal Template Name", false);
                    end;
                    BS.Run();



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


        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        GenJo.Reset();
        GenJo.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GenJo.SetFilter(Name, '%1', rec."Journal Batch Name");
        if GenJo.FindFirst() then begin
            if GenJo."Payment to Employees" = True then
                PaymentVisible := false
            else
                PaymentVisible := True;
        end;

    end;


    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        GenJo.Reset();
        GenJo.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GenJo.SetFilter(Name, '%1', rec."Journal Batch Name");
        if GenJo.FindFirst() then begin
            if GenJo."Payment to Employees" = True then
                PaymentVisible := false
            else
                PaymentVisible := True;
        end;

    end;


    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        GenJo.Reset();
        GenJo.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GenJo.SetFilter(Name, '%1', rec."Journal Batch Name");
        if GenJo.FindFirst() then begin
            if GenJo."Payment to Employees" = True then
                PaymentVisible := false
            else
                PaymentVisible := True;
        end;

    end;

    var
        myInt: Integer;
        GenJo: Record "Gen. Journal Batch";
        PaymentVisible: Boolean;
        RekapitulacijaUplataIsplata: report "Recapitulation GenJournal";
}