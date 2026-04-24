
pageextension 50065 "Posted Whse Shipment" extends "Posted Whse. Shipment"
{
    layout
    {
        addafter("Posting Date")
        {


            field("Employee No."; "Employee No.")
            {
                ApplicationArea = All;
            }
            field("Employee Name"; "Employee Name")
            {
                ApplicationArea = All;
            }

            field("Document No."; "Document No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Order Date"; "Order Date")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field(Transferred; Rec.Transferred)
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("Sales Header No."; "Sales Header No.") { Editable = false; }
            field("RN Source"; "RN Source") { Editable = false; }
            field(Address; Address) { Editable = false; }
            field("G/L Account No."; "G/L Account No.") { Editable = false; }
        }

        modify("Zone Code") { Visible = false; }
        modify("Bin Code") { Visible = false; }
        modify("Assigned User ID") { Visible = false; }
        modify("Assignment Date") { Visible = false; }
        modify("Assignment Time") { Visible = false; }

        addfirst(factboxes)
        {
            part(ItemLedgerEntry; "Item Ledger Entry Factbox")
            {
                ApplicationArea = Warehouse;
                Caption = 'Serial numbers';
                Provider = WhseShptLines;
                SubPageLink = "Item No." = FIELD("Item No."), "Order No." = FIELD("Source No."), Positive = filter(true), "SKLOT No." = field("No.");
                //  Visible = true;
            }
        }
    }

    actions
    {
        addafter("&Print")
        {
            action("Transfer to item journal")
            {
                ApplicationArea = Warehouse;
                Caption = 'Transfer to item journal';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'This action will transfer the lines in this document to item journal.';

                trigger OnAction()
                var
                    WhseShipmentHeader: Record "Posted Whse. Shipment Header";
                    WhseShipmentLine: Record "Posted Whse. Shipment Line";
                    TSH: Record "Transfer Shipment Header";
                    ItemJournalLine: Record "Item Journal Line";
                    NewLineNo: Integer;
                    MaxLineNo: Integer;
                    ErrorExists: Boolean;
                    EntryType: Enum "Item Ledger Entry Type";
                    OpenItemJournalLinePage: Boolean;
                    LocationCode: Code[10];
                    GenBusPostingGrp: Code[20];
                    I: Record Item;
                begin
                    LocationCode := '';
                    WhseShipmentHeader.Reset();
                    WhseShipmentHeader.Get(Rec."No.");
                    Response := Confirm(Label001);
                    if Response then begin

                        WhseShipmentLine.Reset();
                        WhseShipmentLine.SetFilter("No.", Rec."No.");
                        if WhseShipmentLine.FindSet() then
                            repeat
                                MaxLineNo := 0;
                                //Prvo dobij linije skl otpremnice i idi kroz svaku od njih
                                ItemJournalLine.Reset();
                                ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
                                ItemJournalLine.SetRange("Journal Batch Name", 'ZADANO');
                                ItemJournalLine.SetRange("Document No.", WhseShipmentHeader."No.");
                                ItemJournalLine.SetRange("Item No.", WhseShipmentLine."Item No.");
                                if ItemJournalLine.FindFirst() then begin
                                    Error(Label002, WhseShipmentLine."Line No.", WhseShipmentLine."Item No.", WhseShipmentHeader."No.");
                                    ErrorExists := true;
                                    exit;
                                end;
                                //saznaj max LineNo
                                ItemJournalLine.Reset();
                                ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
                                ItemJournalLine.SetRange("Journal Batch Name", 'ZADANO');
                                if ItemJournalLine.FindLast() then
                                    MaxLineNo := ItemJournalLine."Line No.";

                                if MaxLineNo = 0 then
                                    NewLineNo := WhseShipmentLine."Line No."
                                else
                                    NewLineNo := MaxLineNo + 1;

                                ItemJournalLine.Reset();
                                ItemJournalLine.SetRange("Journal Template Name", 'ITEM');
                                ItemJournalLine.SetRange("Journal Batch Name", 'ZADANO');
                                ItemJournalLine.SetRange("Line No.", WhseShipmentLine."Line No.");
                                if ItemJournalLine.FindFirst() then begin
                                    if ItemJournalLine."Document No." = WhseShipmentHeader."No." then begin
                                        Error(Label002, WhseShipmentLine."Line No.", WhseShipmentLine."Item No.", WhseShipmentHeader."No.");
                                        ErrorExists := true;
                                        break;
                                    end else begin
                                        NewLineNo := MaxLineNo + 1;
                                    end;
                                end else begin
                                    NewLineNo := WhseShipmentLine."Line No.";
                                end;

                                //Saznaj Location Code za insert u nalog knjiženja artikla:
                                TSH.Reset();
                                TSH.SetFilter("No.", '%1', WhseShipmentLine."Posted Source No.");
                                if TSH.FindFirst() then begin
                                    LocationCode := TSH."Transfer-to Code";
                                end;

                                //Saznaj koji konto staviti u Gen. Bus. Posting Group
                                I.Reset();
                                I.SetRange("No.", WhseShipmentLine."Item No.");
                                if I.FindFirst() then begin
                                    case I."Inventory Posting Group" of
                                        '10101':
                                            GenBusPostingGrp := '51101';
                                        '10103':
                                            GenBusPostingGrp := '51105';
                                        '10140':
                                            GenBusPostingGrp := '51103';
                                        '10180':
                                            GenBusPostingGrp := '51104';
                                        '1021':
                                            GenBusPostingGrp := '51301';
                                        '1040':
                                            GenBusPostingGrp := '51400';
                                        else
                                            GenBusPostingGrp := 'DOMAĆI';
                                    end;
                                end;

                                if not ErrorExists then begin
                                    ItemJournalLine.Init();
                                    ItemJournalLine.Validate("Journal Template Name", 'ITEM');
                                    ItemJournalLine.Validate("Journal Batch Name", 'ZADANO');
                                    ItemJournalLine.Validate("Line No.", NewLineNo);
                                    ItemJournalLine.Validate("Posting Date", WhseShipmentHeader."Posting Date");
                                    ItemJournalLine.Validate("Document No.", WhseShipmentHeader."No.");
                                    ItemJournalLine.Validate("Item No.", WhseShipmentLine."Item No.");
                                    ItemJournalLine.Validate(Quantity, WhseShipmentLine.Quantity);
                                    ItemJournalLine.Validate("Gen. Bus. Posting Group", GenBusPostingGrp);
                                    ItemJournalLine.Validate("Entry Type", EntryType::"Negative Adjmt.");
                                    ItemJournalLine.Validate("Location Code", LocationCode);
                                    ItemJournalLine.Insert();
                                    //Commit();
                                end;
                            until WhseShipmentLine.Next() = 0;
                        if not ErrorExists then begin
                            OpenItemJournalLinePage := Confirm(Label003);
                            if OpenItemJournalLinePage then begin
                                Clear(ItemJournalLine);
                                ItemJournalLine.SetRange("Document No.", WhseShipmentHeader."No.");
                                Page.Run(Page::"Item Journal", ItemJournalLine);
                            end;

                            //Označi kvakicu na zaglavlju da je uspješno prebačeno u nalog knjiženja artikla
                            WhseShipmentHeader.Reset();
                            WhseShipmentHeader.SetFilter("No.", Rec."No.");
                            WhseShipmentHeader.Transferred := true;
                            WhseShipmentHeader.Modify();
                            CurrPage.Update(false);
                        end;
                    end;
                end;
            }
            action("Transfer ID of mployee")
            {
                ApplicationArea = Warehouse;
                Caption = 'Transfer ID of employee';
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'This action will transfer the ID of responsible employee to Item Ledger Entry.';

                trigger OnAction()
                var
                    PWSH: Record "Posted Whse. Shipment Header";
                    ILE: Record "Item Ledger Entry";
                    E: Record Employee;
                    Counter: Integer;
                    Response: Boolean;
                    dokumentiList: List of [Text];
                    dokumenti: Text;
                    dokumentiEntry: Text;
                    PWSHNo: Text;
                    ModifyILE: Codeunit UpdateEmployeeItemLedgerEntry;
                    Txt001: Label 'Are you sure you want to transfer Employee Nos to corresponding lines in Item Ledger Entry?';
                    Txt002: Label 'Nothing to process.';
                    Txt003: Label 'Process completed. Number of items affected: %1. Affected documents: %2.';
                begin
                    Counter := 0;
                    dokumenti := '';
                    Clear(dokumentiList);
                    Response := Confirm(Txt001);
                    if Response then begin
                        PWSH.Reset();
                        PWSH.SetFilter("Employee No.", '<>%1', '');
                        if PWSH.FindSet() then
                            repeat
                                E.Reset();
                                E.Get(PWSH."Employee No.");
                                if ModifyILE.UpdateItemLedgerEntry(PWSH."Employee No.", E."First Name" + ' ' + E."Last Name", PWSH."No.") then begin
                                    Counter += 1;
                                    PWSHNo := PWSH."No.";
                                    if NOT dokumentiList.Contains(PWSHNo) then begin
                                        dokumentiList.Add(PWSHNo);
                                    end;
                                end;
                            until PWSH.Next() = 0;
                    end;

                    foreach dokumentiEntry in dokumentiList do begin
                        if dokumenti = '' then
                            dokumenti := dokumentiEntry
                        else
                            dokumenti := dokumenti + ', ' + dokumentiEntry;
                    end;
                    if Counter = 0 then
                        Message(Txt002)
                    else
                        Message(Txt003, Counter, dokumenti);

                end;
            }
        }
    }

    var
        Response: Boolean;
        Label001: Label 'Are you sure you want to transfer data to item journal?';
        Label002: Label 'The item with the following parameters have already been transferred to Item Journal Line:\nLine No: %1,\nItem No: %2,\nDocument No: %3';
        Label003: Label 'The lines have been succesfully transferred. \Do you want to open the Item Journal Line page?';
}