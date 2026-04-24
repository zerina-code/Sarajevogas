pageextension 52225 ServiceLineList extends "Service Line List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Line Amount")
        {
            field(VAT; "Amount Including VAT" - Amount) { }
            field("Amount Including VAT"; "Amount Including VAT") { }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        DocFIlter: Record "Service Header";
        TempLinkedRequests: Record "Template_Message" temporary;
        TemporeryItem: Record "Tax Group" temporary;
        EntryNo: integer;
        EntryFilters2: text;
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


    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        DocFIlter: Record "Service Header";
        TempLinkedRequests: Record "Template_Message" temporary;
        TemporeryItem: Record "Tax Group" temporary;
        EntryNo: integer;
        EntryFilters2: text;
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
            DocFIlter.Reset();
            DocFIlter.SetFilter("No.", '%1', "Document No.");
            if DocFIlter.FindFirst() then begin
                if DocFIlter."CZK Request No." <> "Document No." then begin
                    if DocFIlter."CZK Request No." <> '' then
                        ConnectedRN := DocFIlter."CZK Request No." + '|';
                end;
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
        CZKExsist: Record "Service Header";
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
                TempResultRec.reset;
                if MyTable."CZK Request No." <> '' then begin
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
        myInt: Integer;
        ConnectedRN: text;
        DocFilter2: Record "Service Header";
}