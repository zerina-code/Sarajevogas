page 50205 "Items Open Orders"
{
    //ED

    Caption = 'Items Open Orders';
    PageType = List;
    SourceTable = "Purchase Line";
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        PurchaseOrder: Page "Purchase Order";
                    begin
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetFilter("No.", '%1', Rec."Document No.");
                        if PurchaseHeader.FindFirst() then begin
                            PurchaseOrder.SetTableView(PurchaseHeader);
                            PurchaseOrder.Run();
                        end;
                    end;
                }
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    begin
                        VendorTable.Reset();
                        VendorTable.SetFilter("No.", '%1', "Buy-from Vendor No.");
                        if VendorTable.FindFirst() then begin
                            VendorCard.SetTableView(VendorTable);
                            VendorCard.Run();
                        end;
                    end;
                }
                field("Contract No."; "Contract No.")
                {
                    ApplicationArea = all;
                }
                field("Contract Entry No."; "Contract Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Contract Purchase Item"; "Contract Purchase Item")
                {
                    ApplicationArea = All;
                }
                field("User ID Number"; "User ID Number")
                {
                    ApplicationArea = All;
                }
                field("Cost Type"; "Cost Type")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        /*UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            ItemSubgroupTable.Reset();
            ItemSubgroupTable.SetFilter("Code Category Text", '%1', UserSetup."Code Category Text");
            ItemSubgroupPage.SetTableView(ItemSubgroupTable);
            "Code Category Text" := UserSetup."Code Category Text";
        end;*/
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            Rec."Code Category Text" := UserSetup."Code Category Text";
        end;*/
    end;

    var
        UserSetup: Record "User Setup";
        ItemSubgroupTable: Record ItemSubgroup;
        ItemSubgroupPage: Page ItemSubgroup;
        VendorTable: Record Vendor;
        VendorCard: page "Vendor Card";
}

