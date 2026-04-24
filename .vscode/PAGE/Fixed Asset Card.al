pageextension 50036 "Fixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        // Add changes to page layout here
        modify(Acquired)
        {
            Visible = False;
        }



        addafter(DepreciationStartingDate)
        {

            field("FA Posting Date"; "FA Posting Date")
            {
                ApplicationArea = all;
                DrillDown = true;
                trigger OnDrillDown()
                var
                    OrderNO: Integer;
                begin
                    FALedgerEntry.Reset();
                    FALedgerEntry.SetFilter("FA No.", '%1', "No.");
                    FALedgerEntry.SetFilter("Part of Book Value", '%1', true);
                    FALedgerEntry.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALedgerEntry.SetFilter("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                    FALedgerEntry.SetCurrentKey("FA Posting Date");
                    Ascending;
                    OrderNO := 0;
                    if FALedgerEntry.FINDSET then
                        repeat
                            if (FALedgerEntry."Entry No." < OrderNO) or (OrderNO = 0) then
                                OrderNO := FALedgerEntry."Entry No.";
                        until FALedgerEntry.NEXT = 0;
                    FALedgerEntry.SetFilter("Entry No.", '%1', OrderNO);

                    FALedgerEntries.SetTableView(FALedgerEntry);
                    FALedgerEntries.Run();
                    CurrPage.Update();
                end;
            }

            field("Activation Date"; "Activation Date") { ApplicationArea = all; Editable = false; }
            field("FA Depreciation Date"; "FA Depreciation Date") { ApplicationArea = all; Editable = false; }

        }
        modify(FAPostingGroup)
        {
            trigger OnAfterValidate()
            var
                FADep: Record "FA Depreciation Book";
                FAPosting: Record "FA Posting Group";
            begin

                FADep.Reset();
                FADep.SetFilter("FA No.", '%1', Rec."No.");
                if FADep.FindFirst() then begin
                    FAPosting.Reset();
                    FAPosting.SetFilter(Code, '%1', FADep."FA Posting Group");
                    if FAPosting.FindFirst() then begin
                        Rec."FA Posting Group" := FAPosting."Acquisition Cost Account";
                    end;
                end
                else begin
                    Rec."FA Posting Group" := '';
                end;
                rec.Modify();

            end;




            trigger OnDrillDown()
            var
                GLE: Record "G/L Entry";
                PageGLE: page "General Ledger Entries";
            begin

                GLE.Reset();
                GLE.SetFilter("G/L Account No.", '%1', Rec."FA Posting Group");
                GLE.SetFilter("Source No.", '%1', Rec."No.");
                if GLE.FindSet() then begin
                    PageGLE.SetTableView(GLE);
                    PageGLE.run;
                end;
            end;
        }
        modify("FA Location Code")
        {
            Visible = False;
        }
        modify(NumberOfDepreciationYears) //R
        {
            Visible = false;
        }
        modify(DepreciationEndingDate) //R
        {
            Visible = false;
        }
        modify(DepreciationTableCode) //R
        {
            Visible = false;
        }
        modify(AddMoreDeprBooks) //R
        {
            Visible = false;
        }
        modify("Budgeted Asset") { Visible = false; }
        modify(Insured) { Visible = false; }
        modify("No.") { Visible = true; Caption = 'Inventory number'; }
        moveafter("No."; "Serial No.")

        modify("Responsible Employee") { Visible = false; }

        addafter("No.")
        {
            field("Old No."; Rec."OLd No.")
            {
                ApplicationArea = All;
            }
        }






        addafter("Last Date Modified")
        {
            field("Customer No."; "Customer No.") { LookupPageId = Obligations; }
            field("Customer Name"; "Customer Name")
            {

                Editable = false;
                LookupPageId = Obligations;
            }
            field("Posted Whse. Receipt Line."; "Posted Whse. Receipt Line.")
            {
                Editable = false;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    PW: Record "Posted Whse. Receipt Line";
                    PWPage: Page "Posted Whse. Receipt";
                    PHeader: Record "Posted Whse. Receipt Header";
                begin
                    pw.Reset();
                    pw.SetFilter("Item No.", '%1', "No.");
                    pw.SetCurrentKey("Posting Date");
                    PW.Ascending;
                    if pw.FindLast() then begin
                        PHeader.Reset();
                        PHeader.SetFilter("No.", '%1', pw."No.");
                        if PHeader.findfirst then begin
                            PWPage.SetTableView(PHeader);
                            PWPage.Run();
                        end;
                    end;


                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    PW: Record "Posted Whse. Receipt Line";
                    PWPage: Page "Posted Whse. Receipt";
                    PHeader: Record "Posted Whse. Receipt Header";
                begin
                    pw.Reset();
                    pw.SetFilter("Item No.", '%1', "No.");
                    pw.SetCurrentKey("Posting Date");
                    PW.Ascending;
                    if pw.FindLast() then begin
                        PHeader.Reset();
                        PHeader.SetFilter("No.", '%1', pw."No.");
                        if PHeader.findfirst then begin
                            PWPage.SetTableView(PHeader);
                            PWPage.Run();
                        end;
                    end;


                end;

            }

            field("R.Employee Obligation"; "R.Employee Obligation")
            {
                LookupPageId = Obligations2;
            }
            field(ObligationResponsible; Obligation."Responsible Person Name")
            {
                Caption = 'Responsible Persona Name';
                Editable = false;
                LookupPageId = Obligations2;
                DrillDownPageId = Obligations2;
            }
            field(OLocation; Obligation."Location Code")
            {
                Caption = 'Location Code';
                Editable = false;
                LookupPageId = Obligations2;
                DrillDownPageId = Obligations2;
            }
            field(OLocationName; Obligation."Location Name")
            {
                Caption = 'Location Name';
                Editable = false;
                LookupPageId = Obligations2;
                DrillDownPageId = Obligations2;
            }
        }

        addbefore(DepreciationTableCode) //R
        {



            field(PurchValue2; PurchValue2)
            {
                Editable = false;
                Caption = 'Purchase value';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    OrderNO: Integer;
                begin
                    FALedgerEntry.Reset();
                    FALedgerEntry.SetFilter("FA No.", '%1', "No.");
                    FALedgerEntry.SetFilter("Part of Book Value", '%1', true);
                    FALedgerEntry.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALedgerEntry.SetFilter("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                    FALedgerEntry.SetCurrentKey("FA Posting Date");
                    Ascending;
                    //test
                    OrderNO := 0;
                    if FALedgerEntry.FINDSET then
                        repeat
                            if (FALedgerEntry."Entry No." < OrderNO) or (OrderNO = 0) then
                                OrderNO := FALedgerEntry."Entry No.";
                        until FALedgerEntry.NEXT = 0;
                    FALedgerEntry.SetFilter("Entry No.", '%1', OrderNO);
                    //
                    FALedgerEntries.SetTableView(FALedgerEntry);
                    FALedgerEntries.Run();
                    CurrPage.Update();
                end;
            }
            field("Value correction"; "Value correction")
            {
                Editable = false;
                Caption = 'Value correction';
            }
            field(WriteDown2; WriteDown2)
            {
                Editable = false;
                Caption = 'Write-Down';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    WAmount: Decimal;
                    FALE: Record "FA Ledger Entry";
                    FALE2: Record "FA Ledger Entry";
                    BrojStavke: Text;
                begin
                    WAmount := 0;
                    BrojStavke := '';
                    FALE.Reset();
                    FALE.SetFilter("FA No.", '%1', "No.");
                    FALE.SetFilter("Part of Book Value", '%1', true);
                    FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALE.SetFilter("Document Type", '%1', FALE."Document Type"::Invoice);
                    FALE.SetFilter("Amount (LCY)", '<%1', 0);
                    IF FALE.FindSet() then
                        repeat
                            // WAmount += FALE."Amount (LCY)";
                            BrojStavke += format(FALE."Entry No.") + '|';
                        until FALE.Next() = 0;

                    FALE2.Reset();
                    FALE2.SetFilter("FA No.", '%1', "No.");
                    FALE2.SetFilter("Part of Book Value", '%1', true);
                    FALE2.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALE2.SetFilter("FA Posting Type", '%1', FALE2."FA Posting Type"::"Write-Down");
                    IF FALE2.FindSet() then
                        repeat
                            //   WAmount += FALE2."Amount (LCY)";
                            BrojStavke += format(FALE2."Entry No.") + '|';
                        until FALE2.Next() = 0;

                    if StrLen(BrojStavke) >= 2 then
                        BrojStavke := CopyStr(BrojStavke, 1, StrLen(BrojStavke) - 1);

                    FALE.Reset();
                    FALE.SetFilter("FA No.", '%1', "No.");
                    FALE.SetFilter("Part of Book Value", '%1', true);
                    FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    if BrojStavke = '' then
                        FALE.setfilter("Entry No.", '%1', 0)
                    else
                        FALE.setfilter("Entry No.", BrojStavke);

                    // WriteDown2 := WAmount;

                    FALedgerEntries.SetTableView(FALE);
                    FALedgerEntries.Run();
                    CurrPage.Update();
                end;
            }
            field(Appreciation2; Appreciation2)
            {
                Editable = false;
                Caption = 'Appreciation';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    AAmount: Decimal;
                    FALE: Record "FA Ledger Entry";
                    FALE2: Record "FA Ledger Entry";
                    BrojStavke: Text;
                    OrderNo: Integer;
                begin
                    //Filtriram tabelu da dobijem nabavnu vrijednost, a onda spremam Broj stavke u OrderNO
                    FALE.Reset();
                    FALE.SetFilter("FA No.", '%1', "No.");
                    FALE.SetFilter("Part of Book Value", '%1', true);
                    FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALE.SetFilter("FA Posting Type", '%1', FALE."FA Posting Type"::"Acquisition Cost");
                    FALE.SetCurrentKey("FA Posting Date");
                    Ascending;
                    OrderNo := 0;

                    //ovako sam našla nabavu
                    if FALE.FindFirst()
                       then
                        OrderNo := FALE."Entry No."
                    else
                        OrderNo := 0;

                    //Filtriram tabelu da nađem povećanja kroz fakturu
                    AAmount := 0;
                    BrojStavke := '';
                    FALE.Reset();
                    FALE.SetFilter("FA No.", '%1', "No.");
                    FALE.SetFilter("Part of Book Value", '%1', true);
                    FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALE.SetFilter("Document Type", '%1', FALE."Document Type"::Invoice);
                    FALE.SetFilter("Amount (LCY)", '>%1', 0);
                    FALE.SetFilter("Entry No.", '<>%1', OrderNo);
                    IF FALE.FindSet() then
                        repeat
                            BrojStavke += format(FALE."Entry No.") + '|'
                        until FALE.Next() = 0;

                    //Filtriram tabelu da nađem povećanja knjižena temeljnicom GK za OS
                    FALE2.Reset();
                    FALE2.SetFilter("FA No.", '%1', "No.");
                    FALE2.SetFilter("Part of Book Value", '%1', true);
                    FALE2.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    FALE2.SetFilter("FA Posting Type", '%1', FALE2."FA Posting Type"::Appreciation);
                    FALE2.SetFilter("Entry No.", '<>%1', OrderNo);
                    IF FALE2.FindSet() then
                        repeat
                            //         AAmount += FALE2."Amount (LCY)";
                            // BrojStavke += format(FALE2."Entry No.") + '|';
                            //Isključujem nabavnu vrijednost iz povećanja
                            BrojStavke += format(FALE2."Entry No.") + '|'

                        until FALE2.Next() = 0;


                    if StrLen(BrojStavke) >= 2 then
                        BrojStavke := CopyStr(BrojStavke, 1, StrLen(BrojStavke) - 1);

                    FALE.Reset();
                    FALE.SetFilter("FA No.", '%1', "No.");
                    FALE.SetFilter("Part of Book Value", '%1', true);
                    FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
                    if BrojStavke = '' then
                        FALE.setfilter("Entry No.", '%1', 0)
                    else
                        FALE.setfilter("Entry No.", BrojStavke);

                    FALedgerEntries.SetTableView(FALE);
                    FALedgerEntries.Run();
                    CurrPage.Update();

                    //   Appreciation2 := AAmount;
                end;
            }
        }

        addafter(DepreciationTableCode) //ED
        {
            field("Disposed Of"; "Disposed Of" > 0D)
            {
                Editable = false;
                Caption = 'Disposed Of';
            }
        }
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                Editable = true;
                Visible = true;
                Caption = 'Opština';
            }
        }


        addbefore("Main Asset/Component")
        {
            field("Souce of investment"; "Souce of investment")

            { }
            field("Donation Percentage"; "Donation Percentage")
            {

                //FA Allocations
            }

            field("Depreciation Group"; "Depreciation Group")
            {
                trigger OnValidate()
                begin
                    FADepricationBook.Reset();
                    FADepricationBook.SetFilter("FA No.", '%1', "No.");
                    if FADepricationBook.FindFirst() then begin
                        FADepricationBook.Validate("Straight-Line %", Rec."Straight-Line %");
                        FADepricationBook.Modify();
                    end;

                end;
            }
            field("Class Code"; "Class Code")
            {

            }
            field("Class Description"; "Class Description")
            {

            }
            field("Group Code"; "Group Code")
            {

            }
            field("Group Description"; "Group Description")
            {

            }
            field("Subgroup"; "Subgroup")
            {

            }
            field("Subgroup Description"; "Subgroup Description")
            {

            }
            field("SS number"; "SS number")
            {
                Editable = false;
            }
        }
        addbefore(Maintenance)
        {
            group(AdditionalData)
            {
                Caption = 'Additional Data for fixed asset';

                group(Realestates)
                {
                    caption = 'Real estates';
                    field("No. square footage"; "No. square footage") { }
                    field("Number of apartments"; "Number of apartments") { }
                    field("No. particles"; "No. particles") { }

                }
                group(Measures)
                {
                    caption = 'Measures';
                    field("No. measurer"; "No. measurer") { }

                }

                group(PipeLength)
                {
                    caption = 'PipeLength';
                    field("Pipe Length"; "Pipe Length") { }

                }


            }
        }

        addafter(Maintenance)
        {
            group("Car")
            {
                caption = 'Car Information';
                field("Veichle Type"; "Veichle Type")
                {

                }
                field("Veichle Brand"; "Veichle Brand")
                {

                }
                field("Registration No."; "Registration No.")
                { }
                field("Chasis No."; "Chasis No.") { }
                field("Date of Production"; "Date of Production") { }
                field("Engine Volume"; "Engine Volume") { }
                field("Engine Power"; "Engine Power") { }
                field("Engine Number"; "Engine Number") { }
                field("Veichle Weight"; "Veichle Weight") { }
                field("Veichle Load"; "Veichle Load") { }
            }
        }

        addafter(DepreciationMethod) //ED
        {
            field("Straight-Line %"; "Straight-Line %")
            {
                Editable = false; //R

            }
        }
        addlast(content)
        {
            group("Gas Station Data")
            {
                Caption = 'Gas Station Data';
                field("Gas Station Type"; Rec."Gas Station Type")
                {
                    ApplicationArea = All;
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                }
                field("Feed Section"; Rec."Feed Section")
                {
                    ApplicationArea = All;
                }
                field("Gas Station No."; Rec."Gas Station No.")
                {
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field(Box; Rec.Box)
                {
                    ApplicationArea = All;
                    LookupPageId = "Box Fixed Asset";
                }
                field("Installation Year"; Rec."Installation Year")
                {
                    ApplicationArea = All;
                }
                field("Schema ML"; Rec."Schema ML")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        DownloadShemaML();
                    end;
                }
                field("Station Schema"; Rec."Station Schema")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        DownloadStationSchema();
                    end;
                }
                field("Inbound Pressure"; Rec."Inbound Pressure")
                {
                    ApplicationArea = All;
                }
                field("Outbound Pressure"; Rec."Outbound Pressure")
                {
                    ApplicationArea = All;
                }
                field("Blocking Pressure"; Rec."Blocking Pressure")
                {
                    ApplicationArea = All;
                }
                field("Venting Pressure"; Rec."Venting Pressure")
                {
                    ApplicationArea = All;
                }
                field("Owner No."; Rec."Owner No.")
                {
                    ApplicationArea = All;
                }

                field(Street; Rec.Street)
                {
                    ApplicationArea = All;
                }
                field("Street Name"; Rec."Street Name")
                {
                    ApplicationArea = All;
                }
                field("Home No."; Rec."Home No.")
                {
                    ApplicationArea = All;
                }
                field(Address; Address) { }
                field("Municipality Code"; Rec."Municipality Code")
                {
                    ApplicationArea = All;
                }
                field("Municipality Name"; Rec."Municipality Name")
                {
                    ApplicationArea = All;
                }
                field("MZ"; Rec.MZ)
                {
                    ApplicationArea = All;
                }
                field("MZ Name"; Rec."MZ Name")
                {
                    ApplicationArea = All;
                }
                field("Gas Station Parameters"; Rec."Gas Station Parameters")
                {
                    ApplicationArea = All;
                }
                field("Gas Installation Data"; Rec."Gas Installation Data")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {


        addbefore("M&ain Asset Components")
        {
            action("GasM&ain Asset Components")
            {
                ApplicationArea = all;
                Caption = 'Gas M&ain Asset Components';
                Image = Components;
                RunObject = Page "Gas InstallationsE";
                RunPageLink = "Gas Installation No." = FIELD("No.");
            }
            action("Reports")
            {
                ApplicationArea = all;
                Caption = 'Reports';
                Image = Report;
                //RunPageLink = "Service Item No. - Relation" = Field("No.");
                trigger OnAction()
                var
                    myInt: Integer;
                    Rep: Report "Service Order General RDL";
                    SItem: Record "Service Item Line";
                begin
                    SItem.Reset();
                    SItem.SetFilter("Service Item No. - Relation", '%1', rec."No.");
                    SItem.SetFilter(Type, '%1', SItem.Type::OS);
                    Report.Run(50205, true, true, SItem);
                end;
            }


        }

        // Add changes to page actions here
        addafter("Depreciation &Books")
        {
            action("Activate Fixed Asset")
            {
                Caption = 'Activate Fixed Asset';
                Image = FixedAssets;
                ApplicationArea = all;
                PromotedIsBig = true;
                Promoted = true;

                trigger OnAction()
                var
                    FASetup: Record "FA Setup";
                    T_GJL: Record "Gen. Journal Line";
                    LineNo: Integer;
                    FALE: Record "FA Ledger Entry";
                    fadb: Record "FA Depreciation Book";
                    Docno: Code[30];
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    Txt000: Label 'There is nothing to activate.';
                    FAGJL: page "Fixed Asset G/L Journal";
                    FA: Codeunit "Modiy Permissions";
                    RecRef: RecordRef;
                    InsertLine: Boolean;
                    FD: Record "FA Depreciation Book"; //R

                begin
                    InsertLine := false;

                    FASetup.GET;
                    T_GJL.SETFILTER("Journal Template Name", '%1', FASetup."A. Journal Template Name");
                    T_GJL.SETFILTER("Journal Batch Name", '%1', FASetup."A. Journal Batch Name");
                    IF T_GJL.FIND('+') THEN
                        LineNo := T_GJL."Line No." + 100
                    ELSE
                        LineNo := 100;

                    FALE.SETFILTER("FA No.", '%1', Rec."No.");
                    FALE.SETFILTER("FA Posting Type", '%1', FALE."FA Posting Type"::"Acquisition Cost");
                    FALE.SETFILTER(Activation, '%1', FALSE);
                    IF FALE.FIND('+') THEN BEGIN
                        Rec.Inactive := FALSE;

                        Rec.MODIFY;

                        fadb.SETFILTER("FA No.", '%1', "No.");
                        IF fadb.FIND('+') THEN
                            fadb.CALCFIELDS(Unactivated);

                        LineNo += 100;


                        T_GJL."Journal Template Name" := FASetup."A. Journal Template Name";
                        T_GJL."Journal Batch Name" := FASetup."A. Journal Batch Name";
                        T_GJL."Account Type" := T_GJL."Account Type"::"Fixed Asset";
                        // T_GJL.VALIDATE("Account No.",Rec."No.");
                        T_GJL."Account No." := Rec."No.";
                        T_GJL."Line No." := LineNo;
                        T_GJL."Posting Date" := TODAY;
                        T_GJL."Document Date" := TODAY;
                        T_GJL."VAT Date" := TODAY;
                        //T_GJL."Document Type" := "Document Type";


                        Docno := NoSeriesMgt.GetNextNo(FASetup."Activation Nos.", TODAY, false);


                        T_GJL."Document No." := Docno;
                        //T_GJL.Description := T_PurchaseLine.Description;
                        T_GJL.Description := '';
                        T_GJL.VALIDATE("Debit Amount", fadb.Unactivated);
                        T_GJL."Depreciation Book Code" := FASetup."Default Depr. Book";
                        T_GJL."FA Posting Type" := T_GJL."FA Posting Type"::"Acquisition Cost";
                        T_GJL."Gen. Posting Type" := T_GJL."Gen. Posting Type"::Purchase;
                        T_GJL."VAT Bus. Posting Group" := '';
                        T_GJL."VAT Prod. Posting Group" := '';

                        FD.Reset();
                        FD.SetFilter("FA No.", '%1', T_GJL."Account No.");
                        if FD.FindFirst() then begin
                            T_GJL."FA Posting Group" := FD."FA Posting Group";
                        end
                        else begin
                            T_GJL."FA Posting Group" := '';
                        end;


                        T_GJL.VALIDATE("Posting Group", FALE."FA Posting Group");

                        // T_GJL.VALIDATE("Shortcut Dimension 1 Code",T_PurchaseLine."Shortcut Dimension 1 Code");
                        IF fadb.Unactivated <> 0 THEN begin
                            T_GJL.INSERT(TRUE);
                            InsertLine := true;
                        end;

                        LineNo += 100;

                        // Prva linija
                        T_GJL."Journal Template Name" := FASetup."A. Journal Template Name";
                        T_GJL."Journal Batch Name" := FASetup."A. Journal Batch Name";
                        T_GJL."Account Type" := T_GJL."Account Type"::"Fixed Asset";
                        // T_GJL.VALIDATE("Account No.",Rec."No.");
                        T_GJL."Account No." := Rec."No.";
                        T_GJL."Line No." := LineNo;
                        T_GJL."Posting Date" := TODAY;
                        T_GJL."Document Date" := TODAY;
                        T_GJL."VAT Date" := TODAY;
                        //T_GJL."Document Type" := "Document Type";
                        T_GJL."Document No." := Docno;
                        T_GJL.Description := 'A';
                        T_GJL."FA Posting Group" := FD."FA Posting Group";
                        // Dugovni iznos
                        fadb.CALCFIELDS("Acquisition Cost");
                        T_GJL.VALIDATE("Credit Amount", fadb.Unactivated);
                        T_GJL.VALIDATE(Activation, TRUE);
                        T_GJL."FA Posting Type" := T_GJL."FA Posting Type"::"Acquisition Cost";
                        T_GJL."Depreciation Book Code" := FASetup."Default Depr. Book";
                        T_GJL."Gen. Posting Type" := T_GJL."Gen. Posting Type"::Purchase;
                        T_GJL."VAT Bus. Posting Group" := '';
                        T_GJL."VAT Prod. Posting Group" := '';


                        //T_GJL.VALIDATE("Shortcut Dimension 1 Code", T_PurchaseLine."Shortcut Dimension 1 Code");
                        IF fadb.Unactivated <> 0 THEN begin
                            T_GJL.INSERT(TRUE);
                            InsertLine := true;
                        end;



                        FALE.RESET;
                        FALE.SETFILTER("FA No.", '%1', Rec."No.");
                        FALE.SETFILTER("FA Posting Type", '%1', FALE."FA Posting Type"::"Acquisition Cost");
                        FALE.SETFILTER(Activation, '%1', FALSE);
                        IF FALE.FINDFIRST THEN
                            REPEAT
                                if InsertLine = true then begin
                                    FALE.Activation := TRUE;

                                    RecRef.GetTable(FALE);
                                    FA.ModifyRecords(RecRef);

                                    Commit();

                                    //  CODEUNIT.Run(CODEUNIT::"FA Ledger Entry - Modify", FALE);
                                    Commit();
                                end
                                else begin
                                    ERROR(Txt000);
                                    FAGJL.RUN;
                                end;
                            //    FALE.MODIFY;
                            UNTIL FALE.NEXT = 0;
                    END
                    ELSE
                        ERROR(Txt000);
                    FAGJL.RUN;


                end;


            }


            action("Knjižne grupe")
            {
                Caption = 'Knjižne grupe';
                Image = FixedAssets;
                ApplicationArea = all;
                PromotedIsBig = true;
                Promoted = true;

                trigger OnAction()
                var
                    FADep: Record "FA Depreciation Book";
                    FAPosting: Record "FA Posting Group";
                    FA: Record "Fixed asset";
                begin
                    FA.SetFilter("FA Posting Group", '%1', '');
                    IF FA.FindFirst() then
                        repeat
                            FADep.Reset();
                            FADep.SetFilter("FA No.", '%1', FA."No.");
                            if FADep.FindFirst() then begin
                                FAPosting.Reset();
                                FAPosting.SetFilter(Code, '%1', FADep."FA Posting Group");
                                if FAPosting.FindFirst() then begin
                                    FA."FA Posting Group" := FAPosting."Acquisition Cost Account";
                                end;
                            end
                            else begin
                                FA."FA Posting Group" := '';
                            end;
                            FA.Modify();
                        until FA.next = 0;
                    MESSAGE('Done');
                end;
            }

        }
        addlast(navigation)
        {
            Group(Schema)
            {
                Caption = 'Schema', Comment = 'Sheme';
                action("Schema ML Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import Schema ML', Comment = 'Uvezi shemu ML';
                    Image = Word;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        ImportShemaML();
                    end;
                }
                action("Customer Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import Schema ML', Comment = 'Uvezi shemu ML';
                    Image = Word;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        Cust: xmlport CustImport;
                    begin
                        Cust.Run();
                    end;
                }
                action("Remove ML Schema")
                {
                    ApplicationArea = All;
                    Caption = 'Remove Schema ML', Comment = 'Ukloni shemu ML';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        DeleteSchemaML();
                    end;
                }
                action("Station Schema Import")
                {
                    ApplicationArea = All;
                    Caption = 'Import Station Schema', Comment = 'Uvezi shemu stanice';
                    Image = Word;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        ImportStationSchema();
                    end;
                }
                action("Remove Station Scheman")
                {
                    ApplicationArea = All;
                    Caption = 'Remove Station Schema', Comment = 'Ukloni shemu stranice';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        DeleteStationSchema();
                    end;
                }
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        FALE: Record "FA Ledger Entry";
        FALE2: Record "FA Ledger Entry";
        BrojStavke: Integer;

        Acc: Record "G/L Account";
        PageA: page "Chart of Accounts";
        FADep: Record "FA Depreciation Book";
        FAPosting: Record "FA Posting Group";
        US: Record "User Setup";
    begin
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            CanModify := us.FA;

            CurrPage.Editable := CanModify;
        end else begin
            CurrPage.Editable := false;
        end;




        CalcFields("Customer Name");
        //EMC1.0 end
        Obligation.RESET;
        Obligation.SETFILTER("No.", "No.");
        Obligation.SETFILTER(Active, '%1', TRUE);
        IF Obligation.FINDFIRST THEN BEGIN
            Obligation.CalcFields("Customer Name", "Location Name");


        END
        ELSE BEGIN
            Obligation.RESET;
            Obligation."Responsible Person Name" := '';
            Obligation."Location Code" := '';
        END;








        FADep.Reset();
        FADep.SetFilter("FA No.", '%1', Rec."No.");
        if FADep.FindFirst() then begin
            FAPosting.Reset();
            FAPosting.SetFilter(Code, '%1', FADep."FA Posting Group");
            if FAPosting.FindFirst() then begin
                Account_No := FAPosting."Acquisition Cost Account";

            end;



        end
        else begin
            Account_No := '';
        end;





        CalcFields("Disposed Of");
        FADepricationBook.Reset(); //ED
        FADepricationBook.SETFILTER("FA No.", '%1', "No.");
        if FADepricationBook.FindFirst() then begin
            Rec."Straight-Line %" := FADepricationBook."Straight-Line %";
        end;
        BrojStavke := 0;
        //R  
        FALedgerEntry.Reset();
        FALedgerEntry.SetFilter("FA No.", '%1', "No.");
        FALedgerEntry.SetFilter("Part of Book Value", '%1', true);
        FALedgerEntry.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALedgerEntry.SetFilter("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
        FALedgerEntry.SetCurrentKey("FA Posting Date");
        Ascending;

        if FALedgerEntry.FindFirst() then begin
            PurchValue2 := FALedgerEntry."Amount (LCY)";
            BrojStavke := FALedgerEntry."Entry No.";
            "FA Posting Date" := FALedgerEntry."FA Posting Date";
        end
        else begin
            PurchValue2 := 0;
            BrojStavke := 0;
            "FA Posting Date" := 0D;
        end;

        Appreciation2 := 0;

        FALE.Reset();
        FALE.SetFilter("FA No.", '%1', "No.");
        FALE.SetFilter("Part of Book Value", '%1', true);
        FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE.SetFilter("Document Type", '%1', FALE."Document Type"::Invoice);
        FALE.SetFilter("Amount (LCY)", '>%1', 0);
        FALE.SetFilter("Entry No.", '<>%1', BrojStavke);
        IF FALE.FindSet() then
            repeat
                Appreciation2 += FALE."Amount (LCY)";

            until FALE.Next() = 0;

        FALE2.Reset();
        FALE2.SetFilter("FA No.", '%1', "No.");
        FALE2.SetFilter("Part of Book Value", '%1', true);
        FALE2.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE2.SetFilter("FA Posting Type", '%1', FALE2."FA Posting Type"::Appreciation);
        FALE2.SetFilter("Amount (LCY)", '>%1', 0);
        FALE2.SetFilter("Entry No.", '<>%1', BrojStavke);
        IF FALE2.FindSet() then
            repeat
                Appreciation2 += FALE2."Amount (LCY)";
            until FALE2.Next() = 0;

        WriteDown2 := 0;

        FALE.Reset();
        FALE.SetFilter("FA No.", '%1', "No.");
        FALE.SetFilter("Part of Book Value", '%1', true);
        FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE.SetFilter("Document Type", '%1', FALE."Document Type"::Invoice);
        FALE.SetFilter("Amount (LCY)", '<%1', 0);
        IF FALE.FindSet() then
            repeat
                WriteDown2 += FALE."Amount (LCY)";

            until FALE.Next() = 0;

        FALE2.Reset();
        FALE2.SetFilter("FA No.", '%1', "No.");
        FALE2.SetFilter("Part of Book Value", '%1', true);
        FALE2.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE2.SetFilter("FA Posting Type", '%1', FALE2."FA Posting Type"::"Write-Down");
        IF FALE2.FindSet() then
            repeat
                WriteDown2 += FALE2."Amount (LCY)";
            until FALE2.Next() = 0;



    end;


    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        FALE: Record "FA Ledger Entry";
        FALE2: Record "FA Ledger Entry";
        BrojStavke: Integer;

        Acc: Record "G/L Account";
        PageA: page "Chart of Accounts";
        FADep: Record "FA Depreciation Book";
        FAPosting: Record "FA Posting Group";
    begin
        BrojStavke := 0;
        //EMC1.0 end
        CalcFields("Customer Name");
        Obligation.RESET;
        Obligation.SETFILTER("No.", "No.");
        Obligation.SETFILTER(Active, '%1', TRUE);
        IF Obligation.FINDFIRST THEN BEGIN
            Obligation.CalcFields("Customer Name", "Location Name");

        END
        ELSE BEGIN
            Obligation.RESET;
            Obligation."Responsible Person Name" := '';
            Obligation."Location Code" := '';
        END;



        FADep.Reset();
        FADep.SetFilter("FA No.", '%1', Rec."No.");
        if FADep.FindFirst() then begin
            FAPosting.Reset();
            FAPosting.SetFilter(Code, '%1', FADep."FA Posting Group");
            if FAPosting.FindFirst() then begin
                Account_No := FAPosting."Acquisition Cost Account";


            end;



        end
        else begin
            Account_No := '';
        end;

        CalcFields("Disposed Of");
        FADepricationBook.Reset(); //ED
        FADepricationBook.SETFILTER("FA No.", '%1', "No.");
        if FADepricationBook.FindFirst() then begin
            Rec."Straight-Line %" := FADepricationBook."Straight-Line %";
        end;

        //R
        FALedgerEntry.Reset();
        FALedgerEntry.SetFilter("FA No.", '%1', "No.");
        FALedgerEntry.SetFilter("Part of Book Value", '%1', true);
        FALedgerEntry.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALedgerEntry.SetFilter("FA Posting Type", '%1', FALedgerEntry."FA Posting Type"::"Acquisition Cost");
        FALedgerEntry.SetCurrentKey("FA Posting Date");
        Ascending;


        if FALedgerEntry.FindFirst() then begin
            PurchValue2 := FALedgerEntry."Amount (LCY)";
            BrojStavke := FALedgerEntry."Entry No.";
            "FA Posting Date" := FALedgerEntry."FA Posting Date";
        end
        else begin
            PurchValue2 := 0;
            BrojStavke := 0;
            "FA Posting Date" := 0D;
        end;

        Appreciation2 := 0;

        FALE.Reset();
        FALE.SetFilter("FA No.", '%1', "No.");
        FALE.SetFilter("Part of Book Value", '%1', true);
        FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE.SetFilter("Document Type", '%1', FALE."Document Type"::Invoice);
        FALE.SetFilter("Amount (LCY)", '>%1', 0);
        FALE.SetFilter("Entry No.", '<>%1', BrojStavke);
        IF FALE.FindSet() then
            repeat
                Appreciation2 += FALE."Amount (LCY)";

            until FALE.Next() = 0;

        FALE2.Reset();
        FALE2.SetFilter("FA No.", '%1', "No.");
        FALE2.SetFilter("Part of Book Value", '%1', true);
        FALE2.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE2.SetFilter("FA Posting Type", '%1', FALE2."FA Posting Type"::Appreciation);
        FALE2.SetFilter("Amount (LCY)", '>%1', 0);
        FALE2.SetFilter("Entry No.", '<>%1', BrojStavke);
        IF FALE2.FindSet() then
            repeat
                Appreciation2 += FALE2."Amount (LCY)";
            until FALE2.Next() = 0;


        WriteDown2 := 0;

        FALE.Reset();
        FALE.SetFilter("FA No.", '%1', "No.");
        FALE.SetFilter("Part of Book Value", '%1', true);
        FALE.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE.SetFilter("Document Type", '%1', FALE."Document Type"::Invoice);
        FALE.SetFilter("Amount (LCY)", '<%1', 0);
        IF FALE.FindSet() then
            repeat
                WriteDown2 += FALE."Amount (LCY)";

            until FALE.Next() = 0;

        FALE2.Reset();
        FALE2.SetFilter("FA No.", '%1', "No.");
        FALE2.SetFilter("Part of Book Value", '%1', true);
        FALE2.SetFilter("Depreciation Book Code", '%1', 'AMORT');
        FALE2.SetFilter("FA Posting Type", '%1', FALE2."FA Posting Type"::"Write-Down");
        IF FALE2.FindSet() then
            repeat
                WriteDown2 += FALE2."Amount (LCY)";
            until FALE2.Next() = 0;

        CurrPage.Update(true);
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Customer Name");
        Obligation.RESET;
        Obligation.SETFILTER("No.", "No.");
        Obligation.SETFILTER(Active, '%1', TRUE);
        IF Obligation.FINDFIRST THEN BEGIN
            Obligation.CalcFields("Customer Name", "Location Name");

        END
        ELSE BEGIN
            Obligation.RESET;
            Obligation."Responsible Person Name" := '';
            Obligation."Location Code" := '';
        END;

    end;
    //modify permissions-EK
    /* trigger OnModifyRecord(): Boolean
     begin
         US.Reset();
         US.SetFilter("User ID", '%1', UserId);
         if US.FindFirst() then
             CanModify1 := US.BOOKKEEPER;
         if not CanModify1 then begin
             Error('You do not have permission to modify this item.');
         end;
     end;*/
    trigger OnModifyRecord(): Boolean


    begin
        exit(true);
    END;



    var
        myInt: Integer;
        Obligation: Record Obligation;
        FADepricationBook: Record "FA Depreciation Book";
        PurchValue2: Decimal;
        WriteDown2: Decimal;
        Appreciation2: Decimal;
        FALedgerEntry: Record "FA Ledger Entry";
        FALedgerEntries: Page "FA Ledger Entries";
        ConfirmShemaImportQst: Label '%1 already exists. Do you want to override it?';
        ConfirmShemaDeletetQst: Label 'Are you sure that you want to delete %1?';
        ShemaImportFileFilter: Label 'Microsoft Word (*.docx)|*.docx', Locked = true;
        ShemaDownloadQst: Label 'Do you want to download dokument %1?', Comment = 'Da li želite skinuti dokument %1?';
        Account_No: Code[20];
        FAPostingDate: Date;
        US: Record "User Setup";
        CanModify1: Boolean;
        IsModifying: Boolean;
        UserPersonalization: Record "User Personalization";
        CanModify: Boolean;

    local procedure ImportShemaML()
    var
        ConfirmAction: Boolean;
        OutStr: OutStream;
        InStr: InStream;
    begin
        ConfirmAction := true;
        Rec.CalcFields("Schema ML File");
        if Rec."Schema ML File".HasValue then
            ConfirmAction := Confirm(StrSubstNo(ConfirmShemaImportQst, Rec.FieldCaption("Schema ML")), false);

        if not ConfirmAction then
            exit;

        UploadIntoStream('', '', ShemaImportFileFilter, Rec."Schema ML", InStr);
        if Rec."Schema ML" = '' then
            exit;

        Rec."Schema ML File".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        CurrPage.Update(true);
    end;

    local procedure DownloadShemaML()
    var
        InStr: InStream;
    begin
        Rec.CalcFields("Schema ML File");
        if not Rec."Schema ML File".HasValue then
            exit;

        if not Confirm(StrSubstNo(ShemaDownloadQst, Rec."Schema ML"), false) then
            exit;

        Rec."Schema ML File".CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', ShemaImportFileFilter, Rec."Schema ML");
    end;

    local procedure ImportStationSchema()
    var
        ConfirmAction: Boolean;
        OutStr: OutStream;
        InStr: InStream;
    begin
        ConfirmAction := true;
        Rec.CalcFields("Station Schema File");
        if Rec."Station Schema File".HasValue then
            ConfirmAction := Confirm(StrSubstNo(ConfirmShemaImportQst, Rec.FieldCaption("Station Schema")), false);

        if not ConfirmAction then
            exit;

        UploadIntoStream('', '', ShemaImportFileFilter, Rec."Station Schema", InStr);
        if Rec."Schema ML" = '' then
            exit;

        Rec."Station Schema File".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        CurrPage.Update(true);
    end;

    local procedure DeleteSchemaML()
    begin
        Rec.CalcFields("Schema ML File");
        if not Rec."Schema ML File".HasValue then
            exit;
        if not Confirm(StrSubstNo(ConfirmShemaDeletetQst, Rec."Schema ML"), false) then
            exit;
        Clear(Rec."Schema ML File");
        Rec."Schema ML" := '';
        CurrPage.Update(true);
    end;

    local procedure DownloadStationSchema()
    var
        InStr: InStream;
    begin
        Rec.CalcFields("Station Schema File");
        if not Rec."Station Schema File".HasValue then
            exit;

        if not Confirm(StrSubstNo(ShemaDownloadQst, Rec."Station Schema"), false) then
            exit;

        Rec."Station Schema File".CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', ShemaImportFileFilter, Rec."Station Schema");
    end;

    local procedure DeleteStationSchema()
    begin
        Rec.CalcFields("Station Schema File");
        if not Rec."Station Schema File".HasValue then
            exit;
        if not Confirm(StrSubstNo(ConfirmShemaDeletetQst, Rec."Station Schema"), false) then
            exit;
        Clear(Rec."Station Schema File");
        Rec."Station Schema" := '';
        CurrPage.Update(true);
    end;
}