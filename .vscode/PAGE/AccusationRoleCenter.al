page 50151 "Accusations Role Center"
{

    Caption = 'Accusation Role Centar', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
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
            part("Accusation Role Activities"; "Accusation Role Activities")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(Reporting)
        {

            action(IOS)
            {
                ApplicationArea = Suite;
                Caption = 'CustomerBalancetoDate';
                Image = "Report";
                RunObject = Report CustomerBalancetoDate;
            }

            action(InterestList)
            {
                ApplicationArea = Suite;
                Caption = 'Interest List';
                Image = "Report";
                RunObject = Report AccusationInterestReport;
            }
            action(UnpaidInvoices)
            {
                ApplicationArea = Suite;
                Caption = 'Unpaid Invoices';
                Image = "Report";
                RunObject = report UnpaidInvoices;
            }



        }


    }


    var

}





