pageextension 50127 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {




        // Add changes to page layout here
        addafter("Line Amount")
        {

            field("VAT %"; "VAT %") { ApplicationArea = all; }


            field("Amount Including VAT"; "Amount Including VAT") { Visible = true; }
            field("VAT Difference"; "VAT Difference") { Visible = cng; Editable = true; }

            field("VAT Difference CNG"; "VAT Difference CNG") { Visible = not cng; Editable = true; }
            field("Old Price"; "Old Price") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }
            field("Total Old Price"; "Total Old Price") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }
            field(Difference; Difference) { ApplicationArea = all; Editable = false; Visible = DifferenceV; }

            //  field("Posting Date"; "Posting Date") { ApplicationArea = all; Visible = not cng; }

            field("Posting Date2"; "Posting Date2") { ApplicationArea = all; Visible = not cng; }


            field("Payment Method Code"; "Payment Method Code") { ApplicationArea = all; Visible = not cng; Editable = EditableD; }

            //  field("Type of vehicle"; "Type of vehicle") { ApplicationArea = all; Editable = EditableD; }
            field("Driver type"; "Driver type")
            {
                ApplicationArea = all;
                Editable = EditableD;


            }
            field("Driver ID"; "Driver ID")
            {
                ApplicationArea = all;
                Editable = EditableD;


                /*    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        EmployeeCNG: Record Employee;
                        EmployeeList: page "Employee List";
                    begin
                        clear(EmployeeList);
                        EmployeeCNG.Reset();
                        EmployeeCNG.SetFilter("CNG Employee", '%1', true);
                        EmployeeList.SetTableView(EmployeeCNG);

                        EmployeeList.LOOKUPMODE(TRUE);
                        IF EmployeeList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            EmployeeList.GETRECORD(EmployeeCNG);
                            rec."Driver ID" := EmployeeCNG."No.";

                        end;
                    end;*/

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    EmployeeCNG: Record Employee;
                    EmployeeList: page "Employee List";
                    EmployeeCNG_C: Record Contact;
                    EmployeeList_C: page "Contact List";
                    CBR: Record "Contact Business Relation";
                begin

                    if "Driver type" = "Driver type"::Internal then begin
                        clear(EmployeeList);
                        EmployeeCNG.Reset();
                        EmployeeCNG.SetFilter("CNG Employee", '%1', true);
                        EmployeeCNG.SetFilter(StatusExt, '%1', EmployeeCNG.StatusExt::Active);
                        EmployeeList.SetTableView(EmployeeCNG);


                        EmployeeList.LOOKUPMODE(TRUE);
                        IF EmployeeList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            EmployeeList.GETRECORD(EmployeeCNG);
                            rec."Driver ID" := EmployeeCNG."No.";
                            Rec."Driver Name" := EmployeeCNG."First Name" + ' ' + EmployeeCNG."Last Name";

                        end;

                    end
                    else begin
                        //kontakt

                        clear(EmployeeList_C);
                        EmployeeCNG_C.Reset();
                        CBR.RESET;
                        CBR.SETFILTER("No.", '%1', "Sell-to Customer No.");
                        IF CBR.FindFirst() then begin
                            EmployeeCNG_C.SetFilter("Type Relation", '%1', EmployeeCNG_C."Type Relation"::Driver);
                            EmployeeCNG_C.SetFilter("Active CNG", '%1', true);
                            EmployeeCNG_C.SetFilter("Company No.", '%1', CBR."Contact No.");
                            EmployeeList_C.SetTableView(EmployeeCNG_C);


                            EmployeeList_C.LOOKUPMODE(TRUE);
                            IF EmployeeList_C.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                EmployeeList_C.GETRECORD(EmployeeCNG_c);
                                rec."Driver ID" := EmployeeCNG_C."No.";
                                Rec."Driver Name" := EmployeeCNG_c.Name;

                            end;
                        end;
                    end;
                end;
            }
            field("Driver Name"; "Driver Name") { ApplicationArea = all; Editable = EditableD; }
            field("Driver Registration No."; "Driver Registration No.")
            {
                ApplicationArea = all;
                Editable = EditableD;
                trigger OnLookup(var Text: Text): Boolean
                var

                    EmployeeStatGroup: Record "Employee Statistics Group";
                    EmployeeStatGroups: page "Employee Statistics Groups";
                begin

                    clear(EmployeeStatGroups);
                    EmployeeStatGroup.Reset();
                    EmployeeStatGroup.SetFilter("Customer No.", '%1', "Sell-to Customer No.");
                    EmployeeStatGroups.SetTableView(EmployeeStatGroup);


                    EmployeeStatGroups.LOOKUPMODE(TRUE);
                    IF EmployeeStatGroups.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        EmployeeStatGroups.GETRECORD(EmployeeStatGroup);
                        rec.VALIDATE("Driver Registration No.", EmployeeStatGroup.Code);

                    end;

                end;

            }
            field("Type of vehicle"; "Type of vehicle") { ApplicationArea = all; Editable = EditableD; }
            field("Fiscal printed"; "Fiscal printed")
            {
                ApplicationArea = all;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    if (xRec."Fiscal printed" = true) and (rec."Fiscal printed" = false) then
                        Error(Permission);
                end;

            }
            field("Fiscal No."; "Fiscal No.") { ApplicationArea = all; }
            field("Fiscal User"; "Fiscal User") { ApplicationArea = all; Editable = false; }
            field("Fiscal DateTime"; "Fiscal DateTime") { ApplicationArea = all; Editable = false; }



            field("R. Fiscal printed"; "R. Fiscal printed")
            {
                ApplicationArea = all;
                Visible = DifferenceR;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    if (xRec."Fiscal printed" = true) and (rec."Fiscal printed" = false) then
                        Error(Permission);
                end;
            }

            field("Old Quantity"; "Old Quantity") { ApplicationArea = all; Visible = DifferenceR; }

            field("R. Fiscal No."; "R. Fiscal No.") { ApplicationArea = all; Visible = DifferenceR; }
            field("R. Fiscal User"; "R. Fiscal User") { ApplicationArea = all; Editable = false; Visible = DifferenceR; }
            field("R. Fiscal DateTime"; "R. Fiscal DateTime") { ApplicationArea = all; Editable = false; Visible = DifferenceR; }


            field("New Fiscal printed"; "New Fiscal printed")
            {
                ApplicationArea = all;
                Visible = DifferenceV;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    if (xRec."Fiscal printed" = true) and (rec."Fiscal printed" = false) then
                        Error(Permission);
                end;
            }
            field("New Fiscal No."; "New Fiscal No.") { ApplicationArea = all; Visible = DifferenceV; }
            field("New Fiscal User"; "New Fiscal User") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }
            field("New Fiscal DateTime"; "New Fiscal DateTime") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }
            field("Cargo done"; "Cargo done") { }

        }

        modify("Line Discount %") { Visible = cng; }
        modify("Quantity Invoiced") { Visible = cng; }
        modify("Qty. to Ship") { Visible = cng; }
        modify("Quantity Shipped") { Visible = true; }
        modify("Qty. to Invoice") { Visible = cng; }






        modify("Unit Price") { Editable = true; }
        modify("Qty. to Assemble to Order") { Visible = false; }
        modify("Reserved Quantity") { Visible = false; }
        modify("Tax Area Code") { Visible = false; }
        modify("Tax Group Code") { Visible = false; }
        modify("Qty. Assigned") { Visible = false; }
        modify("Prepmt Amt Deducted") { Visible = false; }
        modify("Prepmt Amt to Deduct") { Visible = false; }
        modify("Prepmt. Line Amount") { Visible = false; }
        modify("Planned Delivery Date") { Visible = cng; }
        modify("Qty. to Assign") { Visible = cng; }
        modify("Planned Shipment Date") { Visible = cng; }
        modify("Shipment Date") { Visible = cng; }
        modify("Shortcut Dimension 1 Code") { Visible = cng; }





    }

    actions
    {

        // Add changes to page actions here

        //   PrintDuplicateFiscal(true, Rec."Fiscal No.");
        addafter(SelectMultiItems)
        {
            action("Print Internal")
            {

                Caption = 'Print Internal';
                trigger OnAction()

                var
                    SL: Record "Sales Line";
                begin

                    SL.Reset();
                    sl.SetFilter("Document No.", '%1', "Document No.");
                    sl.SetFilter("Document Type", '%1', "Document Type");
                    sl.SetFilter("Line No.", '%1', "Line No.");
                    REPORT.RUN(50221, TRUE, TRUE, sl);
                end;

            }
            action("Print Duplicate Fiscal")
            {
                Caption = 'Print Duplicate Fiscal';
                Ellipsis = true;
                Image = Import;
                Visible = not cng;
                //Promoted = true;
                //PromotedCategory = Category7;
                // PromotedIsBig = true;
                trigger OnAction()
                var
                    SOrder: page "Sales Order";

                begin

                    SOrder.PrintDuplicateFiscal(true, Rec."Fiscal No.");

                end;
            }

            action("Print Duplicate R. Fiscal")
            {
                Caption = 'Print Duplicate R. Fiscal';
                Ellipsis = true;
                Image = Import;
                Visible = not cng;
                //Promoted = true;
                //PromotedCategory = Category7;
                // PromotedIsBig = true;
                trigger OnAction()
                var
                    SOrder: page "Sales Order";

                begin

                    SOrder.PrintDuplicateReklamniFiscal(true, Rec."Fiscal No.");

                end;
            }

            action("Print Duplicate New. Fiscal")
            {
                Caption = 'Print Duplicate New. Fiscal';
                Ellipsis = true;
                Image = Import;
                Visible = not cng;
                //Promoted = true;
                //PromotedCategory = Category7;
                // PromotedIsBig = true;
                trigger OnAction()
                var
                    SOrder: page "Sales Order";

                begin

                    SOrder.PrintDuplicateFiscal(true, Rec."New Fiscal No.");

                end;
            }


            action("Print R. Fiscal")
            {
                Caption = 'Print R Fiscal';
                Ellipsis = true;
                Image = Import;
                Visible = not cng;
                //Promoted = true;
                //PromotedCategory = Category7;
                // PromotedIsBig = true;
                trigger OnAction()
                var
                    SOrder: page "Sales Order";


                    SalesShptLine: Record "Sales Shipment Line";
                    SalesShptLine2: Record "Sales Shipment Line";
                    SHeader: Record "Sales Shipment Header";
                    WhseShptLineRez: Record "Warehouse Shipment Line";
                    HideDialog: Boolean;
                    IsPosted: Boolean;
                    Selection: Integer;
                    IsHandled: Boolean;
                    SalesL: Record "Sales Line";
                    GenJBatch: Record "Gen. Journal Batch";
                    TransferHeader: Record "Transfer Header";
                    GLSetup: Record "General Ledger Setup";
                    T_GJL: Record "Gen. Journal Line";
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    DocNo: code[20];
                    LineNo: Integer;
                    TransferLine: Record "Transfer Line";

                    ItemJournalLine: Record "Item Journal Line";
                    ItemJLine: Integer;
                    DocItemJournal: Text[250];
                    UnitCostGAS: Decimal;

                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    ItemJournalLine2: Record "Item Journal Line";
                    G: Record "General Ledger Setup";
                    Linija: Integer;
                    CalculationSetup: Record "Calculation Setup";
                    RTD: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    WhseShptLine: Record "Warehouse Shipment Line";
                    WhseShptLine1: Record "Warehouse Shipment Line";
                    WhsePostShipment: Codeunit "Whse.-Post Shipment";
                    TransferRH: Record "Transfer Receipt Header";
                    TransferRL: Record "Transfer Receipt Line";
                    TransferRLPart: Record "Transfer Receipt Line";
                    KolicinaYes: Boolean;
                    SalesHeader: Record "Sales Header";
                    UnitCostOrg: Decimal;
                    KolicinaYesOne: Boolean;
                    LocFind: Record Location;
                    LocFind2: Record Location;
                    TransferRHPart: Record "Transfer Receipt Header";
                    KolicinaYes2: Boolean;
                    IUM: Record "Item Unit of Measure";

                begin
                    KolicinaYes := false;
                    KolicinaYesOne := false;
                    KolicinaYes2 := false;

                    if rec."R. Fiscal printed" = false then begin


                        UnitCostOrg := rec."Unit Cost";//DjeminaTrosak

                        //prvo storno, pa onda print reklamiranog
                        CalculationSetup.get;
                        SHeader.Reset();
                        SHeader.SetFilter("Order No.", '%1', Rec."Document No.");

                        //ovdje već nalazim dvije otpremnice, pa sve storniram
                        if SHeader.FindSet() then
                            repeat


                                SalesShptLine2.Reset();
                                SalesShptLine2.SetFilter("Order No.", '%1', Rec."Document No.");
                                SalesShptLine2.SetFilter("Document No.", '%1', SHeader."No.");
                                SalesShptLine2.SetFilter("Line No.", '%1', rec."Line No.");
                                //storno npr. *37
                                SalesShptLine2.SetFilter(Quantity, '<>0');
                                SalesShptLine2.SetRange(Correction, false);
                                if SalesShptLine2.FindSet() then
                                    repeat


                                        SalesShptLine.Copy(SalesShptLine2);
                                        CODEUNIT.Run(CODEUNIT::"Undo Sales Shipment Line Mess", SalesShptLine);
                                        Commit();

                                    until SalesShptLine2.Next() = 0;


                            until SHeader.Next() = 0;

                        //Mislim da bi reklamni trebala vratiti ako je CNG MLP, prvo na CNG VLP, pa sa
                        //CNG VLP na CNG MLP

                        TransferRH.Reset();
                        TransferRH.SetFilter("Sales Header No.", '%1', "Document No.");
                        TransferRH.SetFilter(Correction, '%1', false);
                        if TransferRH.FindSet() then
                            repeat

                                TransferRL.Reset();
                                TransferRL.SetFilter("Document No.", '%1', TransferRH."No.");
                                TransferRL.SetFilter(Quantity, '%1', Rec.Quantity);
                                TransferRL.SetFilter("Transfer-to Code", '%1', Rec."Location Code");
                                if TransferRL.FindFirst() then
                                    KolicinaYes := true
                                else
                                    KolicinaYes := false;


                                if (TransferRH."Transfer-to Code" <> 'GLAVNO GAS') and (KolicinaYes = true) then begin


                                    KolicinaYesOne := true;


                                    //sada bi ja pustila jednom na VLP, a onda na MLP
                                    // kreiraj nalog za prenos

                                    LocFind.reset;
                                    LocFind.setfilter(Code, '%1', TransferRH."Transfer-to Code");
                                    if LocFind.FindFirst() then begin

                                        if LocFind."CNG MP" = true then begin

                                            //prvo ide sa CNG MLP na CNG VLP

                                            TransferHeader.init;
                                            TransferHeader.Validate("Transfer-from Code", TransferRH."Transfer-to Code");
                                            LocFind2.Reset();
                                            LocFind2.SetFilter("CNG VP", '%1', true);
                                            if LocFind2.FindFirst() then
                                                TransferHeader.Validate("Transfer-to Code", LocFind2.Code);
                                            TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                            TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                            TransferHeader.Validate("Sales Header No.", Rec."No.");
                                            TransferHeader.Validate(Correction, true);
                                            TransferHeader.Validate("R. CNG MLP", true);

                                            TransferHeader.Insert(true);



                                            commit;
                                            Linija += 10000;


                                            TransferRL.Reset();
                                            TransferRL.SetFilter("Document No.", '%1', TransferRH."No.");
                                            if TransferRL.FindSet() then
                                                repeat

                                                    TransferLine.init;
                                                    TransferLine.Validate("Document No.", TransferHeader."No.");
                                                    TransferLine.Validate("Line No.", Linija);
                                                    TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                                    TransferLine.Validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                                    TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");

                                                    TransferLine.Validate(Quantity, TransferRL.Quantity);


                                                    TransferLine.Insert(true);
                                                    TransferRL.Correction := true;
                                                    TransferRL.Modify();

                                                until TransferRL.Next() = 0;

                                            //lansiraj
                                            commit;
                                            RTD.Run(TransferHeader);

                                            TransferRH.Correction := true;
                                            TransferRH.Modify();
                                            commit;





                                            //   GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                            //lansiraj

                                            TransferHeaderPost_GAS(TransferHeader);


                                            Commit();
                                            //kraj

                                            //drugi kraj

                                            TransferHeader.init;
                                            LocFind2.Reset();
                                            LocFind2.SetFilter("CNG VP", '%1', true);
                                            if LocFind2.FindFirst() then
                                                TransferHeader.Validate("Transfer-from Code", LocFind2.Code);
                                            TransferHeader.Validate("Transfer-to Code", 'GLAVNO GAS');
                                            TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                            TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                            TransferHeader.Validate("Sales Header No.", Rec."No.");
                                            TransferHeader.Validate(Correction, true);
                                            TransferHeader.validate("Hide CNG MP", true);

                                            TransferHeader.Insert(true);

                                            commit;
                                            Linija += 10000;


                                            TransferRL.Reset();
                                            TransferRL.SetFilter("Document No.", '%1', TransferRH."No.");
                                            if TransferRL.FindSet() then
                                                repeat

                                                    TransferLine.init;
                                                    TransferLine.Validate("Document No.", TransferHeader."No.");
                                                    TransferLine.Validate("Line No.", Linija);
                                                    TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                                    TransferLine.Validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                                    TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                                                    TransferLine.Validate(Quantity, TransferRL.Quantity);
                                                    //    TransferLine.Validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                                    //  TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");


                                                    TransferLine.Insert(true);
                                                    TransferRL.Correction := true;
                                                    TransferRL.Modify();

                                                until TransferRL.Next() = 0;

                                            //lansiraj
                                            commit;
                                            RTD.Run(TransferHeader);

                                            TransferRH.Correction := true;
                                            TransferRH.Modify();
                                            commit;





                                            //   GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                            //lansiraj

                                            TransferHeaderPost_GAS(TransferHeader);

                                            TransferRHPart.Reset();
                                            TransferRHPart.SetFilter("Sales Header No.", '%1', "Document No.");
                                            TransferRHPart.SetFilter("No.", '<=%1', TransferRH."No.");
                                            TransferRHPart.SetFilter("Posting Date", '<=%1', TransferRH."Posting Date");
                                            TransferRHPart.SetFilter(Correction, '%1', false);
                                            TransferRHPart.SetCurrentKey("No.", "Posting Date");
                                            TransferRHPart.Ascending(false);
                                            if TransferRHPart.FindSet() then
                                                repeat
                                                    TransferRLPart.Reset();
                                                    TransferRLPart.SetFilter("Document No.", '%1', TransferRHPart."No.");
                                                    TransferRLPart.SetFilter(Quantity, '%1', rec.Quantity);
                                                    TransferRLPart.SetFilter("Transfer-from Code", '%1', 'GLAVNO GAS');
                                                    if TransferRLPart.FindFirst() then
                                                        KolicinaYes2 := true
                                                    else
                                                        KolicinaYes2 := false;

                                                    if (KolicinaYes2 = true) then begin
                                                        TransferRHPart.Correction := true;
                                                        TransferRHPart.Modify();

                                                    end;

                                                until (TransferRHPart.next = 0) or (KolicinaYes2 = true);


                                            Commit();
                                            //kraj2

                                        end
                                        else begin

                                            TransferHeader.init;
                                            TransferHeader.Validate("Transfer-from Code", TransferRH."Transfer-to Code");
                                            TransferHeader.Validate("Transfer-to Code", 'GLAVNO GAS');
                                            TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                            TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                            TransferHeader.Validate("Sales Header No.", Rec."No.");
                                            TransferHeader.Validate(Correction, true);

                                            TransferHeader.Insert(true);


                                            commit;
                                            Linija += 10000;


                                            TransferRL.Reset();
                                            TransferRL.SetFilter("Document No.", '%1', TransferRH."No.");
                                            if TransferRL.FindSet() then
                                                repeat

                                                    TransferLine.init;
                                                    TransferLine.Validate("Document No.", TransferHeader."No.");
                                                    TransferLine.Validate("Line No.", Linija);
                                                    TransferLine.Validate("Item No.", CalculationSetup."Item No.");

                                                    TransferLine.Validate(Quantity, TransferRL.Quantity);
                                                    TransferLine.Validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                                    TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");


                                                    TransferLine.Insert(true);
                                                    TransferRL.Correction := true;
                                                    TransferRL.Modify();

                                                until TransferRL.Next() = 0;

                                            //lansiraj
                                            commit;
                                            RTD.Run(TransferHeader);

                                            TransferRH.Correction := true;
                                            TransferRH.Modify();
                                            commit;





                                            //   GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                            //lansiraj

                                            TransferHeaderPost_GAS(TransferHeader);


                                            Commit();
                                        end;
                                    end;
                                end;
                            until (TransferRH.next = 0) or (KolicinaYesOne = true);


                        //ovdje storno art
                        CalculationSetup.get;
                        if CalculationSetup."Transfer Items" = true then begin
                            ItemJLine := 1000;

                            //prvo ide nabava, da mogu uzeti trošak 
                            ItemJournalLine2.reset;
                            ItemJournalLine2.SetCurrentKey("Line No.");
                            ItemJournalLine2.Ascending;
                            if ItemJournalLine2.FindLast() then
                                ItemJLine := ItemJournalLine2."Line No." + 1000
                            else
                                ItemJLine := 1000;

                            ItemJournalLine.Init();
                            ItemJournalLine.validate("Posting Date", Today);
                            ItemJournalLine.Validate("Journal Template Name", 'ITEM');
                            ItemJournalLine.Validate("Journal Batch Name", 'PRENOS');
                            DocItemJournal := NoSeriesMgt.GetNextNo(CalculationSetup."No. Series Transfer", ItemJournalLine."Posting Date", true);
                            ItemJournalLine.validate("Line No.", ItemJLine);
                            ItemJournalLine.validate("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                            ItemJournalLine.validate("Item No.", CalculationSetup."Item No. 2");
                            ItemJournalLine.validate("Location Code", 'GLAVNO GAS');
                            ItemJournalLine.validate("Gen. Bus. Posting Group", 'DOMAĆI');
                            CalculationSetup.get;
                            IUM.Reset();
                            IUM.SetFilter("Item No.", '%1', CalculationSetup."Item No. 2");
                            //od kilograma
                            IUm.SetFilter(Code, '%1', 'KG');
                            if IUM.FindFirst() then begin
                                ItemJournalLine.validate(Quantity, Rec.Quantity * ium."Qty. per Unit of Measure");
                            end
                            else begin
                                ItemJournalLine.validate(Quantity, Rec.Quantity);
                            end;

                            //    ItemJournalLine.validate(Quantity, Rec.Quantity);
                            //ovjde 
                            ItemJournalLine.validate("Document No.", DocItemJournal);

                            CalculationSetup.get;
                            //trošak dijeliš
                            /*   IUM.Reset();
                               IUM.SetFilter("Item No.", '%1', CalculationSetup."Item No. 2");
                               //od kilograma
                               IUm.SetFilter(Code, '%1', 'KG');
                               if IUM.FindFirst() then begin
                                   ItemJournalLine.validate(ItemJournalLine."Unit Cost", ItemJournalLine."Unit Cost" / ium."Qty. per Unit of Measure");
                               end
                               else begin
                                   ItemJournalLine.validate(ItemJournalLine."Unit Cost", ItemJournalLine."Unit Cost");
                               end;*/
                            // ItemJournalLine.Validate("Unit Cost", UnitCostOrg);
                            // DjeminaTrosak
                            UnitCostGAS := ItemJournalLine."Unit Cost";
                            ItemJournalLine.Insert();
                            COMMIT;

                            ItemJLine := ItemJLine + 1000;
                            //kraj

                            //dodala prvo prenos s jednog na drugi
                            ItemJournalLine.Init();
                            ItemJournalLine.Validate("Journal Template Name", 'ITEM');
                            ItemJournalLine.Validate("Journal Batch Name", 'PRENOS');
                            ItemJournalLine.validate("Line No.", ItemJLine);
                            ItemJournalLine.validate("Posting Date", Today);
                            ItemJournalLine.validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                            ItemJournalLine.validate("Item No.", CalculationSetup."Item No.");
                            ItemJournalLine.validate("Location Code", 'GLAVNO GAS');
                            ItemJournalLine.validate("Gen. Bus. Posting Group", 'DOMAĆI');
                            ItemJournalLine.validate(Quantity, Rec.Quantity);
                            ItemJournalLine.validate("Document No.", DocItemJournal);
                            //ovdje je jedinični trošak ažurirati
                            /*    ItemUnitOfMeasure.Reset();
                                ItemUnitOfMeasure.SetFilter("Item No.", '%1', ItemJournalLine."Item No.");
                                ItemUnitOfMeasure.SetFilter(Code, '%1', ItemJournalLine."Unit of Measure Code");
                                if ItemUnitOfMeasure.findfirst then begin

                                    g.Get;
                                    ItemJournalLine.Validate(amount, round((ItemJournalLine.Quantity * ItemJournalLine."Unit Cost"), G."Amount Rounding Precision"));
                                end;*/

                            //DjeminaTrosak
                            ItemJournalLine.validate("Unit Cost", UnitCostOrg);
                            ItemJournalLine.validate("Unit Amount", ItemJournalLine."Unit Cost");
                            ItemJournalLine.Validate(amount, (ItemJournalLine.Quantity * ItemJournalLine."Unit Cost"));


                            ItemJournalLine.Insert();
                            COMMIT;



                            //   ItemJournalLine2.Reset();
                            // ItemJournalLine2.SetFilter("Document No.", ItemJournalLine."Document No.");


                            CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournalLine);



                        end;

                        //krajkla vraća na gas 2

                        //ovdje storno blagajne
                        GLSetup.GET;
                        T_GJL.reset;
                        T_GJL.SETFILTER("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");
                        T_GJL.SETFILTER("Journal Batch Name", '%1', GLSetup."Cash Batch Name");
                        IF T_GJL.FIND('+') THEN
                            LineNo := T_GJL."Line No." + 100
                        ELSE
                            LineNo := 100;
                        T_GJL.validate("Journal Template Name", GLSetup."Cash Receipt Journal Template");
                        T_GJL.validate("Journal Batch Name", GLSetup."Cash Batch Name");
                        T_GJL.validate("Document Type", T_GJL."Document Type"::Refund);
                        SalesHeader.Reset();
                        SalesHeader.SetFilter("No.", '%1', rec."Document No.");
                        SalesHeader.SetFilter("Document Type", '%1|%2', SalesHeader."Document Type"::Invoice, SalesHeader."Document Type"::Order);
                        if SalesHeader.FindFirst() then begin

                            T_GJL.Validate("Payment Type", SalesHeader."Bill type");
                            T_GJL.validate("Bill type", SalesHeader."Bill type");
                            T_GJL.validate("Bill Category", SalesHeader."Bill Category");
                        end;
                        T_GJL.validate("Account Type", T_GJL."Account Type"::"Customer");
                        T_GJL.validate("Account No.", SalesL."Bill-to Customer No.");
                        T_GJL."Line No." := LineNo;
                        T_GJL."Posting Date" := SalesL."Posting Date";
                        T_GJL."Posting Date" := today;
                        T_GJL."Document Date" := SalesL."Posting Date";
                        T_GJL.Validate("Payment Method Code", SalesL."Payment Method Code");


                        GenJBatch.Reset();
                        GenJBatch.SetFilter("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");
                        GenJBatch.SetFilter(Name, '%1', GLSetup."Cash Batch Name");
                        if GenJBatch.FindFirst() then
                            Docno := NoSeriesMgt.GetNextNo(GenJBatch."No. Series", SalesL."Posting Date", false);



                        T_GJL."Document No." := Docno;
                        T_GJL.VALIDATE("External Document No.", SalesL."Document No.");
                        T_GJL.Description := '';
                        T_GJL.VALIDATE(Amount, round(abs(SalesL."Amount Including VAT"), 0.01, '='));
                        //   T_GJL.VALIDATE("Posting Group", "Customer Posting Group");

                        T_GJL.Validate("Bal. Account Type", GenJBatch."Bal. Account Type"::"Bank Account");
                        T_GJL.Validate("Bal. Account No.", GenJBatch."Bal. Account No.");
                        T_GJL."Posting Date" := today;
                        T_GJL."Document Date" := today;
                        IF (SalesL."Payment Method Code" = 'GOTOVINA') or (SalesL."Payment Method Code" = 'KARTIČNO') then
                            T_GJL.INSERT(TRUE);
                        LineNo += 100;
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", T_GJL);

                        PrintReklamirani_ORG(true, Rec);
                        SOrder.PrintDuplicateReklamniFiscal(true, rec."R. Fiscal No.");
                    end
                    else begin
                        SOrder.PrintDuplicateReklamniFiscal(true, rec."R. Fiscal No.");
                    end;

                end;
            }
            action("Fiscal print Correction")

            {
                Caption = 'Fiscal print Correction';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ShowF;

                trigger OnAction()
                var
                    UF: Report "Update Fiscal";

                begin
                    UF.run;
                end;
            }


            //SalesOrder
        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        SH: Record "Sales Header";
        Cut: Record "Customer Templ.";
        SL: Record "Sales Line";

    begin

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if US."Allowed update F" = true then
                ShowF := True
            else
                ShowF := false;

        end;

        DifferenceV := false;
        DifferenceR := false;
        sh.Reset;
        sh.SetFilter("No.", '%1', "Document No.");
        if sh.FindFirst() then begin

            if (sh."Old Price Date" <> 0D) and (sh."New Price" <> 0) then
                DifferenceV := true
            else
                DifferenceV := false;


            if DifferenceV = true then DifferenceR := true;

            SL.Reset();
            SL.SetFilter("Document No.", '%1', rec."Document No.");
            SL.SetFilter("R. Fiscal printed", '%1', true);

            if SL.FindFirst() then
                DifferenceR := true;



            if sh."Bill type" <> '' then begin
                Cut.Reset();
                Cut.SetFilter(Code, '%1', sh."Bill type");
                cut.SetFilter(CNG, '%1', true);
                if cut.FindFirst() then
                    CNG := false
                else
                    CNG := true;
            end
            else begin
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                us.SetFilter("CNG User", '%1', true);
                if us.FindFirst() then
                    cng := false
                else
                    CNG := true;
            end;
        end;
    end;




    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        SH: Record "Sales Header";
        Cut: Record "Customer Templ.";
        SL: Record "Sales Line";
    begin

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if US."Allowed update F" = true then
                ShowF := True
            else
                ShowF := false;

        end;

        if rec."Fiscal printed" = true then
            EditableD := false
        else
            EditableD := true;


        DifferenceV := false;
        sh.Reset;
        sh.SetFilter("No.", '%1', "Document No.");
        if sh.FindFirst() then begin

            if (sh."Old Price Date" <> 0D) and (sh."New Price" <> 0) then
                DifferenceV := true
            else
                DifferenceV := false;

            if DifferenceV = true then DifferenceR := true;

            SL.Reset();
            SL.SetFilter("Document No.", '%1', rec."Document No.");
            SL.SetFilter("R. Fiscal printed", '%1', true);

            if SL.FindFirst() then
                DifferenceR := true;

            if sh."Bill type" <> '' then begin
                Cut.Reset();
                Cut.SetFilter(Code, '%1', sh."Bill type");
                cut.SetFilter(CNG, '%1', true);
                if cut.FindFirst() then
                    CNG := false
                else
                    CNG := true;
            end
            else begin
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                us.SetFilter("CNG User", '%1', true);
                if us.FindFirst() then
                    cng := false
                else
                    CNG := true;
            end;
        end;
    end;


    procedure PrintReklamirani_ORG(Allow: Boolean; SalesL_R: Record "Sales Line")
    var
        Custt: Record Customer;
        SalesLineGet: Record "Sales Line";
        ImaZarez: Integer;
        Rezultat: Text[2000];
        RezultatKolicina: Text[2000];
        CijenaRez: Decimal;
        CZkF: record "User Setup";
        BankAccocunt: Record "Bank Account";


    begin
        clear(file1);
        clear(File5);

        GenL.get;
        Putanja := GenL."Path for fiscal printer";
        Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';
        CZkF.Get(UserId);
        BankAccocunt.Reset();
        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
        if BankAccocunt.findfirst then begin
            Putanja := BankAccocunt."Path for fiscal printer";
            Putanja2 := BankAccocunt."Path for fiscal printer" + 'odgovori\';
        end
        else begin
            Putanja := GenL."Path for fiscal printer";
            Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';
        end;

        File1.CREATE(Putanja + 'stampatireklamiraniracun.' + SalesL_R."Fiscal No.", TEXTENCODING::UTF8);
        File5.CREATE(Putanja + 'unosnovca.xml', TEXTENCODING::UTF8);
        File5.CREATEOUTSTREAM(OutStreamObj2);
        file1.CreateOutStream(OutStreamObj);

        Linije := '<?xml version="1.0" encoding="utf-8"?>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '<BrojZahtjeva>0</BrojZahtjeva>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '<VrstaZahtjeva>7</VrstaZahtjeva>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '<NoviObjekat>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '<Oznaka>Gotovina</Oznaka>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '<Iznos>' + FORMAT(SalesL_R."Amount Including VAT") + '</Iznos>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '</NoviObjekat>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();
        Linije := '</RacunZahtjev>';
        OutStreamObj2.WRITETEXT(Linije);
        OutStreamObj2.WRITETEXT();

        File5.CLOSE;
        FileManagement.DownloadToFile(Putanja + 'unosnovca.xml', Putanja + 'unosnovca.xml');
        GL.Get();
        Commit();

        SLEEP(GL."Sleep value");



        //reklamirani račun
        plite := '<?xml version="1.0" encoding="utf-8"?>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<BrojZahtjeva>' + SalesL_R."Fiscal No." + '</BrojZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<VrstaZahtjeva>2</VrstaZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<NoviObjekat>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<Datum>0001-01-01T00:00:00</Datum>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        /*   plite := '<Kupac>';
           OutStreamObj.WRITETEXT(plite);
           OutStreamObj.WRITETEXT();
           Custt.RESET;
           Custt.SETFILTER("No.", '%1', SalesL_R."Bill-to Customer No.");
           IF Custt.FINDFIRST THEN
               plite := '<IDbroj>' + Custt."Registration No." + '</IDbroj>';
           OutStreamObj.WRITETEXT(plite);
           OutStreamObj.WRITETEXT();
           //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
           plite := '<Naziv>' + Custt.Name + '</Naziv>';
           OutStreamObj.WRITETEXT(plite);
           OutStreamObj.WRITETEXT();

           //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

           plite := '<Adresa>' + Custt.Address + '</Adresa>';
           OutStreamObj.WRITETEXT(plite);
           OutStreamObj.WRITETEXT();

           //<PostanskiBroj>75320</PostanskiBroj>

           plite := '<PostanskiBroj>' + Custt."Post Code" + '</PostanskiBroj>';
           OutStreamObj.WRITETEXT(plite);
           OutStreamObj.WRITETEXT();
           plite := '<Grad>' + Custt.City + '</Grad>';
           OutStreamObj.WRITETEXT(plite);
           OutStreamObj.WRITETEXT();

           plite := '</Kupac>';
           OutStreamObj.WRITETEXT(plite);
           OutStreamObj.WRITETEXT();
           //</Kupac>
   */

        plite := '<StavkeRacuna>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<RacunStavka>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        plite := '<artikal>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Sifra>' + FORMAT('482') + '</Sifra>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Naziv>' + FORMAT('Iznos po fakturi ' + SalesL_R."Document No.") + ' za CNG' + '</Naziv>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<JM>' + SalesL_R."Unit of Measure Code" + '</JM>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        if SalesL_R.Quantity <> 0 then
            ImaZarez := STRPOS(FORMAT(round(SalesL_R."Amount Including VAT" / SalesL_R.Quantity, 0.01, '=')), ',') + 1
        else
            ImaZarez := STRPOS(FORMAT(round(0, 0.01, '=')), ',') + 1;
        //ROUND(s121, 0.01, '=');

        /*    IF STRPOS(FORMAT(COPYSTR(FORMAT(salesl."Unit Price" / salesl.Quantity), ImaZarez, 2)), '00') = 0 THEN
                Rezultat := ChangeSeparator(FORMAT(salesl."Amount Including VAT" / salesl.Quantity, 0, '<Sign><Integer><Decimals><Comma,.>'))
            ELSE
                Rezultat := ChangeSeparator(FORMAT(ROUND(salesl."Amount Including VAT" / salesl.Quantity)));*/

        CijenaRez := round(SalesL_R."Unit Price" + SalesL_R."Unit Price" * SalesL_R."VAT %" / 100, 0.01, '=');

        IF STRPOS(FORMAT(COPYSTR(FORMAT(CijenaRez), ImaZarez, 2)), '00') = 0 THEN
            Rezultat := ChangeSeparator(FORMAT(CijenaRez, 0, '<Sign><Integer><Decimals><Comma,.>'))
        ELSE
            Rezultat := ChangeSeparator(FORMAT(ROUND(CijenaRez), 0, '<Precision,2:2><Standard Format,2>'));


        plite := '<Cijena>' + Rezultat + '</Cijena>';


        //strsubstno(text01,format(100.10,0,'<Precision,2:2><Standard Format,0>'))
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        IF SalesL_R.Amount - SalesL_R."Amount Including VAT" < 0 THEN
            plite := '<Stopa>E</Stopa>'
        ELSE
            plite := '<Stopa>K</Stopa>';


        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '</artikal>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();




        //   plite := '<Kolicina>1</Kolicina>';

        IF STRPOS(FORMAT(COPYSTR(FORMAT(SalesL_R.Quantity), ImaZarez, 2)), '00') = 0 THEN
            RezultatKolicina := ChangeSeparator(FORMAT(SalesL_R.Quantity, 0, '<Sign><Integer><Decimals><Comma,.>'))
        ELSE
            RezultatKolicina := ChangeSeparator(FORMAT(ROUND(SalesL_R.Quantity), 0, '<Precision,2:2><Standard Format,2>'));

        plite := '<Kolicina>' + format(RezultatKolicina) + '</Kolicina>';

        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();




        plite := '<Rabat>0</Rabat>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</RacunStavka>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '</StavkeRacuna>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<VrstePlacanja/>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<VrstaPlacanja>';


        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        if SalesL_R."Payment Method Code" = 'VIRMAN' then
            plite := '<Oznaka>' + 'Virman' + '</Oznaka>';
        if SalesL_R."Payment Method Code" = 'GOTOVINA' then
            plite := '<Oznaka>' + 'Gotovina' + '</Oznaka>';
        if SalesL_R."Payment Method Code" = 'KARTIČNO' then
            plite := '<Oznaka>' + 'Kartica' + '</Oznaka>';
        if SalesL_R."Payment Method Code" = 'VLASTITA' then
            plite := '<Oznaka>' + 'Virman' + '</Oznaka>';


        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Iznos>' + '0' + '</Iznos>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        plite := '</VrstaPlacanja>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</VrstePlacanja>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        plite := '<BrojRacuna>' + SalesL_R."Fiscal No." + '</BrojRacuna>';

        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</NoviObjekat>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</RacunZahtjev>';

        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        File1.CLOSE;
        IF SalesL_R."R. Fiscal printed" = FALSE THEN begin
            Putanja2 := GL."Path for fiscal printer" + 'odgovori\';

            CZkF.Get(UserId);
            BankAccocunt.Reset();
            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
            if BankAccocunt.findfirst then begin

                Putanja2 := BankAccocunt."Path for fiscal printer" + 'odgovori\';
            end
            else begin

                Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';
            end;


            FileManagement.DownloadToFile(Putanja + 'stampatireklamiraniracun.' + SalesL_R."Fiscal No.", Putanja + 'stampatireklamiraniracun.' + SalesL_R."Fiscal No.");

            //   Odgovor(Putanja2 + 'stampatireklamiraniracun.' + SalesL_R."Fiscal No.");
            CZkF.Get(UserId);
            BankAccocunt.Reset();
            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
            if BankAccocunt.findfirst then begin
                BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series R. FIscal No.", TODAY, true);

            end;


            Rec."R. Fiscal printed" := true;
            Rec."R. Fiscal No." := BrojFiskalnogRacuna;
            Rec."R. Fiscal DateTime" := CURRENTDATETIME;
            Rec."R. Fiscal User" := USERID;
            if SalesLineGet.get(rec."Document Type", rec."Document No.", rec."Line No.") then begin
                SalesLineGet."R. Fiscal printed" := true;
                SalesLineGet.Type := SalesLineGet.type::" ";
                SalesLineGet."No." := '';
                SalesLineGet."Location Code" := '';
                SalesLineGet."R. Fiscal No." := BrojFiskalnogRacuna;
                SalesLineGet."R. Fiscal DateTime" := CURRENTDATETIME;
                SalesLineGet."R. Fiscal User" := USERID;
                SalesLineGet."Old Quantity" := rec.Quantity;
                SalesLineGet."Unit Price" := 0;
                SalesLineGet.Amount := 0;
                SalesLineGet."VAT %" := 0;
                SalesLineGet."Amount Including VAT" := 0;
                SalesLineGet."VAT Base Amount" := 0;
                SalesLineGet."Line Amount" := 0;
                SalesLineGet."Shipment create" := true;
                SalesLineGet."New Price" := false;
                SalesLineGet.Quantity := 0;
                SalesLineGet.Modify();

            end;


            /*
             key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        */
            //        Rec.MODIFY(true);


        end
        else begin
            //duplikat reklamirani

            File1.CREATE(Putanja + 'stampatiduplikatreklamiranogracuna.xml', TEXTENCODING::UTF8);
            //File1.CREATE('\\FORTNAV\Temp\snd.xml',TEXTENCODING::UTF8);
            File1.CREATEOUTSTREAM(OutStreamObj);
            plite := '';

            plite := '<?xml version="1.0" encoding="utf-8"?>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<BrojZahtjeva>946717</BrojZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<VrstaZahtjeva>4</VrstaZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Naziv>BrojRacuna</Naziv>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Vrijednost>' + SalesL_R."R. Fiscal No." + '</Vrijednost>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</Zahtjev>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            File1.CLOSE;
            FileManagement.DownloadToFile(Putanja + 'stampatiduplikatreklamiranogracuna.xml', Putanja + 'stampatiduplikatreklamiranogracuna.xml');


        end;
        //ELSE
        //FileManagement.DownloadToFile(Putanja+'srr.reklamirani - Copy.xml',Putanja+'srr.reklamirani - Copy.xml');
    end;

    procedure Odgovor(Upit: Text[2000])

    var
        myInt: Integer;
        XMLManagement: Codeunit "XML DOM Management";
        UlazniRacun: Code[20];
        ReklamniDA: Boolean;
        ImaZarez: Integer;
        TextCitanje: BigText;
        Rezultat: Text[2000];
        TotalCijena2: Decimal;
        Sallesr: Record "Sales Cr.Memo Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Iznoss: Decimal;

        xmlDomdoc: XmlDocument;
        TextPos: Integer;
        xmldomDoc3: XmlDocument;
        xmldomDoc2: XmlDocument;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        xmlNodeList1: XmlNodeList;
        xmlNodeList2: XmlNodeList;
        xmlNodeList3: XmlNodeList;
        xmlNodeList4: XmlNodeList;
        xmlNodeList6: XmlNodeList;

        NodeVale: XmlNode;
        SystemXmlNodeValue: DotNet SystemXmlNode;
        SystemXmlNodeValue2: DotNet SystemXmlNode;
        SystemXmlNodeValue3: DotNet SystemXmlNode;
        SystemXmlNodeValue4: DotNet SystemXmlNode;

        ChildNode: DotNet SystemXmlNode;

        ChildNodeList: DotNet SystemXmlNodeList;

        i: Integer;
        j: Integer;
        xmlNodeList5: XmlNodeList;
        //TempBlob: Record TempBlob;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text[2000];
        ReadLine2: Text[2000];
        VrstaOdgovora: Text[2000];
        strInStream: InStream;
        x1: Text[2000];
        x2: Text[2000];
        x3: Text[2000];
        x4: Text[2000];
        XMLFileOutStr: OutStream;
        ToFileName: Text[2000];
        x5: Text[2000];
        x6: Text[2000];
        Zamjena: Text[2000];


        Custt: Record Customer;
        Putanja: Text[250];
        OutStreamObj2: OutStream;
        Linije: Text[2000];

        File5: File;
        Putanja2: Text[250];
        SystemXmlNodeListValue: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue2: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue3: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue4: DotNet SystemXmlNodeList;

        TXTTab: Char;
        Instr: InStream;
        filename: Text[2000];
        filepath: Text[2000];
        SalesHeader: Record "Sales Invoice Header";
        XMLDomDocParam: DotNet SystemXmlDocument;

        SystemDokument: Dotnet SystemXmlDocument;
        SubText: Text[2000];
        OutStreamObj: OutStream;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        plite: Text[2000];
        SalesInvoiceLine: Record "Sales Invoice Line";
        Salles: Record "Sales Invoice Line";
        TotalCijena: Decimal;
        FileManagement: Codeunit "File Management";


    begin
        TXTTab := 13;
        //Upit:='\\DESKTOP-B6A3125\odgovori\sfr';
        IF EXISTS(Upit + '_1' + '.xml') THEN
            ERASE(Upit + '_1' + '.xml');
        IF EXISTS(Upit) THEN BEGIN
            Charr := 10;
            importFile.WRITEMODE(TRUE);
            importFile.TEXTMODE(TRUE);
            importFile.OPEN(Upit);
            importFile2.WRITEMODE(TRUE);
            importFile2.TEXTMODE(TRUE);
            IF NOT EXISTS(Upit + '_1' + '.xml') THEN
                importFile2.CREATE(Upit + '_1' + '.xml');


            WHILE importFile.READ(ReadLine) > 0 DO BEGIN

                x1 := 'xml';
                x2 := 'Kasa';
                x3 := 'VrstaOdgovora';
                x4 := 'Naziv';
                x5 := 'Vrijednost';
                X6 := 'Odgovor';
                IF (STRPOS(ReadLine, x1) = 0) THEN BEGIN
                    IF (STRPOS(ReadLine, x2) = 0) THEN BEGIN
                        IF (STRPOS(ReadLine, x3) = 0) THEN BEGIN
                            IF (STRPOS(ReadLine, x4) <> 0) THEN BEGIN

                                //<Naziv>BrojFiskalnogRacuna</Naziv>
                                Zamjena := COPYSTR(ReadLine, STRLEN('<Naziv>') + 7, STRLEN(ReadLine) - STRLEN('<Naziv></Naziv>') - 6);

                            END;
                            IF (STRPOS(ReadLine, x5) <> 0) THEN BEGIN
                                ReadLine2 := '<' + Zamjena + '>' + COPYSTR(ReadLine, STRPOS(ReadLine, '">') + 2, STRLEN(ReadLine) - STRPOS(ReadLine, '">') - STRLEN('</Vrijednost>') - 1) + '</' + Zamjena + '>';
                                importFile2.WRITE(ReadLine2 + FORMAT(Charr));
                            END;
                            IF STRPOS(ReadLine, X6) <> 0 THEN BEGIN
                                importFile2.WRITE(ReadLine);
                            END;


                        END
                        ELSE BEGIN
                            VrstaOdgovora := COPYSTR(ReadLine, STRLEN('<VrstaOdgovora>') + 3, STRLEN(ReadLine) - STRLEN('<VrstaOdgovora></VrstaOdgovora>') - 2)
                        END;


                    END;

                END;

                importFile2.CREATEINSTREAM(strInStream);
                importFile2.CREATEOUTSTREAM(XMLFileOutStr);
            END;
        END;



        importFile.CLOSE;
        importFile2.CLOSE;


        ToFileName := Upit + '_1' + '.xml';

        CLEAR(xmldomDoc2);
        CLEAR(xmlNodeList1);
        CLEAR(xmlNodeList2);
        CLEAR(xmlNodeList3);
        CLEAR(xmlNodeList4);
        CLEAR(xmlNodeList5);
        CLEAR(xmlNodeList6);

        //ĐK xmldomDoc2 := XmlDocument.Create();
        XMLDomDocParam := XMLDomDocParam.XmlDocument();
        XMLDomDocParam.Load(Upit + '_1' + '.xml');
        SystemXmlNodeListValue := XMLDomDocParam.GetElementsByTagName('BrojFiskalnogRacuna');
        SystemXmlNodeListValue2 := XMLDomDocParam.GetElementsByTagName('DatumFiskalnogRacuna');
        SystemXmlNodeListValue3 := XMLDomDocParam.GetElementsByTagName('VrijemeFiskalnogRacuna');
        SystemXmlNodeListValue4 := XMLDomDocParam.GetElementsByTagName('IznosFiskalnogRacuna');

        FOR i := 0 TO SystemXmlNodeListValue.Count - 1 DO BEGIN
            SystemXmlNodeValue := SystemXmlNodeListValue.Item(i);
            SystemXmlNodeValue2 := SystemXmlNodeListValue2.Item(i);
            SystemXmlNodeValue3 := SystemXmlNodeListValue3.Item(i);
            SystemXmlNodeValue4 := SystemXmlNodeListValue4.Item(i);




            BrojFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            DatumFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            VrijemeFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            IznosFiskalnogRacuna := SystemXmlNodeValue.InnerText;




        END;




    end;

    procedure ChangeSeparator(Number: Text[2000]) NumberConvert: Text


    begin
        IF STRLEN(Number) > 2 THEN BEGIN
            IF COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2) = ',' THEN BEGIN
                NumberConvert := COPYSTR(FORMAT(Number), 1, STRLEN(FORMAT(Number)) - 2) + '.' + COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2);
            END
            ELSE BEGIN
                NumberConvert := FORMAT(Number);
            END;
        END
        ELSE BEGIN
            NumberConvert := FORMAT(Number);
        END;

    end;


    local procedure TransferHeaderPost_GAS(var TransHeader: Record "Transfer Header")
    var
        TransLine: Record "Transfer Line";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        DefaultNumber: Integer;
        Selection: Option " ",Shipment,Receipt;
        IsHandled: Boolean;
    begin
        if IsHandled then
            exit;

        with TransHeader do begin
            TransLine.SetRange("Document No.", "No.");
            if TransLine.Find('-') then
                repeat
                    if (TransLine."Quantity Shipped" < TransLine.Quantity) and
                       (DefaultNumber = 0)
                    then
                        DefaultNumber := 1;
                    if (TransLine."Quantity Received" < TransLine.Quantity) and
                       (DefaultNumber = 0)
                    then
                        DefaultNumber := 2;

                    "Direct Transfer" := true;
                until (TransLine.Next = 0) or (DefaultNumber > 0);
            if "Direct Transfer" then begin
                TransferPostShipment.Run(TransHeader);
                TransferPostReceipt.Run(TransHeader);
            end else begin
                if DefaultNumber = 0 then
                    DefaultNumber := 1;
                case Selection of
                    0:
                        exit;
                    Selection::Shipment:
                        TransferPostShipment.Run(TransHeader);
                    Selection::Receipt:
                        TransferPostReceipt.Run(TransHeader);
                end;
            end;
        end;

    end;


    var
        myInt: Integer;
        ShowF: Boolean;

        EditableD: Boolean;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        CNG: Boolean;
        US: Record "User Setup";
        DifferenceV: Boolean;
        DifferenceR: Boolean;
        Permission: Label 'You cannot change the value!';

        File1: File;
        File5: File;
        plite: text[250];
        OutStreamObj2: OutStream;
        Linije: Text[2000];
        FileManagement: Codeunit "File Management";

        Putanja: text[250];
        GL: Record "General Ledger Setup";

        OutStreamObj: OutStream;
        GenL: Record "General Ledger Setup";
        Putanja2: text[250];

        BrojFiskalnogRacuna: text[250];
        DatumFiskalnogRacuna: Text[2000];
        IznosFiskalnogRacuna: Text[2000];

        VrijemeFiskalnogRacuna: Text[2000];
        trh: Record "Transfer Receipt Header";
}