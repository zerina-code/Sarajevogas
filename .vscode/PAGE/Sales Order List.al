pageextension 50135 Sales_Order_List extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout her
    }

    actions
    {
        modify("O&rder") { Visible = FALSE; }
        modify("&Order Confirmation") { Visible = FALSE; }
        modify("Display") { Visible = FALSE; }
        modify("Documents") { Visible = FALSE; }
        modify("Warehouse") { Visible = FALSE; }
        modify("ActionGroupCRM") { Visible = FALSE; }
        modify("Action12") { Visible = FALSE; }
        modify("F&unctions") { Visible = FALSE; }
        modify("Request Approval") { Visible = FALSE; }
        modify("Action3") { Visible = FALSE; }
        modify("&Print") { Visible = FALSE; }
        modify("Statistics") { Visible = FALSE; }
        modify("Co&mments") { Visible = FALSE; }
        modify("Approvals") { Visible = FALSE; }
        modify("Dimensions") { Visible = FALSE; }
        modify("Pla&nning") { Visible = FALSE; }
        modify("PostAndSend") { Visible = FALSE; }
        modify("Email Confirmation") { Visible = FALSE; }
        modify("Print Confirmation") { Visible = FALSE; }
        modify("AttachAsPDF") { Visible = FALSE; }
        modify("PostedSalesInvoices") { Visible = FALSE; }
        modify("Sales Reservation Avail.") { Visible = FALSE; }




        addafter("Sales Reservation Avail.")
        {
            action("Registration number CNG")
            {
                ApplicationArea = Reservation;
                visible = NOT CngUser;
                Caption = 'Registration number CNG';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report RegistrationNumberCNG;
                ToolTip = 'To see a report with all drivers';
            }


        }


        addafter("&Print")

        {

            group(Fiscal)
            {
                Caption = 'Fiscal';
                Image = Print;


                action("Cross section")
                {
                    Caption = 'Cross section';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;


                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    var
                        GenL: Record "General Ledger Setup";
                        CzkF: Record "User Setup";
                        BankAccocunt: Record "Bank Account";
                    begin
                        Genl.get;

                        Putanja := GenL."Path for fiscal printer";

                        CZkF.Get(UserId);
                        BankAccocunt.Reset();
                        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                        if BankAccocunt.findfirst then begin
                            Putanja := BankAccocunt."Path for fiscal printer";

                        end
                        else begin
                            Putanja := GenL."Path for fiscal printer";

                        end;

                        File1.CREATE(Putanja + 'stampatipresjekstanja.xml', TEXTENCODING::UTF8);
                        File1.CREATEOUTSTREAM(OutStreamObj);
                        Plite := '<?xml version="1.0" encoding="utf-8"?>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<BrojZahtjeva>198020</BrojZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<VrstaZahtjeva>3</VrstaZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Parametri />';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '</Zahtjev>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        File1.CLOSE;
                        FileManagement.DownloadToFile(Putanja + 'stampatipresjekstanja.xml', Putanja + 'stampatipresjekstanja.xml');
                        COMMIT;


                        //Odgovor('\\SERVER6\Temp2\XML\odgovori\sps');
                    end;
                }
                action("Print Daily report")
                {
                    Caption = 'Print Daily report';
                    Image = Print;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;


                    trigger OnAction()
                    var
                        Genl: Record "General Ledger Setup";
                        CZkF: Record "User Setup";
                        BankAccocunt: Record "Bank Account";
                    begin
                        Genl.get;

                        Putanja := GenL."Path for fiscal printer";

                        CZkF.Get(UserId);
                        BankAccocunt.Reset();
                        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                        if BankAccocunt.findfirst then begin
                            Putanja := BankAccocunt."Path for fiscal printer";

                        end
                        else begin
                            Putanja := GenL."Path for fiscal printer";

                        end;

                        File1.CREATE(Putanja + 'stampatidnevniizvjestaj.xml', TEXTENCODING::UTF8);
                        File1.CREATEOUTSTREAM(OutStreamObj);
                        Plite := '<?xml version="1.0" encoding="utf-8"?>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001FileManagement.DownloadToFile(filename,filename);/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<BrojZahtjeva>61529</BrojZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<VrstaZahtjeva>4</VrstaZahtjeva>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '<Parametri />';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        Plite := '</Zahtjev>';
                        OutStreamObj.WRITETEXT(Plite);
                        OutStreamObj.WRITETEXT();
                        File1.CLOSE;

                        //Odgovor('\\SERVER6\Temp2\XML\odgovori\StampatiDnevniIzvjestaj');
                        FileManagement.DownloadToFile(Putanja + 'stampatidnevniizvjestaj.xml', Putanja + 'stampatidnevniizvjestaj.xml');
                        COMMIT;
                    end;
                }
                action("Print Periodic report")
                {
                    Promoted = true;
                    PromotedCategory = Report;
                    PromotedIsBig = true;


                    Caption = 'Print Periodic report';
                    Image = Print;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    RunObject = Report "Periodic report - fiscal";
                }
            }



            action("Import txt file MP")
            {
                Caption = 'Import txt file MP';
                Ellipsis = true;
                Image = Import;
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TempFile: File;
                    FileName: Text;
                    ReadLineNew: Text;
                    Proceed: Boolean;
                    Text040: Label 'Xml file(*.xml)|*.xml|Text file(*.txt)|*.txt';
                    Text000: Label 'Import File';
                    Text004: Label 'Importing Data from file @1@@@@@@@@';
                    Text005: Label 'Please select a valid File name first!';
                    Brojac: Integer;
                    DataFile: File;
                    Window: Dialog;
                    StreamInTest: InStream;
                    SalseLineUpdate: Record "Sales Line";
                    DataLine: Text;
                    Linija: Integer;
                    Text12: array[12] of Text[2500];
                    G: Record "General Ledger Setup";
                    Proc: Integer;
                    SalesLine: Record "Sales Line";
                    Calc: Record "Calculation Setup";
                    Quantity2: Decimal;
                    GL: Record "General Ledger Setup";
                    Price: Decimal;
                    LocationGet: Record Location;
                    SalesLineE: Record "Sales Line";
                    MessageText: text[2000];
                    BrojaInt: Integer;
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    worktype: Record "Work Type";
                    FileD: Record File;
                    worktypes: Page "Work Types";
                    Text12_T: array[4, 4] of Text[2500];

                    FileBuffer: record File;
                    Separator: text[1000];
                    SHCheck: Record "Sales Line";
                    ItemUnitCost: Record item;
                    IUM: Record "Item Unit of Measure";
                    BillT: Record "Customer Templ.";
                    SHNew: Record "Sales Header";
                    SHOpen: record "Sales Header";

                    SHLineNew: Record "Sales Line";
                    SalesSet: Record "Sales & Receivables Setup";
                    SOOpen: page "Sales Order";
                    CuInternal: Record Customer;
                    Cust: Record Customer;
                    StartDate: Date;
                    EndDate: Date;
                    AbsenceFill: Codeunit "Absence Fill";
                    FileNamePrevious: Text;
                    NewFileName: text;
                    DestinationFile: text;
                    BrojacDisp: Integer;
                    US: Record "User Setup";

                begin


                    GL.get;


                    linija := 0;




                    /*    ReleaseSalesDoc.PerformManualReopen(Rec);

                        TempFile.CREATETEMPFILE(TEXTENCODING::UTF8);
                        FileName := TempFile.NAME + '.txt';
                        TempFile.CLOSE;

                        Proceed := UPLOAD(Text000, '', Text040, '', FileName);

                        IF NOT Proceed THEN
                            ERROR(Text005);
                        linija := 0;

                        IF FILE.EXISTS(FileName) THEN
                            DataFile.OPEN(FileName, TextEncoding::UTF8
                        ELSE
                            ERROR(Text005);
                        Brojac := 1;

                        IF GUIALLOWED THEN
                            Window.OPEN(Text004, Proc);
                        DataFile.TEXTMODE := TRUE;

                        DataFile.CLOSE;
                        DataFile.OPEN(FileName, TextEncoding::UTF8);

                        DataFile.CREATEINSTREAM(StreamInTest);
                        WHILE NOT StreamInTest.EOS DO BEGIN
                            StreamInTest.READTEXT(DataLine);
                            
                            Text12[1] := Split(DataLine, ';');
                            Text12[2] := Split(DataLine, ';');
                            Text12[3] := Split(DataLine, ';');
                            Text12[4] := Split(DataLine, ';');
                            Text12[2] := Replacestring(Text12[2], '.', ',');
                            Text12[3] := Replacestring(Text12[3], '.', ',');
                            Text12[4] := Replacestring(Text12[4], '.', ',');*/



                    worktype.DeleteAll;
                    BrojacDisp := 0;
                    FileD.SetRange("Is a file", true);
                    GL.Get();
                    FileD.SetRange(Path, GL."Path for import txt file");
                    //ShowFileOrder(File);




                    BrojaInt := 0;
                    //   ShowFileOrder(File);
                    if FileD.FindSet() then
                        repeat

                            MessageText := '';
                            BrojacDisp += 1;
                            BrojaInt += 1;
                            FileBuffer := FileD;
                            FileBuffer.Path := Format(CreateDateTime(FileD.Date, FileD.time), 0, 9);
                            importFile.WRITEMODE(TRUE);
                            importFile.TEXTMODE(TRUE);

                            MessageText := StrSubstNo('%1%2%3', MessageText, Separator, FileD.Name);
                            Separator := '\';

                            importFile.OPEN(GL."Path for import txt file" + MessageText);


                            WHILE importFile.READ(ReadLine) > 0 DO BEGIN


                                Text12_T[1] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[2] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[3] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[4] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[2] [BrojaInt] := Replacestring_T(Text12_T[2] [BrojaInt], '.', ',');
                                Text12_T[3] [BrojaInt] := Replacestring_T(Text12_T[3] [BrojaInt], '.', ',');
                                Text12_T[4] [BrojaInt] := Replacestring_T(Text12_T[4] [BrojaInt], '.', ',');
                            end;
                            importFile.CLOSE;
                            if text12[1] [BrojaInt] <> '' then begin
                                worktype.Init();
                                worktype.Code := format(BrojacDisp);
                                Evaluate(Quantity_Read, Text12_T[2] [BrojaInt]);
                                worktype.Quantity := Quantity_Read;

                                Evaluate(Price, Text12_T[3] [BrojaInt]);
                                worktype.Price := Price;

                                Evaluate(ukupno, Text12_T[4] [BrojaInt]);
                                worktype.Total := ukupno;

                                worktype.Description := MessageText;
                                worktype.Insert();
                            end;



                        //mogu biti 4 terminala

                        /*    for i := 1 to BrojaInt do begin
                                if text12[1] [BrojaInt] <> '' then
                                    Message(Text12[1] [BrojaInt] + File.Name);
                                if text12[2] [BrojaInt] <> '' then
                                    Message(Text12[1] [BrojaInt] + File.Name);
                                if text12[3] [BrojaInt] <> '' then
                                    Message(Text12[1] [BrojaInt] + File.Name);
                                if text12[1] [BrojaInt] <> '' then
                                    Message(Text12[4] [BrojaInt] + File.Name);


                            end;
            */



                        until FileD.next = 0;




                    Clear(worktypes);
                    worktype.Reset();

                    Commit();
                    //   worktypes.Run();
                    Commit();
                    worktypes.LOOKUPMODE(TRUE);
                    IF worktypes.RUNMODAL = ACTION::LookupOK THEN BEGIN

                        worktypes.GETRECORD(worktype);

                        SHCheck.Reset();
                        if worktype."Customer No." = '400015' then
                            SHCheck.SetFilter("Sell-to Customer No.", '%1', 'DJemina')
                        else
                            SHCheck.SetFilter("Sell-to Customer No.", '%1', worktype."Customer No.");
                        SHCheck.SetFilter("Type of vehicle", '%1', worktype."Type of vehicle");
                        SHCheck.SetFilter("Document Type", '%1', SHCheck."Document Type"::Order);

                        StartDate := AbsenceFill.GetMonthRange(Date2DMY(today, 2), Date2DMY(today, 3), TRUE);
                        EndDate := AbsenceFill.GetMonthRange(Date2DMY(today, 2), Date2DMY(today, 3), FALSE);

                        SHCheck.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                        if SHCheck.FindFirst() then begin
                            SalesLineE.Reset();
                            SalesLineE.SetFilter("Document No.", '%1', SHCheck."Document No.");
                            SalesLine.SetCurrentKey("Line No.");
                            if SalesLineE.FindLast() then
                                Linija := SalesLineE."Line No." + 10000
                            else
                                Linija += 10000;
                            SHOpen.Reset();
                            SHOpen.SetFilter("No.", '%1', SHCheck."Document No.");
                            SHOpen.SetFilter("Document Type", '%1', SHCheck."Document Type");
                            IF SHOpen.FindFirst() then begin
                                ReleaseSalesDoc.PerformManualReopen(SHOpen);
                                if SHOpen."Posting Date" <= Today then begin
                                    SHOpen.Validate("Posting Date", today);
                                    SHOpen.Validate("VAT Date", today);
                                    SHOpen.Validate("Shipment Date", today);
                                end;

                            end;

                            SalesLine.Init();
                            SalesLine.Validate("Line No.", Linija);
                            SalesLine."Posting Date2" := today;

                            SalesLine.Validate("Sell-to Customer No.", worktype."Customer No.");
                            SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.Validate("Document No.", SHCheck."Document No.");
                            SalesLine.Validate(Type, SalesLine.Type::Item);
                            SalesLine.validate("Type of vehicle", worktype."Type of vehicle");
                            Calc.Get();
                            US.Reset();
                            US.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                us."Type of vehicle" := worktype."Type of vehicle";
                                us.Modify();
                            end;


                            SalesLine.Validate("No.", Calc."Item No.");
                            LocationGet.Reset();
                            SalesSet.get;
                            if worktype."Customer No." = SalesSet."NN Customer Code" then begin
                                LocationGet.SetFilter("CNG MP", '%1', true)
                            end

                            else begin
                                if CuInternal.get(worktype."Customer No.") then begin
                                    if CuInternal."Internal Customer" = true then
                                        LocationGet.SetFilter("CNG VL", '%1', true)
                                    else
                                        LocationGet.SetFilter("CNG VP", '%1', true);
                                end
                                else begin
                                    LocationGet.SetFilter("CNG VP", '%1', true);

                                end;


                            end;

                            if LocationGet.FindFirst() then
                                SalesLine.Validate("Location Code", LocationGet.Code);
                            SalesLine.Validate(Quantity, worktype.Quantity);
                            SalesLine.validate("Payment Method Code", worktype."Payment Method Code");
                            SalesLine.validate("Driver type", worktype."Driver type");
                            SalesLine.validate("Driver ID", worktype."Driver ID");
                            SalesLine.validate("Driver Name", worktype."Driver Name");
                            SalesLine.validate("Driver Registration No.", worktype."Driver Registration No.");

                            SalesLine.validate("Vehicle Registration", worktype."Vehicle Registration");
                            SalesLine.validate("Type of vehicle", worktype."Type of vehicle");
                            if (SalesLine."Type of vehicle" = "Type of vehicle"::"Cargo vehicles") and (SalesLine."Driver type" = SalesLine."Driver type"::Internal) then begin

                                Cust.GET("Sell-to Customer No.");
                                IF Cust."Internal Customer" then
                                    SalesLine.validate("VAT Prod. Posting Group", 'PDV0');

                            end;

                            if SalesLine."Unit Cost" = 0 then begin
                                Calc.get;
                                ItemUnitCost.Reset();
                                ItemUnitCost.SetFilter("No.", '%1', Calc."Item No. 2");
                                if ItemUnitCost.FindFirst() then begin
                                    IUM.Reset();
                                    IUM.SetFilter("Item No.", '%1', Calc."Item No. 2");
                                    //od kilograma
                                    IUm.SetFilter(Code, '%1', 'KG');
                                    if IUM.FindFirst() then begin
                                        G.get;
                                        SalesLine.Validate("Unit Cost", ItemUnitCost."Unit Cost" * IUM."Qty. per Unit of Measure");
                                        SalesLine.Validate("Unit Cost (LCY)", ItemUnitCost."Unit Cost" * IUM."Qty. per Unit of Measure");
                                    end;

                                end;
                            end;
                            if SalesLine.Quantity <> 0 then begin
                                SalesLine."Posting Date2" := today;

                                SalesLine.Insert();
                            end;
                            SHOpen.Reset();
                            SHOpen.SetFilter("No.", '%1', SalesLine."Document No.");
                            SHOpen.SetFilter("Document Type", '%1', SalesLine."Document Type");

                            SOOpen.SetTableView(SHOpen);
                            Commit();
                            SOOpen.Run();
                            Commit();


                        end

                        else begin
                            SalesSet.get;



                            //nemam prodajni nalog, otvaram novi.
                            SHNew.Init();
                            SHNew.Validate("Sell-to Customer No.", worktype."Customer No.");
                            SHNew.Validate("Posting Date", today);
                            SHNew.Validate("Document Type", SHNew."Document Type"::Order);
                            if worktype."Customer No." = SalesSet."NN Customer Code" then begin
                                BillT.Reset();
                                BillT.SetFilter(CNG, '%1', true);
                                BillT.SetFilter(NN, '%1', true);
                                if BillT.FindFirst() then begin
                                    SHNew.Validate("Bill type", BillT.Code);
                                    SHNew.Validate("No. Series", BillT."No. Series Bill");
                                    SHNew.Validate("Posting No. Series", BillT."Posting No. Series Bill");

                                end;

                            end
                            else begin
                                BillT.Reset();
                                BillT.SetFilter(CNG, '%1', true);
                                BillT.SetFilter(NN, '%1', false);
                                if BillT.FindFirst() then begin
                                    SHNew.Validate("Bill type", BillT.Code);
                                    SHNew.Validate("No. Series", BillT."No. Series Bill");
                                    SHNew.Validate("Posting No. Series", BillT."Posting No. Series Bill");
                                end;

                            end;
                            SHNew.Insert(true);
                            Commit();

                            SHLineNew.init;
                            SHLineNew.Validate("Line No.", 10000);
                            SHLineNew.Validate("Document Type", SHNew."Document Type");
                            SHLineNew."Posting Date2" := today;
                            SHLineNew.Validate("Sell-to Customer No.", worktype."Customer No.");
                            SHLineNew.Validate("Document Type", SalesLine."Document Type"::Order);
                            SHLineNew.Validate("Document No.", SHNew."No.");
                            SHLineNew.Validate(Type, SHLineNew.Type::Item);
                            Calc.get;
                            us.Reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                us."Type of vehicle" := worktype."Type of vehicle";
                                us.modify;
                            end;

                            SHLineNew.Validate("No.", Calc."Item No.");
                            LocationGet.Reset();
                            //   LocationGet.SetFilter("CNG MP", '%1', true);
                            SalesSet.get;
                            if worktype."Customer No." = SalesSet."NN Customer Code" then begin
                                LocationGet.SetFilter("CNG MP", '%1', true)
                            end

                            else begin
                                if CuInternal.get(worktype."Customer No.") then begin
                                    if CuInternal."Internal Customer" = true then
                                        LocationGet.SetFilter("CNG VL", '%1', true)
                                    else
                                        LocationGet.SetFilter("CNG VP", '%1', true);
                                end
                                else begin
                                    LocationGet.SetFilter("CNG VP", '%1', true);

                                end;


                            end;
                            if LocationGet.FindFirst() then
                                SHLineNew.Validate("Location Code", LocationGet.Code);
                            SHLineNew.Validate(Quantity, worktype.Quantity);

                            SHLineNew.validate("Payment Method Code", worktype."Payment Method Code");
                            SHLineNew.validate("Driver type", worktype."Driver type");
                            SHLineNew.validate("Driver ID", worktype."Driver ID");
                            SHLineNew.validate("Driver Name", worktype."Driver Name");
                            SHLineNew.validate("Driver Registration No.", worktype."Driver Registration No.");

                            SHLineNew.validate("Vehicle Registration", worktype."Vehicle Registration");
                            SHLineNew.validate("Type of vehicle", worktype."Type of vehicle");
                            if SHLineNew."Unit Cost" = 0 then begin
                                Calc.get;
                                ItemUnitCost.Reset();
                                ItemUnitCost.SetFilter("No.", '%1', Calc."Item No. 2");
                                if ItemUnitCost.FindFirst() then begin
                                    IUM.Reset();
                                    IUM.SetFilter("Item No.", '%1', Calc."Item No. 2");
                                    //od kilograma
                                    IUm.SetFilter(Code, '%1', 'KG');
                                    if IUM.FindFirst() then begin
                                        G.get;
                                        SHLineNew.Validate("Unit Cost", ItemUnitCost."Unit Cost" * IUM."Qty. per Unit of Measure");
                                        SHLineNew.Validate("Unit Cost (LCY)", ItemUnitCost."Unit Cost" * IUM."Qty. per Unit of Measure");

                                    end;

                                end;
                            end;


                            Calc.Get();
                            SHLineNew."Posting Date2" := today;
                            if SHLineNew.Quantity <> 0 then
                                SHLineNew.Insert();
                            Commit();
                            Clear(SOOpen);
                            SHOpen.Reset();
                            SHOpen.SetFilter("No.", '%1', SHLineNew."Document No.");
                            SHOpen.SetFilter("Document Type", '%1', SHLineNew."Document Type");

                            SOOpen.SetTableView(SHOpen);
                            Commit();
                            SOOpen.Run();
                            Commit();

                        end;
                        IF FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for copy txt file" + format(worktype.Description)) THEN begin

                            FileNamePrevious := FileManagement.GetFileNameWithoutExtension(worktype.Description);
                            NewFileName := FileNamePrevious + '.old';
                            DestinationFile := NewFileName;
                            File.Rename(GL."Path for import txt file" + worktype.Description, GL."Path for import txt file" + NewFileName);

                            /*   FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for import txt file" + DestinationFile);

                               Erase(GL."Path for import txt file" + DestinationFile);
                               Erase(GL."Path for import txt file" + worktype.Description);*/

                            //ovdje sada tražim pravi nalog i linije punim na taj nalog

                            //    if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                            //      SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));

                            //total/(količina *(1+17%))

                        end
                        else begin
                            //naziv fajla  i opis fajla generisati ID

                            FileNamePrevious := FileManagement.GetFileNameWithoutExtension(worktype.Description);
                            NewFileName := FileNamePrevious + '.old';
                            DestinationFile := NewFileName;
                            File.Rename(GL."Path for import txt file" + worktype.Description, GL."Path for import txt file" + NewFileName);
                            /*FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for import txt file" + DestinationFile);

                            Erase(GL."Path for import txt file" + DestinationFile);
                            Erase(GL."Path for import txt file" + worktype.Description);*/
                        end;

                        //obriši fajl

                        worktypes.Close();
                    end;


                    //    ShowFileOrder(FileBuffer);




                end;








                //   if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                //         SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));










            }



            action("Import txt file VP")
            {
                Caption = 'Import txt file VP';

                Ellipsis = true;
                Image = Import;
                Visible = false;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    TempFile: File;
                    FileName: Text;
                    ReadLineNew: Text;
                    Proceed: Boolean;
                    Text040: Label 'Xml file(*.xml)|*.xml|Text file(*.txt)|*.txt';
                    Text000: Label 'Import File';
                    Text004: Label 'Importing Data from file @1@@@@@@@@';
                    Text005: Label 'Please select a valid File name first!';
                    Brojac: Integer;
                    DataFile: File;
                    Window: Dialog;
                    StreamInTest: InStream;
                    SalseLineUpdate: Record "Sales Line";
                    DataLine: Text;
                    Linija: Integer;
                    Text12: array[12] of Text[2500];
                    Proc: Integer;
                    SalesLine: Record "Sales Line";
                    Calc: Record "Calculation Setup";
                    Quantity2: Decimal;
                    GL: Record "General Ledger Setup";
                    Price: Decimal;
                    LocationGet: Record Location;
                    SalesLineE: Record "Sales Line";
                    MessageText: text[2000];
                    BrojaInt: Integer;
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    worktype: Record "Work Type";
                    FileD: Record File;
                    worktypes: Page "Work Types";
                    Text12_T: array[4, 4] of Text[2500];

                    FileBuffer: record File;
                    Separator: text[1000];
                    SHCheck: Record "Sales Line";
                    BillT: Record "Customer Templ.";
                    SHNew: Record "Sales Header";
                    SHOpen: record "Sales Header";

                    SHLineNew: Record "Sales Line";
                    SalesSet: Record "Sales & Receivables Setup";
                    SOOpen: page "Sales Order";
                    US: Record "User Setup";

                begin


                    GL.get;


                    linija := 0;



                    /*    ReleaseSalesDoc.PerformManualReopen(Rec);

                        TempFile.CREATETEMPFILE(TEXTENCODING::UTF8);
                        FileName := TempFile.NAME + '.txt';
                        TempFile.CLOSE;

                        Proceed := UPLOAD(Text000, '', Text040, '', FileName);

                        IF NOT Proceed THEN
                            ERROR(Text005);
                        linija := 0;

                        IF FILE.EXISTS(FileName) THEN
                            DataFile.OPEN(FileName, TextEncoding::UTF8)
                        ELSE
                            ERROR(Text005);
                        Brojac := 1;

                        IF GUIALLOWED THEN
                            Window.OPEN(Text004, Proc);
                        DataFile.TEXTMODE := TRUE;

                        DataFile.CLOSE;
                        DataFile.OPEN(FileName, TextEncoding::UTF8);

                        DataFile.CREATEINSTREAM(StreamInTest);
                        WHILE NOT StreamInTest.EOS DO BEGIN
                            StreamInTest.READTEXT(DataLine);
                            
                            Text12[1] := Split(DataLine, ';');
                            Text12[2] := Split(DataLine, ';');
                            Text12[3] := Split(DataLine, ';');
                            Text12[4] := Split(DataLine, ';');
                            Text12[2] := Replacestring(Text12[2], '.', ',');
                            Text12[3] := Replacestring(Text12[3], '.', ',');
                            Text12[4] := Replacestring(Text12[4], '.', ',');*/



                    worktype.DeleteAll;
                    FileD.SetRange("Is a file", true);
                    GL.Get();
                    FileD.SetRange(Path, GL."Path for import txt file");
                    //ShowFileOrder(File);




                    BrojaInt := 0;
                    //   ShowFileOrder(File);
                    if FileD.FindSet() then
                        repeat

                            MessageText := '';
                            BrojaInt += 1;
                            FileBuffer := FileD;
                            FileBuffer.Path := Format(CreateDateTime(FileD.Date, FileD.time), 0, 9);
                            importFile.WRITEMODE(TRUE);
                            importFile.TEXTMODE(TRUE);

                            MessageText := StrSubstNo('%1%2%3', MessageText, Separator, FileD.Name);
                            Separator := '\';

                            importFile.OPEN(GL."Path for import txt file" + MessageText);


                            WHILE importFile.READ(ReadLine) > 0 DO BEGIN


                                Text12_T[1] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[2] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[3] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[4] [BrojaInt] := Split_T(ReadLine, ';');
                                Text12_T[2] [BrojaInt] := Replacestring_T(Text12_T[2] [BrojaInt], '.', ',');
                                Text12_T[3] [BrojaInt] := Replacestring_T(Text12_T[3] [BrojaInt], '.', ',');
                                Text12_T[4] [BrojaInt] := Replacestring_T(Text12_T[4] [BrojaInt], '.', ',');
                            end;
                            importFile.CLOSE;
                            if text12[1] [BrojaInt] <> '' then begin
                                worktype.Init();
                                worktype.Code := Text12_T[1] [BrojaInt];
                                Evaluate(Quantity_Read, Text12_T[2] [BrojaInt]);
                                worktype.Quantity := Quantity_Read;

                                Evaluate(Price, Text12_T[3] [BrojaInt]);
                                worktype.Price := Price;

                                Evaluate(ukupno, Text12_T[4] [BrojaInt]);
                                worktype.Total := ukupno;

                                worktype.Description := MessageText;
                                worktype.Insert();
                            end;



                        //mogu biti 4 terminala

                        /*    for i := 1 to BrojaInt do begin
                                if text12[1] [BrojaInt] <> '' then
                                    Message(Text12[1] [BrojaInt] + File.Name);
                                if text12[2] [BrojaInt] <> '' then
                                    Message(Text12[1] [BrojaInt] + File.Name);
                                if text12[3] [BrojaInt] <> '' then
                                    Message(Text12[1] [BrojaInt] + File.Name);
                                if text12[1] [BrojaInt] <> '' then
                                    Message(Text12[4] [BrojaInt] + File.Name);


                            end;
            */



                        until FileD.next = 0;




                    Clear(worktypes);
                    worktype.Reset();

                    Commit();
                    //   worktypes.Run();
                    Commit();
                    worktypes.LOOKUPMODE(TRUE);
                    IF worktypes.RUNMODAL = ACTION::LookupOK THEN BEGIN

                        worktypes.GETRECORD(worktype);
                        SHCheck.Reset();
                        SHCheck.SetFilter("Sell-to Customer No.", '%1', worktype."Customer No.");
                        SHCheck.SetFilter("Type of vehicle", '%1', worktype."Type of vehicle");
                        if SHCheck.FindFirst() then begin
                            SalesLineE.Reset();
                            SalesLineE.SetFilter("Document No.", '%1', SHCheck."Document No.");
                            SalesLine.SetCurrentKey("Line No.");
                            if SalesLineE.FindLast() then
                                Linija := SalesLineE."Line No." + 10000
                            else
                                Linija += 10000;

                            SalesLine.Init();
                            SalesLine.Validate("Line No.", Linija);
                            SalesLine."Posting Date2" := today;
                            SalesLine.Validate("Sell-to Customer No.", worktype."Customer No.");
                            SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.Validate("Document No.", SHCheck."Document No.");
                            SalesLine.Validate(Type, SalesLine.Type::Item);
                            Calc.Get();
                            US.Reset();
                            US.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                us."Type of vehicle" := worktype."Type of vehicle";
                                us.Modify();
                            end;

                            SalesLine.Validate("No.", Calc."Item No.");
                            LocationGet.Reset();
                            LocationGet.SetFilter("CNG VP", '%1', true);
                            if LocationGet.FindFirst() then
                                SalesLine.Validate("Location Code", LocationGet.Code);
                            SalesLine.Validate(Quantity, worktype.Quantity);
                            SalesLine."Payment Method Code" := worktype."Payment Method Code";
                            SalesLine."Driver ID" := worktype."Driver ID";
                            SalesLine."Driver Name" := worktype."Driver Name";
                            SalesLine."Driver Registration No." := worktype."Driver Registration No.";
                            SalesLine."Driver type" := worktype."Driver type";
                            SalesLine."Vehicle Registration" := worktype."Vehicle Registration";
                            SalesLine."Type of vehicle" := worktype."Type of vehicle";
                            SalesLine."Posting Date2" := todaY;

                            if SalesLine.Quantity <> 0 then
                                SalesLine.Insert();

                            SHOpen.Reset();
                            SHOpen.SetFilter("No.", '%1', SalesLine."Document No.");
                            SHOpen.SetFilter("Document Type", '%1', SalesLine."Document Type");

                            SOOpen.SetTableView(SHOpen);
                            Commit();
                            SOOpen.Run();
                            Commit();


                        end

                        else begin
                            SalesSet.get;



                            //nemam prodajni nalog, otvaram novi.
                            SHNew.Init();
                            SHNew.Validate("Sell-to Customer No.", worktype."Customer No.");
                            SHNew.Validate("Posting Date", today);
                            SHNew.Validate("Document Type", SHNew."Document Type"::Order);
                            if worktype."Customer No." = SalesSet."NN Customer Code" then begin
                                BillT.Reset();
                                BillT.SetFilter(CNG, '%1', true);
                                BillT.SetFilter(NN, '%1', true);
                                if BillT.FindFirst() then
                                    SHNew.Validate("Bill type", BillT.Code);

                            end
                            else begin
                                BillT.Reset();
                                BillT.SetFilter(CNG, '%1', true);
                                BillT.SetFilter(NN, '%1', false);
                                if BillT.FindFirst() then
                                    SHNew.Validate("Bill type", BillT.Code);

                            end;
                            SHNew.Insert(true);
                            Commit();

                            SHLineNew.init;
                            SHLineNew.Validate("Line No.", 10000);
                            SHLineNew.Validate("Document Type", SHNew."Document Type");
                            SHLineNew."Posting Date2" := today;
                            SHLineNew.Validate("Sell-to Customer No.", worktype."Customer No.");
                            SHLineNew.Validate("Document Type", SalesLine."Document Type"::Order);
                            SHLineNew.Validate("Document No.", SHNew."No.");
                            SHLineNew.Validate(Type, SHLineNew.Type::Item);

                            Calc.Get();
                            Calc.get;
                            us.Reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                us."Type of vehicle" := worktype."Type of vehicle";
                                us.modify;
                            end;

                            SHLineNew.Validate("No.", Calc."Item No.");
                            LocationGet.Reset();
                            LocationGet.SetFilter("CNG MP", '%1', true);
                            if LocationGet.FindFirst() then
                                SHLineNew.Validate("Location Code", LocationGet.Code);
                            SHLineNew.Validate(Quantity, worktype.Quantity);
                            SHLineNew."Payment Method Code" := worktype."Payment Method Code";
                            SHLineNew."Driver ID" := worktype."Driver ID";
                            SHLineNew."Driver Name" := worktype."Driver Name";
                            SHLineNew."Driver Registration No." := worktype."Driver Registration No.";
                            SHLineNew."Driver type" := worktype."Driver type";
                            SHLineNew."Vehicle Registration" := worktype."Vehicle Registration";
                            SHLineNew."Type of vehicle" := worktype."Type of vehicle";
                            SHLineNew."Posting Date2" := today;
                            if SHLineNew.Quantity <> 0 then
                                SHLineNew.Insert();
                            Commit();
                            Clear(SOOpen);
                            SHOpen.Reset();
                            SHOpen.SetFilter("No.", '%1', SHLineNew."Document No.");
                            SHOpen.SetFilter("Document Type", '%1', SHLineNew."Document Type");

                            SOOpen.SetTableView(SHOpen);
                            Commit();
                            SOOpen.Run();
                            Commit();

                        end;
                        IF FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for copy txt file" + format(worktype.Description)) THEN begin
                            Erase(GL."Path for import txt file" + worktype.Description);

                            //ovdje sada tražim pravi nalog i linije punim na taj nalog





                            //    if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                            //      SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));

                            //total/(količina *(1+17%))


                        end;

                        //obriši fajl

                        worktypes.Close();
                    end;


                    //    ShowFileOrder(FileBuffer);




                end;








                //   if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                //         SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));










            }



            action(CalculateSubsidies)
            {
                Caption = 'Calculate Subsidies';
                visible = NOT CngUser;
                Ellipsis = true;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SLS: Record "Sales Line";
                    CS: Record "Calculation Setup";
                    CustS: Record Customer;
                    SubAmount: Decimal;
                    SH2: Record "Sales Header";
                begin


                    sh2.reset;
                    sh2.setfilter("Subsidies Line", '<>%1', 0);
                    if sh2.FindSet() then
                        repeat

                            SLS.Reset();
                            sls.SetFilter("Document No.", '%1', sh2."No.");
                            if (cs."Subsidies Date from" <> 0D) and (cs."Subsidies Date to" <> 0D) then
                                SLS.SetFilter("Posting Date2", '%1..%2', cs."Subsidies Date from", cs."Subsidies Date to");
                            SLS.SetFilter(Subsidies, '%1', false);
                            SLS.SetCurrentKey("No.", "Line No.");
                            sls.Ascending;
                            if SLS.FindSet() then
                                repeat


                                    cs.get;


                                    CustS.Reset();
                                    CustS.SetFilter("No.", '%1', SLS."Sell-to Customer No.");
                                    if CustS.FindFirst() then begin
                                        if (CustS."Subsidies - YES/NO" = CustS."Subsidies - YES/NO"::Yes) and (CustS."Subsidies - has statement" = CustS."Subsidies - has statement") then begin


                                            //nađem taj nalog
                                            //Količina * iznos subvencije
                                            Sh2."Subsidies Amount" += SLS.Quantity * cs.Subsidies;
                                            sls.Subsidies := true;
                                            sls.Modify();
                                        end;

                                    end;




                                until SLS.Next() = 0;

                            sh2.Subsidies := true;
                            sh2.Modify();

                        until sh2.Next() = 0;



                end;
            }



            action(ChangePrice)
            {
                Caption = 'ChangePrice';
                visible = NOT CngUser;
                Ellipsis = true;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SH: record "Sales Header";
                    filter: text[250];
                    CS: Record "Calculation Setup";
                    SO: page "Sales Order";
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    Saesl: Record "Sales Line";
                    GL: record "General Ledger Setup";
                    Custt: Record customer;
                    CalculationSetup: Record "Calculation Setup";
                    Linija: Integer;
                    CorrFInd: boolean;

                    SHeader: Record "Sales Shipment Header";
                    LocTrans: Record Location;
                    SalesShptLine2: Record "Sales Shipment Line";
                    SalesShptLine: Record "Sales Shipment Line";
                    TransferRH: Record "Transfer Header";
                    TransferHeader: Record "Transfer Header";
                    TransferRL: Record "Transfer Line";
                    TransferLine: Record "Transfer Line";

                    BrojFiskalnogRacuna: Text[2000];
                    VrijemeFiskalnogRacuna: Text[2000];
                    NothingToPostErr: Label 'There is nothing to post.';

                    UpdateSalesLines: Record "Sales Header";
                    SalesHeader: Record "Sales Header";
                    SalesL: Record "Sales Line";
                    ImaZarez: Integer;
                    Rezultat: Text[2000];
                    Putanja2: Text[250];

                    RTD: Codeunit "Release Transfer Document";
                    GLGet: Record "General Ledger Setup";
                    SalesSetup: Record "Sales & Receivables Setup";
                    // SH: Record "Sales Header";
                    SHFind: Record "Sales Header";
                    SaeslFind: Record "Sales Line";
                    OpRisk: Record Employee temporary;
                    CzkF: Record "User Setup";
                    BankAccocunt: Record "Bank Account";

                begin

                    OpRisk.DeleteAll();
                    CS.get;

                    CS.TestField("Change Price");
                    CS.TestField("New Price");
                    SaeslFind.Reset();
                    SaeslFind.SetFilter("Posting Date2", '<=%1 & >=%2', CS."Change Price", DMY2Date(01, Date2DMY(CS."Change Price", 2), Date2DMY(CS."Change Price", 3)));
                    SaeslFind.SetFilter("Fiscal printed", '%1', true);
                    if SaeslFind.FindSet() then
                        repeat

                            OpRisk.Reset();
                            OpRisk.SetFilter("No.", '%1', SaeslFind."Document No.");
                            if not OpRisk.FindFirst() then begin
                                OpRisk.init;
                                OpRisk."No." := SaeslFind."Document No.";
                                OpRisk.Insert();
                                SHFind.Reset();
                                SHFind.SetFilter("No.", '%1', SaeslFind."Document No.");
                                if SHFind.FindFirst() then
                                    ReleaseSalesDoc.PerformManualReopen(SHFind);

                                Saesl.Reset();
                                Saesl.SetFilter("Document No.", '%1', SHFind."No.");
                                Saesl.SetFilter("Posting Date2", '<=%1', CS."Change Price");
                                Saesl.SetFilter("Fiscal printed", '%1', true);
                                if Saesl.FindSet() then
                                    repeat

                                        Saesl.validate("Old Price", Saesl."Unit Price");
                                        Saesl.validate("Total Old Price", Saesl.Amount);

                                        Saesl.validate("Unit Price", CS."New Price");
                                        Saesl.validate(Difference, Saesl.Amount - Saesl."Total Old Price");
                                        Saesl."New Price" := true;
                                        Saesl.Modify(true);
                                        Commit();

                                    until Saesl.Next() = 0;

                                Commit();
                                //po potvrdi

                                Saesl.Reset();
                                Saesl.SetFilter(Difference, '>%1', 0);
                                Saesl.SetFilter("Document No.", '%1', SHFind."No.");
                                if Saesl.FindFirst() then begin
                                    //doknjiži jedan
                                    Saesl.CalcSums(Difference);
                                    //sve idem na jedan zbirni, total
                                    GL.get;

                                    Putanja := GL."Path for fiscal printer";

                                    CZkF.Get(UserId);
                                    BankAccocunt.Reset();
                                    BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                                    if BankAccocunt.findfirst then begin
                                        Putanja := BankAccocunt."Path for fiscal printer";

                                    end
                                    else begin
                                        Putanja := GL."Path for fiscal printer";

                                    end;



                                    File1.CREATE(Putanja + 'Stampatifiskalniracun.000', TEXTENCODING::UTF8);

                                    File1.CREATEOUTSTREAM(OutStreamObj);

                                    plite := '<?xml version="1.0" encoding="utf-8"?>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<BrojZahtjeva></BrojZahtjeva>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    plite := '<VrstaZahtjeva>0</VrstaZahtjeva>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<NoviObjekat>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    /*    plite := '<Kupac>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();
                                        Custt.RESET;
                                        Custt.SETFILTER("No.", '%1', SHFind."Bill-to Customer No.");
                                        IF Custt.FINDFIRST THEN
                                            plite := '<IDbroj>' + Custt."Registration No." + '</IDbroj>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();


                                        //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
                                        plite := '<Naziv>' + SHFind."Bill-to Customer No." + '</Naziv>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

                                        plite := '<Adresa>' + SHFind."Bill-to Address" + '</Adresa>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        //<PostanskiBroj>75320</PostanskiBroj>

                                        plite := '<PostanskiBroj>' + SHFind."Bill-to Post Code" + '</PostanskiBroj>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        //<Grad>Gračanica</Grad>
                                        plite := '<Grad>' + SHFind."Bill-to City" + '</Grad>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        plite := '</Kupac>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();
                                        //</Kupac>
            */
                                    SalesSetup.geT;
                                    if SalesSetup."NN Customer Code" <> SalesL."Sell-to Customer No." then begin
                                        plite := '<Datum>0001-01-01T00:00:00</Datum>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();
                                        plite := '<Kupac>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();
                                        Custt.RESET;
                                        Custt.SETFILTER("No.", '%1', SHFind."Bill-to Customer No.");
                                        IF Custt.FINDFIRST THEN
                                            plite := '<IDbroj>' + Custt."VAT Registration No." + '</IDbroj>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();


                                        //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
                                        plite := '<Naziv>' + SHFind."Bill-to Name" + '</Naziv>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

                                        plite := '<Adresa>' + SHFind."Bill-to Address" + '</Adresa>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        //<PostanskiBroj>75320</PostanskiBroj>

                                        plite := '<PostanskiBroj>' + SHFind."Bill-to Post Code" + '</PostanskiBroj>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        //<Grad>Gračanica</Grad>
                                        plite := '<Grad>' + SHFind."Bill-to City" + '</Grad>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();

                                        plite := '</Kupac>';
                                        OutStreamObj.WRITETEXT(plite);
                                        OutStreamObj.WRITETEXT();
                                        //</Kupac>

                                    end;



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
                                    plite := '<Naziv>' + FORMAT('Iznos po nalogu ' + SHFind."No." + ' za CNG') + '</Naziv>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<JM>' + SalesL."Unit of Measure Code" + '</JM>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    Saesl.Difference := round(Saesl.Difference, 0.01, '=');
                                    //    ImaZarez := STRPOS(FORMAT(Saesl.Difference), ',') + 1;

                                    if salesl.Quantity <> 0 then
                                        ImaZarez := STRPOS(FORMAT(round(Saesl.Difference, 0.01, '=')), ',') + 1
                                    else
                                        ImaZarez := STRPOS(FORMAT(round(0, 0.01, '=')), ',') + 1;


                                    IF STRPOS(FORMAT(COPYSTR(FORMAT(Saesl.Difference), ImaZarez, 2)), '00') = 0 THEN
                                        Rezultat := SO.ChangeSeparator(FORMAT(Saesl.Difference, 0, '<Sign><Integer><Decimals><Comma,.>'))
                                    ELSE
                                        Rezultat := SO.ChangeSeparator(FORMAT(ROUND(Saesl.Difference), 0, '<Precision,2:2><Standard Format,2>'));


                                    plite := '<Cijena>' + Rezultat + '</Cijena>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    IF round(Saesl.Amount, 0.01, '=') - round(Saesl."Amount Including VAT", 0.01, '=') < 0 THEN
                                        plite := '<Stopa>E</Stopa>'
                                    ELSE
                                        plite := '<Stopa>K</Stopa>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<Grupa>0</Grupa>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<PLU>0</PLU>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '</artikal>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<Kolicina>' + '1' + '</Kolicina>';
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
                                    plite := '<VrstePlacanja>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<VrstaPlacanja>';


                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    //  plite := '<Oznaka>Virman</Oznaka>';

                                    if SHFind."Payment Method Code" = 'VIRMAN' then
                                        plite := '<Oznaka>' + 'Virman' + '</Oznaka>';
                                    if SHFind."Payment Method Code" = 'GOTOVINA' then
                                        plite := '<Oznaka>' + 'Gotovina' + '</Oznaka>';
                                    if SHFind."Payment Method Code" = 'KARTIČNO' then
                                        plite := '<Oznaka>' + 'Kartica' + '</Oznaka>';
                                    if SHFind."Payment Method Code" = 'VLASTITA' then
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
                                    plite := '<BrojRacuna></BrojRacuna>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    plite := '<Napomena>' + '</Napomena>';

                                    OutStreamObj.WRITETEXT(plite);



                                    OutStreamObj.WRITETEXT();

                                    plite := '</NoviObjekat>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '</RacunZahtjev>';

                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();


                                    File1.CLOSE;

                                    IF SHFind."Fiscal printed" = FALSE THEN
                                        FileManagement.DownloadToFile(Putanja + 'Stampatifiskalniracun.000', Putanja + 'Stampatifiskalniracun.000');
                                    GL.get;
                                    Commit();
                                    SLEEP(GL."Sleep value");



                                    IF SHFind."Fiscal printed" = FALSE THEN BEGIN
                                        Putanja2 := GL."Path for fiscal printer" + 'odgovori\';

                                        CZkF.Get(UserId);
                                        BankAccocunt.Reset();
                                        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                                        if BankAccocunt.findfirst then begin

                                            Putanja2 := BankAccocunt."Path for fiscal printer" + 'odgovori\';
                                        end
                                        else begin

                                            Putanja2 := GL."Path for fiscal printer" + 'odgovori\';
                                        end;
                                        //  SO.Odgovor(Putanja2 + 'Stampatifiskalniracun.000');
                                        //Key1; "Document Type", "Document No.", "Line No.")
                                        CZkF.Get(UserId);
                                        BankAccocunt.Reset();
                                        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                                        if BankAccocunt.findfirst then begin
                                            BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series FIscal No.", TODAY, true);

                                        end;

                                        UpdateSalesLines.reset;
                                        UpdateSalesLines.get(SHFind."Document Type", SHFind."No.");
                                        UpdateSalesLines."Fiscal No." := BrojFiskalnogRacuna;
                                        UpdateSalesLines."New Price" := cs."New Price";
                                        UpdateSalesLines."Old Price Date" := cs."Change Price";
                                        //UserSetup.GET(USERID);đ
                                        //FiscalPrinterSetup.GET(UserSetup."Fiscal Printer Code");


                                        UpdateSalesLines."Fiscal printed" := TRUE;
                                        UpdateSalesLines."Fiscal DateTime" := CURRENTDATETIME;
                                        UpdateSalesLines."Fiscal User" := USERID;
                                        UpdateSalesLines.MODIFY;
                                        //odmah i duplikat
                                        SO.PrintDuplicateFiscal(true, BrojFiskalnogRacuna);

                                    END
                                    else begin
                                        SO.PrintDuplicateFiscal(true, SHFind."Fiscal No.");
                                    end;


                                    //kraj

                                end;



                                Saesl.Reset();
                                Saesl.SetFilter(Difference, '<%1', 0);
                                Saesl.SetFilter("Document No.", '%1', SHFind."No.");
                                if Saesl.FindSet() then
                                    repeat
                                        //provjeriti ovdje proces kada je iznos manji, 
                                        //da li bi trebala uraditi storno otpremnica, pa nove samo kreirati ponovo



                                        //undo otpremnice
                                        CalculationSetup.get;
                                        GLGet.Get();
                                        if GLGet."Undo Shipment for CP" = true then begin

                                            //storno otpremnice

                                            SHeader.Reset();
                                            SHeader.SetFilter("Order No.", '%1', SHFind."No.");
                                            SHeader.SetFilter("Posting Date", '<=%1', CS."Change Price");

                                            //ovdje već nalazim dvije otpremnice, pa sve storniram
                                            if SHeader.FindSet() then
                                                repeat

                                                    SalesShptLine2.Reset();
                                                    SalesShptLine2.SetFilter("Order No.", '%1', SHFind."No.");
                                                    SalesShptLine2.SetFilter("Document No.", '%1', SHeader."No.");
                                                    //storno npr. *37
                                                    SalesShptLine2.SetFilter(Quantity, '<>0');
                                                    SalesShptLine2.SetRange(Correction, false);
                                                    SalesShptLine2.SetFilter("Posting Date", '<=%1', CS."Change Price");
                                                    if SalesShptLine2.FindSet() then
                                                        repeat


                                                            SalesShptLine.Copy(SalesShptLine2);

                                                            //storno otpremnice

                                                            CODEUNIT.Run(CODEUNIT::"Undo Sales Shipment Line Mess", SalesShptLine);
                                                            commit;

                                                            //kada sam uradila storno otpremnice, da odmah uradim prenos na glavno gas

                                                            LocTrans.Reset();
                                                            LocTrans.SetFilter(Code, '%1', SalesShptLine."Location Code");
                                                            if LocTrans.FindFirst() then begin

                                                                if (LocTrans."CNG VP" = true) or (LocTrans."CNG MP") then begin

                                                                    if (LocTrans."CNG VP" = true) then begin
                                                                        CorrFInd := False;
                                                                        TransferRH.Reset();
                                                                        TransferRH.SetFilter("Sales Header No.", '%1', SalesShptLine."Order No.");
                                                                        TransferRH.SetFilter(Correction, '%1', false);
                                                                        TransferRH.SetFilter("Transfer-to Code", '%1', SalesShptLine."Location Code");

                                                                        TransferRH.setfilter("Posting Date", '%1', SalesShptLine."Posting Date");
                                                                        if TransferRH.findset then
                                                                            repeat

                                                                                TransferRL.reset;
                                                                                TransferRL.setfilter("Document No.", '%1', TransferRH."No.");
                                                                                TransferRL.setfilter("Quantity", '%1', SalesShptLine."Quantity");

                                                                                if TransferRL.findfirst then begin
                                                                                    TransferRH.correction := true;
                                                                                    CorrFInd := true;
                                                                                    TransferRH.modify;
                                                                                    Commit();
                                                                                end;

                                                                            //korigovala sam prethodnu prenosnicu da je korekcija
                                                                            until (TransferRH.next = 0) or (CorrFInd = true);
                                                                    end;


                                                                    if (LocTrans."CNG MP" = true) then begin
                                                                        TransferRH.Reset();
                                                                        TransferRH.SetFilter("Sales Header No.", '%1', SalesShptLine."Order No.");
                                                                        TransferRH.SetFilter(Correction, '%1', false);
                                                                        TransferRH.SetFilter("Transfer-to Code", '%1', SalesShptLine."Location Code");
                                                                        CorrFInd := False;
                                                                        TransferRH.setfilter("Posting Date", '%1', SalesShptLine."Posting Date");
                                                                        if TransferRH.findset then
                                                                            repeat

                                                                                TransferRL.reset;
                                                                                TransferRL.setfilter("Document No.", '%1', TransferRH."No.");
                                                                                TransferRL.setfilter("Quantity", '%1', SalesShptLine."Quantity");

                                                                                if TransferRL.findfirst then begin
                                                                                    TransferRH.correction := true;
                                                                                    TransferRH.modify;
                                                                                    CorrFInd := true;
                                                                                end;
                                                                                Commit();
                                                                            until (TransferRH.next = 0) or (CorrFInd = true);
                                                                        //korigovala sam prethodnu prenosnicu da je korekcija
                                                                    end;

                                                                    CorrFInd := False;

                                                                    TransferRH.Reset();
                                                                    TransferRH.SetFilter("Sales Header No.", '%1', SalesShptLine."Order No.");
                                                                    TransferRH.SetFilter(Correction, '%1', false);
                                                                    TransferRH.SetFilter("Transfer-to Code", '%1', 'CNG VLP');

                                                                    TransferRH.setfilter("Posting Date", '%1', SalesShptLine."Posting Date");
                                                                    if TransferRH.findset then
                                                                        repeat
                                                                            CorrFInd := false;
                                                                            TransferRL.reset;
                                                                            TransferRL.setfilter("Document No.", '%1', TransferRH."No.");
                                                                            TransferRL.setfilter("Quantity", '%1', SalesShptLine."Quantity");

                                                                            if TransferRL.findfirst then begin
                                                                                TransferRH.correction := true;

                                                                                CorrFInd := True;
                                                                                TransferRH.modify;
                                                                                Commit();
                                                                            end;
                                                                        //korigovala sam prethodnu prenosnicu da je korekcija
                                                                        until (TransferRH.next = 0) or (CorrFInd = true);

                                                                end;

                                                            end;
                                                            //vrati sa CNG VP na GLAVNO GAS ili MP na glavno


                                                            if (LocTrans."CNG MP" = true) then begin

                                                                //vratim sam MP na VL pa na glavno gas

                                                                TransferHeader.init;
                                                                TransferHeader.Validate("Transfer-from Code", SalesShptLine."Location Code");
                                                                TransferHeader.Validate("Transfer-to Code", 'CNG VLP');
                                                                TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                                                TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                                                TransferHeader.Validate("Sales Header No.", SHFind."No.");
                                                                //     TransferHeader.Validate(Correction, true);
                                                                // kreiraj nalog za prenos

                                                                TransferHeader.Insert(true);
                                                                commit;
                                                                Linija += 10000;



                                                                TransferLine.init;
                                                                TransferLine.Validate("Document No.", TransferHeader."No.");
                                                                TransferLine.Validate("Line No.", Linija);
                                                                TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                                                TransferLine.validate("Transfer-from Code", SalesShptLine."Location Code");
                                                                TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");

                                                                TransferLine.Validate(Quantity, SalesShptLine.Quantity);
                                                                TransferLine.Insert(true);

                                                                //lansiraj
                                                                commit;
                                                                RTD.Run(TransferHeader);
                                                                commit;



                                                                //   GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                                                //lansiraj

                                                                SO.TransferHeaderPost_GAS(TransferHeader);


                                                                TransferHeader.init;
                                                                TransferHeader.Validate("Transfer-from Code", 'CNG VLP');
                                                                TransferHeader.Validate("Transfer-to Code", 'GLAVNO GAS');
                                                                TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                                                TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                                                TransferHeader.Validate("Sales Header No.", SHFind."No.");
                                                                //     TransferHeader.Validate(Correction, true);
                                                                // kreiraj nalog za prenos

                                                                TransferHeader.Insert(true);
                                                                commit;
                                                                Linija += 10000;



                                                                TransferLine.init;
                                                                TransferLine.Validate("Document No.", TransferHeader."No.");
                                                                TransferLine.Validate("Line No.", Linija);
                                                                TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                                                TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                                                TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");

                                                                TransferLine.Validate(Quantity, SalesShptLine.Quantity);
                                                                TransferLine.Insert(true);

                                                                //lansiraj
                                                                commit;
                                                                RTD.Run(TransferHeader);
                                                                commit;



                                                                //   GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                                                //lansiraj

                                                                SO.TransferHeaderPost_GAS(TransferHeader);


                                                                //

                                                            end;


                                                            Commit();



                                                            if (LocTrans."CNG VP" = true) then begin

                                                                //vratim sam MP na VL pa na glavno gas

                                                                TransferHeader.init;
                                                                TransferHeader.Validate("Transfer-from Code", SalesShptLine."Location Code");
                                                                TransferHeader.Validate("Transfer-to Code", 'GLAVNO GAS');
                                                                TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                                                TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                                                TransferHeader.Validate("Sales Header No.", SHFind."No.");
                                                                //     TransferHeader.Validate(Correction, true);
                                                                // kreiraj nalog za prenos

                                                                TransferHeader.Insert(true);
                                                                commit;
                                                                Linija += 10000;



                                                                TransferLine.init;
                                                                TransferLine.Validate("Document No.", TransferHeader."No.");
                                                                TransferLine.Validate("Line No.", Linija);
                                                                TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                                                TransferLine.validate("Transfer-from Code", SalesShptLine."Location Code");
                                                                TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");

                                                                TransferLine.Validate(Quantity, SalesShptLine.Quantity);
                                                                TransferLine.Insert(true);

                                                                //lansiraj
                                                                commit;
                                                                RTD.Run(TransferHeader);
                                                                commit;



                                                                //   GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                                                //lansiraj

                                                                SO.TransferHeaderPost_GAS(TransferHeader);



                                                            end;


                                                        until SalesShptLine2.Next() = 0;


                                                until SHeader.Next() = 0;

                                            //Provjeriti da li uopšte treba promjena količine. potrebnu količinu na glavno, pa potom ponovo kreirati

                                            //kako se desio storno otpremnice, treba ponovo vratiti 




                                            //sada kreirati otpremu i prijem za nalog prenosa


                                            //sada kreirati otpremu i prijem za nalog prenosa


                                            /*    WhseShptLine1.Reset();
                                                WhseShptLine1.SetFilter("Source No.", '%1', TransferHeader."No.");
                                                if WhseShptLine1.FindSet() then
                                                    WhseShptLine.Copy(WhseShptLine1);
                                                //PROKNJIZIM    CODEUNIT.Run(CODEUNIT::"Whse.-Post Shipment (Yes/No)", WhseShptLine);

                                                WhseShptLineRez.Copy(WhseShptLine);
                                                HideDialog := true;
                                                IsPosted := false;

                                                if IsPosted then
                                                    exit;

                                                with WhseShptLineRez do begin
                                                    if Find then
                                                        selection := 1;

                                                    WhsePostShipment.SetPostingSettings(Invoice);
                                                    WhsePostShipment.SetPrint(false);
                                                    WhsePostShipment.Run(WhseShptLineRez);
                                                    Clear(WhsePostShipment);
                                                end;


                                                Commit();*/



                                            //nova otpremnica pa novo izdavanje

                                        end;

                                        //storno i novi fiskalni račun;

                                        SO.PrintReklamirani(true, Saesl);
                                        commit;
                                        //ovdje trebam dodatni storno otpremnica i treba mi dio koji se odnosi na primke prijenosa i označenu kvačicu correction


                                        if GLGet."Undo Shipment for CP" = true then begin
                                            SalesL.Reset();
                                            SalesL.SetFilter("Document Type", '%1', SalesL."Document Type"::Order);
                                            SalesL.SetFilter("Document No.", '%1', SHFind."No.");
                                            SalesL.SetFilter("Fiscal printed", '%1', true);
                                            SalesL.SetFilter("R. Fiscal printed", '%1', true);
                                            SalesL.SetFilter("New Fiscal printed", '%1', false);
                                            SalesL.SetFilter("Cargo done", '%1', false);
                                            if SalesL.FindSet() then
                                                repeat

                                                    // kreiraj nalog za prenos
                                                    TransferHeader.init;
                                                    TransferHeader.Validate("Transfer-from Code", 'GLAVNO GAS');
                                                    TransferHeader.Validate("Transfer-to Code", SalesL."Location Code");
                                                    TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                                    TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                                    TransferHeader.Validate("Sales Header No.", SHFind."No.");

                                                    TransferHeader.Insert(true);


                                                    commit;
                                                    Linija += 10000;




                                                    TransferLine.init;
                                                    TransferLine.Validate("Document No.", TransferHeader."No.");
                                                    TransferLine.Validate("Line No.", Linija);
                                                    TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                                    TransferLine.Validate(Quantity, SalesL.Quantity);
                                                    TransferLine.Insert(true);

                                                    //lansiraj
                                                    commit;
                                                    RTD.Run(TransferHeader);
                                                    commit;



                                                    //za glavno gas


                                                    SO.TransferHeaderPost_GAS(TransferHeader);
                                                    Commit();




                                                /*ĐK ZA GLAVNO SKLADIŠTE       GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                                       //lansiraj
                                                       "Transfer Receipt Created" := true;
                                                       Commit();


                                                       //sada kreirati otpremu i prijem za nalog prenosa


                                                       //sada kreirati otpremu i prijem za nalog prenosa


                                                       WhseShptLine1.Reset();
                                                       WhseShptLine1.SetFilter("Source No.", '%1', TransferHeader."No.");
                                                       if WhseShptLine1.FindSet() then
                                                           WhseShptLine.Copy(WhseShptLine1);
                                                       //PROKNJIZIM    CODEUNIT.Run(CODEUNIT::"Whse.-Post Shipment (Yes/No)", WhseShptLine);

                                                       WhseShptLineRez.Copy(WhseShptLine);
                                                       HideDialog := true;
                                                       IsPosted := false;

                                                       if IsPosted then
                                                           exit;

                                                       with WhseShptLineRez do begin
                                                           if Find then
                                                               selection := 1;

                                                           WhsePostShipment.SetPostingSettings(Invoice);
                                                           WhsePostShipment.SetPrint(false);
                                                           WhsePostShipment.Run(WhseShptLineRez);
                                                           Clear(WhsePostShipment);
                                                       end;

                                                       "Posted Transfer Order" := true;
                                                       Commit();
                    */
                                                until SalesL.Next() = 0;


                                            //kreiraj otpremu, pa izdaj fiskalni račun

                                            //    PostDocument(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"Posted Document");




                                            //    PostDocument(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"Posted Document");


                                            if not SHFind.Find then
                                                Error(NothingToPostErr);

                                            SalesHeader.Copy(Rec);
                                            SO.Code_SalesHeader(Rec, false);
                                            commit;



                                        end;



                                        //da na kraju kreiraj otpremu za ovo

                                        //ovdje bi sada ispisala fiskalni račun

                                        SO.PrintFiscal_New(true, Saesl);


                                    //

                                    until Saesl.Next() = 0;
                            end;
                        until SaeslFind.Next() = 0;

                end;

            }




            // }

        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        LocationF: Text[1024];
        UserSetup: Record "User Setup";
        LocationT: Record Location;
        WE: Record "Warehouse Employee";
        BillType: Record "Customer Templ.";
        Billcode: text;
    begin

        LocationF := '';
        Billcode := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if (UserSetup."CNG User" = true) or (UserSetup."CNG Administrator" = true) then begin
                BillType.Reset();
                BillType.SetFilter(CNG, '%1', true);
                if BillType.FindSet() then
                    repeat
                        Billcode += BillType.Code + '|';
                    until BillType.Next() = 0;
                if StrLen(Billcode) > 2 then begin
                    Billcode := CopyStr(Billcode, 1, StrLen(Billcode) - 1);
                end;
                SetFilter("Bill type", Billcode);
            end;

            if UserSetup."CNG User" = true then begin



                LocationT.Reset();
                LocationT.SetFilter("CNG MP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';

                LocationT.Reset();
                LocationT.SetFilter("CNG VP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';



            end
            else begin

                WE.Reset();
                WE.SetFilter("User ID", '%1', UserId);
                if WE.FindSet() then
                    repeat
                        LocationF += we."Location Code" + '|';

                    until WE.Next() = 0;


            end;

            if (LocationF <> '') and (StrLen(LocationF) >= 2) then begin
                LocationF := CopyStr(LocationF, 1, StrLen(LocationF) - 1);
            end

        end;
        //
        if LocationF <> '' then begin
            SetFilter("Location Filter", LocationF);
        end;

    end;



    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        LocationF: Text[1024];
        UserSetup: Record "User Setup";
        LocationT: Record Location;
        WE: Record "Warehouse Employee";
        BillType: Record "Customer Templ.";
        Billcode: text;
    begin

        LocationF := '';
        Billcode := '';
        CngUser := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if (UserSetup."CNG User" = true) or (UserSetup."CNG Administrator" = true) then begin
                BillType.Reset();
                BillType.SetFilter(CNG, '%1', true);
                if BillType.FindSet() then
                    repeat
                        Billcode += BillType.Code + '|';
                    until BillType.Next() = 0;
                if StrLen(Billcode) > 2 then begin
                    Billcode := CopyStr(Billcode, 1, StrLen(Billcode) - 1);
                end;
                SetFilter("Bill type", Billcode);
            end;

            if UserSetup."CNG User" = true then begin
                CngUser := TRUE;
                LocationT.Reset();
                LocationT.SetFilter("CNG MP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';

                LocationT.Reset();
                LocationT.SetFilter("CNG VP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';


            end
            else begin

                WE.Reset();
                WE.SetFilter("User ID", '%1', UserId);
                if WE.FindSet() then
                    repeat
                        LocationF += we."Location Code" + '|';

                    until WE.Next() = 0;


            end;

            if (LocationF <> '') and (StrLen(LocationF) >= 2) then begin
                LocationF := CopyStr(LocationF, 1, StrLen(LocationF) - 1);
            end

        end;
        //
        if LocationF <> '' then begin
            SetFilter("Location Filter", LocationF);
        end;

    end;





    procedure Split_T(VAR TextSplit: Text[1024]; Separator: Text[1]) Part: Text[1024]
    var
        Pos: Integer;
    begin

        Pos := STRPOS(TextSplit, Separator);
        IF Pos > 0 THEN BEGIN
            Part := COPYSTR(TextSplit, 1, Pos - 1);
            IF Pos + 1 <= STRLEN(TextSplit) THEN
                TextSplit := COPYSTR(TextSplit, Pos + 1)
            ELSE
                TextSplit := '';
        END ELSE BEGIN
            Part := TextSplit;
            TextSplit := '';
        END;
    end;

    procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    var

        myInt: Integer;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Quantity_Read: Decimal;
        Putanja: Text[1000];
        ukupno: Decimal;
        File1: File;
        Plite: Text;
        OutStreamObj: OutStream;
        Periodicreportfiscal: Report "Periodic report - fiscal";
        TXTTab: Char;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text;
        x5: Text;
        X6: Text;
        x1: Text;
        x2: Text;
        x3: Text;
        x4: Text;
        Zamjena: Text;
        ReadLine2: Text;
        VrstaOdgovora: Text;
        strInStream: InStream;
        XMLFileOutStr: OutStream;
        ToFileName: Text;
        FileManagement: Codeunit "File Management";
        CngUser: Boolean;
        UserSetup: Record "User Setup";

}