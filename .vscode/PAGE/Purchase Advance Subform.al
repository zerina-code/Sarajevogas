page 50137 "Purchase Adv. Invoice Subform"
{
    // //AS1.00 26.08 - COST ALLOCATION

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    //ListPart
    SourceTable = "Purchase Line";
    SourceTableView = WHERE("Document Type" = FILTER('Invoice'));

    layout
    {
        area(content)
        {
            repeater("Control 1")
            {
                field(Type; Type)
                {

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("No."; "No.")
                {

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate;
                    end;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        CrossReferenceNoLookUp;
                        InsertExtendedText(FALSE);
                        NoOnAfterValidate;
                    end;

                    trigger OnValidate()
                    begin
                        CrossReferenceNoOnAfterValidat;
                        NoOnAfterValidate;
                    end;
                }
                field("IC Partner Code"; "IC Partner Code")
                {
                    Visible = false;
                }
                field("IC Partner Ref. Type"; "IC Partner Ref. Type")
                {
                    Visible = false;
                }
                field("IC Partner Reference"; "IC Partner Reference")
                {
                    Visible = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                }
                field(Nonstock; Nonstock)
                {
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    Visible = false;
                }
                field(Description; Description)
                {
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Bin Code"; "Bin Code")
                {
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Visible = false;
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    BlankZero = true;
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                    Visible = false;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Visible = false;
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankZero = true;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Visible = false;
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; "Allow Item Charge Assignment")
                {
                    Visible = false;
                }
                field("Qty. to Assign"; "Qty. to Assign")
                {
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Qty. Assigned"; "Qty. Assigned")
                {
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        CurrPage.SAVERECORD;
                        ShowItemChargeAssgnt;
                        UpdateForm(FALSE);
                    end;
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field("Job Task No."; "Job Task No.")
                {
                    Visible = false;
                }
                field("Job Line Type"; "Job Line Type")
                {
                    Visible = false;
                }
                field("Job Unit Price"; "Job Unit Price")
                {
                    Visible = false;
                }
                field("Job Line Amount"; "Job Line Amount")
                {
                    Visible = false;
                }
                field("Job Line Discount Amount"; "Job Line Discount Amount")
                {
                    Visible = false;
                }
                field("Job Line Discount %"; "Job Line Discount %")
                {
                    Visible = false;
                }
                field("Job Total Price"; "Job Total Price")
                {
                    Visible = false;
                }
                field("Job Unit Price (LCY)"; "Job Unit Price (LCY)")
                {
                    Visible = false;
                }
                field("Job Total Price (LCY)"; "Job Total Price (LCY)")
                {
                    Visible = false;
                }
                field("Job Line Amount (LCY)"; "Job Line Amount (LCY)")
                {
                    Visible = false;
                }
                field("Job Line Disc. Amount (LCY)"; "Job Line Disc. Amount (LCY)")
                {
                    Visible = false;
                }
                field("Prod. Order No."; "Prod. Order No.")
                {
                    Visible = false;
                }
                field("Blanket Order No."; "Blanket Order No.")
                {
                    Visible = false;
                }
                field("Blanket Order Line No."; "Blanket Order Line No.")
                {
                    Visible = false;
                }
                field("Insurance No."; "Insurance No.")
                {
                    Visible = false;
                }
                field("Budgeted FA No."; "Budgeted FA No.")
                {
                    Visible = false;
                }
                field("FA Posting Type"; "FA Posting Type")
                {
                    Visible = false;
                }
                field("Depreciation Book Code"; "Depreciation Book Code")
                {
                    Visible = false;
                }
                field("Depr. until FA Posting Date"; "Depr. until FA Posting Date")
                {
                    Visible = false;
                }
                field("Depr. Acquisition Cost"; "Depr. Acquisition Cost")
                {
                    Visible = false;
                }
                field("Duplicate in Depreciation Book"; "Duplicate in Depreciation Book")
                {
                    Visible = false;
                }
                field("Use Duplication List"; "Use Duplication List")
                {
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }

                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }


                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }

                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("VAT Difference"; "VAT Difference")
                {
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
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction()
                    begin
                        ExplodeBOM;
                    end;
                }
                action("Insert &Ext. Texts")
                {
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action(GetReceiptLines)
                {
                    Caption = '&Get Receipt Lines';
                    Ellipsis = true;
                    Image = Receipt;

                    trigger OnAction()
                    begin
                        GetReceipt;
                    end;
                }
                action(FAChargeAssignment)
                {
                    Caption = 'FA Charge Assignment';
                    Image = FARegisters;

                    trigger OnAction()
                    var
                        DocumentNo: Code[20];
                        VendorOrder: Record "Purch. Inv. Header";
                        OrderLines: Record "Purch. Inv. Line";
                        NewRecord: Record "Purchase Line";
                        ChargeDocumentNo: Code[20];
                        OrderAmount: Decimal;
                        Factor: Decimal;
                        TempI: Integer;
                        VATGroup: Text;
                        DirectUnitCost: Decimal;
                        unit: Text;
                        TotalSum: Decimal;
                        ItemTypeNo: Text;
                        Text0001: Label 'The selected line needs to be Type "Charge (Item)" or "G\L Account"';
                        Text0002: Label 'The Account No. must be 2710';
                        VATForPDV: Text;
                        ItemSum: Integer;
                        ItemTypeFound: Boolean;
                        ItemRecord: Record "Purchase Line";
                    begin
                        NewRecord.COPY(Rec);
                        TempI := Rec."Line No.";
                        DirectUnitCost := Rec."Direct Unit Cost";
                        DocumentNo := Rec."Document No.";
                        VATGroup := Rec."VAT Prod. Posting Group";

                        ItemTypeNo := NewRecord."No.";
                        //za item
                        ItemTypeFound := FALSE;
                        ItemSum := 0;

                        IF NewRecord.Type <> NewRecord.Type::"Charge (Item)" THEN BEGIN
                            ERROR(Text0001);
                            EXIT;
                        END;

                        //Pronađi doc no originalne dobavljačeve fakture
                        ChargeDocumentNo := FindOrderDocument(DocumentNo);

                        //Uzmi cijeli iznos ordera
                        VendorOrder.SETFILTER("No.", ChargeDocumentNo);
                        IF VendorOrder.FIND('-') THEN BEGIN
                            VendorOrder.CALCFIELDS(Amount);
                            OrderAmount := VendorOrder.Amount;
                        END;

                        Rec.DELETE;
                        //Pronađi linije dokumenta
                        TotalSum := 0;
                        OrderLines.SETFILTER("Document No.", ChargeDocumentNo);
                        IF OrderLines.FINDSET(FALSE, FALSE) THEN BEGIN
                            REPEAT
                                //Izračunaj faktor
                                //VATGroup := OrderLines."VAT Prod. Posting Group";
                                unit := OrderLines."Unit of Measure";
                                Factor := OrderLines."Line Amount" / OrderAmount;

                                // Ako je tip Item dodaj na sumu vriejdnost
                                IF OrderLines.Type = OrderLines.Type::Item THEN BEGIN
                                    IF ItemTypeFound = TRUE THEN BEGIN
                                        ItemRecord.VALIDATE("Direct Unit Cost", ItemRecord."Direct Unit Cost" + (Factor * DirectUnitCost));
                                        ItemRecord.MODIFY;
                                    END

                                    ELSE BEGIN
                                        ItemRecord := NewRecord;
                                        ItemRecord."Line No." := TempI;
                                        ItemRecord.VALIDATE("Document No.", DocumentNo);
                                        ItemRecord.INSERT;

                                        ItemRecord.Type := ItemRecord.Type::"Charge (Item)";
                                        ItemRecord.VALIDATE("No.", 'R-Freight');
                                        ItemRecord.MODIFY;
                                        ItemRecord.VALIDATE("Direct Unit Cost", Factor * DirectUnitCost);
                                        ItemRecord.VALIDATE(Quantity, 1);
                                        ItemRecord.VALIDATE("VAT Prod. Posting Group", VATGroup);
                                        ItemRecord.MODIFY;
                                        TempI += 10;
                                        ItemTypeFound := TRUE;
                                    END;


                                END

                                ELSE BEGIN
                                    //Unesi novu liniju
                                    NewRecord."Line No." := TempI;
                                    NewRecord.INSERT;

                                    //Promijeni tip, artikal/osnovno sredstvo i cijenu
                                    //NewRecord.VALIDATE(Type, NewRecord.Type);
                                    NewRecord.Type := OrderLines.Type;
                                    NewRecord.VALIDATE("No.", OrderLines."No.");
                                    NewRecord.MODIFY;


                                    NewRecord.VALIDATE("Direct Unit Cost", Factor * DirectUnitCost);
                                    NewRecord.VALIDATE(Quantity, 1);
                                    IF unit <> '' THEN BEGIN
                                        NewRecord.VALIDATE("Unit of Measure", unit);
                                    END
                                    ELSE BEGIN
                                        NewRecord.VALIDATE("Unit of Measure", 'PCS');
                                    END;
                                    NewRecord.VALIDATE("VAT Prod. Posting Group", VATGroup);
                                    NewRecord.MODIFY;

                                    //TotalSum += NewRecord."Direct Unit Cost";

                                    TempI += 10;
                                END;

                            UNTIL OrderLines.NEXT = 0;
                        END;

                        //Testirao uvijek je dobra suma, ako nekad ne bude dobra u ovaj dio koda ubaciti višak manjak na neku liniju
                        //IF TotalSum <> DirectUnitCost THEN BEGIN

                        //END;
                    end;
                }
                action("PDV Charge Assignment")
                {
                    Caption = 'PDV Charge Assignment';
                    Image = VATPostingSetup;

                    trigger OnAction()
                    var
                        DocumentNo: Code[20];
                        VendorOrder: Record "Purch. Inv. Header";
                        OrderLines: Record "Purch. Inv. Line";
                        NewRecord: Record "Purchase Line";
                        ChargeDocumentNo: Code[20];
                        OrderAmount: Decimal;
                        Factor: Decimal;
                        TempI: Integer;
                        VATGroup: Text;
                        DirectUnitCost: Decimal;
                        unit: Text;
                        TotalSum: Decimal;
                        ItemTypeNo: Text;
                        VATForPDV: Text;
                        Text0001: Label 'The selected line needs to be Type "Fixed Asset" or "G\L Account"';
                        Text0002: Label 'The Account No. must be 2710';
                    begin
                        NewRecord.COPY(Rec);
                        TempI := Rec."Line No.";
                        DirectUnitCost := Rec."Direct Unit Cost";
                        DocumentNo := Rec."Document No.";
                        ItemTypeNo := NewRecord."No.";
                        VATForPDV := NewRecord."VAT Prod. Posting Group";

                        IF NewRecord.Type <> NewRecord.Type::"G/L Account" THEN BEGIN
                            ERROR(Text0001);
                            EXIT;
                        END;

                        IF NewRecord.Type = NewRecord.Type::"G/L Account" THEN BEGIN
                            IF ItemTypeNo <> '2710' THEN BEGIN
                                IF ItemTypeNo <> '5519' THEN BEGIN
                                    ERROR(Text0002);
                                    EXIT;
                                END;
                            END;


                        END;



                        //Pronađi doc no originalne dobavljačeve fakture
                        ChargeDocumentNo := FindOrderDocument(DocumentNo);

                        //Uzmi cijeli iznos ordera
                        VendorOrder.SETFILTER("No.", ChargeDocumentNo);
                        IF VendorOrder.FIND('-') THEN BEGIN
                            VendorOrder.CALCFIELDS(Amount);
                            OrderAmount := VendorOrder.Amount;
                        END;

                        Rec.DELETE;
                        //Pronađi linije dokumenta
                        TotalSum := 0;
                        OrderLines.SETFILTER("Document No.", ChargeDocumentNo);
                        IF OrderLines.FINDSET(FALSE, FALSE) THEN BEGIN
                            REPEAT
                                //Izračunaj faktor
                                //VATGroup := OrderLines."VAT Prod. Posting Group";
                                unit := OrderLines."Unit of Measure";
                                Factor := OrderLines."Line Amount" / OrderAmount;

                                //Unesi novu liniju
                                NewRecord."Line No." := TempI;
                                NewRecord.INSERT;

                                //Promijeni tip, artikal/osnovno sredstvo i cijenu
                                NewRecord.VALIDATE(Type, NewRecord.Type);
                                NewRecord.MODIFY;
                                NewRecord.VALIDATE("No.", ItemTypeNo);
                                NewRecord.MODIFY;
                                NewRecord.VALIDATE("Direct Unit Cost", Factor * DirectUnitCost);
                                NewRecord.VALIDATE(Quantity, 1);
                                NewRecord.VALIDATE("Unit of Measure", unit);
                                NewRecord.VALIDATE("VAT Prod. Posting Group", VATForPDV);
                                NewRecord.MODIFY;

                                TotalSum += NewRecord."Direct Unit Cost";

                                TempI += 10;
                            UNTIL OrderLines.NEXT = 0
                        END;

                        //Testirao uvijek je dobra suma, ako nekad ne bude dobra u ovaj dio koda ubaciti višak manjak na neku liniju
                        IF TotalSum <> DirectUnitCost THEN BEGIN

                        END;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action("Event")
                    {
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod)
                        end;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant)
                        end;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation)
                        end;
                    }
                    action("BOM Level")
                    {
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM)
                        end;
                    }
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        ShowLineComments;
                    end;
                }
                action(ItemChargeAssignment)
                {
                    Caption = 'Item Charge &Assignment';

                    trigger OnAction()
                    begin
                        ShowItemChargeAssgnt;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction()
                    begin
                        OpenItemTrackingLines;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
            COMMIT;
            IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
                EXIT(FALSE);
            ReservePurchLine.DeleteLine(Rec);
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InitType;
        CLEAR(ShortcutDimCode);
    end;

    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000: Label 'Unable to execute this function while in view only mode.';
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        //ĐK  CostAllocations: Record product;
        Cost: Decimal;
        NewCost: Decimal;
        NewRecord: Record "Purchase Line";
        CostLine: Decimal;
        NewCostLine: Integer;
        NewPurchaseLine: Record "Purchase Line";
        NewDimensionSet: Record "Dimension Set Entry";
        LastDim: Record "Dimension Set Entry";
        GKAccountNo: Code[10];
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        CurrDimSetID: Record "Dimension Set Entry";
        DimMgt: Codeunit "DimensionManagement";
        VATGroup: Text;
        DifferenceLine: Record "Purchase Line";
        CurrAmount: Decimal;
        NewAmount: Decimal;
        DiffI: Integer;
        DocLookupRes: Record "Purchase Header";
        OwisNo: Text;
        DocNumber: Code[50];

    procedure ApproveCalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)", Rec);
    end;

    procedure CalcInvDisc()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount", Rec);
    end;

    procedure ExplodeBOM()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM", Rec);
    end;

    procedure GetReceipt()
    begin
        CODEUNIT.RUN(CODEUNIT::"Purch.-Get Receipt", Rec);
    end;

    procedure InsertExtendedText(Unconditionally: Boolean)
    begin
        IF TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertPurchExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN
            UpdateForm(TRUE);
    end;

    procedure ItemChargeAssgnt()
    begin
        ShowItemChargeAssgnt;
    end;

    procedure UpdateForm(SetSaveRecord: Boolean)
    begin
        CurrPage.UPDATE(SetSaveRecord);
    end;

    procedure SetUpdateAllowed(UpdateAllowed: Boolean)
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    procedure UpdateAllowed(): Boolean
    begin
        IF UpdateAllowedVar = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    procedure ShowPrices()
    begin
        PurchHeader.GET("Document Type", "Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    procedure ShowLineDisc()
    begin
        PurchHeader.GET("Document Type", "Document No.");
        CLEAR(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
           (xRec."No." <> '')
        THEN
            CurrPage.SAVERECORD;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(FALSE);
    end;

    procedure FindOrderDocument(ChargeDocumentNo: Code[20]) VendorDocumentNo: Code[20]
    var
        OwisNo: Code[50];
        Orders: Record "Purchase Header";
        postedOrder: Record "Purch. Inv. Header";
        Text000: Label 'The OWIS purchase request no. cannot be empty';
        Text100: Label 'No Posted document was found with the same owis no.';
    begin
        //Funkcija koja na osnovu ChargeDocNo pronađe dobavljačev purchase order
        //Filtriraj po document no
        Orders.SETFILTER("No.", ChargeDocumentNo);
        IF Orders.FIND('-') THEN BEGIN
            //Uzmi owis na sonovu doc no.
            OwisNo := Orders."Vendor Order No.";
            IF OwisNo <> '' THEN BEGIN
                // postedOrder.RESET;
                //Filtriraj po owis no i nadji dokument sa istim owis no
                //(ali različitim document no)
                postedOrder.SETFILTER("Vendor Order No.", OwisNo);
                //IF Orders.FINDSET(FALSE, FALSE) THEN BEGIN
                IF postedOrder.FIND('-') THEN BEGIN
                    //REPEAT
                    //IF Orders."No." <> ChargeDocumentNo THEN BEGIN
                    VendorDocumentNo := postedOrder."No.";
                    //END
                    //UNTIL Orders.NEXT = 0;
                END
                //Ako nema dokumenta sa istim owis no
                ELSE BEGIN
                    ERROR(Text100);
                    EXIT;
                END
            END

            //Ako je owis prazan
            ELSE BEGIN
                ERROR(Text000);
                EXIT;
            END
        END;
    end;
}

