pageextension 50004 "Service Item Worksheet SubForm" extends "Service Item Worksheet Subform"
{
    layout
    {

        addafter("Location Code")
        {
            field("Source Location Code"; "Source Location Code") { }
        }
        addafter("Unit Price")
        {
            field("VAT Difference"; "VAT Difference") { Editable = true; }
        }

        addafter(Type)
        {
            field("RN Type"; "RN Type")
            {
                Visible = VisibleRN;

                trigger OnValidate()
                begin
                    NoOnAfterValidate();
                end;

            }
        }
        modify("Unit of Measure Code")
        {
            Visible = falsE;
        }

        addafter("Unit of Measure Code")
        {
            field("Unit of Measure Code2"; "Unit of Measure Code2") { Visible = VisibleRN; }
        }
        modify("Unit of Measure") { Visible = false; }

        modify("Unit Price")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Unit Price" <= 0 then
                    Error(UnitPriceNotEmpty);
            end;
        }
        addafter("Unit Price")
        {
            field("Fixed Asset OS"; "Fixed Asset OS") { }
            field("Fixed Asset Mark"; "Fixed Asset Mark") { }
        }

        addafter(Quantity)
        {
            field("Quantity RN"; "Quantity RN")
            {

                Visible = VisibleRN;
                trigger OnValidate()
                var
                    DocFIlter: Record "Service Header";

                begin

                    CalcFields("Invoiced Quantity", "Shiped Quantity");
                    DocFIlter.Reset();
                    DocFIlter.SetFilter("No.", '%1', "Document No.");
                    DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                    if DocFIlter.FindFirst() then begin
                        if DocFIlter."CZK Request No." <> '' then
                            SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
                        else
                            SETRANGE("CZK Request No. Filter", "Document No.");


                    end
                    else begin
                        SETRANGE("CZK Request No. Filter", "Document No.");

                    end;



                    if "Invoiced Quantity" > 0 then begin

                        DocFIlter.Reset();
                        DocFIlter.SetFilter("No.", '%1', "Document No.");
                        DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                        if DocFIlter.FindFirst() then begin
                            SETRANGE("Shipment No. Filter", Rec."Document No.")

                        end
                        else begin
                            SETRANGE("Shipment No. Filter", '       ');

                        end;
                    end
                    else begin

                        SETRANGE("Shipment No. Filter", rec."Document No.");

                    end;
                    if DocFIlter."CZK Request No." <> '' then
                        setfilter("Shipment No. Filter", '%1', rec."Document No.");

                    // DocFIlter."CZK Request No." <> ''
                    CalcFields("Invoiced Quantity", "Shiped Quantity");

                    if "Invoiced Quantity" <> 0 then
                        error(Error2);


                end;




            }
            field("Number of leaks detected"; "Number of leaks detected") { }

            field("Qty. To Ship"; "Qty. To Ship")
            {
                Visible = false;
            }

            field("Qty. To Ship (Base)"; "Qty. To Ship (Base)")
            {
                Visible = false;
            }
            field("Qty. Consumed (Base)"; "Qty. Consumed (Base)")
            {

                Visible = false;
            }
            field("Quantity Base"; "Quantity (Base)")
            {
                Visible = false;
            }
            field("Quantity Consumed"; "Quantity Consumed")
            {
                Visible = false;
            }
            field("Quantity Shipped"; "Quantity Shipped")
            {//otpremljena količina - već izdato}
                Caption = 'Quantity Shipped';
                Visible = False;
            }

            field("Shiped Quantity"; "Shiped Quantity")
            {
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    ILePage: page "Item Ledger Entries";
                    ILE: Record "Item Ledger Entry";
                    ShiptFilter: code[250];
                    DocFIlter: Record "Service Header";
                //     CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Sales Header No." = field("Shipment No. Filter"), "Location Code" = field("Location Code"), "Entry Type" = filter(Transfer)));

                begin

                    //      if "Invoiced Quantity" > 0 then begin

                    DocFIlter.Reset();
                    DocFIlter.SetFilter("No.", '%1', "Document No.");
                    DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                    if DocFIlter.FindFirst() then begin
                        if DocFIlter."CZK Request No." <> '' then
                            ShiptFilter := rec."Document No."
                        else
                            ShiptFilter := rec."Document No.";
                    end
                    else begin
                        ShiptFilter := rec."Document No.";

                    end;

                    ILE.Reset();
                    ILE.SetFilter("Item No.", '%1', "No.");
                    ile.setfilter("Sales Header No.", ShiptFilter);
                    ile.SetFilter("Location Code", "Location Code");
                    ile.SetFilter("Entry Type", '%1', ile."Entry Type"::Transfer);
                    ILePage.SetTableView(ile);
                    ILePage.Run();

                end;

            }
            field("Invoiced Quantity"; "Invoiced Quantity")
            {
                ApplicationArea = all;
                Visible = false;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    ILePage: page "Item Ledger Entries";
                    ILE: Record "Item Ledger Entry";
                    CZKPostFilter: code[20];
                    DocFIlter: Record "Service Header";
                // sum("Item Ledger Entry"."Invoiced Quantity" where("Item No." = field("No."), "Sales Header No." = field("CZK Request No. Filter"), "Location Code" = field("Location Code"),
                //"Entry Type" = filter("Sale")));
                begin



                    DocFIlter.Reset();
                    DocFIlter.SetFilter("No.", '%1', "Document No.");
                    DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                    if DocFIlter.FindFirst() then begin
                        CZKPostFilter := DocFIlter."CZK Request No."

                    end
                    else begin
                        CZKPostFilter := '       ';

                    end;
                    if CZKPostFilter = '' then
                        CZKPostFilter := "Document No.";

                    ILE.Reset();
                    ILE.SetFilter("Item No.", '%1', "No.");
                    ile.SetRange("Sales Header No.", CZKPostFilter);
                    ile.SetFilter("Location Code", '%1', "Location Code");
                    ile.SetFilter("Entry Type", '%1', ile."Entry Type"::Sale);
                    ILePage.SetTableView(ile);
                    ILePage.Run();

                end;
            }
            field("Connected Quantity"; "Connected Quantity")
            {

                trigger OnDrillDown()
                var
                    myInt: Integer;
                    ILePage: page "Item Ledger Entries";
                    ILE: Record "Item Ledger Entry";
                    ShiptFilter: code[250];
                    DocFIlter: Record "Service Header";
                    TempLinkedRequests: Record "Template_Message" temporary;
                    TemporeryItem: Record "Tax Group" temporary;
                    EntryNo: integer;
                    EntryFilters2: text;

                //     CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."), "Sales Header No." = field("Shipment No. Filter"), "Location Code" = field("Location Code"), "Entry Type" = filter(Transfer)));

                begin

                    //      if "Invoiced Quantity" > 0 then begin

                    ConnectedRN := '';

                    if "Document No." <> '' then begin
                        DocFIlter.Reset();
                        DocFIlter.SetFilter("CZK Request No.", '%1', "Document No.");
                        if DocFIlter.findset() then
                            repeat

                                if DocFIlter."No." <> "Document No." then
                                    ConnectedRN += DocFIlter."No." + '|';
                            until DocFIlter.Next() = 0;
                        DocFIlter.Reset();
                        DocFIlter.SetFilter("No.", '%1', "Document No.");
                        if DocFIlter.FindFirst() then begin

                            if DocFIlter."CZK Request No." <> "Document No." then begin
                                if DocFIlter."CZK Request No." <> '' then
                                    ConnectedRN := DocFIlter."CZK Request No." + '|';
                            end;
                        end;



                        if DocFIlter."CZK Request No." <> '' then begin
                            DocFIlter2.Reset();
                            DocFIlter2.SetFilter("CZK Request No.", '%1', DocFIlter."CZK Request No.");
                            if DocFIlter2.findset() then
                                repeat

                                    if DocFIlter2."No." <> "Document No." then begin
                                        if strpos(ConnectedRN, DocFIlter2."No.") = 0 then
                                            ConnectedRN += DocFIlter2."No." + '|';
                                    end;
                                until DocFIlter.Next() = 0;

                        end;

                        if strlen(ConnectedRN) > 2 then
                            ConnectedRN := CopyStr(ConnectedRN, 1, StrLen(ConnectedRN) - 1);


                        //ja bih ovdje sada dodala ovaj connectedRN i da vidim kako će to izgledati

                        TempLinkedRequests.deleteall;
                        TemporeryItem.DeleteAll();
                        EntryNo := 1;



                        EntryFilters2 := '';
                        GetLinkedRequests(Rec."Document No.", TempLinkedRequests, EntryNo);
                        TempLinkedRequests.Reset();
                        TempLinkedRequests.setcurrentkey("ID");
                        TempLinkedRequests.ascending;

                        if TempLinkedRequests.FindSet() then
                            repeat
                                if TempLinkedRequests."Message Code" <> Rec."Document No." then
                                    EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                            until TempLinkedRequests.Next() = 0;


                        if strlen(EntryFilters2) > 2 then
                            EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


                        ConnectedRN := EntryFilters2;
                        //kraj djemina

                        if ConnectedRN <> '' then
                            SETFILTER("CZK Connected No. Filter", ConnectedRN)
                        else
                            setfilter("CZK Connected No. Filter", '%1', 'Ne postoji');
                    end;


                    //ja bih ovdje sada dodala ovaj connectedRN i da vidim kako će to izgledati
                    EntryFilters2 := '';
                    TempLinkedRequests.deleteall;
                    TemporeryItem.DeleteAll();
                    EntryNo := 1;


                    EntryFilters2 := '';

                    GetLinkedRequests(Rec."Document No.", TempLinkedRequests, EntryNo);
                    TempLinkedRequests.Reset();
                    TempLinkedRequests.setcurrentkey("ID");
                    TempLinkedRequests.ascending;

                    if TempLinkedRequests.FindSet() then
                        repeat
                            if TempLinkedRequests."Message Code" <> Rec."Document No." then
                                EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                        until TempLinkedRequests.Next() = 0;


                    if strlen(EntryFilters2) > 2 then
                        EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


                    ConnectedRN := EntryFilters2;
                    //kraj djemina


                    ILE.Reset();
                    ILE.SetFilter("Item No.", '%1', "No.");
                    ile.setfilter("Sales Header No.", ConnectedRN);
                    ile.SetFilter("Location Code", "Location Code");
                    ile.SetFilter("Entry Type", '%1', ile."Entry Type"::Transfer);
                    ILePage.SetTableView(ile);
                    ILePage.Run();

                end;


            }


        }

        modify(Quantity)
        {
            Visible = not VisibleRN;



            trigger OnAfterValidate()
            var
                DocFIlter: Record "Service Header";
            begin

                CalcFields("Invoiced Quantity", "Shiped Quantity");
                DocFIlter.Reset();
                DocFIlter.SetFilter("No.", '%1', "Document No.");
                DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                if DocFIlter.FindFirst() then begin
                    if DocFIlter."CZK Request No." <> '' then
                        SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
                    else
                        SETRANGE("CZK Request No. Filter", "Document No.");


                end
                else begin
                    SETRANGE("CZK Request No. Filter", "Document No.");

                end;



                if "Invoiced Quantity" > 0 then begin

                    DocFIlter.Reset();
                    DocFIlter.SetFilter("No.", '%1', "Document No.");
                    DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                    if DocFIlter.FindFirst() then begin
                        SETRANGE("Shipment No. Filter", Rec."Document No.")

                    end
                    else begin
                        SETRANGE("Shipment No. Filter", '       ');

                    end;
                end
                else begin

                    SETRANGE("Shipment No. Filter", rec."Document No.");

                end;
                if DocFIlter."CZK Request No." <> '' then
                    setfilter("Shipment No. Filter", '%1', rec."Document No.");
                CalcFields("Invoiced Quantity", "Shiped Quantity");
                if "Invoiced Quantity" <> 0 then
                    error(Error2);


            end;

        }

        modify(type)

        {
            Visible = not VisibleRN;
        }
        addafter(Description)
        {
            field("Request Resource Type"; Rec."Request Resource Type")
            {
                ApplicationArea = All;
                Visible = false;


            }
            field("Resource Connection Type"; Rec."Resource Connection Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Resource No."; Rec."Resource No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Resource Name"; Rec."Resource Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(Intent; Rec.Intent)
            {
                ApplicationArea = All;
                Visible = false;
            }


        }


        addbefore(Quantity)
        {
            field("Planned Quantity"; Rec."Planned Quantity")
            {
                ApplicationArea = All;
            }
        }
        modify("Fault Reason Code")
        {
            Visible = false;
        }
        modify("Fault Code")
        {
            Visible = false;
        }
        modify("Fault Area Code")
        {
            Visible = false;
        }
        modify("Resolution Code")
        {
            Visible = false;
        }

        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Line Discount Amount")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            Visible = false;
        }
        modify("Exclude Warranty")
        {
            Visible = false;
        }
        modify("Exclude Contract Discount")
        {
            Visible = false;
        }
        modify(Warranty)
        {
            Visible = false;
        }
        modify("Contract No.")
        {
            Visible = false;
        }
        modify("Contract Disc. %")
        {
            Visible = false;
        }
        modify("Symptom Code")
        {
            Visible = false;
        }
        modify("Line Discount Type")
        {
            Visible = false;
        }
        modify("Planned Delivery Date") { Visible = false; }
        modify("Needed by Date") { Visible = false; }
    }
    actions
    {
        /*modify("F&unctions")
        {
            Visible = false;
        }
        modify("&Line")
        {
            Visible = false;
        }*/
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        DocFIlter: Record "Service Header";
        SL: Record "Service Line";
        TempLinkedRequests: Record "Template_Message" temporary;
        TemporeryItem: Record "Tax Group" temporary;
        EntryNo: integer;
        EntryFilters2: text;

    begin
        CalcFields("Shiped Quantity", "Invoiced Quantity", "Connected Quantity");


        VisibleRN := false;
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Profile ID" = 'RADNI NALOZI'
            then
                VisibleRN := true
            else
                VisibleRN := false;
        end;
        DocFIlter.Reset();
        DocFIlter.SetFilter("No.", '%1', "Document No.");
        DocFIlter.SetFilter("Document Type", '%1', "Document Type");
        if DocFIlter.FindFirst() then begin
            if DocFIlter."CZK Request No." <> '' then
                SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
            else
                SETRANGE("CZK Request No. Filter", "Document No.");

        end
        else begin
            SETRANGE("CZK Request No. Filter", "Document No.");

        end;

        if "Invoiced Quantity" > 0 then begin

            DocFIlter.Reset();
            DocFIlter.SetFilter("No.", '%1', "Document No.");
            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
            if DocFIlter.FindFirst() then begin
                SETRANGE("Shipment No. Filter", Rec."Document No.")

            end
            else begin
                SETRANGE("Shipment No. Filter", '       ');

            end;
        end
        else begin

            SETRANGE("Shipment No. Filter", "Document No.");

        end;

        if DocFIlter."CZK Request No." <> '' then
            setfilter("Shipment No. Filter", '%1', rec."Document No.");

        ConnectedRN := '';

        if "Document No." <> '' then begin
            DocFIlter.Reset();
            DocFIlter.SetFilter("CZK Request No.", '%1', "Document No.");
            if DocFIlter.findset() then
                repeat
                    if DocFIlter."No." <> "Document No." then
                        ConnectedRN += DocFIlter."No." + '|';
                until DocFIlter.Next() = 0;
            DocFIlter.Reset();
            DocFIlter.SetFilter("No.", '%1', "Document No.");
            if DocFIlter.FindFirst() then begin
                if DocFIlter."CZK Request No." <> "Document No." then begin
                    if DocFIlter."CZK Request No." <> '' then
                        ConnectedRN := DocFIlter."CZK Request No." + '|';
                end;
            end;



            if DocFIlter."CZK Request No." <> '' then begin
                DocFIlter2.Reset();
                DocFIlter2.SetFilter("CZK Request No.", '%1', DocFIlter."CZK Request No.");
                if DocFIlter2.findset() then
                    repeat
                        if DocFIlter2."No." <> "Document No." then begin
                            if strpos(ConnectedRN, DocFIlter2."No.") = 0 then
                                ConnectedRN += DocFIlter2."No." + '|';
                        end;
                    until DocFIlter.Next() = 0;

            end;

            if strlen(ConnectedRN) > 2 then
                ConnectedRN := CopyStr(ConnectedRN, 1, StrLen(ConnectedRN) - 1);

            //ja bih ovdje sada dodala ovaj connectedRN i da vidim kako će to izgledati
            EntryFilters2 := '';
            TempLinkedRequests.deleteall;
            TemporeryItem.DeleteAll();
            EntryNo := 1;




            GetLinkedRequests(Rec."Document No.", TempLinkedRequests, EntryNo);
            TempLinkedRequests.Reset();
            TempLinkedRequests.setcurrentkey("ID");
            TempLinkedRequests.ascending;

            if TempLinkedRequests.FindSet() then
                repeat
                    if TempLinkedRequests."Message Code" <> Rec."Document No." then
                        EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                until TempLinkedRequests.Next() = 0;


            if strlen(EntryFilters2) > 2 then
                EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


            ConnectedRN := EntryFilters2;
            //kraj djemina

            if ConnectedRN <> '' then
                SETFILTER("CZK Connected No. Filter", ConnectedRN)
            else
                setfilter("CZK Connected No. Filter", '%1', 'Ne postoji');
        end;
    end;


    trigger OnQueryClosePage(Closeactio: Action): Boolean
    var
        SH: record "Service Header";
    begin
        If "Unit Price" = 0 then begin
            SH.Reset();
            SH.SetFilter("No.", '%1', rec."Document No.");
            if SH.FindFirst() then begin
                if (sh."Request Type" <> sh."Request Type"::"General Geo. Work Order") and
                (sh."Request Type" <> sh."Request Type"::"General Geo. Work Order Office") and
                (sh."Request Type" <> sh."Request Type"::"General Work Order")
                and (sh."Request Type" <> sh."Request Type"::"Work Execution Request") then
                    Message('Morate unijeti cijenu!');
            end;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        DocFIlter: Record "Service Header";
        TempLinkedRequests: Record "Template_Message" temporary;
        TemporeryItem: Record "Tax Group" temporary;
        EntryNo: integer;
        EntryFilters2: text;

    begin

        VisibleRN := false;
        CalcFields("Shiped Quantity", "Invoiced Quantity");
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Profile ID" = 'RADNI NALOZI'
            then
                VisibleRN := true
            else
                VisibleRN := false;
        end;
        DocFIlter.Reset();
        DocFIlter.SetFilter("No.", '%1', "Document No.");
        DocFIlter.SetFilter("Document Type", '%1', "Document Type");
        if DocFIlter.FindFirst() then begin
            if DocFIlter."CZK Request No." <> '' then
                SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
            else
                SETRANGE("CZK Request No. Filter", "Document No.");

        end
        else begin
            SETRANGE("CZK Request No. Filter", "Document No.");

        end;

        if "Invoiced Quantity" > 0 then begin

            DocFIlter.Reset();
            DocFIlter.SetFilter("No.", '%1', "Document No.");
            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
            if DocFIlter.FindFirst() then begin
                SETRANGE("Shipment No. Filter", Rec."Document No.")

            end
            else begin
                SETRANGE("Shipment No. Filter", '       ');

            end;
        end
        else begin

            SETRANGE("Shipment No. Filter", "Document No.");

        end;

        if DocFIlter."CZK Request No." <> '' then
            setfilter("Shipment No. Filter", '%1', rec."Document No.");

        ConnectedRN := '';


        if "Document No." <> '' then begin
            DocFIlter.Reset();
            DocFIlter.SetFilter("CZK Request No.", '%1', "Document No.");
            if DocFIlter.findset() then
                repeat
                    if DocFIlter."No." <> "Document No." then
                        ConnectedRN += DocFIlter."No." + '|';
                until DocFIlter.Next() = 0;
            DocFIlter.Reset();
            DocFIlter.SetFilter("No.", '%1', "Document No.");
            if DocFIlter.FindFirst() then begin
                if DocFIlter."CZK Request No." <> "Document No." then begin
                    if DocFIlter."CZK Request No." <> '' then
                        ConnectedRN := DocFIlter."CZK Request No." + '|';
                end;
            end;



            if DocFIlter."CZK Request No." <> '' then begin
                DocFIlter2.Reset();
                DocFIlter2.SetFilter("CZK Request No.", '%1', DocFIlter."CZK Request No.");
                if DocFIlter2.findset() then
                    repeat
                        if DocFIlter2."No." <> "Document No." then begin
                            if strpos(ConnectedRN, DocFIlter2."No.") = 0 then
                                ConnectedRN += DocFIlter2."No." + '|';
                        end;
                    until DocFIlter.Next() = 0;

            end;

            if strlen(ConnectedRN) > 2 then
                ConnectedRN := CopyStr(ConnectedRN, 1, StrLen(ConnectedRN) - 1);

            //ja bih ovdje sada dodala ovaj connectedRN i da vidim kako će to izgledati
            EntryFilters2 := '';
            TempLinkedRequests.deleteall;
            TemporeryItem.DeleteAll();
            EntryNo := 1;




            GetLinkedRequests(Rec."Document No.", TempLinkedRequests, EntryNo);
            TempLinkedRequests.Reset();
            TempLinkedRequests.setcurrentkey("ID");
            TempLinkedRequests.ascending;

            if TempLinkedRequests.FindSet() then
                repeat
                    if TempLinkedRequests."Message Code" <> Rec."Document No." then
                        EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                until TempLinkedRequests.Next() = 0;


            if strlen(EntryFilters2) > 2 then
                EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


            ConnectedRN := EntryFilters2;
            //kraj djemina


            if ConnectedRN <> '' then
                SETFILTER("CZK Connected No. Filter", ConnectedRN)
            else
                setfilter("CZK Connected No. Filter", '%1', 'Ne postoji');
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        DocFIlter: Record "Service Header";
        TempLinkedRequests: Record "Template_Message" temporary;
        TemporeryItem: Record "Tax Group" temporary;
        EntryNo: integer;
        EntryFilters2: text;

    begin
        VisibleRN := false;
        CalcFields("Shiped Quantity", "Invoiced Quantity");
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Profile ID" = 'RADNI NALOZI'
            then
                VisibleRN := true
            else
                VisibleRN := false;
        end;
        DocFIlter.Reset();
        DocFIlter.SetFilter("No.", '%1', "Document No.");
        DocFIlter.SetFilter("Document Type", '%1', "Document Type");
        if DocFIlter.FindFirst() then begin
            if DocFIlter."CZK Request No." <> '' then
                SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
            else
                SETRANGE("CZK Request No. Filter", "Document No.");

        end
        else begin
            SETRANGE("CZK Request No. Filter", "Document No.");

        end;

        if "Invoiced Quantity" > 0 then begin

            DocFIlter.Reset();
            DocFIlter.SetFilter("No.", '%1', "Document No.");
            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
            if DocFIlter.FindFirst() then begin
                SETRANGE("Shipment No. Filter", Rec."Document No.")

            end
            else begin
                SETRANGE("Shipment No. Filter", '       ');

            end;
        end
        else begin

            SETRANGE("Shipment No. Filter", "Document No.");

        end;
        if DocFIlter."CZK Request No." <> '' then
            setfilter("Shipment No. Filter", '%1', rec."Document No.");


        ConnectedRN := '';

        if "Document No." <> '' then begin
            DocFIlter.Reset();
            DocFIlter.SetFilter("CZK Request No.", '%1', "Document No.");
            if DocFIlter.findset() then
                repeat
                    if DocFIlter."No." <> "Document No." then
                        ConnectedRN += DocFIlter."No." + '|';
                until DocFIlter.Next() = 0;
            DocFIlter.Reset();
            DocFIlter.SetFilter("No.", '%1', "Document No.");
            if DocFIlter.FindFirst() then begin
                if DocFIlter."CZK Request No." <> "Document No." then begin
                    if DocFIlter."CZK Request No." <> '' then
                        ConnectedRN := DocFIlter."CZK Request No." + '|';
                end;
            end;



            if DocFIlter."CZK Request No." <> '' then begin
                DocFIlter2.Reset();
                DocFIlter2.SetFilter("CZK Request No.", '%1', DocFIlter."CZK Request No.");
                if DocFIlter2.findset() then
                    repeat
                        if DocFIlter2."No." <> "Document No." then begin
                            if strpos(ConnectedRN, DocFIlter2."No.") = 0 then
                                ConnectedRN += DocFIlter2."No." + '|';
                        end;
                    until DocFIlter.Next() = 0;

            end;

            if strlen(ConnectedRN) > 2 then
                ConnectedRN := CopyStr(ConnectedRN, 1, StrLen(ConnectedRN) - 1);

            //ja bih ovdje sada dodala ovaj connectedRN i da vidim kako će to izgledati
            EntryFilters2 := '';
            TempLinkedRequests.deleteall;
            TemporeryItem.DeleteAll();
            EntryNo := 1;




            GetLinkedRequests(Rec."Document No.", TempLinkedRequests, EntryNo);
            TempLinkedRequests.Reset();
            TempLinkedRequests.setcurrentkey("ID");
            TempLinkedRequests.ascending;

            if TempLinkedRequests.FindSet() then
                repeat
                    if TempLinkedRequests."Message Code" <> Rec."Document No." then
                        EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                until TempLinkedRequests.Next() = 0;


            if strlen(EntryFilters2) > 2 then
                EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


            ConnectedRN := EntryFilters2;
            //kraj djemina

            if ConnectedRN <> '' then
                SETFILTER("CZK Connected No. Filter", ConnectedRN)
            else
                setfilter("CZK Connected No. Filter", '%1', 'Ne postoji');
        end;

    end;

    procedure GetLinkedRequests(StartNo: Code[20]; var TempResultRec: Record Template_Message temporary; EntryNo: Integer)
    var

        CZKExsist: record "Service Header";
    begin
        // Dodaj početni No.
        TempResultRec.Reset();
        TempResultRec.SetFilter("Message Code", '%1', StartNo);
        if not TempResultRec.findfirst then begin
            TempResultRec.Init();
            TempResultRec."Message Code" := StartNo;
            TempResultRec."ID" := EntryNo;
            EntryNo += 1;
            TempResultRec.Insert();
        end;

        // Pokreni rekurziju
        GetChildRequests(StartNo, TempResultRec, Count);

        CZKExsist.Reset();
        CZKExsist.SetFilter("No.", '%1', StartNo);
        if CZKExsist.findfirst then begin

            if CZKExsist."CZK Request No." <> '' then begin
                TempResultRec.Reset();
                TempResultRec.SetFilter("Message Code", '%1', CZKExsist."CZK Request No.");
                if not TempResultRec.findfirst then begin
                    TempResultRec.Init();
                    TempResultRec."Message Code" := CZKExsist."CZK Request No.";
                    TempResultRec."ID" := EntryNo;
                    EntryNo += 1;
                    TempResultRec.Insert();
                end;

                // Pokreni rekurziju
                GetChildRequests(CZKExsist."CZK Request No.", TempResultRec, Count);
            end;
        end;

    end;


    local procedure GetChildRequests(ParentNo: Code[20]; var TempResultRec: Record Template_Message temporary; EntryNo: integer)
    var
        MyTable: Record "Service Header";
    begin
        MyTable.Reset();
        MyTable.SetRange("CZK Request No.", ParentNo);
        if MyTable.FindSet() then
            repeat
                TempResultRec.reset;
                TempResultRec.setfilter("Message Code", '%1', MyTable."No.");
                if not TempResultRec.findfirst then begin
                    TempResultRec.Init();
                    TempResultRec."Message Code" := MyTable."No.";
                    TempResultRec."ID" := EntryNo;
                    EntryNo += 1;
                    TempResultRec.Insert();
                    // Rekurzivno idi dalje
                    GetChildRequests(MyTable."No.", TempResultRec, EntryNo);
                end;
            until MyTable.Next() = 0;
        MyTable.Reset();
        MyTable.SetRange("No.", ParentNo);
        if MyTable.FindSet() then
            repeat
                if MyTable."CZK Request No." <> '' then begin
                    TempResultRec.reset;
                    TempResultRec.setfilter("Message Code", '%1', MyTable."CZK Request No.");
                    if not TempResultRec.findfirst then begin
                        TempResultRec.Init();
                        TempResultRec."Message Code" := MyTable."CZK Request No.";
                        TempResultRec."ID" := EntryNo;
                        EntryNo += 1;
                        TempResultRec.Insert();
                        // Rekurzivno idi dalje
                        GetChildRequests(MyTable."CZK Request No.", TempResultRec, EntryNo);
                    end;
                end;
            until MyTable.Next() = 0;
    end;


    var
        VisibleRN: Boolean;
        US: Record "User Personalization";
        UnitPriceNotEmpty: Label 'Morate unijeti cijenu.';
        Error1: Label 'It is not allowed to change quantity, because the service order is already shipped';

        Error2: Label 'It is not allowed to change quantity, because the service order is already Invoiced';
        ConnectedRN: text;

        SL: Record "Service Line";
        DocFIlter2: Record "Service Header";
}
