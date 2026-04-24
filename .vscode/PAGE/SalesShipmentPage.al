page 50238 "Posted Sales Shpt. List"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Sales Shipment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Type; Type)
                {
                    ApplicationArea = Advanced;

                }
                field(FilteredTypeField; FormatType)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Type';

                    Visible = IsFoundation;
                }
                field("No."; "No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.") { }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                    ObsoleteReason = 'Cross-Reference replaced by Item Reference feature.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '17.0';
                }
                field("Item Reference No."; "Item Reference No.")
                {
                    ApplicationArea = Basic, Suite;

                    Visible = ItemReferenceVisible;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = Planning;

                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    ApplicationArea = Suite;

                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = Suite;
                    Visible = false;
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                    ApplicationArea = Basic, Suite;
                    BlankZero = true;
                }
                field("Qty. Shipped Not Invoiced"; "Qty. Shipped Not Invoiced")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                    ApplicationArea = OrderPromising;
                    Visible = false;
                }
                field("Planned Delivery Date"; "Planned Delivery Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Planned Shipment Date"; "Planned Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Driver Name"; "Driver Name") { }
                field("Driver Registration No."; "Driver Registration No.") { }
                field("Driver Type"; "Driver Type") { }
                field("Type of vehicle"; "Type of vehicle") { }
                field("Payment Method Code"; "Payment Method Code") { }
                field("Fiscal No."; "Fiscal No.") { ApplicationArea = all; }
                field("Fiscal User"; "Fiscal User") { ApplicationArea = all; Editable = false; }
                field("Fiscal DateTime"; "Fiscal DateTime") { ApplicationArea = all; Editable = false; }
                field("Amount"; "Amount") { ApplicationArea = all; Editable = false; }
                field("Amount Incl. VAT"; "Amount Incl. VAT") { ApplicationArea = all; Editable = false; }
                field("Shipping Time"; "Shipping Time")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = Jobs;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = Jobs;
                    Visible = false;
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Correction; Correction)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = DimVisible1;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = DimVisible2;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible3;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible4;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible5;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible6;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible7;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                    Visible = DimVisible8;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Order Tra&cking")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Order Tra&cking';
                    Image = OrderTracking;

                    trigger OnAction()
                    begin
                        ShowTracking();
                    end;
                }
                action(UndoShipment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Undo Shipment';
                    Image = UndoShipment;

                    trigger OnAction()
                    begin
                        UndoShipmentPosting;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';

                    trigger OnAction()
                    begin
                        ShowDimensions();
                    end;
                }
                action(Comments)
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        ShowLineComments();
                    end;
                }
                action(ItemTrackingEntries)
                {
                    ApplicationArea = ItemTracking;
                    Caption = 'Item &Tracking Entries';
                    Image = ItemTrackingLedger;

                    trigger OnAction()
                    begin
                        ShowItemTrackingLines;
                    end;
                }
                action("Assemble-to-Order")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Assembly;
                    Caption = 'Assemble-to-Order';

                    trigger OnAction()
                    begin
                        ShowAsmToOrder;
                    end;
                }
                action(ItemInvoiceLines)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Invoice &Lines';
                    Image = ItemInvoice;

                    trigger OnAction()
                    begin
                        PageShowItemSalesInvLines;
                    end;
                }
                action(DocumentLineTracking)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Document &Line Tracking';
                    Image = Navigate;

                    trigger OnAction()
                    begin
                        ShowDocumentLineTracking();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInit()
    var
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        IsFoundation := ApplicationAreaMgmtFacade.IsFoundationEnabled;
    end;

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
        SetItemReferenceVisibility();
    end;

    var
        IsFoundation: Boolean;
        [InDataSet]
        ItemReferenceVisible: Boolean;

    protected var
        ShortcutDimCode: array[8] of Code[20];
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;

    local procedure ShowTracking()
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        TrackingForm: Page "Order Tracking";
    begin
        TestField(Type, Type::Item);
        if "Item Shpt. Entry No." <> 0 then begin
            ItemLedgEntry.Get("Item Shpt. Entry No.");
            TrackingForm.SetItemLedgEntry(ItemLedgEntry);
        end else
            TrackingForm.SetMultipleItemLedgEntries(TempItemLedgEntry,
              DATABASE::"Sales Shipment Line", 0, "Document No.", '', 0, "Line No.");

        TrackingForm.RunModal;
    end;

    local procedure UndoShipmentPosting()
    var
        SalesShptLine: Record "Sales Shipment Line";
        IsHandled: Boolean;
    begin
        SalesShptLine.Copy(Rec);
        CurrPage.SetSelectionFilter(SalesShptLine);
        OnBeforeUndoShipmentPosting(SalesShptLine, IsHandled);
        if not IsHandled then
            CODEUNIT.Run(CODEUNIT::"Undo Sales Shipment Line", SalesShptLine);
    end;

    local procedure PageShowItemSalesInvLines()
    begin
        TestField(Type, Type::Item);
        ShowItemSalesInvLines;
    end;

    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking: Page "Document Line Tracking";
    begin
        Clear(DocumentLineTracking);
        DocumentLineTracking.SetDoc(
          4, "Document No.", "Line No.", "Blanket Order No.", "Blanket Order Line No.", "Order No.", "Order Line No.");
        DocumentLineTracking.RunModal;
    end;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);
    end;

    local procedure SetItemReferenceVisibility()
    var
        ItemReferenceMgt: Codeunit "Item Reference Management";
    begin
        ItemReferenceVisible := ItemReferenceMgt.IsEnabled();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUndoShipmentPosting(SalesShipmentLine: Record "Sales Shipment Line"; var IsHandled: Boolean)
    begin
    end;
}

