pageextension 50022 "G/L Account Card" extends "G/L Account Card"
{
    layout
    {
        // Add changes to page layout here
        modify("Account Category")
        { Visible = false; }
        modify(SubCategoryDescription)
        { Visible = false; }
        modify("No. of Blank Lines")
        { Visible = false; }
        modify("Reconciliation Account")
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Omit Default Descr. in Jnl.")
        { Visible = false; }
        modify("Tax Group Code")
        { Visible = false; }
        modify("Default IC Partner G/L Acc. No")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        { Visible = false; }
        modify(Consolidation) { Visible = false; }
        modify("Cost Accounting")
        { Visible = false; }
    }

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
        }
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}