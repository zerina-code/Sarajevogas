page 50107 "Cashier Role Center"
{
    Caption = 'Cashier', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; Payrollgreeting)
            {
                ApplicationArea = all;
                Visible = true;
            }
            part("Cashier Activities"; "Cashier Activities")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(reporting)
        {

            action(CashReceiptJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cash Receipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Journal";
            }
            //Payment Journal

            action(PaymentReceiptJournal)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Receipt Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }

        }
    }

    var

}


