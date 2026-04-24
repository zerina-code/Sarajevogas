pageextension 50043 GLAccount extends "G/L Account List"
{
    actions
    {
        addafter("Trial Balance")
        {
            action("Obrada")
            {
                ApplicationArea = all;
                Caption = 'Obrada';
                Image = PaymentPeriod;
                Visible = true;

                trigger OnAction()
                var
                    GLAcc: Record "G/L Account";

                begin
                    GLAcc.Reset();
                    GLAcc.SetFilter("No.", '<>%1', '');
                    if GLAcc.FindFirst() then
                        repeat
                            GLAcc."Income/Balance" := "Income/Balance"::"Balance Sheet";
                            GLAcc.Modify();
                        until GLAcc.Next() = 0;
                end;
            }
            action("Obrada - knjižne grupe")
            {
                ApplicationArea = all;
                Caption = 'Obrada - knjižne grupe';
                Image = PaymentPeriod;
                Visible = true;

                trigger OnAction()
                var
                    GLAcc: Record "G/L Account";

                begin
                    GLAcc.Reset();
                    GLAcc.SetFilter("No.", '%1', '5*');
                    GLAcc.SetFilter("Account Type", '%1', 0);
                    if GLAcc.FindFirst() then
                        repeat
                            GLAcc."Gen. Prod. Posting Group" := 'OSTALO';
                            GLAcc."VAT Prod. Posting Group" := 'PDV17';
                            GLAcc.Modify();
                        until GLAcc.Next() = 0;
                end;
            }

        }
    }

    trigger OnOpenPage() //da bi se na narudžbenici prikazali samo radovi koji su izabrani u opsegu ovog ugovora
    var
        GLAccount: Record "G/L Account";
        Contract: Record "Contract Scope";
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Contract No." <> '' then begin

                Contract.Reset();
                Contract.SetFilter("Contract Entry No.", '%1', UserSetup."Contract No.");

                if Contract.FindSet() then
                    repeat

                        GLAccount.reset;
                        GLAccount.SetFilter("No.", '%1', Contract."G/L Account No.");
                        if GLAccount.FindFirst() then begin
                            GLAccount.Show := true;
                            GLAccount.Modify();

                        end;
                    until Contract.Next() = 0;

                setfilter(Show, '%1', true);

            end;
        end;
    end;

    trigger OnAfterGetRecord()
    begin


    end;



    var
        UserSetup: Record "User Setup";
}