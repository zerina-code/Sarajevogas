page 50035 "CNG Role Activities"
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
            cuegroup(Information)
            {
                Caption = 'Information';
                visible = Not CngUser;

                field("Customer CNG - NP"; "Customer CNG - NP") { }
                field("Customer CNG - Legal Person"; "Customer CNG - Legal Person")
                {

                }
                field("Customer CNG - Own consumption"; "Customer CNG - Own consumption") { }


            }
            cuegroup(ORDERS)
            {
                Caption = 'Orders';
                field("SalesOrdersOpen"; "Sales Orders - Open")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SalesList: Page "Sales Order List";
                    begin
                        SalesList.Run();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SalesList: Page "Sales List";
                    begin
                        SalesList.Run();
                    end;
                }

                field("Petty Cash"; "Petty Cash")
                {
                    ApplicationArea = all;
                }
                field("Sales Credit Memo - Open"; "Sales Credit Memo - Open")
                {
                    ApplicationArea = all;
                    visible = Not CngUser;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SalesList: Page "Sales Credit Memos";
                    begin
                        SalesList.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SalesList: Page "Sales Credit Memos";
                    begin
                        SalesList.Run();

                    end;
                }
                field("Sales Shipment Header"; "Sales Shipment Header") { ApplicationArea = all; visible = Not CngUser; }

            }
            cuegroup(Transfers)
            {
                Caption = 'Transfer';
                visible = Not CngUser;

                field("Transfer Header"; "Transfer Header")
                {
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        TransferOrder: page "Transfer Orders";

                    begin
                        TransferOrder.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        TransferOrder: page "Transfer Orders";
                    begin
                        TransferOrder.Run();

                    end;



                }

                //"Posted Transfer Receipts";

                field("Transfer Receipt Header"; "Transfer Receipt Header")
                {
                    ApplicationArea = all;
                    visible = Not CngUser;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        TransferOrder: page "Posted Transfer Receipts";
                    begin
                        TransferOrder.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        TransferOrder: page "Posted Transfer Receipts";
                    begin
                        TransferOrder.Run();

                    end;
                }
                field("Transfer Shipment Header"; "Transfer Shipment Header")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        TransferOrder: page "Posted Transfer Shipments";
                    begin
                        TransferOrder.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        TransferOrder: page "Posted Transfer Shipments";
                    begin
                        TransferOrder.Run();

                    end;

                }
            }
            cuegroup(Journals)
            {
                Caption = 'Journals';
                visible = Not CngUser;
                field("Revaluation Journal"; "Revaluation Journal")
                {
                    ApplicationArea = all;
                    visible = Not CngUser;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        TransferOrder: page "Revaluation Journal";
                    begin
                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup.Nivelacija := false;
                            UserSetup.Modify();
                        end;
                        TransferOrder.Run();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        TransferOrder: page "Revaluation Journal";
                    begin
                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup.Nivelacija := false;
                            UserSetup.Modify();
                        end;
                        TransferOrder.Run();

                    end;

                }

                field("Nivelacija"; "Revaluation Journal")
                {
                    ApplicationArea = all;
                    visible = Not CngUser;

                    caption = 'Nivelacija';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        TransferOrder: page "Revaluation Journal";
                        IJB: Record "Item Journal Line";

                    begin
                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup.Nivelacija := true;
                            UserSetup.Modify();
                        end;

                        IJB.Reset();
                        IJB.SetFilter(Nivelacija, '%1', true);
                        TransferOrder.SetTableView(IJB);

                        TransferOrder.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        TransferOrder: page "Revaluation Journal";
                        IJB: Record "Item Journal Line";
                    begin

                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup.Nivelacija := false;
                            UserSetup.Modify();
                        end;
                        IJB.Reset();
                        IJB.SetFilter(Nivelacija, '%1', true);
                        TransferOrder.SetTableView(IJB);
                        TransferOrder.Run();

                    end;

                }
            }
            cuegroup(avans)
            {
                Caption = 'Advances';
                visible = Not CngUser;



                field("TestAVANSFIELD"; "TestAVANSFIELD")
                {
                    ApplicationArea = all;

                    //Revaluation Journa

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SalesAdvanceInvoice: page "Sales Advance Invoice";
                    begin
                        SalesAdvanceInvoice.Run();



                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SalesAdvanceInvoice: page "Sales Advance Invoice";
                    begin
                        SalesAdvanceInvoice.Run();



                    end;

                }



                field("Sales Advanced Credit Memo"; "Sales Advanced Credit Memo")
                {
                    ApplicationArea = all;
                    visible = Not CngUser;


                    //Revaluation Journa

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SalesAdvancedCreditMemo: page "Sales Advanced Credit Memo";
                    begin
                        SalesAdvancedCreditMemo.Run();



                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SalesAdvancedCreditMemo: page "Sales Advanced Credit Memo";
                    begin
                        SalesAdvancedCreditMemo.Run();



                    end;

                }
                field("StornoAvansField"; "StornoAvansField")
                {
                    ApplicationArea = all;
                    visible = Not CngUser;


                    //Revaluation Journa

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        PostedSalesCreditMemos: page "Posted Sales Credit Memos";
                    begin
                        PostedSalesCreditMemos.Run();



                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        PostedSalesCreditMemos: page "Posted Sales Credit Memos";
                    begin
                        PostedSalesCreditMemos.Run();



                    end;

                }



            }





        }
    }

    actions
    {


    }


    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;


        LocationF := '';
        CngUser := FALSE;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if UserSetup."CNG User" = true then begin
                CngUser := TRUE;
                LocationT.Reset();
                LocationT.SetFilter("CNG MP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';

                LocationT.Reset();
                LocationT.SetFilter("CNG VP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';


            end
            else begin

                WE.Reset();
                WE.SetFilter("User ID", '%1', UserId);
                if WE.FindSet() then
                    repeat
                        LocationF += we."Location Code" + '|';

                    until WE.Next() = 0;


            end;

            if (LocationF <> '') and (StrLen(LocationF) >= 2) then begin
                LocationF := CopyStr(LocationF, 1, StrLen(LocationF) - 1);
            end

        end;
        //
        SalesOr.Reset;
        SalesOr.SetFilter("Document Type", '%1', SalesOr."Document Type"::Order);
        if LocationF <> '' then begin
            SalesOr.SetFilter("Location Filter", LocationF);
            if SalesOr.FindFirst() // [THEN] z
            then
                SalesOrdersOpen := SalesOr.Count
            else
                SalesOrdersOpen := 0;


        end;


    end;

    var

        SalesOrdersOpen: Integer;
        SalesOr: Record "Sales Header";
        LocationF: Text[1024];
        UserSetup: Record "User Setup";
        LocationT: Record Location;
        WE: Record "Warehouse Employee";
        CngUser: boolean;



}

