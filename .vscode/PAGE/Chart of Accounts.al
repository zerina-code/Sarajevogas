pageextension 50023 MyExtensionChart extends "Chart of Accounts"
{
    layout
    {
        // Add changes to page layout here
        addafter(Balance)
        {
            field("Budgeted Amount"; "Budgeted Amount")
            {
                ApplicationArea = All;
            }
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Cost Type No.")
        {
            Visible = false;
        }

        moveafter(Name; "Account Type")
    }

    actions
    {
        modify("Close Income Statement") { Visible = false; }
        addafter("General Journal")
        {
            action("Close Income Statement-new")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Income Statement - new';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report CloseIncomeStatement;
                ToolTip = 'Start the transfer of the year''s result to an account in the balance sheet and close the income statement accounts.';
            }
        }
        addafter(IndentChartOfAccounts)
        {
            action("Ažuriraj zaokruživanja na kontima materijalnog")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Ažuriraj zaokruživanja na kontima materijalnog';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Adjust GL Entries";

            }
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
                    GLAcc.SetFilter("No.", '%1|%2', '5*', '6*');
                    if GLAcc.FindFirst() then
                        repeat
                            GLAcc."Income/Balance" := GLAcc."Income/Balance"::"Income Statement";
                            GLAcc.Modify();
                        until GLAcc.Next() = 0;
                end;
            }
        }

        addafter("Ažuriraj zaokruživanja na kontima materijalnog")
        {
            action("Zbroj")
            {
                Image = Lock;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin

                    ZB.RUN;
                END;
            }
        }
        modify("Trial Balance by Period")
        {
            Promoted = true;
            PromotedCategory = "Report";
            PromotedOnly = true;
            //Promoted = false;
        }
        modify("Trial Balance")
        {
            Promoted = true;
            PromotedCategory = "Report";
            PromotedOnly = true;
        }
        modify("Detail Trial Balance")
        {
            Promoted = true;
            PromotedCategory = "Report";
            PromotedOnly = true;
        }
        modify(Action1900210206)
        {
            Promoted = true;
            PromotedCategory = "Report";
            PromotedOnly = true;
        }
        addafter("G/L Register")
        {
            action("Dimensions2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Dimensions';
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page Dimensions;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SETFILTER("No.", '<>%1', 'VB');
    end;

    var
        myInt: Integer;
        //  AZ: Report "GLAcc update";
        ZB: XmlPort "AccUpdate";
}
