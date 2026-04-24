pageextension 50017 BookkeeperActivities extends "Bookkeeper Activities"
{
    layout
    {
        // Add changes to page layout here
        modify("My User Tasks")
        {
            Visible = false;
            //LL
        }


        addafter("Approved Purchase Orders")
        {
            field("Opened Purchase Orders"; "Opened Purchase Orders")
            {
                ApplicationArea = all;
                DrillDownPageId = "Purchase Order List";
            }
            field("Opened Purchase Invoices"; "Opened Purchase Invoices")
            {
                ApplicationArea = all;
                DrillDownPageId = "Purchase Invoices";
            }
            field("Commercial Approve"; "Commercial Approve")
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
                    PurchaseHeaderTable.SETFILTER(Commercial, '%1', true);
                    PuchaseOrderPage.SETTABLEVIEW(PurchaseHeaderTable);
                    PuchaseOrderPage.RUN;
                    CurrPage.UPDATE(true);
                end;
            }

        }




        addafter(Receivables)
        {
            cuegroup("Posting groups not entered")
            {
                Caption = 'Posting groups not entered';

                field("Entry Not  Finished - Items"; "Entry Not  Finished - Items")
                {
                    ApplicationArea = all;
                }
                field("Entry Not  Finished - Vendors"; "Entry Not  Finished - Vendors")
                {
                    ApplicationArea = all;
                }
                field("Entry Not  Finished Customers"; "Entry Not  Finished Customers")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Posting groups not entered")
        {
            cuegroup("Fixed Asset Cue")
            {
                Caption = 'Fixed Asset';
                field("Fixed Asset"; "Fixed Asset")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("Fixed Asset Cue")
        {
            cuegroup("SmallInventory")
            {
                Caption = 'Small Inventory';
                field("Small Inventory"; "Small Inventory")
                {
                    ApplicationArea = all;
                }
            }
        }
        addafter("SmallInventory")
        {
            cuegroup("Approvals2")
            {
                Caption = 'Approvals';

                field("Requests to Approve2"; "Requests to Approve2")
                {
                    DrillDownPageID = "Requests to Approve";
                }

                field("Requests Sent for Approval2"; "Requests Sent for Approval2")
                {
                    DrillDownPageID = "Approval Entries";
                }
            }
        }
        addafter(Approvals2)
        {
            cuegroup(Reminders)
            {
                Caption = 'Reminders';
                field("New Reminders"; "New Reminders")
                {
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetRange("Document Date", Today - 10, Today);
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
            }
            cuegroup(Inventory)
            {
                Caption = 'Inventory';
                field("Inventory Group 1"; "Inventory Group 1")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup1;
                }
                field("Inventory Group 2"; "Inventory Group 2")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup2;
                }
                field("Inventory Group 3"; "Inventory Group 3")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup3;
                }
                field("Inventory Group 4"; "Inventory Group 4")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup4;
                }
                field("Inventory Group 5"; "Inventory Group 5")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup5;
                }
                field("Inventory Group 6"; "Inventory Group 6")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup6;
                }
                field("Inventory Group 7"; "Inventory Group 7")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup7;
                }
                field("Inventory Group 8"; "Inventory Group 8")
                {
                    DrillDownPageId = "Posted Whse. Shipment List";
                    CaptionClass = '1,5,,' + InventoryGroup8;
                }
            }

        }
    }

    actions
    {
        addafter("New Sales Credit Memo")
        {
            action("AgingReport")
            {
                ApplicationArea = All;
                Caption = '30-60-90';


                trigger OnAction()
                begin

                    agingReport.Run();

                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        GS: Record "General Ledger Setup";
        InventoryGroup: Record "Inventory Posting Group";
        BrojI: Integer;
        Filters: text;
    begin
        GS.Get();
        SetFilter("Code Filter", GS."No. series for S.Inventory");
        SetRange("Date Filter 2", CALCDATE('<-10D>', WorkDate), WorkDate);

        for BrojI := 1 to 8 do begin
            Filters := '';
            InventoryGroup.Reset();
            InventoryGroup.SetFilter(GlAccountNo, '%1', BrojI);
            if InventoryGroup.FindSet() then
                repeat

                    Filters += InventoryGroup.Code + '|';

                until InventoryGroup.Next() = 0;
            if strlen(Filters) > 2 then begin
                Filters := CopyStr(Filters, 1, StrLen(Filters) - 1);
            end;

            if BrojI = 1 then
                SetFilter("GL Account No. 1", Filters);
            if BrojI = 2 then
                SetFilter("GL Account No. 2", Filters);
            if BrojI = 3 then
                SetFilter("GL Account No. 3", Filters);
            if BrojI = 4 then
                SetFilter("GL Account No. 4", Filters);
            if BrojI = 5 then
                SetFilter("GL Account No. 5", Filters);
            if BrojI = 6 then
                SetFilter("GL Account No. 6", Filters);

            if BrojI = 7 then
                SetFilter("GL Account No. 7", Filters);
            if BrojI = 8 then
                SetFilter("GL Account No. 8", Filters);
            SetName();


        end;



    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        GS: Record "General Ledger Setup";
        InventoryGroup: Record "Inventory Posting Group";
        BrojI: Integer;
        Filters: text;
    begin
        GS.Get();
        SetFilter("Code Filter", GS."No. series for S.Inventory");

        for BrojI := 1 to 8 do begin
            Filters := '';
            InventoryGroup.Reset();
            InventoryGroup.SetFilter(GlAccountNo, '%1', BrojI);
            if InventoryGroup.FindSet() then
                repeat

                    Filters += InventoryGroup.Code + '|';
                until InventoryGroup.Next() = 0;
            if strlen(Filters) > 2 then begin
                Filters := CopyStr(Filters, 1, StrLen(Filters) - 1);
            end;
            if BrojI = 1 then
                SetFilter("GL Account No. 1", Filters);
            if BrojI = 2 then
                SetFilter("GL Account No. 2", Filters);
            if BrojI = 3 then
                SetFilter("GL Account No. 3", Filters);
            if BrojI = 4 then
                SetFilter("GL Account No. 4", Filters);
            if BrojI = 5 then
                SetFilter("GL Account No. 5", Filters);

            if BrojI = 6 then
                SetFilter("GL Account No. 6", Filters);

            if BrojI = 7 then
                SetFilter("GL Account No. 7", Filters);

            if BrojI = 8 then
                SetFilter("GL Account No. 8", Filters);

        end;

        SetName();

    end;

    local procedure SetName()

    var
        InventoryGroup: Record "Inventory Posting Group";
        BrojI: Integer;
        Filters: text;

    begin
        Clear(InventoryGroup1);
        Clear(InventoryGroup2);
        Clear(InventoryGroup3);
        Clear(InventoryGroup4);
        Clear(InventoryGroup5);
        Clear(InventoryGroup6);
        Clear(InventoryGroup7);
        Clear(InventoryGroup8);

        for BrojI := 1 to 8 do begin
            Filters := '';
            InventoryGroup.Reset();
            InventoryGroup.SetFilter(GlAccountNo, '%1', BrojI);
            if InventoryGroup.FindSet() then
                repeat

                    Filters += InventoryGroup.Code + '|';
                until InventoryGroup.Next() = 0;
            if strlen(Filters) > 2 then begin
                Filters := CopyStr(Filters, 1, StrLen(Filters) - 1);
            end;
            if BrojI = 1 then
                InventoryGroup1 := Filters;
            if BrojI = 2 then
                InventoryGroup2 := Filters;
            if BrojI = 3 then
                InventoryGroup3 := Filters;
            if BrojI = 4 then
                InventoryGroup4 := Filters;
            if BrojI = 5 then
                InventoryGroup5 := Filters;
            if BrojI = 6 then
                InventoryGroup6 := Filters;
            if BrojI = 7 then
                InventoryGroup7 := Filters;
            if BrojI = 8 then
                InventoryGroup8 := Filters;

            CurrPage.Update();


        end;

    end;

    var
        myInt: Integer;
        agingReport: Report CustomerSummaryAging;
        InventoryGroup1, InventoryGroup2, InventoryGroup3, InventoryGroup4, InventoryGroup5, InventoryGroup6, InventoryGroup7, InventoryGroup8 : text[250];
}