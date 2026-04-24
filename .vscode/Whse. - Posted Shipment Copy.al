report 50106 "Whse. - Posted Shipment Copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './WhsePostedShipmentCopy.rdl';
    ApplicationArea = Warehouse;
    Caption = 'Warehouse Posted Shipment';
    UsageCategory = Documents;

    dataset
    {
        dataitem("Posted Whse. Shipment Header"; "Posted Whse. Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(User; UserName)
            {

            }
            column(External_Document_No_; "External Document No.") { }
            column(Posting_Date; "Posting Date") { }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column("Responsible_ext_name"; Responsible_ext_name)
                {

                }
                column("Responsible_ext_pos"; Responsible_ext_pos)
                {

                }
                column("Responsible_ext_unit"; Responsible_ext_unit)
                {

                }
                column(CompanyName; COMPANYPROPERTY.DisplayName)
                {
                }
                column(Transferfrom; Location.Name)
                {

                }

                column(DocumentNo; WSH."Document No.")
                {

                }
                column(TodayFormatted; Format(Today))
                {
                }
                column(AssgndUID_PostedWhseShptHeader; "Posted Whse. Shipment Header"."Assigned User ID")
                {
                }
                column(LocCode_PostedWhseShptHeader; "Posted Whse. Shipment Header"."Location Code")
                {
                }

                column(No_PostedWhseShptHeader; "Posted Whse. Shipment Header"."No.")
                {
                }
                column(BinMandatoryShow1; not Location."Bin Mandatory")
                {
                }
                column(BinMandatoryShow2; Location."Bin Mandatory")
                {
                }
                column(AssgndUID_PostedWhseShptHeaderCaption; "Posted Whse. Shipment Header".FieldCaption("Assigned User ID"))
                {
                }
                column(LocCode_PostedWhseShptHeaderCaption; "Posted Whse. Shipment Header".FieldCaption("Location Code"))
                {
                }
                column(No_PostedWhseShptHeaderCaption; "Posted Whse. Shipment Header".FieldCaption("No."))
                {
                }
                column(ShelfNo_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Shelf No."))
                {
                }
                column(ItemNo_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Item No."))
                {
                }
                column(Desc_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption(Description))
                {
                }
                column(UOM_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Unit of Measure Code"))
                {
                }
                column(Qty_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption(Quantity))
                {
                }
                column(SourceNo_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Source No."))
                {
                }
                column(SourceDoc_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Source Document"))
                {
                }
                column(ZoneCode_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Zone Code"))
                {
                }
                column(BinCode_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Bin Code"))
                {
                }
                column(LocCode_PostedWhseShptLineCaption; "Posted Whse. Shipment Line".FieldCaption("Location Code"))
                {
                }
                column(CurrReportPAGENOCaption; CurrReportPAGENOCaptionLbl)
                {
                }
                column(WarehousePostedShipmentCaption; WarehousePostedShipmentCaptionLbl)
                {
                }
                dataitem("Posted Whse. Shipment Line"; "Posted Whse. Shipment Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Posted Whse. Shipment Header";
                    DataItemTableView = SORTING("No.", "Line No.");
                    column(ShelfNo_PostedWhseShptLine; "Shelf No.")
                    {
                    }
                    column(ItemNo_PostedWhseShptLine; "Item No.")
                    {
                    }
                    column(Desc_PostedWhseShptLine; Description)
                    {
                    }
                    column(UOM_PostedWhseShptLine; "Unit of Measure Code")
                    {
                    }
                    column(LocCode_PostedWhseShptLine; "Location Code")
                    {
                    }
                    column(Qty_PostedWhseShptLine; Quantity)
                    {
                    }

                    column(SourceNo_PostedWhseShptLine; "Source No.")
                    {
                    }
                    column(SourceDoc_PostedWhseShptLine; "Source Document")
                    {
                    }
                    column(ZoneCode_PostedWhseShptLine; "Zone Code")
                    {
                    }
                    column(BinCode_PostedWhseShptLine; "Bin Code")
                    {
                    }
                    column(SerialNumbersText; SerialNumbersText) { }

                    //R
                    // dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
                    // {
                    ////                        column(Vendor_Shipment_No_; "Vendor Shipment No.") { }
                    //}
                    //

                    trigger OnAfterGetRecord()
                    var
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        SerialNumbersText := '';
                        ItemLedgerEntry.SetFilter("Item No.", '%1', "Posted Whse. Shipment Line"."Item No.");
                        ItemLedgerEntry.SetFilter("Order No.", '%1', "Posted Whse. Shipment Line"."Source No.");
                        ItemLedgerEntry.SetFilter(Positive, '%1', true);
                        ItemLedgerEntry.SetFilter("SKLOT No.", '%1', "Posted Whse. Shipment Line"."No.");
                        if ItemLedgerEntry.FindSet() then
                            repeat
                                if SerialNumbersText <> '' then
                                    SerialNumbersText += ', ';
                                SerialNumbersText += ItemLedgerEntry."Serial No.";
                            until ItemLedgerEntry.Next() = 0;

                        GetLocation("Location Code");
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                User.reset();
                user.SetFilter("User Name", '%1', UserId);
                if User.FindFirst() then begin
                    UserName := User."Full Name";
                end;

                Location.reset();
                Location.SetFilter("Code", '%1', "Posted Whse. Shipment Header"."Location Code");
                ;
                if Location.FindFirst() then begin
                    Responsible_ext_name := location."Responsible Person Exit Name";
                    Responsible_ext_pos := Location."Responsible Person E Position";
                    Responsible_ext_unit := Location."Responsible Person Exit Unit";
                end;

                GetLocation("Location Code");

                WRH.Reset();
                WRH.SetFilter("No.", '%1', "No.");
                WRH.SetFilter("Location Code", '%1', "Location Code");
                if FindFirst() then begin
                    VendorShipmentNo := WRH."Vendor Shipment No.";
                end;
            end;
        }
    }

    requestpage
    {
        Caption = 'Warehouse Posted Shipment';

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        UserName: Text[150];
        User: Record User;
        Responsible_ext_name: Text[150];
        Responsible_ext_pos: Text[150];
        Responsible_ext_unit: Text[150];


        Location: Record Location;
        CurrReportPAGENOCaptionLbl: Label 'Page';
        WarehousePostedShipmentCaptionLbl: Label 'Warehouse Posted Shipment';
        WRH: Record "Warehouse Receipt Header";
        WSH: Record "Warehouse Shipment Header";
        VendorShipmentNo: Code[35];
        DocumentNo: Code[20];
        SerialNumbersText: Text;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;
}

