report 50227 "Add CNG"
{
    DefaultLayout = RDLC;
    Caption = 'Add CNG';
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SIL: Record "Sales Shipment Line";
                SalesHeader: Record "Sales Header";
                SILLine: Record "Sales Line";
                SILInsert: Record "Sales Shipment Line";
                PosedF: Record "Sales Invoice Line";
                ItemLedgerEntry: Record "Item Ledger Entry";
                BrojacLinijeSamo1MOze: Integer;
                SILInsertIma: Record "Sales Shipment Line";
                SalesShipmentHeader: Record "Sales Shipment Header";
            begin

                SIL.Reset();
                SIL.SetFilter("Order No.", '%1', "Sales Line"."Document No.");
                SIL.SetFilter("Order Line No.", '%1', "Sales Line"."Line No.");
                if not SIL.FindFirst() then begin
                    SalesShipmentHeader.Reset();
                    SalesShipmentHeader.SetFilter("Posting Date", '%1', "Sales Line"."Shipment Date");
                    SalesShipmentHeader.SetFilter("Sell-to Customer No.", '%1', "Sales Line"."Sell-to Customer No.");
                    if SalesShipmentHeader.FindFirst() then begin
                        SILInsert.Init;
                        SILInsert.TransferFields("Sales Line");

                        SILInsert."Posting Date" := "Sales Line"."Posting Date2";
                        SILInsert."Document No." := "Sales Line"."Document No.";
                        SILInsert.Quantity := "Sales Line".Quantity;
                        SILInsert."Quantity (Base)" := "Sales Line".Quantity;

                        PosedF.Reset();
                        PosedF.SetFilter("Order No.", '%1', "Sales Line"."Document No.");
                        PosedF.SetFilter("Order Line No.", '%1', "Sales Line"."Line No.");
                        if PosedF.FindFirst() then begin

                            SILInsert."Quantity Invoiced" := -"Sales Line".Quantity;
                            SILInsert."Qty. Invoiced (Base)" := -"Sales Line".Quantity;
                            "Sales Line"."Qty. to Invoice" := 0;
                            SILInsert."Qty. Invoiced (Base)" := "Sales Line"."Qty. to Invoice";
                        end
                        else begin
                            SILInsert."Quantity Invoiced" := 0;
                            SILInsert."Qty. Invoiced (Base)" := 0;
                            "Sales Line"."Qty. to Invoice" := "Sales Line".Quantity;
                            SILInsert."Qty. Invoiced (Base)" := "Sales Line"."Qty. to Invoice";
                        end;


                        SILInsert."Qty. Shipped Not Invoiced" := SILInsert.Quantity - SILInsert."Quantity Invoiced";
                        if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Order then begin
                            SILInsert."Order No." := "Sales Line"."Document No.";
                            SILInsert."Order Line No." := "Sales Line"."Line No.";
                        end;


                        SILInsert."Qty. Shipped Not Invoiced" := SILInsert.Quantity - abs(SILInsert."Quantity Invoiced");

                        ItemLedgerEntry.Reset();
                        ItemLedgerEntry.SetFilter("Document No.", '%1', SILInsert."Document No.");
                        ItemLedgerEntry.SetFilter("Document Line No.", '%1', SILInsert."Line No.");
                        if ItemLedgerEntry.FindFirst() then begin
                            SILInsert."Item Shpt. Entry No." := ItemLedgerEntry."Entry No.";
                        end;
                        // SILInsert.Insert(true);
                        SILInsert."Payment Method Code" := "Sales Line"."Payment Method Code";
                        SILInsert."Item Charge Base Amount" := round("Sales Line".Amount, 0.01, '=');
                        SILInsert.Amount := "Sales Line".Amount;
                        SILInsert."Amount Incl. VAT" := "Sales Line"."Amount Including VAT";
                        RecRef.GetTable(SILInsert);
                        RecordRefExample.InsertRecords(RecRef);
                        commit;
                    end
                    else begin
                        SalesShipmentHeader.Reset();
                        SalesShipmentHeader.SetFilter("Posting Date", '%1', "Sales Line"."Posting Date2");
                        SalesShipmentHeader.SetFilter("Sell-to Customer No.", '%1', "Sales Line"."Sell-to Customer No.");
                        if SalesShipmentHeader.FindFirst() then begin
                            SILInsert.Init;
                            SILInsert.TransferFields("Sales Line");

                            SILInsert."Posting Date" := "Sales Line"."Posting Date2";
                            SILInsert."Document No." := "Sales Line"."Document No.";
                            SILInsert.Quantity := "Sales Line".Quantity;
                            SILInsert."Quantity (Base)" := "Sales Line".Quantity;

                            PosedF.Reset();
                            PosedF.SetFilter("Order No.", '%1', "Sales Line"."Document No.");
                            PosedF.SetFilter("Order Line No.", '%1', "Sales Line"."Line No.");
                            if PosedF.FindFirst() then begin

                                SILInsert."Quantity Invoiced" := -"Sales Line".Quantity;
                                SILInsert."Qty. Invoiced (Base)" := -"Sales Line".Quantity;
                                "Sales Line"."Qty. to Invoice" := 0;
                                SILInsert."Qty. Invoiced (Base)" := "Sales Line"."Qty. to Invoice";
                            end
                            else begin
                                SILInsert."Quantity Invoiced" := 0;
                                SILInsert."Qty. Invoiced (Base)" := 0;
                                "Sales Line"."Qty. to Invoice" := "Sales Line".Quantity;
                                SILInsert."Qty. Invoiced (Base)" := "Sales Line"."Qty. to Invoice";
                            end;


                            SILInsert."Qty. Shipped Not Invoiced" := SILInsert.Quantity - SILInsert."Quantity Invoiced";
                            if "Sales Line"."Document Type" = "Sales Line"."Document Type"::Order then begin
                                SILInsert."Order No." := "Sales Line"."Document No.";
                                SILInsert."Order Line No." := "Sales Line"."Line No.";
                            end;


                            SILInsert."Qty. Shipped Not Invoiced" := SILInsert.Quantity - abs(SILInsert."Quantity Invoiced");

                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetFilter("Document No.", '%1', SILInsert."Document No.");
                            ItemLedgerEntry.SetFilter("Document Line No.", '%1', SILInsert."Line No.");
                            if ItemLedgerEntry.FindFirst() then begin
                                SILInsert."Item Shpt. Entry No." := ItemLedgerEntry."Entry No.";
                            end;
                            // SILInsert.Insert(true);
                            SILInsert."Payment Method Code" := "Sales Line"."Payment Method Code";
                            SILInsert."Item Charge Base Amount" := round("Sales Line".Amount, 0.01, '=');
                            SILInsert.Amount := "Sales Line".Amount;
                            SILInsert."Amount Incl. VAT" := "Sales Line"."Amount Including VAT";
                            RecRef.GetTable(SILInsert);
                            RecordRefExample.InsertRecords(RecRef);
                            commit;
                        end;
                    end;

                end;
            end;
        }


    }



    trigger OnPostReport()
    var

    begin






    end;

    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin

    end;

    var
        OldStreetNo: Code[20];
        OldStreetNew: code[20];
        RecRef: RecordRef;
        RecordRefExample: Codeunit "Modiy Permissions";
}

