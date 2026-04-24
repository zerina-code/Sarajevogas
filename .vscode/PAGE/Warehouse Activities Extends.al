pageextension 50107 "Warehouse Activities Extends" extends "Warehouse Worker Activities"
{
    layout
    {
        modify("Unassigned Picks") { Visible = false; }
        modify("My Picks") { Visible = false; }

        addafter("Unassigned Picks")
        {
            /*cuegroup(OutbondToday)
            {
                Caption = 'Outbond Today';*/

            field(SalesHeaderReleased; LansNalPro)
            {
                ApplicationArea = all;
                Caption = 'Sales Header Released';


                trigger OnDrillDown()
                var
                    SalesHeader: Record "Transfer Header";
                    SalesOrderList: Page "Transfer Orders";
                begin
                    SalesHeader.Reset();
                    //SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
                    SalesHeader.SetFilter(Status, '%1', SalesHeader.Status::Open);
                    SalesHeader.SetFilter("Shipment Date", '%1', FilterDate);
                    SalesOrderList.SetTableView(SalesHeader);
                    SalesOrderList.Run();
                    CurrPage.Update(true);
                end;
            }
            field(ShipmentHeader; Otpdanas)
            {
                ApplicationArea = all;
                Caption = 'Shipment Header';

                trigger OnDrillDown()
                var
                    ShipmentHeader: Record "Warehouse Shipment Header";
                    ShipmentList: Page "Warehouse Shipment List";
                begin
                    ShipmentHeader.Reset();
                    ShipmentHeader.SetFilter("Shipment Date", '%1', FilterDate);
                    ShipmentList.SetTableView(ShipmentHeader);
                    ShipmentList.Run();
                    CurrPage.Update(true);
                end;
            }
            field(PostedShipmentHeader; ProknjOtpdanas)
            {
                ApplicationArea = all;
                Caption = 'Posted Shipment Header';

                trigger OnDrillDown()
                var
                    PostedShipmentHeader: Record "Posted Whse. Shipment Header";
                    PostedShipmentList: Page "Posted Whse. Shipment List";
                begin
                    PostedShipmentHeader.Reset();
                    PostedShipmentHeader.SetFilter("Posting Date", '%1', FilterDate);
                    PostedShipmentList.SetTableView(PostedShipmentHeader);
                    PostedShipmentList.Run();
                    CurrPage.Update(true);
                end;
            }
            field(TransferShipmentHeader; ProkPreOtp)
            {
                ApplicationArea = all;
                Caption = 'Posted Transfer Shipment';

                trigger OnDrillDown()
                var
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                    PostedTransfer: Page "Posted Transfer Shipments";
                begin
                    TransferShipmentHeader.Reset();
                    TransferShipmentHeader.SetFilter("Posting Date", '%1', FilterDate);
                    PostedTransfer.SetTableView(TransferShipmentHeader);
                    PostedTransfer.Run();
                    CurrPage.Update(true);
                end;
            }
            //}
        }

        modify("Unassigned Put-aways") { Visible = false; }
        modify("My Put-aways") { Visible = false; }

        addafter("Unassigned Put-aways")
        {
            field(WarehouseReceipts; Dolasci)
            {
                ApplicationArea = all;
                Caption = 'Warehouse Receipts';

                trigger OnDrillDown()
                var
                    WarehouseReceiptHeader: Record "Warehouse Receipt Header";
                    WarehouseReceipts: Page "Warehouse Receipts";
                begin
                    WarehouseReceiptHeader.Reset();
                    WarehouseReceiptHeader.SetFilter("Posting Date", '%1', FilterDate);
                    WarehouseReceipts.SetTableView(WarehouseReceiptHeader);
                    WarehouseReceipts.Run();
                    CurrPage.Update(true);
                end;
            }

            field(PostedWarehouseReceipts; ProknjPrimkeDns)
            {
                ApplicationArea = all;
                Caption = 'Posted Warehouse Receipts';

                trigger OnDrillDown()
                var
                    PostedWarehouseReceiptHeader: Record "Posted Whse. Receipt Header";
                    PostedWarehouseReceipts: Page "Posted Whse. Receipt List";
                begin
                    PostedWarehouseReceiptHeader.Reset();
                    PostedWarehouseReceiptHeader.SetFilter("Posting Date", '%1', FilterDate);
                    PostedWarehouseReceipts.SetTableView(PostedWarehouseReceiptHeader);
                    PostedWarehouseReceipts.Run();
                    CurrPage.Update(true);
                end;
            }
            field(PostedWarehouseReceiptsNew; ProknjNabavnePrimkeDns)
            {
                ApplicationArea = all;
                Caption = 'Posted Warehouse Order Receipts';

                trigger OnDrillDown()
                var
                    PurcReceiptHeader: Record "Purch. Rcpt. Header";
                    PostedPurchaseReceipts: Page "Posted Purchase Receipts";
                begin
                    PurcReceiptHeader.Reset();
                    PurcReceiptHeader.SetFilter("Posting Date", '%1', FilterDate);
                    PostedPurchaseReceipts.SetTableView(PurcReceiptHeader);
                    PostedPurchaseReceipts.Run();
                    CurrPage.Update(true);
                end;

            }
        }

        modify("Unassigned Movements") { Visible = false; }
        //modify("Unassigned Movements") { Visible = false; }

        addafter("Unassigned Movements")
        {
            field(AllMovements; Premjestanja)
            {
                ApplicationArea = all;
                Caption = 'All Movements';

                trigger OnDrillDown()
                var
                    WarehouseActivityHeader: Record "Warehouse Activity Header";
                    WarehouseMovements: Page "Warehouse Movements";
                begin
                    WarehouseActivityHeader.Reset();
                    WarehouseActivityHeader.SetFilter(Type, '%1', WarehouseActivityHeader.Type::Movement);
                    WarehouseMovements.SetTableView(WarehouseActivityHeader);
                    WarehouseMovements.Run();
                    CurrPage.Update(true);
                end;
            }
            field(AllPutAways; SvaSkladistenja)
            {
                ApplicationArea = all;
                Caption = 'Skladištenja - sva';

                trigger OnDrillDown()
                var
                    WarehouseActivityHeader: Record "Warehouse Activity Header";
                    WarehouseMovements: Page "Warehouse Movements";
                begin
                    WarehouseActivityHeader.Reset();
                    WarehouseActivityHeader.SetFilter(Type, '%1', WarehouseActivityHeader.Type::"Put-away");
                    WarehouseMovements.SetTableView(WarehouseActivityHeader);
                    WarehouseMovements.Run();
                    CurrPage.Update(true);
                end;
            }
            field(UnfinishedDoc; DjelZaprimPrimke)
            {
                ApplicationArea = all;
                Caption = 'Djelimično zaprimljene primke';

                trigger OnDrillDown()
                var
                    WarehouseRecEnum: Record "Warehouse Receipt Header";
                    WarehouseRec: Page "Warehouse Receipts";
                begin
                    WarehouseRecEnum.Reset();
                    WarehouseRecEnum.SetFilter("Document Status", '%1', WarehouseRecEnum."Document Status"::"Partially Received");
                    WarehouseRec.SetTableView(WarehouseRecEnum);
                    WarehouseRec.Run();
                    CurrPage.Update(true);
                end;
            }


        }
    }

    actions
    {
        // Add changes to page actions here;
    }

    trigger OnOpenPage()
    begin

        FilterDate := WarehouseShipHeaderCue.TodaysDate(1);

        WarehouseReceiptHeader.Reset();
        WarehouseReceiptHeader.SetFilter("Posting Date", '%1', FilterDate);
        Dolasci := WarehouseReceiptHeader.count;

        TransferShipmentHeader.Reset();
        TransferShipmentHeader.SetFilter("Posting Date", '%1', FilterDate);
        ProkPreOtp := TransferShipmentHeader.count;


        PostedShipmentHeader.Reset();
        PostedShipmentHeader.SetFilter("Posting Date", '%1', FilterDate);
        ProknjOtpdanas := PostedShipmentHeader.count;

        PurcReceiptOrder.Reset();
        PurcReceiptOrder.SetFilter("Posting Date", '%1', FilterDate);
        ProknjNabavnePrimkeDns := PurcReceiptOrder.count;


        SalesHeader.Reset();
        //SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        SalesHeader.SetFilter(Status, '%1', SalesHeader.Status::Open);
        SalesHeader.SetFilter("Shipment Date", '%1', FilterDate);
        LansNalPro := SalesHeader.count;

        ShipmentHeader.Reset();
        ShipmentHeader.SetFilter("Shipment Date", '%1', FilterDate);
        Otpdanas := ShipmentHeader.count;

        PostedWarehouseReceiptHeader.Reset();
        PostedWarehouseReceiptHeader.SetFilter("Posting Date", '%1', FilterDate);
        ProknjPrimkeDns := PostedWarehouseReceiptHeader.count;

        WarehouseActivityHeader.Reset();
        WarehouseActivityHeader.SetFilter(Type, '%1', WarehouseActivityHeader.Type::Movement);
        Premjestanja := WarehouseActivityHeader.count;

        WarehouseRecEnum.Reset();
        WarehouseRecEnum.SetFilter("Document Status", '%1', WarehouseRecEnum."Document Status"::"Partially Received");
        DjelZaprimPrimke := WarehouseRecEnum.count;

        WarehouseActivityHeader.Reset();
        WarehouseActivityHeader.SetFilter(Type, '%1', WarehouseActivityHeader.Type::"Put-away");
        SvaSkladistenja := WarehouseActivityHeader.count;



    end;

    trigger OnAfterGetRecord()
    begin
        WarehouseReceiptHeader.Reset();
        WarehouseReceiptHeader.SetFilter("Posting Date", '%1', FilterDate);
        Dolasci := WarehouseReceiptHeader.count;


        PostedShipmentHeader.Reset();
        PostedShipmentHeader.SetFilter("Posting Date", '%1', FilterDate);
        ProknjOtpdanas := PostedShipmentHeader.count;

        TransferShipmentHeader.Reset();
        TransferShipmentHeader.SetFilter("Posting Date", '%1', FilterDate);
        ProkPreOtp := TransferShipmentHeader.count;


        SalesHeader.Reset();
        //SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::Order);
        SalesHeader.SetFilter(Status, '%1', SalesHeader.Status::Open);
        SalesHeader.SetFilter("Shipment Date", '%1', FilterDate);
        LansNalPro := SalesHeader.count;

        ShipmentHeader.Reset();
        ShipmentHeader.SetFilter("Shipment Date", '%1', FilterDate);
        Otpdanas := ShipmentHeader.count;

        PostedWarehouseReceiptHeader.Reset();
        PostedWarehouseReceiptHeader.SetFilter("Posting Date", '%1', FilterDate);
        ProknjPrimkeDns := PostedWarehouseReceiptHeader.count;

        PurcReceiptOrder.Reset();
        PurcReceiptOrder.SetFilter("Posting Date", '%1', FilterDate);
        ProknjNabavnePrimkeDns := PurcReceiptOrder.count;

        WarehouseActivityHeader.Reset();
        WarehouseActivityHeader.SetFilter(Type, '%1', WarehouseActivityHeader.Type::Movement);
        Premjestanja := WarehouseActivityHeader.count;

        WarehouseRecEnum.Reset();
        WarehouseRecEnum.SetFilter("Document Status", '%1', WarehouseRecEnum."Document Status"::"Partially Received");
        DjelZaprimPrimke := WarehouseRecEnum.count;

        WarehouseActivityHeader.Reset();
        WarehouseActivityHeader.SetFilter(Type, '%1', WarehouseActivityHeader.Type::"Put-away");
        SvaSkladistenja := WarehouseActivityHeader.count;

        FilterDate := WarehouseShipHeaderCue.TodaysDate(1);


    end;

    var
        WarehouseShipHeaderCue: Record "Warehouse Shipment Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        WarehouseRecHeaderCue: Record "Warehouse Receipt Header";
        FilterDate: Date;
        Dolasci: Integer;
        ProknjOtpdanas: Integer;

        ProkPreOtp: Integer;
        LansNalPro: Integer;
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        PostedShipmentHeader: Record "Posted Whse. Shipment Header";

        PurcReceiptOrder: Record "Purch. Rcpt. Header";

        SalesHeader: Record "Transfer Header";
        Otpdanas: Integer;
        ShipmentHeader: Record "Warehouse Shipment Header";
        ProknjPrimkeDns: Integer;
        ProknjNabavnePrimkeDns: Integer;
        PostedWarehouseReceiptHeader: Record "Posted Whse. Receipt Header";
        Premjestanja: Integer;
        WarehouseActivityHeader: Record "Warehouse Activity Header";
        DjelZaprimPrimke: Integer;
        WarehouseRecEnum: Record "Warehouse Receipt Header";
        SvaSkladistenja: Integer;

}