page 50170 "Sales Natural GAS"
{
    Caption = 'Sales Agent for Natural GAS', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Payrollgreeting")
            {
                ApplicationArea = all;
                Visible = true;

            }
            part("Sales Natural Gas Activity"; "Sales Natural Gas Activity")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        area(Processing)
        {

            //"Calculation Setup"
            action(Setup)
            {

                Caption = 'Calculation Setup';
                Image = Calculate;
                ApplicationArea = all;
                RunObject = Page "Calculation Setup";

            }
            //50009

            action(ImportXML)
            {

                Caption = 'Import XML';
                Image = Calculate;
                ApplicationArea = all;
                Visible = true;
                RunObject = xmlport "Update Installation History";

            }
            //"Customer Import"

            action(ImportXML2)
            {

                Caption = 'Import XML2';
                Image = Calculate;
                ApplicationArea = all;
                Visible = true;
                RunObject = xmlport "Update Gauge";

            }


            action(Calculation)
            {

                Caption = 'Calculation';
                Image = Calculate;
                ApplicationArea = all;
                RunObject = Page "Calculation Step 1";


            }
            action(Entries)
            {

                Caption = 'Entries';
                Image = Entries;
                ApplicationArea = all;
                RunObject = Page "Calculation Entries";





            }

            action(EntriesByBilling)
            {

                Caption = 'Entries';
                Image = Entries;
                ApplicationArea = all;
                RunObject = Page "Calculation List";
                RunPageLink = Locked = filter(true);





            }

        }
        area(embedding)
        {
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Service Items")
            {
                ApplicationArea = Service;
                Caption = 'Service Items';
                Image = ServiceItem;
                RunObject = Page "Service Item List";
                ToolTip = 'View the list of service items.';
            }

            action("Gauge")
            {
                ApplicationArea = Service;
                Caption = 'Gauges';
                Image = ServiceItem;
                RunObject = Page "Installation History Page";
                RunPageLink = Type = filter(Gauge), Active = filter(true);

            }

            action("RN by Address")
            {
                ApplicationArea = Service;
                Caption = 'Requests';
                Image = List;
                Promoted = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "List RN by address";



                //  RunPageMode = Create;
            }
            action("Corrector")
            {
                ApplicationArea = Service;
                Caption = 'Corrector';
                Image = ServiceItem;
                RunObject = Page "Installation History Page";
                RunPageLink = Type = filter(Corrector), Active = filter(True);

            }
            action("RadioModule")
            {
                ApplicationArea = Service;
                Caption = 'Corrector';
                Image = ServiceItem;
                RunObject = Page "Installation History Page";
                RunPageLink = Type = filter(Radio_Module), Active = filter(True);

            }

            action("Service Header")
            {
                ApplicationArea = Service;
                Caption = 'Service Header';
                Image = ViewServiceOrder;
                RunObject = Page "Service Orders";
                RunPageLink = "Request Type" = filter("Billing Invoice");

            }
            action("Posted Service Header")
            {
                ApplicationArea = Service;
                Caption = 'Posted Service Header';
                Image = PostedServiceOrder;
                RunObject = Page "Posted Service Invoices";
                RunPageLink = "Request Type" = filter("Billing Invoice");

            }

            action(TransferOrders)
            {
                ApplicationArea = Service;
                Caption = 'Transfer Orders';
                RunObject = page "Transfer Orders";
            }

            action(EmployeeAbsence)
            {
                ApplicationArea = Service;
                Caption = 'Employee Absence';
                RunObject = page "Employee Absence";
            }
        }

    }
}


