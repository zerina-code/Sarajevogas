pageextension 50067 "Purchase Activities Extends" extends "Purchase Agent Activities"
{
    layout
    {

        addafter("Pre-arrival Follow-up on Purchase Orders")
        {

            cuegroup(AllVendors)

            {
                Caption = 'All Vendors';

                field(Vendors; Vendors)
                {
                    ApplicationArea = all;
                }
                field(NotBlocked; NotBlocked)
                {
                    ApplicationArea = all;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter(AllVendors)
        {
            cuegroup(AllItems)
            {
                Caption = 'Artikli';

                field(Items; Items)
                {
                    ApplicationArea = all;
                    Caption = 'Svi artikli';
                }
                field(AvailableItems; AvailableItems)
                {
                    ApplicationArea = all;
                }
                field(NotAvailableItems; NotAvailableItems)
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter(AllItems)
        {

            cuegroup(AllResources)
            {
                Caption = 'Usluge';

                field(Resources; Resources)
                {
                    ApplicationArea = all;
                }
            }
            cuegroup(Sales)
            {
                Caption = 'Sales CZK';
                field(ServiceOrders; ServiceOrders)
                //da mogu filtrirati narudžbenice po artiklima
                {
                    Caption = 'ServiceOrders';
                    Visible = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        EmployeeContractLedger.Reset();
                        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                        EmployeeContractLedger.SetFilter(Active, '%1', true);
                        if EmployeeContractLedger.FindFirst() then begin
                            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                                Manag := true
                            else
                                Manag := false;
                        end;
                        Emp_2 := UseriD_Rec."Employee No. for Wage";
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', 0);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            ServiceOrders := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        EmployeeContractLedger.Reset();
                        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                        EmployeeContractLedger.SetFilter(Active, '%1', true);
                        if EmployeeContractLedger.FindFirst() then begin
                            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                                Manag := true
                            else
                                Manag := false;
                        end;
                        Emp_2 := UseriD_Rec."Employee No. for Wage";
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', 0);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            ServiceOrders := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }
                field("Sales Orders - Open"; "Sales Orders - Open")
                {
                    DrillDownPageId = "Sales Order List";
                    LookupPageId = "Sales Order List";


                }

                field(BrojOther2; BrojOther2)
                {
                    ApplicationArea = all;
                    Caption = 'BrojOther';
                    DrillDownPageID = "Requests";
                    Visible = CZKPurchaseAgent;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        EmployeeContractLedger.Reset();
                        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                        EmployeeContractLedger.SetFilter(Active, '%1', true);
                        if EmployeeContractLedger.FindFirst() then begin
                            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                                Manag := true
                            else
                                Manag := false;
                        end;
                        Emp_2 := UseriD_Rec."Employee No. for Wage";
                        sh.Reset();
                        // sh.SetFilter("Request Type", '%1', 0);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojOther2 := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        EmployeeContractLedger.Reset();
                        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                        EmployeeContractLedger.SetFilter(Active, '%1', true);
                        if EmployeeContractLedger.FindFirst() then begin
                            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                                Manag := true
                            else
                                Manag := false;
                        end;
                        Emp_2 := UseriD_Rec."Employee No. for Wage";
                        sh.Reset();
                        //sh.SetFilter("Request Type", '%1', 0);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojOther2 := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }


            }
        }
        addafter(AllResources)
        {
            cuegroup("Inbound - Today")
            {
                Caption = 'Inbound - Today';
                field("Posted Receipts - Today"; "Posted Receipts - Today")
                {
                    ApplicationArea = all;
                    DrillDownPageID = "Posted Whse. Receipt List";
                    ToolTip = 'Specifies the number of posted receipts. The documents are filtered by today''s date.';
                }
            }
            cuegroup(AllFixedAssets)
            {
                Caption = 'Osnovna sredstva';

                field(FixedAssets; FixedAssets)
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter(AllFixedAssets)
        {
            cuegroup(PurchaseOrders)
            {
                Caption = 'Narudžbenice';

                field(OpenOrders; OpenOrders)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseHeaderTable: Record "Purchase Header";
                        PurchaseDocStatusEnum: Enum "Purchase Document Status";
                        PuchaseOrderPage: Page "Purchase Order List";


                    begin

                        PurchaseHeaderTable.RESET;
                        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::Order);
                        PurchaseHeaderTable.SETFILTER("Status", '%1', PurchaseDocStatusEnum::Open);
                        PurchaseHeaderTable.SETFILTER("Responsibility Center", '%1', "Responsibility Center Filter");
                        PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PuchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }


                field(ItemsOpenOrders; ItemsOpenOrdersEL)
                //da mogu filtrirati narudžbenice po artiklima
                {
                    Caption = 'Otvoreno po artiklima';
                    Visible = false;
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseLineTable: Record "Purchase Line";
                        PurchaseDocStatusEnum: Enum "Purchase Document Status";
                        ItemsOpenOrders: Page "Items Open Orders";
                    begin
                        PurchaseLineTable.RESET;
                        PurchaseLineTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::Order);
                        ItemsOpenOrders.SetTableView(PurchaseLineTable);
                        ItemsOpenOrders.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }
                field(ReleasedOrders; ReleasedOrders)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseHeaderTable: Record "Purchase Header";
                        PurchaseDocStatusEnum: Enum "Purchase Document Status";
                        PuchaseOrderPage: Page "Purchase Order List";

                    begin

                        PurchaseHeaderTable.RESET;
                        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::Order);
                        PurchaseHeaderTable.SETFILTER("Status", '%1', PurchaseDocStatusEnum::Released);
                        PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PuchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }
                field(CommercialApproval; CommercialApproval)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseHeaderTable: Record "Purchase Header";

                        //PurchaseDocComm: Boolean "Commercial"; 

                        PuchaseOrderPage: Page "Purchase Order List";

                    begin

                        PurchaseHeaderTable.RESET;
                        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::Order);
                        PurchaseHeaderTable.SETFILTER(Commercial, '%1', false);
                        PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PuchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }
                /*field(AccountingApproval; AccountingApproval)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseHeaderTable: Record "Purchase Header";
                        PuchaseOrderPage: Page "Purchase Order List";

                    begin

                        PurchaseHeaderTable.RESET;
                        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::Order);
                        PurchaseHeaderTable.SetFilter(Accounting, '%1', false);
                        PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PuchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }*/
                field("Posted Purchase Invoices"; "Posted Purchase Invoices")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        //PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseInvHeadTable: Record "Purch. Inv. Header";
                        //PurchaseDocStatusEnum: Enum "Purchase Document Status";
                        PostedPurchaseInvoices: Page "Posted Purchase Invoices";


                    begin

                        PurchaseInvHeadTable.RESET;
                        //PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::Order);
                        PurchaseInvHeadTable.SETFILTER("Responsibility Center", '%1', "Responsibility Center Filter");
                        // PurchaseInvHeadTable.SETFILTER("Status", '%1', PurchaseDocStatusEnum::Released);
                        //PurchaseHeaderTable.SETFILTER(Commercial, '%1', true);
                        //PurchaseHeaderTable.SETFILTER(Finance, '%1', true);

                        PostedPurchaseInvoices.SETTABLEVIEW(PurchaseInvHeadTable);
                        PostedPurchaseInvoices.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }
                field("Received in WHSE"; Rec."Received in WHSE")
                {
                    ApplicationArea = all;
                    Caption = 'Received in WHSE';
                    Editable = false;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        PurchaseHeaderTable: Record "Purchase Header";
                        PurchaseOrderPage: Page "Purchase Order List";
                    begin
                        PurchaseHeaderTable.RESET();
                        PurchaseHeaderTable.SetFilter("Purchase Line - Received", '>%1', 0);
                        PurchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PurchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }
                field("Canceled Whse Receipts"; Rec."Canceled Whse Receipts")
                {
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        PurchaseRcptHeader: Record "Purch. Rcpt. Header";
                        PostedPurchaseReceipts: Page "Posted Purchase Receipts";
                    begin
                        PurchaseRcptHeader.Reset();
                        PurchaseRcptHeader.SetFilter(Correction, '%1', true);
                        PostedPurchaseReceipts.SetTableView(PurchaseRcptHeader);
                        PostedPurchaseReceipts.Run();
                        CurrPage.Update(true);
                    end;
                }
            }
        }
        addafter(PurchaseOrders)
        {
            cuegroup(ReturnOrders)
            {
                Caption = 'Nalozi za povrat';

                field("Purchase Return Orders - All3"; "Purchase Return Orders - All")
                { //DŽ
                    ApplicationArea = all;
                    Caption = 'Svi nalozi za povrat';
                    Editable = true;
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseHeaderTable: Record "Purchase Header";
                        PuchaseOrderPage: Page "Purchase Return Order List";

                    begin

                        PurchaseHeaderTable.RESET;
                        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::"Return Order");
                        PurchaseHeaderTable.SETFILTER("Responsibility Center", '%1', "Responsibility Center Filter");
                        PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PuchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }
                field("Purchase Return Orders - Open"; "Purchase Return Orders - Open")
                {
                    //DŽ

                    ApplicationArea = all;
                    Caption = 'Otvoreno';
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseHeaderTable: Record "Purchase Header";
                        PurchaseDocStatusEnum: Enum "Purchase Document Status";
                        PuchaseOrderPage: Page "Purchase Return Order List";

                    begin

                        PurchaseHeaderTable.RESET;
                        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::"Return Order");
                        PurchaseHeaderTable.SETFILTER("Status", '%1', PurchaseDocStatusEnum::Open);
                        PurchaseHeaderTable.SETFILTER("Responsibility Center", '%1', "Responsibility Center Filter");
                        PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PuchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;
                }
                field("Purchase Return Orders - Released"; "Purchase Return Orders - R")
                {
                    //DŽ
                    ApplicationArea = all;
                    Caption = 'Lansirano';
                    trigger OnDrillDown()
                    var
                        PurchaseDocTypeEnum: Enum "Purchase Document Type";
                        PurchaseHeaderTable: Record "Purchase Header";
                        PurchaseDocStatusEnum: Enum "Purchase Document Status";
                        PuchaseOrderPage: Page "Purchase Return Order List";

                    begin

                        PurchaseHeaderTable.RESET;
                        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseDocTypeEnum::"Return Order");
                        PurchaseHeaderTable.SETFILTER("Status", '%1', PurchaseDocStatusEnum::Released);
                        PurchaseHeaderTable.SETFILTER("Responsibility Center", '%1', "Responsibility Center Filter");
                        PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                        PuchaseOrderPage.RUN;
                        CurrPage.UPDATE(true);

                    end;
                }

            }
        }

        modify("Post Arrival Follow-up") { Visible = false; }
        modify("Pre-arrival Follow-up on Purchase Orders") { Visible = false; }
        modify("Purchase Orders - Authorize for Payment") { Visible = false; }

        /*modify("Post Arrival Follow-up")
        {
            Visible = false;
        }
        addafter("Pre-arrival Follow-up on Purchase Orders")
        {
            cuegroup("test")
            {
                Caption = 'test';
                field("Outstanding Purchase Orders2"; "Outstanding Purchase Orders2")
                {
                    ApplicationArea = all;
                }
                field("Purchase Return Orders - All2"; "Purchase Return Orders - All2")
                {
                }
            }
        }*/
    }

    actions
    {
        // Add changes to page actions here;
    }
    trigger OnOpenPage()
    var
        PurchaseHeaderTable: Record "Purchase Header";
        sh: Record "Service Header";
    begin

        USetup.reset;
        USetup.SetFilter("User ID", '%1', UserId);
        if USetup.findfirst then begin
            if USetup."Visible Request" = true then begin
                CZKPurchaseAgent := true;
            end
            else begin
                CZKPurchaseAgent := FalsE;

            end;
        end;


        PurchaseHeader.Reset();
        PurchaseHeader.SetFilter("Document Type", '%1', PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SetFilter(Status, '%1', PurchaseHeader.Status::Open);
        ItemsOpenOrdersEL := PurchaseHeader.Count;

        //za hrpicu Zaprimljeno u skladištu:
        PurchaseHeaderTable.RESET;
        PurchaseHeaderTable.SetFilter("Purchase Line - Received", '>%1', 0);
        Received := PurchaseHeaderTable.Count;

        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        Manag := false;

        UseriD_REc.Get(UseriD);
        EmployeeContractLedger.Reset();
        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
        EmployeeContractLedger.SetFilter(Active, '%1', true);
        if EmployeeContractLedger.FindFirst() then begin
            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                Manag := true
            else
                Manag := false;
        end;
        Emp_2 := UseriD_Rec."Employee No. for Wage";
        sh.Reset();
        sh.SetFilter("Request Type", '%1', 0);
        if (DepartmentCode <> '') and (CZKUser = true) then begin


            sh.SetFilter("Request Department", DepartmentCode);
            ServiceOrders := sh.Count;

        end;


    end;

    trigger OnAfterGetRecord()
    var
        PurchaseHeaderTable: Record "Purchase Header";
        sh: Record "Service Header";
    begin
        USetup.reset;
        USetup.SetFilter("User ID", '%1', UserId);
        if USetup.findfirst then begin
            if USetup."Visible Request" = true then begin
                CZKPurchaseAgent := true;
            end
            else begin
                CZKPurchaseAgent := FalsE;

            end;
        end;
        PurchaseHeaderTable.RESET;
        PurchaseHeaderTable.SETFILTER("Document Type", '%1', PurchaseHeaderTable."Document Type"::Order);
        //   PurchaseHeaderTable.SETFILTER("Status", '%1', PurchaseDocStatusEnum::Released);
        //    PurchaseHeaderTable.SETFILTER("Responsibility Center", '%1', "Responsibility Center Filter");
        PurchaseHeaderTable.SetFilter("Purchase Line - Received", '>%1', 0);
        PurchaseHeaderTable.SETFILTER("Status", '%1', PurchaseHeaderTable.Status::Released);
        Received := PurchaseHeaderTable.Count;
        PurchaseHeader.SetFilter("Document Type", '%1', PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SetFilter(Status, '%1', PurchaseHeader.Status::Open);
        ItemsOpenOrdersEL := PurchaseHeader.Count;
        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        Manag := false;

        UseriD_REc.Get(UseriD);
        EmployeeContractLedger.Reset();
        EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
        EmployeeContractLedger.SetFilter(Active, '%1', true);
        if EmployeeContractLedger.FindFirst() then begin
            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                Manag := true
            else
                Manag := false;
        end;
        Emp_2 := UseriD_Rec."Employee No. for Wage";
        sh.Reset();
        sh.SetFilter("Request Type", '%1', 0);
        if (DepartmentCode <> '') and (CZKUser = true) then begin


            sh.SetFilter("Request Department", DepartmentCode);
            ServiceOrders := sh.Count;

        end;

    end;

    procedure GetDefaultResponsibleDepartment(var DeparmentCode: Code[20]; var CZKUser: Boolean; Manag: Boolean; Emp_bezt: Code[20])
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        US: Record "User Personalization";
        EmployeeContractLedger: Record "Employee Contract Ledger";
    begin
        Employee.SetAutoCalcFields("Department Code");
        Employee.SetLoadFields("Department Code");


        if not UserSetup.Get(UserId) then
            exit;
        if not Employee.Get(UserSetup."Employee No. for Wage") then
            exit;

        DeparmentCode := Employee."Department Code";
        CZKUser := UserSetup."CZK User";
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Profile ID" = 'CZK' then
                CZKUser := true
            else
                CZKUser := false;

        end;

        Manag := false;



        EmployeeContractLedger.Reset();
        EmployeeContractLedger.SetFilter("Employee No.", '%1', Employee."No.");
        EmployeeContractLedger.SetFilter(Active, '%1', true);
        if EmployeeContractLedger.FindFirst() then begin
            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                Manag := true
            else
                Manag := false;
        end;
        Emp_bezt := Employee."No.";



    end;


    var
        myInt: Integer;
        ItemsOpenOrdersEL: Integer;
        PurchaseHeader: Record "Purchase Header";
        Received: Decimal;
        ServiceOrders: Integer;
        DepartmentCode: Code[20];
        CZKUser: Boolean;
        Manag: Boolean;
        Emp_2: Code[20];
        UseriD_REc: Record "User Setup";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        BrojOther2: integer;
        USetup: record "User Setup";
        CZKPurchaseAgent: Boolean;


}