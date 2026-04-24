page 50034 "CNG Role Centar"
{
    Caption = 'CNG Role Centar', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
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
            part("CNG Role Activities"; "CNG Role Activities")
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {
        area(Reporting)
        {
            action("Inventory-Transaction Detail")
            {
                ApplicationArea = Suite;
                Caption = 'Inventory - Transaction Detail';
                Image = "Report";
                RunObject = Report "Inventory - Transaction Card";
            }
            action("CNG report")
            {
                ApplicationArea = Suite;
                Caption = 'Registration number CNG';
                Image = "Report";
                RunObject = Report RegistrationNumberCNG;

            }
            action("CNG summary")
            {
                ApplicationArea = Suite;
                Caption = 'CNG Summary';
                Image = "Report";
                RunObject = Report "CNG summary";

            }
            action("Purchase VAT book")
            {
                ApplicationArea = Suite;
                Caption = 'Purchase VAT book';
                Image = "Report";
                RunObject = Report "Sales VAT Book";
            }
            action("Trade Book")
            {
                ApplicationArea = Suite;
                Caption = 'Trade book';
                Image = "Report";
                RunObject = Report "TK";
            }

            action(CustomerDetalTrailBal)
            {
                ApplicationArea = Suite;
                Caption = 'Trade book';
                Image = "Report";
                RunObject = Report CustomerDetalTrailBal;
            }
            action(IOS)
            {
                ApplicationArea = Suite;
                Caption = 'CustomerBalancetoDate';
                Image = "Report";
                RunObject = Report CustomerBalancetoDate;
            }
            action(GroupCalculation)
            {
                ApplicationArea = Suite;
                Caption = 'Group Calculation';
                Image = "Report";
                RunObject = Report "Group Retail Calculation";
            }
            action(GroupCalculationVP)
            {
                ApplicationArea = Suite;
                Caption = 'Group Calculation VP';
                Image = "Report";
                RunObject = Report "GroupRetailCalculationVP";
            }
            action(GroupTransfer)
            {
                ApplicationArea = Suite;
                Caption = 'Group Transfer';
                Image = "Report";
                RunObject = Report "Group Transfer";
            }
            action(DailySales)
            {
                ApplicationArea = Suite;
                Caption = 'CNG Daily Sales';
                Image = "Report";
                RunObject = Report "CNG Daily sales";
            }
            action(Listoofchanges)
            {
                ApplicationArea = Suite;
                Caption = 'Zbirni pregled fakturisanih i neplaćenih vrijednosti';
                Image = "Report";
                RunObject = Report listofchanges;
            }

            action(Plans)
            {
                ApplicationArea = Suite;
                Caption = 'Planovi potrošnje';
                Image = CapacityJournal;
                RunObject = Page Areas;
            }


            action(Shipments)
            {
                ApplicationArea = Suite;
                Caption = 'Otpreme';
                Image = Shipment;
                RunObject = Page "Posted Sales Shpt. List";
            }

            action(TransferOrders)
            {
                ApplicationArea = Suite;
                Caption = 'Transfer Orders';
                Image = TransferOrder;
                RunObject = Page "Transfer Orders";
            }

            action(EmployeeAbsence)
            {
                ApplicationArea = Suite;
                Caption = 'Employee Absence';
                Image = TransferOrder;
                RunObject = page "Employee Absence";
            }

        }


        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View posted invoices and credit memos, and analyze G/L registers.';
                action("Posted Sales Shipments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page "Posted Sales Shipments";
                    ToolTip = 'Open the list of posted sales shipments.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }

                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }



            }

        }

    }



    var
        CngUser: boolean;
        UserSetup: Record "User Setup";

}


