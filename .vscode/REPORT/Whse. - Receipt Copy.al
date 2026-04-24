report 50108 "Whse. - Receipt Copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './WhseReceiptCopy.rdl';
    ApplicationArea = Warehouse;
    Caption = 'Warehouse Receipt Copy';
    UsageCategory = Documents;

    dataset
    {
        dataitem("Warehouse Receipt Header"; "Warehouse Receipt Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(User; UserName)
            {

            }
            column(No_WhseRcptHeader; "No.")
            {
            }
            column(Vendor_Shipment_No_; "Vendor Shipment No.")
            {

            }
            column(VendorNo; "Vendor No.")
            {

            }
            column(Vendor_Name; "Vendor Name")
            {

            }
            column(Vendor_Date; "Vendor Date")
            {

            }
            column(Order_Date; "Posting Date")
            {

            }
            column("DestinationTest"; location.Name)
            {

            }



            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                column(Name; Location.Name)
                {

                }
                column(CompanyName; COMPANYPROPERTY.DisplayName)
                {
                }
                column(TodayFormatted; Format(Today))
                {
                }
                column(LocationCode_WhseRcptHeader; "Warehouse Receipt Header"."Location Code")
                {
                    IncludeCaption = true;
                }
                column(No1_WhseRcptHeader; "Warehouse Receipt Header"."No.")
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
                column(WarehouseReceiptCaption; WarehouseReceiptCaptionLbl)
                {
                }
                column("Responsible"; Location."Responsible Person Name")
                {

                }
                column("ResponsiblePos"; Location."Responsible Person Position")
                {

                }


                dataitem("Warehouse Receipt Line"; "Warehouse Receipt Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Warehouse Receipt Header";
                    DataItemTableView = SORTING("No.", "Line No.");
                    column(ShelfNo_WhseRcptLine; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }
                    column(ItemNo_WhseRcptLine; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_WhseRcptLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(UnitofMeasureCode_WhseRcptLine; "Unit of Measure Code")
                    {
                        IncludeCaption = true;
                    }
                    column(QToReceive; "Qty. to Receive") { }
                    column(LocationCode_WhseRcptLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Quantity_WhseRcptLine; Quantity)
                    {
                        IncludeCaption = true;
                    }

                    column(SourceNo_WhseRcptLine; "Source No.")
                    {
                        IncludeCaption = true;
                    }
                    column(CreateEmployee; CreateEmployee) { }
                    column(BrIzlazaText; BrIzlazaText) { }
                    column(BrojNaloga; BrojNaloga) { }
                    column(SourceDocument_WhseRcptLine; "Source Document")
                    {
                        IncludeCaption = true;
                    }
                    column(ZoneCode_WhseRcptLine; "Zone Code")
                    {
                        IncludeCaption = true;
                    }
                    column(TextPrint; TextPrint) { }
                    column(TextPrint2; TextPrint2) { }
                    column(CreatedBy; CreatedBy) { }
                    column(BinCode_WhseRcptLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(SerialNumbersText; SerialNumbersText) { }

                    trigger OnAfterGetRecord()
                    var
                        ReservationEntry: Record "Reservation Entry";
                        PurchaseIn: Record "Purchase Header";
                        UserS: Record "User Setup";
                        EMp: Record Employee;

                    begin


                        if strpos("Warehouse Receipt Header"."No.", 'POVR') = 0 then begin
                            TextPrint := 'prijema robe';
                            TextPrint2 := 0;
                        end

                        else begin
                            TextPrint := 'povrata';
                            TextPrint2 := 1;

                        end;

                        UserS.reset();
                        UserS.SetFilter("User ID", '%1', SystemCreatedBy);
                        if UserS.FindFirst() then begin
                            EMp.get(UserS."Employee No. for Wage");
                            CreateEmployee := EMp."First Name" + ' ' + EMp."Last Name";
                        end
                        else begin
                            CreateEmployee := '';
                        end;


                        if "Source Document" = "Source Document"::"Purchase Order" then begin
                            PurchaseIn.Reset();
                            PurchaseIn.SetFilter("No.", '%1', "Source No.");
                            if PurchaseIn.FindFirst() then begin

                                UserSetup.Reset();
                                UserSetup.SetFilter("User ID", '%1', PurchaseIn."User ID Number");
                                if UserSetup.FindFirst() then begin
                                    US.Reset();
                                    US.SetFilter("No.", '%1', UserSetup."Employee No. for Wage");
                                    if US.FindFirst() then
                                        CreateEmployee := US."First Name" + ' ' + US."Last Name"
                                    else
                                        CreateEmployee := '';
                                end;

                            end;

                        end;

                        //BrojNaloga

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

                        BrojNaloga := "Sales Header No.";
                        if "Source Document" = "Source Document"::"Inbound Transfer" then begin

                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetFilter("Sales Header No.", '%1', "Warehouse Receipt Line"."Sales Header No.");
                            ItemLedgerEntry.SetFilter("Item No.", '%1', "Warehouse Receipt Line"."Item No.");
                            ItemLedgerEntry.SetFilter("SKLOT No.", '<>%1', '');
                            ItemLedgerEntry.SetCurrentKey("Posting Date");
                            ItemLedgerEntry.Ascending(false);
                            if ItemLedgerEntry.FindFirst() then begin
                                ItemLedgerEntry.CalcFields("SKLOT No.");
                                BrIzlazaText := ItemLedgerEntry."SKLOT No.";
                            end;

                        end;


                        SerialNumbersText := '';
                        ReservationEntry.SetFilter("Item No.", '%1', "Warehouse Receipt Line"."Item No.");
                        ReservationEntry.SetFilter("Source ID", '%1', "Warehouse Receipt Line"."Source No.");
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
                Location.SetFilter("Responsible Person", '%1', "Warehouse Receipt Header"."Responsible Name");
                Location.SetFilter("Responsible Person Position", '%1', "Warehouse Receipt Header"."Responsible Position");
                if Location.FindFirst() then begin
                    if "Location Code" = "Warehouse Receipt Line"."Location Code" then begin
                        "Responsible Name" := location."Responsible Person";
                        "Responsible Position" := Location."Responsible Person Position";

                    end;
                end;

                GetLocation("Location Code");
            end;
        }
    }

    requestpage
    {
        Caption = 'Warehouse Posted Receipt';

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
        contarct: record "Employee Contract Ledger";
        Location: Record Location;
        CreateEmployee: Text;

        ServiceHeader: Record "Service Header";
        ServiceHeaderInovice: Record "Service Invoice Header";
        BrojNaloga: Text;
        VrstaTroska: Text;
        BrIzlazaText: Text;

        CurrReportPageNoCaptionLbl: Label 'Page';
        WarehouseReceiptCaptionLbl: Label 'Warehouse - Receipt';
        VendorShipmentNo: Code[35];
        SerialNumbersText: Text;
        US: Record Employee;
        TextPrint: text;
        UserSetup: Record "User Setup";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ServiceLiine: Record "Service Item Line";
        ServiceLineInvoice: Record "Service Invoice Line";
        TextPrint2: Integer;
        CreatedBy: text;

        AdresaKupca: Text;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;


}

