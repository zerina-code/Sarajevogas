report 50214 "Item Stock Card"
{
    DefaultLayout = RDLC;

    RDLCLayout = './Item Stock Card.rdl';
    ApplicationArea = Basic, Suite;
    Caption = 'Inventory - Transaction Det. Prices';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Date Filter", "Inventory Posting Group", "Location Filter";
            column(No_Item; Item."No.")
            {
            }
            column(filter; filter) { }
            column(Description_Item; Item.Description)
            {
            }
            column(Brojac; Brojac) { }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(Inventory_Posting_Group; "Inventory Posting Group") { }
            column(Name_CompanyInfo; CompanyInfo.Name)
            {
            }
            column(Show; Show) { }
            column(TodayForm; FORMAT(TODAY, 0, 4))
            {
            }
            dataitem(Location; "Location")
            {
                DataItemTableView = SORTING(Code);
                PrintOnlyIfDetail = true;
                column(Code_Location; Location.Code)
                {
                }
                column(Name_Location; Location.Name)
                {
                }
                column(PostingPeriod; STRSUBSTNO(Text003, StartDate, EndDate))
                {
                }
                column(LocationInfo; STRSUBSTNO(Text004, Location.Code, Location.Name))
                {
                }
                column(StartQuantity; StartQuantity)
                {
                }
                column(StartAmount; StartAmount)
                {
                }

                dataitem("Value Entry"; "Value Entry")
                {
                    DataItemTableView = SORTING("Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date");
                    column(PostingDate_ItemLedgerEntry; "Value Entry"."Posting Date")
                    {
                        IncludeCaption = true;
                    }

                    column(CostPostedtoGL_ItemLedgerEntry; "Value Entry"."Cost Amount (Actual)" + SumAdd)
                    {
                    }
                    column(EntryType_ItemLedgerEntry; "Value Entry"."Entry Type")
                    {
                        IncludeCaption = true;
                    }
                    column(DocumentNo_ItemLedgerEntry; "Value Entry"."Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SKLOT_No_; SKLotNumber) { }
                    column(LocationCode_ItemLedgerEntry; "Value Entry"."Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Quantity_ItemLedgerEntry; "Value Entry"."Item Ledger Entry Quantity")
                    {
                        IncludeCaption = true;
                    }
                    column(SumSaldoIznos; SumSaldoIznos) { }
                    column(SumIzlazIznos; SumIzlazIznos) { }
                    column(SumIzlazKolicina; SumIzlazKolicina) { }
                    column(SumNabavnaCijena; SumNabavnaCijena) { }
                    column(SumSaldoKolicina; SumSaldoKolicina) { }
                    column(SumUlazIznos; SumUlazIznos) { }
                    column(CijenaIzlazIznos; CijenaIzlazIznos) { }
                    column(SumUlazKolicina; SumUlazKolicina) { }


                    column(CumulativQuantity; CumulativQuantity)
                    {
                    }
                    column(CumulativAmounts; CumulativAmount)
                    {
                    }
                    column(CumulativAmounts2; CumulativAmount2) { }
                    column(dPrice; dPrice)
                    {
                    }
                    column(dPriceOut; dPriceOut)
                    {
                    }
                    column(QInput; QInput)
                    {
                    }
                    column(QOutput; QOutput)
                    {
                    }
                    column(VInput; VInput)
                    {
                    }
                    column(VOutput; VOutput)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        ItemLedg: Record "Value Entry" temporary;
                        PWSLine: Record "Posted Whse. Shipment Line";
                        ValueEntrySum: Record "Value Entry";

                    begin


                        PWSLine.Reset();
                        PWSLine.SetFilter("Posted Source No.", '%1', "Value Entry"."Document No.");
                        if PWSLine.FindFirst() then begin
                            SKLotNumber := PWSLine."No."
                        end
                        else begin
                            SKLotNumber := '';
                        end;
                        SumAdd := 0;

                        if ("Document Type" = "Document Type"::"Purchase Invoice") and ("Cost Amount (Actual)" <> 0) then
                            "Item Ledger Entry Quantity" := "Valued Quantity";

                        if (SKLotNumber <> '') and ("Value Entry"."Item Ledger Entry Quantity" <> 0) then begin
                            ValueEntrySum.Reset();
                            ValueEntrySum.SetFilter("Document No.", '%1', "Value Entry"."Document No.");
                            ValueEntrySum.SetFilter("Entry No.", '<>%1', "Value Entry"."Entry No.");
                            //probalaa ovdje možda da rješenje.
                            //ValueEntrySum.SetFilter("Document Type", '%1', "Value Entry"."Document Type");
                            ValueEntrySum.SetFilter("Item No.", '%1', "Value Entry"."Item No.");
                            ValueEntrySum.SetFilter("Posting Date", '%1', "Value Entry"."Posting Date");
                            ValueEntrySum.SetFilter("Location Code", '%1', "Value Entry"."Location Code");
                            ValueEntrySum.SetFilter("Document Type", '<>%1', "Value Entry"."Document Type"::"Purchase Receipt");
                            if ValueEntrySum.findfirst then begin
                                ValueEntrySum.CalcSums("Cost Amount (Actual)");
                                SumAdd := ValueEntrySum."Cost Amount (Actual)";
                            end;
                        end;

                        ItemLedg.Reset();
                        ItemLedg.SetFilter("Entry No.", '%1', "Value Entry"."Entry No.");
                        if not ItemLedg.FindFirst() then begin
                            ItemLedg.Init();
                            ItemLedg.TransferFields("Value Entry");
                            ItemLedg.Insert();
                            if "Value Entry"."Item Ledger Entry Quantity" > 0 then
                                SumUlazKolicina += "Value Entry"."Item Ledger Entry Quantity";

                            if "Value Entry"."Document Type" = "Value Entry"."Document Type"::"Purchase Credit Memo"
                            then
                                SumUlazKolicina += "Value Entry"."Valued Quantity";

                            if ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" <> 'HTZ') then
                                SumIzlazKolicina += "Value Entry"."Item Ledger Entry Quantity";

                            if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Transfer Shipment")
                                               and ("Value Entry"."Item Ledger Entry Type" = "Value Entry"."Item Ledger Entry Type"::Transfer)
                                               and ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" = 'HTZ') then begin
                                SumIzlazKolicina += -"Item Ledger Entry Quantity";
                            end;

                            if "Value Entry"."Item Ledger Entry Quantity" > 0 then
                                SumSaldoKolicina += "Value Entry"."Item Ledger Entry Quantity";

                            if ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" <> 'HTZ') then
                                SumSaldoKolicina += "Value Entry"."Item Ledger Entry Quantity";

                            if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Transfer Shipment")
                                         and ("Value Entry"."Item Ledger Entry Type" = "Value Entry"."Item Ledger Entry Type"::Transfer)
                                         and ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" = 'HTZ') then begin
                                SumSaldoKolicina += "Item Ledger Entry Quantity";
                            end;



                            SumNabavnaCijena := 0;

                            VESum.RESET;
                            VESum.SETRANGE(VESum."Location Code", Location.Code);
                            VESum.SETRANGE(VESum."Inventory Posting Group", Item.GETFILTER("Inventory Posting Group"));
                            VESum.SETFILTER(VESum."Posting Date", DateFilter);
                            VESum.SetFilter("Item Ledger Entry Type", '%1', VESum."Item Ledger Entry Type"::Purchase);
                            VESum.SetFilter("Invoiced Quantity", '<>%1', 0);
                            VESum.CalcSums("Cost Amount (Actual)", VESum."Item Ledger Entry Quantity", "Cost Amount (Expected)", "Cost per Unit");
                            SumNabavnaCijena := abs(VESum."Cost per unit");

                            if ("Value Entry"."Item Ledger Entry Quantity" > 0) or ("Value Entry"."Valued Quantity" > 0) then begin
                                SumUlazIznos += "Value Entry"."Cost Amount (Actual)";
                                SumSaldoIznos += "Value Entry"."Cost Amount (Actual)";
                            end;
                            if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Purchase Credit Memo") then begin

                                SumUlazIznos += "Value Entry"."Cost Amount (Actual)";
                                SumSaldoIznos += "Value Entry"."Cost Amount (Actual)";

                            end;



                            if (("Value Entry"."Item Ledger Entry Quantity" < 0) or ("Value Entry"."Valued Quantity" < 0)) and ("Value Entry"."Gen. Prod. Posting Group" <> 'HTZ') then begin
                                SumIzlazIznos += -"Value Entry"."Cost Amount (Actual)";
                                SumSaldoIznos += "Value Entry"."Cost Amount (Actual)";
                            end;

                            if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Transfer Shipment")
                                          and ("Value Entry"."Item Ledger Entry Type" = "Value Entry"."Item Ledger Entry Type"::Transfer)
                                          and ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" = 'HTZ') then begin
                                SumIzlazIznos += -"Value Entry"."Cost Amount (Actual)";
                                SumSaldoIznos += "Value Entry"."Cost Amount (Actual)";
                            end;




                            if "Item Ledger Entry Quantity" <> 0 then
                                CijenaIzlazIznos += ROUND(ABS("Sales Amount (Actual)" / "Item Ledger Entry Quantity"), 0.01)
                            else
                                CijenaIzlazIznos := 0;





                        end;


                        //   CALCFIELDS("Cost Amount (Actual)", "Sales Amount (Actual)");

                        IF "Item Ledger Entry Quantity" > 0 THEN begin
                            CumulativQuantity += "Item Ledger Entry Quantity";
                            if ("Value Entry"."Item Ledger Entry Quantity" <> 0) and (ReportLayout = 'Kopija Ugrađeni izgled') then
                                CumulativAmount += "Cost Amount (Actual)" + SumAdd
                            else
                                CumulativAmount += "Cost Amount (Actual)";

                        end
                        else begin
                            if "Gen. Prod. Posting Group" <> 'HTZ' then begin
                                CumulativQuantity += "Item Ledger Entry Quantity";
                                //  CumulativAmount += -"Cost Amount (Actual)" + SumAdd;
                                if ("Value Entry"."Item Ledger Entry Quantity" <> 0) and (ReportLayout = 'Kopija Ugrađeni izgled') then
                                    CumulativAmount += "Cost Amount (Actual)" + SumAdd
                                else
                                    CumulativAmount += "Cost Amount (Actual)";


                            end
                            else begin
                                if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Transfer Shipment")
                                                    and ("Value Entry"."Item Ledger Entry Type" = "Value Entry"."Item Ledger Entry Type"::Transfer)
                                                    and ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" = 'HTZ') then begin
                                    CumulativQuantity += "Item Ledger Entry Quantity";
                                    //     CumulativAmount += "Cost Amount (Actual)" + SumAdd;
                                    if ("Value Entry"."Item Ledger Entry Quantity" <> 0) and (ReportLayout = 'Kopija Ugrađeni izgled') then
                                        CumulativAmount += "Cost Amount (Actual)" + SumAdd
                                    else
                                        CumulativAmount += "Cost Amount (Actual)";

                                end;

                            end;



                        end;

                        //pocetak
                        IF "Item Ledger Entry Quantity" > 0 THEN begin
                            if "Value Entry"."Document Type" = "Value Entry"."Document Type"::"Purchase Invoice" then begin
                                if (ReportLayout = 'Kopija Ugrađeni izgled') then
                                    CumulativAmount2 += "Cost Amount (Actual)" + SumAdd;

                            end
                            else begin

                                if ("Value Entry"."Item Ledger Entry Quantity" <> 0) and (ReportLayout = 'Kopija Ugrađeni izgled') then
                                    CumulativAmount2 += "Cost Amount (Actual)" + SumAdd;
                            end;

                        end
                        else begin
                            if "Gen. Prod. Posting Group" <> 'HTZ' then begin
                                //  CumulativAmount += -"Cost Amount (Actual)" + SumAdd;
                                if ("Value Entry"."Item Ledger Entry Quantity" <> 0) and (ReportLayout = 'Kopija Ugrađeni izgled') then
                                    CumulativAmount2 += "Cost Amount (Actual)" + SumAdd;


                            end
                            else begin
                                if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Transfer Shipment")
                                                    and ("Value Entry"."Item Ledger Entry Type" = "Value Entry"."Item Ledger Entry Type"::Transfer)
                                                    and ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" = 'HTZ') then begin
                                    //    CumulativQuantity += "Item Ledger Entry Quantity";
                                    //     CumulativAmount += "Cost Amount (Actual)" + SumAdd;
                                    if ("Value Entry"."Item Ledger Entry Quantity" <> 0) and (ReportLayout = 'Kopija Ugrađeni izgled') then
                                        CumulativAmount2 += "Cost Amount (Actual)" + SumAdd;

                                end;

                            end;



                        end;

                        //kraj

                        IF ("Item Ledger Entry Quantity" > 0) or (("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Purchase Credit Memo")) THEN BEGIN
                            if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Purchase Credit Memo") then begin
                                QInput += "Valued Quantity";
                                VInput += "Cost Amount (Actual)";

                            end
                            else begin
                                QInput += "Item Ledger Entry Quantity";
                                VInput += "Cost Amount (Actual)";
                            end;

                            //q1 += Quantity;
                            //v1 += "Cost Posted to GL";
                            if "Item Ledger Entry Quantity" = 0 then BEGIN
                                ve.RESET;
                                ve.SETFILTER("Item Ledger Entry No.", '%1', "Entry No.");
                                IF ve.Findfirst then
                                    CALCSUMS("Cost per Unit");
                                dPrice := "Cost per Unit";
                            END;
                            //   else
                            //     dPrice := 0;

                        END ELSE BEGIN
                            if "Gen. Prod. Posting Group" <> 'HTZ' then begin
                                QOutput += -"Item Ledger Entry Quantity";
                                VOutput += -"Cost Amount (Actual)";
                                //q2 -= Quantity;
                                //v2 += -"Cost Posted to GL";
                                if "Item Ledger Entry Quantity" = 0 then
                                    dPrice := -"Cost per Unit";
                                //else
                                //  dPrice := 0;
                                IF "Item Ledger Entry Quantity" <> 0 THEN
                                    dPriceOut := ROUND(ABS("Sales Amount (Actual)" / "Item Ledger Entry Quantity"), 0.01)
                                else
                                    dPriceOut := 0;
                            end;

                        END;

                        if ("Value Entry"."Document Type" = "Value Entry"."Document Type"::"Transfer Shipment")
                        and ("Value Entry"."Item Ledger Entry Type" = "Value Entry"."Item Ledger Entry Type"::Transfer)
                        and ("Value Entry"."Item Ledger Entry Quantity" < 0) and ("Value Entry"."Gen. Prod. Posting Group" = 'HTZ') then begin
                            QOutput += -"Item Ledger Entry Quantity";
                            VOutput += -"Cost Amount (Actual)";


                            //  dPrice += abs("Cost per Unit");


                            dPriceOut += ROUND(ABS("Cost Amount (Actual)"), 0.01)


                        end;


                        if "Value Entry"."Item Ledger Entry Quantity" <> 0 then begin
                            if "Value Entry"."Cost Amount (Actual)" + SumAdd > 0 then
                                dPrice := ("Value Entry"."Cost Amount (Actual)" + SumAdd) / "Value Entry"."Item Ledger Entry Quantity"
                            else
                                dPrice := -("Value Entry"."Cost Amount (Actual)" + SumAdd) / -"Value Entry"."Item Ledger Entry Quantity";
                        end;


                    end;

                    trigger OnPreDataItem()
                    begin
                        "Value Entry".SETRANGE("Value Entry"."Item No.", Item."No.");
                        "Value Entry".SETRANGE("Value Entry"."Location Code", Location.Code);
                        "Value Entry".SETFILTER("Value Entry"."Posting Date", DateFilter);
                        "Value Entry".SetFilter("Document Type", '<>%1', "Value Entry"."Document Type"::"Purchase Receipt");


                        CumulativQuantity := StartQuantity;
                        SumSaldoKolicina := StartQuantity;
                        CumulativAmount := StartAmount;
                        CumulativAmount2 := StartAmount;
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    if ReportLayout = 'Kopija Ugrađeni izgled' then
                        Show := true
                    else
                        Show := false;


                    StartQuantity := 0;
                    StartAmount := 0;
                    QOutput := 0;
                    QInput := 0;
                    VInput := 0;
                    VOutput := 0;
                    ItemLedgerEntry.SETCURRENTKEY(ItemLedgerEntry."Posting Date");
                    ItemLedgerEntry.SETFILTER("Posting Date", '..%1', Item.GETRANGEMIN(Item."Date Filter") - 1);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Location Code", Location.Code);
                    ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", Item."No.");
                    IF ItemLedgerEntry.FINDFIRST THEN
                        REPEAT
                            //    ItemLedgerEntry.CALCFIELDS("Cost Amount (Actual)");
                            StartQuantity += ItemLedgerEntry."Item Ledger Entry Quantity";
                            StartAmount += VE."Cost Posted to G/L";
                        UNTIL ItemLedgerEntry.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    setfilter("Code", '%1', 'GLAVNO');
                    IF Item.GETFILTER(Item."Location Filter") <> '' THEN
                        Location.SETFILTER(Location.Code, Item.GETFILTER(Item."Location Filter"));
                end;
            }

            trigger OnPreDataItem()
            begin
                IF Item.GETFILTER(Item."No.") = '' THEN begin
                    if OptionV = OptionV::"By Document" then
                        ERROR(Text001);
                end;
                IF Item.GETFILTER(Item."Date Filter") = '' THEN
                    ERROR(Text002);

                DateFilter := Item.GETFILTER(Item."Date Filter");
                StartDate := Item.GETRANGEMIN(Item."Date Filter");
                EndDate := Item.GETRANGEMAX(Item."Date Filter");


                CompanyInfo.GET;

                filter := Item.GETFILTERS;
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                ItemTemp: Record Item temporary;
                VIma: Record "Value Entry";

            begin
                ItemTemp.Reset();
                ItemTemp.SetFilter("No.", '%1', item."No.");
                if not ItemTemp.FindFirst() then begin
                    ItemTemp.Init();
                    ItemTemp.TransferFields(Item);
                    ItemTemp.Insert();
                    VIma.Reset();
                    VIma.SETRANGE("Item No.", Item."No.");
                    VIma.SETRANGE("Location Code", 'GLAVNO');
                    VIma.SETFILTER("Posting Date", DateFilter);
                    if VIma.FindFirst() then
                        Brojac += 1;
                end;
            end;

        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {

                field(ReportLayout; ReportLayout)
                {
                    ApplicationArea = Suite;
                    Caption = 'Report Layout';
                    //   TableRelation="Custom Report Layout".Description wher;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        CustomReportLayout: Record "Custom Report Layout";
                        ReportLayoutSelection: Record "Report Layout Selection";
                        CRLPage: Page "Custom Report Layouts";
                    begin
                        clear(CRLPage);
                        CustomReportLayout.reset;
                        CustomReportLayout.SetFilter("Report ID", '%1', 50214);
                        CRLPage.SetTableView(CustomReportLayout);

                        CRLPage.LOOKUPMODE(TRUE);
                        IF CRLPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            CRLPage.GETRECORD(CustomReportLayout);
                            ReportLayout := CustomReportLayout.Description;
                            ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));
                        end;
                    end;
                }
            }

        }



    }

    labels
    {
        ReportTitleLb = 'Item Stock Card';
        InputLb = 'Input';
        OutputLb = 'Output';
        BalanceLb = 'Balance';
        PurchPriceLb = 'Purchase price';
        UnitPriceLb = 'Unit Price';
        AmountLb = 'Amount';
        PriceLb = 'Price-out';
        ItemLb = 'Item';
        LocationLb = 'Location';

        PageLb = 'Page ';
        StartBalLb = 'Opening Balance';
        TotalLb = 'TOTAL';
        TransferLb = 'Transfer...';
    }

    trigger OnInitReport()
    var
        myInt: Integer;
        CL: Record "Custom Report Layout";
    begin
        CL.Reset();
        CL.SetFilter("Report ID", '%1', 50214);
        if cl.FindFirst() then
            ReportLayout := cl.Description;

    end;



    var
        Text001: Label 'You have to select item no.!';
        Text002: Label 'You have to define date filter!';
        VESum: Record "Value Entry";
        OptionV: Option "By Item","By Document";
        ReportLayout: Text;
        StartQuantity: Decimal;
        Show: Boolean;
        StartAmount: Decimal;
        filter: text;
        ItemLedgerEntry: Record "Value Entry";
        Brojac: Integer;

        SumUlazKolicina: decimal;
        SumIzlazKolicina: Decimal;
        SumSaldoKolicina: Decimal;
        SumNabavnaCijena: Decimal;
        SumUlazIznos: Decimal;
        SumIzlazIznos: Decimal;
        SumSaldoIznos: Decimal;

        CijenaIzlazIznos: Decimal;
        StartDate: Date;
        EndDate: Date;
        DateFilter: Text[30];
        CumulativQuantity: Decimal;
        CumulativAmount: Decimal;
        CumulativAmount2: Decimal;
        QInput: Decimal;
        QOutput: Decimal;
        VInput: Decimal;
        VOutput: Decimal;
        dPriceOut: Decimal;
        dPrice: Decimal;
        Text003: Label 'Overview for period %1-%2';
        Text004: Label 'Location %1-%2';
        CompanyInfo: Record "Company Information";
        SKLotNumber: code[20];
        VE: Record "Value Entry";
        CostPostedToGL: Decimal;
        ItemOnHand: Decimal;
        StartOnHand: Decimal;
        SumAdd: Decimal;
        RecordNo: Integer;





}
