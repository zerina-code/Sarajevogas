pageextension 50047 ItemCard extends "Item Card"
{

    //ED

    layout
    {
        addafter("No.")
        {
            field("Old ID"; "Old ID")
            {
                ApplicationArea = all;
            }
        }
        modify("Qty. on Service Order")
        {
            Visible = false;
        }
        addafter("Qty. on Sales Order")
        {
            field("Qty. on Service Order 2"; "Qty. on Service Order 2")
            {
                DrillDownPageId = "Page by Intervention";
                LookupPageId = "Page by Intervention";
            }
        }

        addafter(Inventory)
        {
            field(InventoryGL; InventoryGL)
            {

                ApplicationArea = Basic, Suite;
                Enabled = IsInventoriable;
                HideValue = IsNonInventoriable;
                Importance = Promoted;
                ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';
                //Visible = IsFoundationEnabled;

                /*trigger OnAssistEdit()
                    var
                        AdjustInventory: Page "Adjust Inventory";
                        RecRef: RecordRef;*/
                /*begin
                    RecRef.GetTable(Rec);

                    if RecRef.IsDirty() then begin
                        Modify(true);
                        Commit();
                    end;

                   AdjustInventory.SetItem("No.");
                    if AdjustInventory.RunModal() in [ACTION::LookupOK, ACTION::OK] then
                        Get("No.");
                    CurrPage.Update()
                end;*/
            }
        }
        addafter(GTIN)
        {
            field("Item Subgroup"; "Item Subgroup")
            {
                ApplicationArea = all;
                Editable = false;

            }
            field("Subgroup Description"; "Subgroup Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Item Group"; "Item Group")
            {
                ApplicationArea = all;
                Editable = false;

            }
            field("Group Description"; "Group Description")
            {
                Editable = false;
            }
            field("Category Code"; "Category Code")
            {
                Editable = false;

            }
            field("Category Description"; "Category Description")
            {
                Editable = false;
            }

        }
        modify("No.")
        {
            Visible = true;

            trigger OnAssistEdit()
            begin
                if AssistEdit then
                    CurrPage.Update;
            end;
        }
        modify("Item Category Code")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }
        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Net Weight")
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }
        modify("Unit Volume")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Net Invoiced Qty.")
        {
            Visible = false;
        }
        modify(ForeignTrade)
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Price Includes VAT")
        {
            Visible = false;
        }
        modify("Sales Blocked")
        {
            Visible = false;
        }
        modify("Include Inventory")
        {
            Visible = false;
        }
        modify(Replenishment_Production)
        {
            Visible = false;
        }
        modify("Purchasing Blocked")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        modify("Profit %")
        {
            Visible = false;
        }
        modify("Last Counting Period Update")
        {
            Visible = false;
        }
        modify("Next Counting Start Date")
        {
            Visible = false;
        }
        modify("Next Counting End Date")
        {
            Visible = false;
        }
        modify("Identifier Code")
        {
            Visible = false;
        }
        modify("Use Cross-Docking")
        {
            Visible = false;
        }
        modify(ItemTracking)
        {
            Caption = 'Praćenje artikla';
        }
        modify(Planning)
        {
            Visible = false;
        }
        modify(Replenishment_Assembly)
        {
            Visible = false;
        }
        modify(SpecialPurchPricesAndDiscountsTxt)
        {
            Visible = false;
        }
        modify(SpecialPricesAndDiscountsTxt)
        {
            Visible = false;
        }
        modify("Service Item Group")
        {
            Visible = false;
        }

        addafter("Base Unit of Measure")
        {
            field("Sales Unit of Measure2"; "Sales Unit of Measure") { }
            field("Purch. Unit of Measure2"; "Purch. Unit of Measure") { }

        }
    }

    actions
    {
        modify(PurchPricesandDiscounts)
        {
            Visible = false;
        }
        modify(Sales)
        {
            Visible = false;
        }
        modify(BillOfMaterials)
        {
            Visible = false;
        }
        modify(RequestApproval)
        {
            Visible = false;
        }
        modify("&Phys. Inventory Ledger Entries")
        {
            Visible = false;
        }
        modify("&Reservation Entries")
        {
            Visible = false;
        }
        modify("&Value Entries")
        {
            Visible = false;
        }
        modify("Item &Tracking Entries")
        {
            Visible = false;
        }
        modify("&Warehouse Entries")
        {
            Visible = false;
        }
        modify("Export Item Data")
        {
            Visible = false;
        }
        modify("Cross Re&ferences")
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
        modify(Resources)
        {
            Visible = false;
        }
        modify("&Bin Contents")
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }
        modify(CreateFlow)
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify("Stockkeepin&g Units")
        {
            Visible = false;
        }
        modify("<Action110>")
        {
            Visible = false;
        }
        modify(Variant)
        {
            Visible = false;
        }
        modify("BOM Level")
        {
            Visible = false;
        }
        modify("Unit of Measure")
        {
            Visible = false;
        }
        modify(StatisticsGroup)
        {
            Visible = false;
        }


        //R
        addafter("Item Journal")
        {
            action("Delete Item")
            {
                ApplicationArea = All;
                Caption = 'Delete Item', Comment = 'Obriši Artikle';
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Item: Record Item;
                    ItemUM: Record "Item Unit of Measure";
                begin
                    Item.DELETEALL;
                    ItemUM.DeleteAll();
                end;
            }
        }

        //R - obrada za popunjavanje knjižnih grupa iz brojčane serije na kartice artikala
        addafter("Item Journal")
        {
            action("Obrada - knjižne grupe")
            {
                ApplicationArea = all;
                Caption = 'Obrada - knjižne grupe';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                var
                    NoSeries: Record "No. Series";
                    ItemTable: Record "Item";
                begin
                    NoSeries.Reset();
                    NoSeries.SetFilter("Code Category Text", '%1', 1);
                    if NoSeries.FindFirst() then
                        repeat
                            ItemTable.Reset();
                            ItemTable.SetFilter("Item Subgroup", '%1', NoSeries."Subgroup Code");
                            ItemTable.SetFilter("Item Group", '%1', NoSeries."Group Code");
                            ItemTable.SetFilter("Category Code", '%1', NoSeries."Category Code");
                            if ItemTable.FindFirst() then
                                repeat
                                    ItemTable."VAT Prod. Posting Group" := NoSeries."VAT Prod. Posting Group";
                                    ItemTable."Gen. Prod. Posting Group" := NoSeries."Gen. Prod. Posting Group";
                                    ItemTable."Inventory Posting Group" := NoSeries."Inventory Posting Group";
                                    ItemTable.Modify();
                                until ItemTable.Next() = 0;
                        until NoSeries.Next() = 0;
                end;
                //Import Knjiznih Grupa
            }
            action("Import knjižnih grupa")
            {
                ApplicationArea = all;
                Caption = 'Import knjižnih grupa';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                RunObject = xmlport "Import Knjiznih Grupa";

            }

        }
        addafter("Item Reclassification Journal")
        {
            action("Obrada - obračun troškova") //Mijenja opciju FIFO u Average ali samo na pojedinačnom artiklu
            {
                ApplicationArea = all;
                Caption = 'Obrada - obračun troškova';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                trigger OnAction()
                var
                    ItemTable: Record "Item";
                begin
                    ItemTable.Reset();
                    ItemTable.SetFilter("No.", '<>%1', '');
                    if ItemTable.Findset() then
                        repeat
                            "Costing Method" := "Costing Method"::Average;
                            ItemTable.Modify();
                        // ItemTable.Modify(true);
                        until
                          ItemTable.Next() = 0;

                end;
            }
        }
        //R

        addafter("Obrada - obračun troškova")
        {
            action("Obrada - popunjavanje br. serija")
            {
                ApplicationArea = all;
                Caption = 'Obrada - popunjavanje br serija';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                var
                    NoSeries: Record "No. Series";
                    GenProdPostGr: Text[100];
                    VatProdPostGr: Text[100];
                    InvPostGr: Text[100];
                    ItemTable: Record "Item";
                    NoSeries2: Record "No. Series";
                    NoSeriesLine2: Record "No. Series Line";
                begin

                    NoSeries.Reset();
                    NoSeries.SetFilter("Code", '<>%1', '');
                    if NoSeries.Findfirst() then
                        repeat
                            ItemTable.Reset();
                            ItemTable.SetFilter("Item Subgroup", '%1', NoSeries."Subgroup Code");
                            ItemTable.SetFilter("Item Group", '%1', NoSeries."Group Code");
                            ItemTable.SetFilter("Category Code", '%1', NoSeries."Category Code");

                            if ItemTable.Findlast() then begin
                                NoSeries2.Reset();
                                NoSeries2.SetFilter("Subgroup Code", '%1', ItemTable."Item Subgroup");
                                NoSeries2.SetFilter("Group Code", '%1', ItemTable."Item Group");
                                NoSeries2.SetFilter("Category Code", '%1', ItemTable."Category Code");
                                if NoSeries2.findfirst then begin
                                    NoSeriesLine2.SetFilter("Series Code", '%1', NoSeries2.Code);
                                    IF NoSeriesLine2.findfirst then begin
                                        NoSeriesLine2."Last No. Used" := ItemTable."No.";
                                        NoSeriesLine2.Modify();
                                    end;
                                end;
                            end;
                        until NoSeries.next = 0;
                end;
            }
        }

        /*trigger OnAction()
        var
            ItemTable: Record "Item";
        begin
            ItemTable.Reset();
            if ItemTable.Findset() then
                repeat
                    "Gen. Prod. Posting Group" := 'MATERIJALI';
                    "VAT Prod. Posting Group" := 'PDV17';
                    "Inventory Posting Group" := 'MAT.PRIKLJ';
                    ItemTable.Modify();
                until ItemTable.Next() = 0;
        end;*/


        /* addafter("Obrada - popunjavanje knjižnih grupa")
         {
             action("Import Knjižnih Grupa")
             {
                 ApplicationArea = all;
                 Caption = 'Import knjižnih grupa';
                 Image = PaymentPeriod;
                 Promoted = true;
                 PromotedCategory = Process;
                 Visible = true;
             }
         }*/
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            UserSetup."Code Category Text" := 1;
            UserSetup.Modify();
        end;
        SETRANGE("Date Filter 2", DMY2Date(01, 01, 2025), TODAY);

    end;


    trigger OnClosePage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            UserSetup."Code Category Text" := 0;
            UserSetup.Modify();
        end;
    end;




    var
        UserSetup: Record "User Setup";
        ItemSubgroup: Record ItemSubgroup;
        Itemgroup: Record "Item Group";
        NoSeries: Record "No. Series";

}