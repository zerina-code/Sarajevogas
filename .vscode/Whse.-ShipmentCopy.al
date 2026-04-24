report 50109 "Whse. - Shipment Copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './WhseShipmentCopy.rdl';
    ApplicationArea = Warehouse;
    Caption = 'Warehouse Shipment';
    UsageCategory = Documents;

    dataset
    {
        dataitem("Warehouse Shipment Header"; "Warehouse Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(User; UserName)
            {

            }
            column(HeaderNo_WhseShptHeader; "No.")
            {
            }
            column(Employee_Name; "Employee Name") { }
            column("Responsible_ext_name"; location."Responsible Person Exit Name")
            {

            }
            column("Responsible_ext_pos"; location."Responsible Person E Position")
            {

            }
            column("Responsible_ext_unit"; location."Responsible Person Exit Unit")
            {

            }
            column("DestinationTest"; location.Name)
            {

            }
            column(External_Document_No_; "External Document No.") { }

            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyName; COMPANYPROPERTY.DisplayName)
                {
                }
                column(TodayFormatted; Format(Today))
                {
                }
                column(AssUid__WhseShptHeader; "Warehouse Shipment Header"."Assigned User ID")
                {
                    IncludeCaption = true;
                }
                column(HrdLocCode_WhseShptHeader; "Warehouse Shipment Header"."Location Code")
                {
                    IncludeCaption = true;
                }
                column(HeaderNo1_WhseShptHeader; "Warehouse Shipment Header"."No.")
                {
                    IncludeCaption = true;
                }

                column(Show1; not Location."Bin Mandatory")
                {
                }
                column(Show2; Location."Bin Mandatory")
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(WarehouseShipmentCaption; WarehouseShipmentCaptionLbl)
                {
                }
                column(Order_Date; "Warehouse Shipment Header"."Order Date")
                {

                }

                dataitem("Warehouse Shipment Line"; "Warehouse Shipment Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Shipment Header";
                    DataItemTableView = SORTING("No.", "Line No.");
                    column(ShelfNo_WhseShptLine; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }
                    column(ItemNo_WhseShptLine; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(DocumentNo; "Warehouse Shipment Header"."Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(VrstaTroska; VrstaTroska) { }
                    column(BrojNaloga; BrojNaloga) { }
                    column(AdresaKupca; AdresaKupca) { }
                    column(Desc_WhseShptLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(UomCode_WhseShptLine; "Unit of Measure Code")
                    {
                        IncludeCaption = true;
                    }
                    column(LocCode_WhseShptLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Qty_WhseShptLine; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(SourceNo_WhseShptLine; "Source No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SourceDoc_WhseShptLine; "Source Document")
                    {
                        IncludeCaption = true;
                    }
                    column(ZoneCode_WhseShptLine; "Zone Code")
                    {
                        IncludeCaption = true;
                    }
                    column(BinCode_WhseShptLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(SerialNumbersText; SerialNumbersText) { }

                    trigger OnAfterGetRecord()
                    var
                        ReservationEntry: Record "Reservation Entry";
                    begin

                        if "Sales Header No." <> '' then begin
                            ServiceHeader.Reset();
                            ServiceHeader.SetFilter("No.", '%1', "Sales Header No.");
                            if ServiceHeader.FindFirst() then begin
                                VrstaTroska := format(ServiceHeader."RN Source");
                                BrojNaloga := ServiceHeader."No.";
                                ServiceLiine.Reset();
                                ServiceLiine.SetFilter("Document No.", '%1', ServiceHeader."No.");
                                if ServiceLiine.FindFirst() then begin
                                    AdresaKupca := ServiceLiine.Address;
                                end;

                            end
                            else begin
                                ServiceHeaderInovice.Reset();
                                ServiceHeaderInovice.SetFilter("No.", '%1', "Sales Header No.");
                                if ServiceHeaderInovice.FindFirst() then begin

                                    VrstaTroska := format(ServiceHeaderInovice."RN Source");
                                    BrojNaloga := ServiceHeaderInovice."No.";
                                    AdresaKupca := ServiceHeaderInovice.Address;

                                end
                                else begin
                                    ServiceHeaderInovice.Reset();
                                    ServiceHeaderInovice.SetFilter("Order No.", '%1', "Sales Header No.");
                                    if ServiceHeaderInovice.FindFirst() then begin

                                        VrstaTroska := format(ServiceHeaderInovice."RN Source");
                                        BrojNaloga := ServiceHeaderInovice."No.";
                                        AdresaKupca := ServiceHeaderInovice.Address;
                                    end;
                                end;
                            end;

                        end;
                        SerialNumbersText := '';
                        ReservationEntry.SetFilter("Item No.", '%1', "Warehouse Shipment Line"."Item No.");
                        ReservationEntry.SetFilter("Source ID", '%1', "Warehouse Shipment Line"."Source No.");
                        ReservationEntry.SetFilter(Positive, '%1', true);
                        if ReservationEntry.FindSet() then
                            repeat
                                if SerialNumbersText <> '' then
                                    SerialNumbersText += ', ';
                                SerialNumbersText += ReservationEntry."Serial No.";
                            until ReservationEntry.Next() = 0;

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
                Location.SetFilter("Responsible Person Exit Name", '%1', "Warehouse Shipment Header"."Responsible Person Exit Name");
                Location.SetFilter("Responsible Person E Position", '%1', "Warehouse Shipment Header"."Responsible Person E Position");
                Location.SetFilter("Responsible Person Exit Unit", '%1', "Warehouse Shipment Header"."Responsible Person Exit Unit");
                if Location.FindFirst() then begin
                    if "Location Code" = "Warehouse Shipment Line"."Location Code" then begin
                        "Responsible Person Exit Name" := location."Responsible Person Exit Name";
                        "Responsible Person E Position" := Location."Responsible Person E Position";
                        "Responsible Person Exit Unit" := Location."Responsible Person Exit Unit";

                    end;
                end;

                GetLocation("Location Code");
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
        Location: Record Location;
        CurrReportPageNoCaptionLbl: Label 'Page';
        WarehouseShipmentCaptionLbl: Label 'Skladišna otpremnica';
        SerialNumbersText: Text;
        VrstaTroska: Text;
        ServiceLiine: Record "Service Item Line";
        ServiceLineInvoice: Record "Service Invoice Line";
        BrojNaloga: Text;

        AdresaKupca: Text;
        ServiceHeader: Record "Service Header";
        ServiceHeaderInovice: Record "Service Invoice Header";

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;
}

