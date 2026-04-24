pageextension 50072 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        modify("Currency Code")
        {
            Visible = true;
        }

        addbefore("Posting Description")
        {
            field("No.2"; "No.") { Visible = true; }
        }

        addbefore("VAT Bus. Posting Group")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group") { }


        }



        addbefore("Buy-from Vendor No.")
        {
            field("Contract Entry No."; "Contract Entry No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
            field("Contract No."; "Contract No.")
            {
                ApplicationArea = All;
            }
            field("Contract Purchase Item"; "Contract Purchase Item")
            {
                ApplicationArea = All;
            }
        }
        addafter("Posting Date")
        {
            field("VAT Date"; "VAT Date")
            {
                ApplicationArea = All;
            }
        }


        addafter(Status)
        {
            field("User ID Number"; "User ID Number")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Commercial; Commercial)
            {
                ApplicationArea = all;
                Editable = Komercijala;
            }
            field("Commercial UserID"; "Commercial UserID")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Vendor Posting Group"; "Vendor Posting Group")
            {
                ApplicationArea = all;
                Editable = true;
            }
            /* field(Accounting;Accounting)
             {
                 ApplicationArea = all;
                 Editable = "Računovodstvo";
             }
             field("Accounting UserID";"Accounting UserID")
             {
                 ApplicationArea = all;
                 Editable = false;
             }*/
            field(KUF; KUF) { }
        }
        modify(Control3)
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }


        movebefore("Vendor Posting Group"; "VAT Bus. Posting Group")
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Purchaser Code") { Visible = false; }
        modify("No. of Archived Versions") { Visible = false; }
        modify("Assigned User ID") { Visible = false; }
        modify("Payment Reference") { Visible = false; }
        modify("Posting Description")
        {
            Visible = true;
            editable = true;
        }
    }

    actions
    {
        modify("Create &Whse. Receipt")
        {
            Visible = false;
        }

        // Add changes to page actions here
        addafter(Action17)
        {
            action("Create &Whse. Receipt2")
            {
                AccessByPermission = TableData "Warehouse Receipt Header" = R;
                ApplicationArea = Warehouse;
                Caption = 'Create &Whse. Receipt';
                Image = NewReceipt;
                ToolTip = 'Create a warehouse receipt to start a receive and put-away process according to an advanced warehouse configuration.';

                trigger OnAction()
                var
                    GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                begin
                    CreateFromPurchOrder2(Rec);

                    if not Find('=><') then
                        Init;
                end;
            }

            //Warehouse da prikaže i linije primke



        }

        modify(Action225)
        {
            Visible = false;
        }
        moveafter("Create &Whse. Receipt2"; Warehouse)
        modify(Action186)
        {
            Visible = false;
        }

        modify(Action17) { Visible = false; }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                Text001: Label 'Commercial sector did not approve this order.';
                //Text002: Label 'Accounting did not approve this order.';
                Text003: Label 'User does not belong to the accounting sector.';
                UserSetupTable: Record "User Setup";
            begin
                if Commercial = false then //komercijala nije verifikovala nabavku
                    Error(Text001);
                // if Accounting = false then //račiunovodstvo nije verifikovalo nabavku
                //    Error(Text002);
                if "Računovodstvo" = false then //korisnik ne pripada računovodstvu i ne može proknjiziti nabavku
                    Error(Text003);
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                Text001: Label 'Commercial sector did not approve this order.';
                //Text002: Label 'Accounting sector did not approve this order.';
                Text003: Label 'User does not belong to the accounting sector.';
                UserSetupTable: Record "User Setup";
            begin
                if Commercial = false then //komercijala nije verifikovala nabavku
                    Error(Text001);
                // if Accounting = false then //računovodstvo nije verifikovalo nabavku
                //     Error(Text002);
                if "Računovodstvo" = false then //korisnik ne pripada računovodstvu i ne može proknjiziti nabavku
                    Error(Text003);
            end;
        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            var
                Text001: Label 'Commercial sector did not approve this order.';
                // Text002: Label 'Accounting sector did not approve this order.';
                Text003: Label 'User does not belong to the accounting sector.';
                UserSetupTable: Record "User Setup";
            begin
                if Commercial = false then //komercijala nije verifikovala nabavku
                    Error(Text001);
                // if Accounting = false then //računovodstvo nije verifikovalo nabavku
                // Error(Text002);
                if "Računovodstvo" = false then //korisnik ne pripada računovodstvu i ne može proknjiziti nabavku
                    Error(Text003);
            end;
        }
    }

    procedure CreateFromPurchOrder2(PurchHeader: Record "Purchase Header")
    var
        Gen: Codeunit "Get Source Doc. Inbound";
        WareH: Record "Warehouse Receipt Line";
    begin



        ShowDialog2(Gen.CreateFromPurchOrderHideDialog(PurchHeader), PurchHeader);
    end;

    local procedure ShowDialog2(WhseReceiptCreated: Boolean; PH: Record "Purchase Header")
    var
        Text005: Label 'One or more of the lines on this %1 require special warehouse handling. The %2 for such lines has been set to blank.';
        ErrorOccured: Boolean;
        SpecialHandlingMessage: Text[1024];
        WareH: Record "Warehouse Receipt Line";
        WhseReceiptLine: Record "Warehouse Receipt Line";
        WhseReceiptHeader: Record "Warehouse Receipt Header";
        ActivitiesCreated: Integer;
        Text001: Label '%1 %2 has been created.';
        Text002: Label '%1 Warehouse Receipts have been created.';
        GetSourceDocuments: Report "Get Source Fixed Asset";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        WSH: Record "Warehouse Shipment Header";
        WSHP: page "Whse. Receipt Lines";
    begin




        if ActivitiesCreated = 1 then
            Message(StrSubstNo(Text001, ActivitiesCreated, WhseReceiptHeader.TableCaption) + SpecialHandlingMessage);
        if ActivitiesCreated > 1 then
            Message(StrSubstNo(Text002, ActivitiesCreated) + SpecialHandlingMessage);
        if WhseReceiptCreated = true then begin

            WareH.Reset();
            WareH.SetFilter("Source No.", '%1', PH."No.");
            if WareH.FindFirst() then
                ActivitiesCreated := WareH.Count;

            //ĐK            GetSourceDocuments.GetLastReceiptHeader(WarehouseReceiptHeader);

            Message(StrSubstNo(Text001, ActivitiesCreated, WhseReceiptHeader.TableCaption) + SpecialHandlingMessage);
            /* WarehouseReceiptHeader.Reset();
             WarehouseReceiptHeader.SetFilter("No.", '%1', WareH."No.");
             if WarehouseReceiptHeader.FindFirst() then begin
                 //đK   PAGE.Run(PAGE::"Warehouse Receipt", WarehouseReceiptHeader);
             end;
             OpenWarehouseReceiptPage2;*/

            WhseReceiptHeader.Get(WareH."No.");
            PAGE.Run(PAGE::"Warehouse Receipt", WhseReceiptHeader);


        end

        else begin
            ErrorOccured := true;
            if ErrorOccured then
                SpecialHandlingMessage :=
                  ' ' + StrSubstNo(Text005, WhseReceiptHeader.TableCaption, WhseReceiptLine.FieldCaption("Bin Code"));
            if (ActivitiesCreated = 0) and ErrorOccured then
                Message(SpecialHandlingMessage);


        end;


    end;

    local procedure OpenWarehouseReceiptPage2()
    var
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        GetSourceDocuments: Report "Get Source Fixed Asset";
        IsHandled: Boolean;
    begin
        GetSourceDocuments.GetLastReceiptHeader(WarehouseReceiptHeader);
        PAGE.Run(PAGE::"Warehouse Receipt", WarehouseReceiptHeader);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if NOT UserSetup."Order From Expired Contract" then
                //provjeravam da li je korisnik oznacen da moze kreirati narudzbenicu iz ugovora koji je istekao
                //ako je oznacen da moze onda njemu prikazujem sve ugovore
                //ako nije oznacen stavljam mu filter datuma samo na aktivne ugovore, one koji nisu istekli
                setfilter("Today Date", '>=%1', Today)
            else
                Clear(Rec."Today Date");
        end;


        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            Finansije := UserSetup.Finance;
            Komercijala := UserSetup.Commercial;
            "Računovodstvo" := UserSetup.Accounting;
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        //setfilter("Today Date", '>=%1', Today);

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if NOT UserSetup."Order From Expired Contract" then
                //provjeravam da li je korisnik oznacen da moze kreirati narudzbenicu iz ugovora koji je istekao
                //ako je oznacen da moze onda njemu prikazujem sve ugovore
                //ako nije oznacen stavljam mu filter datuma samo na aktivne ugovore, one koji nisu istekli
                setfilter("Today Date", '>=%1', Today)
            else
                Clear(Rec."Today Date");
        end;


    end;

    var
        UserSetup: Record "User Setup";
        Finansije: Boolean;
        Komercijala: Boolean;
        Računovodstvo: Boolean;
}