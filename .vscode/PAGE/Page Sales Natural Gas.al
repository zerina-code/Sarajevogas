page 50171 "Sales Natural Gas Activity"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Payroll Cue";
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }
            cuegroup(Information3)
            {
                Caption = 'Customer by Category';

                field(CustomerAll; CustomerAll)
                {
                    ApplicationArea = all;

                    Caption = 'Customer - All';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;
                }
                field(CustomerAllActive; CustomerAllActive)
                {
                    ApplicationArea = all;

                    Caption = 'Customer - All';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();

                        Cust.SetFilter("Customer Status", '%1', Cust."Customer Status"::Active);
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;
                }

                field(HouseHold; HouseHold)
                {
                    ApplicationArea = all;

                    Caption = 'Customer - Household';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        cust.SetFilter("Customer Category", '%1', Cust."Customer Category"::Household);
                        Cust.SetFilter("Customer Status", '%1', Cust."Customer Status"::Active);
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;
                }

                field(Large; Large)
                {
                    ApplicationArea = all;
                    Caption = 'Customer - Large Economy';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        cust.SetFilter("Customer Category", '%1', Cust."Customer Category"::"Large Economy");
                        Cust.SetFilter("Customer Status", '%1', Cust."Customer Status"::Active);
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;


                }

                field(Small; Small)
                {
                    ApplicationArea = all;

                    Caption = 'Customer - Small Economy';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        cust.SetFilter("Customer Category", '%1', Cust."Customer Category"::"Small Economy");
                        Cust.SetFilter("Customer Status", '%1', Cust."Customer Status"::Active);
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;

                }


                field(KJKP_Heating_plant; KJKP_Heating_plant)
                {
                    ApplicationArea = all;

                    Caption = 'Customer - KJKP Heating plant';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        cust.SetFilter("Customer Category", '%1', Cust."Customer Category"::"KJKP Heating plant");
                        Cust.SetFilter("Customer Status", '%1', Cust."Customer Status"::Active);
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;

                }
                field(Special; Special)
                {
                    ApplicationArea = all;
                    Caption = 'Customer - Special Customer';
                    trigger OnDrillDown()
                    var

                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        cust.SetFilter("Customer Category", '%1', Cust."Customer Category"::"Special Customer");
                        Cust.SetFilter("Customer Status", '%1', Cust."Customer Status"::Active);
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;
                }

                field(CNG; CNG)
                {
                    ApplicationArea = all;
                    Caption = 'Customer - CNG';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Customer List";
                        Cust: Record Customer;
                    begin
                        Cust.Reset();
                        cust.SetFilter("Customer Category", '%1', Cust."Customer Category"::CNG);
                        Cust.SetFilter("Customer Status", '%1', Cust."Customer Status"::Active);
                        CustomerList.SetTableView(Cust);
                        CustomerList.Run();


                    end;
                }
            }
            /* 
            
            

        }

        cuegroup(Information)
        {
            Caption = 'Customer by Status';
            field("Customers - all"; "Customers - all") { ApplicationArea = all; Visible = false; }
            field("Customers - Active"; "Customers - Active")
            {
                ApplicationArea = all;

            }
            field("Customers - Potential"; "Customers - Potential")
            { ApplicationArea = all; }
            field("Customers - Terminated"; "Customers - Terminated") { ApplicationArea = all; }

        }
        ///DJEMINA HIDE
*/
            cuegroup(Information2)
            {
                Caption = 'Measuring point';
                field(MM_All; MM_All)
                {
                    ApplicationArea = all;
                    Caption = 'MM_All';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Service Item List";
                        Cust: Record "Service Item";
                    begin

                        CustomerList.Run();


                    end;

                }
                field(MM_Active; MM_Active)
                {
                    ApplicationArea = all;
                    Caption = 'MM Active';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Service Item List";
                        Cust: Record "Service Item";
                    begin
                        cust.Reset();
                        cust.SetFilter("Status MM", '%1', cust."Status MM"::Active);
                        CustomerList.SetTableView(cust);
                        CustomerList.Run();


                    end;

                }
                field(MM_PR; MM_PR)
                {
                    ApplicationArea = all;
                    Caption = 'MM_Pr';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Service Item List";
                        Cust: Record "Service Item";
                    begin
                        cust.Reset();
                        cust.SetFilter("Status MM", '%1', cust."Status MM"::"Permanently deregistered");
                        CustomerList.SetTableView(cust);
                        CustomerList.Run();


                    end;
                }
                field(MM_TR; MM_TR)
                {
                    ApplicationArea = all;
                    Caption = 'MM_TR';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomerList: page "Service Item List";
                        Cust: Record "Service Item";
                    begin
                        cust.Reset();
                        cust.SetFilter("Status MM", '%1', cust."Status MM"::"Temporarily deregistered");
                        CustomerList.SetTableView(cust);
                        CustomerList.Run();


                    end;
                }

            }
            cuegroup(Calculation)
            {
                Caption = 'Calculation';
                field("Calculation Header - Open"; "Calculation Header - Open") { ApplicationArea = all; }
                field("Calculation Header - Locked"; "Calculation Header - Locked") { ApplicationArea = all; }

            }

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var
        Customer: Record Customer;
        CompanyInf: Record "User Setup";

    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
        // CompanyInf.get(UserId);
        CompanyInf.Reset();
        CompanyInf.SetFilter("Show Sales Natural", '%1', true);
        if CompanyInf.FindFirst() then begin
            Small := CompanyInf."Small Economy";
            Large := CompanyInf."Large Economy";
            HouseHold := CompanyInf.Household;
            KJKP_Heating_plant := CompanyInf."KJKP Heating plant";
            CNG := CompanyInf.CNG;
            Special := CompanyInf."Special Customer";
            CustomerAll := CompanyInf."All Customer";
            CustomerAllActive := Small + Large + HouseHold + KJKP_Heating_plant + CNG + Special;
            MM_Active := CompanyInf."MM Active";
            MM_All := CompanyInf."MM all";
            MM_PR := CompanyInf."MM PR";
            MM_TR := CompanyInf."MM TR";
        end;





        /* Customer.Reset();
         Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Small Economy");
         Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
         if Customer.FindFirst() then
             Small := Customer.count
         else
             Small := 0;
         Customer.Reset();
         Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Large Economy");
         Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
         if Customer.FindFirst() then
             Large := Customer.count
         else
             Large := 0;

         Customer.Reset();
         Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::Household);
         Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
         if Customer.FindFirst() then
             HouseHold := Customer.count
         else
             HouseHold := 0;
        */
        /*
                Customer.Reset();
                Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Small Economy");
                Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                if Customer.FindFirst() then
                    Small := Customer.count
                else
                    Small := 0;

                Customer.Reset();
                Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Large Economy");
                Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                if Customer.FindFirst() then
                    Large := Customer.count
                else
                    Large := 0;
                Customer.Reset();
                Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::Household);
                Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                if Customer.FindFirst() then
                    HouseHold := Customer.count
                else
                    HouseHold := 0;

                Customer.Reset();
                Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"KJKP Heating plant");
                Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                if Customer.FindFirst() then
                    KJKP_Heating_plant := Customer.count
                else
                    KJKP_Heating_plant := 0;
                Customer.Reset();
                Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::CNG);
                Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                if Customer.FindFirst() then
                    CNG := Customer.count
                else
                    CNG := 0;
                Customer.Reset();
                Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Special Customer");
                Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                if Customer.FindFirst() then
                    Special := Customer.count
                else
                    Special := 0;


        */

        // SETFILTER("Due Date Filter",'<=%1',WORKDATE);
        //SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        // SETFILTER("User ID Filter",USERID);
        // SETRANGE(DateFilter5,CALCDATE('-'+ FORMAT(HRSetup."New employee period"),TODAY),TODAY);
        /*  ThisMonthFirst := CALCDATE('-SM;', WORKDATE);
          ThisMonthLast := CALCDATE('SM', ThisMonthFirst);
          NextMonthFirst := CALCDATE('+1D', ThisMonthLast);
          NextMonthLast := CALCDATE('SM', NextMonthFirst);
          DBThisMonthLast := CALCDATE('SM-1D', ThisMonthFirst);
          DBThisMonthFirst := CALCDATE('-SM-1D;', WORKDATE);
          //SETRANGE(DateFilter6,ThisMonthFirst,ThisMonthLast);
          SETRANGE(DateFilter7, ThisMonthFirst, DBThisMonthLast);
          //SETRANGE(DateFilter8,01011980D,DBThisMonthFirst);
          SETRANGE(DateFilter9, CALCDATE('+1D;', ThisMonthFirst), ThisMonthLast);
          SETRANGE(DateFilterChange, ThisMonthFirst, ThisMonthLast);*/
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        Customer: Record Customer;
        CompanyInf: Record "User Setup";
    begin

        //  CompanyInf.get(UserId);
        CompanyInf.Reset();
        CompanyInf.SetFilter("Show Sales Natural", '%1', true);
        if CompanyInf.FindFirst() then begin
            Small := CompanyInf."Small Economy";
            Large := CompanyInf."Large Economy";
            HouseHold := CompanyInf.Household;
            KJKP_Heating_plant := CompanyInf."KJKP Heating plant";
            CNG := CompanyInf.CNG;
            Special := CompanyInf."Special Customer";
            CustomerAll := CompanyInf."All Customer";
            CustomerAllActive := Small + Large + HouseHold + KJKP_Heating_plant + CNG + Special;
            MM_Active := CompanyInf."MM Active";
            MM_All := CompanyInf."MM all";
            MM_PR := CompanyInf."MM PR";
            MM_TR := CompanyInf."MM TR";
        end;
        /*   Customer.Reset();
           Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Small Economy");
           Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
           if Customer.FindFirst() then
               Small := Customer.count
           else
               Small := 0;

           Customer.Reset();
           Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Large Economy");
           Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
           if Customer.FindFirst() then
               Large := Customer.count
           else
               Large := 0;
           Customer.Reset();
           Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::Household);
           Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
           if Customer.FindFirst() then
               HouseHold := Customer.count
           else
               HouseHold := 0;

           Customer.Reset();
           Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"KJKP Heating plant");
           Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
           if Customer.FindFirst() then
               KJKP_Heating_plant := Customer.count
           else
               KJKP_Heating_plant := 0;
           Customer.Reset();
           Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::CNG);
           Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
           if Customer.FindFirst() then
               CNG := Customer.count
           else
               CNG := 0;
           Customer.Reset();
           Customer.SetFilter("Customer Category", '%1', Customer."Customer Category"::"Special Customer");
           Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
           if Customer.FindFirst() then
               Special := Customer.count
           else
               Special := 0;*/

    end;

    var
        Small: Integer;
        Large: Integer;
        CustomerAll: Integer;
        CustomerAllActive: Integer;
        HouseHold: Integer;
        CNG: Integer;
        Special: Integer;
        KJKP_Heating_plant: Integer;


        MM_All: Integer;
        MM_Active: Integer;

        MM_PR: Integer;

        MM_TR: Integer;







}

