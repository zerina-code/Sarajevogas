report 50094 PrintSmallCards
{
    DefaultLayout = RDLC;
    RDLCLayout = './PrintSmallCards.rdl';
    ApplicationArea = Service;
    Caption = 'Print Small Cards';
    UsageCategory = ReportsAndAnalysis;

    dataset

    {


        dataitem(DataItem21; "Warehouse Receipt Line")

        {

            UseTemporary = true;
            //DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
            //RequestFilterFields = "Document Type", "Document No.", "Line No.";
            column(Addr11; Addr[1] [1])
            {
            }



            column(Addr12; Addr[1] [2])
            {
            }

            column(Addr13; Addr[1] [3])

            {
            }
            column(PrvaKolonaV; PrvaKolonaV) { }
            column(DrugaKolonaV; DrugaKolonaV) { }
            column(TrecaKolonaV; TrecaKolonaV) { }
            column(Addr14; Addr[1] [4])
            {
            }
            column(Addr21; Addr[2] [1])
            {
            }
            column(Addr22; Addr[2] [2])
            {
            }
            column(Addr23; Addr[2] [3])
            {
            }
            column(Addr24; Addr[2] [4])
            {
            }
            column(Addr31; Addr[3] [1])
            {
            }
            column(Addr32; Addr[3] [2])
            {
            }
            column(Addr33; Addr[3] [3])
            {
            }
            column(Addr34; Addr[3] [4])
            {
            }
            column(ItemUOM; ItemUOM)
            {
            }
            /*column(ShowSection; ColumnNo = 0)
            {
            }*/
            column(ShowSection; true)
            {
            }
            column(BrojacNaljepnica; BrojacNaljepnica) { }
            column(ItemDescription; ItemDescription) { }

            trigger OnAfterGetRecord()

            var
                Umanjenjeza3: Decimal;
                Rezultat: Decimal;
            begin
                PrvaKolonaV := false;
                DrugaKolonaV := false;
                TrecaKolonaV := false;


                ItemTable.Reset();
                ItemTable.SetFilter("No.", '%1', "Item No.");
                if ItemTable.FindFirst() then begin //artikal iz primke je pronadjen u tabeli Item
                    ItemDescription := ItemTable.Description; //preuzimam naziv artikla
                    ItemUOM := ItemTable."Base Unit of Measure"; //preuzimam jedinicu mjere
                end;

                BrojacNaljepnica += 1;


                Rezultat := BrojacNaljepnica;
                //npr. rezu 4
                while
                Rezultat > 3 do begin
                    Rezultat -= 3;

                end;
                if Rezultat = 1 then
                    PrvaKolonaV := true;
                if Rezultat = 2 then DrugaKolonaV := true;
                if Rezultat = 3 then TrecaKolonaV := true;

                PrvaKolonaV := true;


                if Rezultat MOD 3 = 0 then begin
                    PrvaKolonaV := false;
                    DrugaKolonaV := false;
                    TrecaKolonaV := true;

                end
                else begin
                    if Rezultat MOD 2 = 0 then begin
                        PrvaKolonaV := false;
                        DrugaKolonaV := true;
                        TrecaKolonaV := false;

                    end
                    else begin
                        PrvaKolonaV := true;
                        DrugaKolonaV := false;
                        TrecaKolonaV := false;

                    end;

                end;


                //brojevi 1, 4,7 ,10 (Prva kolona)
                //brojevi 2,5,8 (Druga kolona)
                //brojevi 3,6,9,12 (Treca kolona)






                RecordNo := RecordNo + 1;
                ColumnNo := ColumnNo + 1;
                //  BrojacNaljepnica += 1;


                ItemTable.Reset();
                ItemTable.SetFilter("No.", '%1', "Item No.");
                if ItemTable.FindFirst() then begin //artikal iz primke je pronadjen u tabeli Item
                    ItemDescription := ItemTable.Description; //preuzimam naziv artikla
                    ItemUOM := ItemTable."Base Unit of Measure"; //preuzimam jedinicu mjere
                end;

                WarehouseReceiptHeaderTable.Reset();
                WarehouseReceiptHeaderTable.SetFilter("No.", '%1', WarehouseReceiptNoFilter);
                if WarehouseReceiptHeaderTable.FindFirst() then
                    ReceiptPostingDate := WarehouseReceiptHeaderTable."Posting Date";

                Addr[1] [1] := StrSubstNo('%1 %2', 'NAZIV', '');
                Addr[1] [2] := StrSubstNo('%1 %2', ItemDescription, '');
                Addr[1] [3] := StrSubstNo('%1 %2', '' + WarehouseReceiptNoFilter + ' od ' + FORMAT(ReceiptPostingDate), '');
                Addr[1] [4] := StrSubstNo('%1 %2', "Item No.", '');


                CompressArray(Addr[ColumnNo]);

                if RecordNo = NoOfRecords then begin
                    for i := ColumnNo + 1 to NoOfColumns do
                        Clear(Addr[i]);
                    ColumnNo := 0;
                end else begin
                    if ColumnNo = NoOfColumns then
                        ColumnNo := 0;
                end;

                PrintControl -= 1;





            end;



            trigger OnPreDataItem()
            var
                WRLOrg: Record "Warehouse Receipt Line";
                i: Integer;
                LineNo: Integer;
            begin
                BrojacReda := 0;

                WRLOrg.Reset();
                WRLOrg.SetFilter("No.", '%1', WarehouseReceiptNoFilter);
                LineNo += 100;

                if WRLOrg.FindSet() then
                    repeat
                        for i := 1 to WRLOrg."Print Quantity" do begin
                            LineNo += 100;
                            DataItem21.Init();
                            DataItem21.TransferFields(WRLOrg);
                            DataItem21."Line No." := LineNo;

                            DataItem21.Insert();
                        end;

                    until WRLOrg.Next() = 0;

                //NoOfRecords := Count;
                //       NoOfRecords := TotalCards;
                NoOfColumns := 3;

                WRL.Reset();
                WRL.CopyFilters(DataItem21);
                WRL.CalcSums("Print Quantity");


                //    NoOfCopies := ROUND(WRL."Print Quantity" / 3, 1, '>');


            end;


        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
    var
        BrojacReda: Integer;



    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        BrojacNaljepnica := 0;

    end;

    procedure SetParam(WarehouseReceiptNo: Code[20])    //veza izmedju WarehouseReceiptHeader i WarehouseReceiptLine je polje No.
    begin
        WarehouseReceiptNoFilter := WarehouseReceiptNo;
    end;

    var
        Addr: array[3, 4] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;

        WRL: Record "Warehouse Receipt Line";
        WarehouseReceiptNoFilter: Code[20];
        PrvaKolonaV: Boolean;
        DrugaKolonaV: Boolean;
        TrecaKolonaV: Boolean;


        OutputNo: Integer;
        NoOfCopies: Integer;
        ItemTable: Record Item;
        ItemDescription: Text[100];
        ItemUOM: Code[10];
        ReceiptPostingDate: Date;
        BrojacNaljepnica: Integer;
        WarehouseReceiptHeaderTable: Record "Warehouse Receipt Header";
        TotalCards: Integer;
        NoOfLoops: Integer;

        PrintControl: Integer;
        Test: Integer;
}

