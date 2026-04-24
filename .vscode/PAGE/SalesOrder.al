pageextension 50081 SalesOrder extends "Sales Order"
{
    layout
    {


        modify("Attached Documents") { Visible = cng; }
        modify(Control35) { Visible = cng; }
        modify(Control1903720907) { Visible = cng; }
        modify(Control1902018507) { Visible = cng; }
        modify(Control1900316107) { Visible = cng; }
        modify(Control1906127307) { visible = cng; }
        modify(Control1901314507) { visible = cng; }
        modify(ApprovalFactBox) { Visible = cng; }
        modify(IncomingDocAttachFactBox) { Visible = cng; }
        modify(Control1907012907) { Visible = cng; }
        modify(Control1901796907) { Visible = cng; }
        modify(Control1907234507) { Visible = cng; }
        modify(WorkflowStatus) { Visible = cng; }
        modify(Control1900201301) { Visible = cng; }










        modify("Sell-to") { Visible = CNG; }
        modify("Invoice Details") { Visible = cng; }
        modify("Shipping and Billing") { Visible = cng; }
        modify("Foreign Trade") { Visible = cng; }
        modify("Bill-to Contact No.") { Visible = cng; }
        modify("Sell-to Contact") { Visible = cng; }
        modify("No. of Archived Versions") { Visible = cng; }
        modify("Document Date") { Visible = cng; }
        modify("Order Date") { Visible = cng; }
        modify("Due Date") { Visible = true; }
        modify("Requested Delivery Date") { Visible = cng; }
        modify("Promised Delivery Date") { Visible = cng; }
        modify("External Document No.") { Visible = cng; }
        modify("Your Reference") { Visible = cng; }
        modify("Salesperson Code") { Visible = cng; }
        modify("Campaign No.") { Visible = false; }
        modify("Opportunity No.") { Visible = false; }
        modify("Responsibility Center") { Visible = false; }










        moveafter("Sell-to Customer Name"; "Payment Method Code")

        modify("Payment Method Code") { Visible = false; }

        addbefore("No.")
        {
            field("Bill Type"; "Bill Type")
            {
                editable = false;
            }
        }

        addafter("Payment Method Code")
        {
            field("Posting Date2"; "Posting Date")
            {
                Caption = 'Posting Date';
                Visible = false;
            }


        }
        addafter(Status)
        {
            field(Subsidies; Subsidies) { ApplicationArea = all; }
            field("Subsidies Amount"; "Subsidies Amount") { ApplicationArea = all; }
        }
        addafter("No.")
        {
            field("Document No_"; "Document No_") { ApplicationArea = all; Visible = cng; }
        }

        addafter(SalesLines)
        {
            group(NewPrice)
            {
                Visible = not cng;

                Caption = 'New Price';
                field("New Price"; "New Price") { Visible = not cng; ApplicationArea = all; }
                field("Old Price Date"; "Old Price Date") { Visible = not cng; ApplicationArea = all; }
                field("Fiscal printed"; "Fiscal printed") { Visible = not cng; ApplicationArea = all; }
                field("Fiscal No."; "Fiscal No.") { Visible = not cng; }
                field("Fiscal DateTime"; "Fiscal DateTime") { Visible = not cng; ApplicationArea = all; }
                field("Fiscal User"; "Fiscal User") { Visible = not cng; ApplicationArea = all; }

            }

            group(Posting)
            {
                Caption = 'Posting';

                field("VAT Bus. Posting Group2"; "VAT Bus. Posting Group") { ApplicationArea = all; caption = 'VAT Bus. Posting Group'; }

                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group") { ApplicationArea = all; }
                field("Customer Posting Group"; "Customer Posting Group") { ApplicationArea = all; Editable = true; }
                field(KIF_Entry; KIF_Entry) { }
                field("RN Source"; "RN Source") { }

            }
        }

        modify("Work Description") { Visible = false; }
        modify(WorkDescription) { Visible = false; }
        // Add changes to page layout here



        addafter("Salesperson Code")
        {
            field("Bank No."; "Bank No.")
            {
                Caption = 'Šifra banke';
                Visible = cng;
            }
        }
        addafter("Posting Date")
        {
            field("VAT Date"; "VAT Date")
            {
                Visible
                = not cng;

            }
        }


        addafter("External Document No.") { field("Payment Reference"; "Payment Reference") { ApplicationArea = all; Visible = cng; } }

        /* addafter("Language Code")
         {


             field(Documents; Documents)
             {
                 DrillDown = true;
                 Visible = false;
                 trigger OnDrillDown()
                 var
                     DocumentList: Page "Document List";
                     DocumentRec: Record Documents;
                     templateM: Record Template_Message;

                 begin
                     DocumentRec.Reset();
                     DocumentRec.SetFilter("Document No", '%1', Rec."No.");
                     DocumentList.SetTableView(DocumentRec);
                     DocumentList.Run();

                 end;


             }
         }*/
        addafter("Invoice Details")
        {
            group("CR")
            {
                Visible = false;
                field("CR included"; "CR included")
                {

                }
                field(Orderer; Orderer)
                {

                }
                field("Contract Number"; "Contract Number")
                {

                }
                field("Order person"; "Order person")
                {

                }
                field("Responsible Person"; "Responsible Person")
                {

                }
                field("Responsible Person Infodom"; "Responsible Person Infodom")
                {

                }
                field(Designer; Designer)
                {

                }
                field("Project manager"; "Project manager")
                {

                }
                field("HD Number"; "HD Number")
                {

                }
                field("Area covered by changes"; "Area covered by changes")
                {

                }
                field("Person/hours"; "Person/hours")
                {
                    Visible = false;
                }
                field("Amount without VAT"; "Amount without VAT")
                {
                    Visible = false;

                }
                field(Deadline; Deadline)
                {

                }
                field(seriousness; seriousness)
                {

                }
                field("Templates for CR"; "Templates for CR")
                {

                }
            }
        }



    }

    actions
    {


        modify("Create &Warehouse Shipment") { Visible = Not CNGUser; }
        addbefore(Post)
        {



            action("Import txt file MP")
            {
                Caption = 'Import txt file MP';
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
                    Price: Decimal;
                    LocationGet: Record Location;
                    SalesLineE: Record "Sales Line";
                    ReleaseSalesDoc: Codeunit "Release Sales Document";

                begin



                    linija := 0;


                    SalesLineE.Reset();
                    SalesLineE.SetFilter("Document No.", '%1', Rec."No.");
                    SalesLine.SetCurrentKey("Line No.");
                    if SalesLineE.FindLast() then
                        Linija := SalesLineE."Line No." + 10000
                    else
                        Linija += 10000;

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
                            end



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

                    ReleaseSalesDoc.PerformManualReopen(Rec);


                    SalesLine.Init();
                    SalesLine.Validate("Line No.", Linija);
                    SalesLine."Posting Date" := today;
                    SalesLine."Posting Date2" := today;
                    SalesLine.Validate("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Document No.", rec."No.");
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    Calc.Get();

                    SalesLine.Validate("No.", Calc."Item No.");
                    LocationGet.Reset();
                    LocationGet.SetFilter("CNG MP", '%1', true);
                    if LocationGet.FindFirst() then
                        SalesLine.Validate("Location Code", LocationGet.Code);

                    Clear(worktypes);
                    worktype.Reset();
                    if worktype.Count > 1 then begin
                        Commit();
                        //   worktypes.Run();
                        Commit();
                        worktypes.LOOKUPMODE(TRUE);
                        IF worktypes.RUNMODAL = ACTION::LookupOK THEN BEGIN

                            worktypes.GETRECORD(worktype);

                            IF FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for copy txt file" + format(worktype.Description)) THEN begin
                                Erase(GL."Path for import txt file" + worktype.Description);


                                SalesLine.Validate(Quantity, worktype.Quantity);

                                //    if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                                //      SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));

                                //total/(količina *(1+17%))


                            end;

                            //obriši fajl

                            worktypes.Close();
                        end;


                        //    ShowFileOrder(FileBuffer);


                    end
                    else begin
                        worktype.Reset();
                        if worktype.FindFirst() then begin

                            IF FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for copy txt file" + format(worktype.Description)) THEN begin
                                Erase(GL."Path for import txt file" + worktype.Description);
                                SalesLine.Validate(Quantity, worktype.Quantity);
                                //    if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                                //      SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));

                            end;

                        end;
                    end;




                    //   if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                    //         SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));


                    if SalesLine.Quantity <> 0 then
                        SalesLine.Insert();




                end;


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
                    Proceed: Boolean;
                    Text040: Label 'Xml file(*.xml)|*.xml|Text file(*.txt)|*.txt';
                    Text000: Label 'Import File';
                    Text004: Label 'Importing Data from file @1@@@@@@@@';
                    Text005: Label 'Please select a valid File name first!';
                    Brojac: Integer;
                    DataFile: File;
                    Window: Dialog;
                    StreamInTest: InStream;
                    DataLine: Text;
                    Linija: Integer;
                    Text12: array[12] of Text[2500];
                    Proc: Integer;
                    SalesLine: Record "Sales Line";
                    Calc: Record "Calculation Setup";
                    Quantity2: Decimal;
                    Price: Decimal;
                    LocationGet: Record Location;
                    SalesLineE: Record "Sales Line";
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    Customer: Record Customer;



                begin
                    linija := 0;


                    SalesLineE.Reset();
                    SalesLineE.SetFilter("Document No.", '%1', Rec."No.");
                    SalesLine.SetCurrentKey("Line No.");
                    if SalesLineE.FindLast() then
                        Linija := SalesLineE."Line No." + 10000
                    else
                        Linija += 10000;

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
                            end



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

                    ReleaseSalesDoc.PerformManualReopen(Rec);


                    SalesLine.Init();
                    SalesLine.Validate("Line No.", Linija);
                    SalesLine."Posting Date" := today;
                    SalesLine."Posting Date2" := today;
                    SalesLine.Validate("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    SalesLine.Validate("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.Validate("Document No.", rec."No.");
                    SalesLine.Validate(Type, SalesLine.Type::Item);
                    Calc.Get();

                    SalesLine.Validate("No.", Calc."Item No.");
                    LocationGet.Reset();
                    LocationGet.SetFilter("CNG VP", '%1', true);
                    if LocationGet.FindFirst() then
                        SalesLine.Validate("Location Code", LocationGet.Code);
                    Customer.GET(SalesLine."Sell-to Customer No.");
                    IF customer."Internal Customer" then begin
                        SalesLine.Validate("Location Code", 'VLASTITA');

                    end;

                    Clear(worktypes);

                    worktype.Reset();
                    if worktype.Count > 1 then begin
                        Commit();
                        //   worktypes.Run();
                        Commit();
                        worktypes.LOOKUPMODE(TRUE);
                        IF worktypes.RUNMODAL = ACTION::LookupOK THEN BEGIN

                            worktypes.GETRECORD(worktype);

                            IF FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for copy txt file" + format(worktype.Description)) THEN begin
                                Erase(GL."Path for import txt file" + worktype.Description);


                                SalesLine.Validate(Quantity, worktype.Quantity);
                                //            if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                                //              SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));



                            end;

                            //obriši fajl

                            worktypes.Close();
                        end;


                        //    ShowFileOrder(FileBuffer);


                    end
                    else begin
                        worktype.Reset();
                        if worktype.FindFirst() then begin

                            IF FILE.COPY(GL."Path for import txt file" + worktype.Description, GL."Path for copy txt file" + format(worktype.Description)) THEN begin
                                Erase(GL."Path for import txt file" + worktype.Description);
                                SalesLine.Validate(Quantity, worktype.Quantity);
                                //        if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                                //          SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));
                            end;

                        end;
                    end;




                    //  if ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)) <> 0 then
                    //    SalesLine.Validate("Unit Price", worktype.Total / ((SalesLine.Quantity) * (1 + SalesLine."VAT %" / 100)));


                    if SalesLine.Quantity <> 0 then
                        SalesLine.Insert();




                end;

            }







            action("Print Fiscal")
            {
                Caption = 'Print Fiscal';
                Ellipsis = true;
                Image = Import;
                Visible = not cng;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseLine: Record "Purchase Line";
                    CalculationSetup: Record "Calculation Setup";
                    Locat: record "Location";
                    Locat2: record "Location";
                    Linija: Integer;
                    SalesL: Record "Sales Line";
                    SalesLGet: Record "Sales Line";
                    UpdateSalesLines: Record "Sales Line";
                    GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    TransferHeader: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    GenL: Record "General Ledger Setup";
                    DocNo: code[20];
                    HideDialog: Boolean;
                    IsPosted: Boolean;
                    //  WhsePostReceipt: Codeunit 
                    SSL: Record "Sales Shipment Line";
                    SSLModify: Codeunit "Modiy Permissions";

                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                    WareHouseRH: Record "Warehouse Receipt Header";
                    WarehouseRL: Record "Warehouse Receipt Line";
                    WarehouseReceipt: page "Warehouse Receipt";
                    WhseRcptLine: Record "Warehouse Receipt Line";
                    RTD: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    WhseShptLine: Record "Warehouse Shipment Line";
                    WhseShptLine1: Record "Warehouse Shipment Line";

                    TXTTab: Char;
                    File1: File;
                    GJL: Page "Payment Journal";
                    SystemDokument: Dotnet SystemXmlDocument;
                    NavigateAfterPost: Option "Posted Document","New Document","Do Nothing";
                    Putanja2: text[250];
                    SubText: Text[2000];

                    PurchaseHeaderCopy: Record "Purchase Header";
                    WhsePostReceipt: Codeunit "Whse.-Post Receipt";
                    RecRef: RecordRef;
                    RecordRefExample: Codeunit "Modiy Permissions";


                    Iznoss: Decimal;
                    Custt: Record Customer;
                    ImaZarez: Integer;
                    Rezultat: Text[2000];
                    RezultatKolicina: Text[2000];
                    CijenaRez: Decimal;
                    PurchExist: Record "Purchase Header";
                    PurchLineExist: Record "Purchase Line";
                    TransferHeaderExist: Record "Transfer Header";
                    TransferLineExist: Record "Transfer Line";
                    Selection: Integer;
                    ShipInvoiceQst: Label '&Ship,Ship &and Invoice';
                    WhseShptLineRez: Record "Warehouse Shipment Line";
                    WhsePostShipment: Codeunit "Whse.-Post Shipment";
                    ium: Record "Item Unit of Measure";
                    SalesLine_First: Record "Sales Line";
                    TransferHeaderEx: Record "Transfer Header";
                    SalesSetup: Record "Sales & Receivables Setup";
                    IJL: Record "Item Journal Line";

                    ItemJournalLine: Record "Item Journal Line";
                    ItemJLine: Integer;
                    DocItemJournal: Text[250];
                    UnitCostGAS: Decimal;

                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    ItemJournalLine2: Record "Item Journal Line";
                    G: Record "General Ledger Setup";
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    TGet: Record "Transfer Header";

                    CZkF: record "User Setup";
                    BankAccocunt: Record "Bank Account";
                    BrojfiskInt: Integer;
                    ILeAdd: Record "Item Ledger Entry";




                begin


                    CalculationSetup.get;
                    Linija += 10000;
                    GenL.get;
                    //      TESTFIELD("Payment Method Code");
                    SalesLine_First.Reset();
                    SalesLine_First.SetFilter("Quantity Shipped", '%1', 0);
                    SalesLine_First.SetFilter("Document No.", '%1', Rec."No.");
                    SalesLine_First.SetFilter("Document Type", '%1', SalesLine_First."Document Type"::Order);
                    SalesLine_First.SetFilter("Cargo done", '%1', false);
                    if SalesLine_First.FindFirst() then begin

                        //if SalesL."Driver type" <> SalesL."Driver type"::" " then begin

                        SalesSetup.GET;
                        IF SalesLine_First."Sell-to Customer No." <> SalesSetup."NN Customer Code" then begin
                            SalesLine_First.TestField("Driver ID");
                            SalesLine_First.TestField("Driver Registration No.");
                            SalesLine_First.TestField("Driver Name");
                        end;
                        SalesLine_First.TestField("Payment Method Code");
                        SalesL.Reset();
                        SalesL.SetFilter("Document Type", '%1', SalesL."Document Type"::Order);
                        SalesL.SetFilter("Document No.", '%1', Rec."No.");
                        SalesL.SetFilter("Quantity Shipped", '%1', 0);
                        SalesL.SetFilter("Cargo done", '%1', false);
                        if SalesL.FindSet() then
                            repeat

                                if CalculationSetup."Transfer Items" = true then begin

                                    ILeAdd.Reset();
                                    ILeAdd.SetFilter("Sales Header No.", '%1', SalesL."Document No.");
                                    ILeAdd.SetFilter("Sales Line No.", '%1', SalesL."Line No.");
                                    ILeAdd.SetFilter("Entry Type", '%1|%2', ILeAdd."Entry Type"::"Negative Adjmt.", ILeAdd."Entry Type"::"Positive Adjmt.");
                                    if not ILeAdd.FindFirst() then begin
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
                                        ItemJournalLine.validate("Posting Date", SalesL."Posting Date2");
                                        ItemJournalLine.Validate("Journal Template Name", 'ITEM');
                                        ItemJournalLine.Validate("Journal Batch Name", 'PRENOS');
                                        DocItemJournal := NoSeriesMgt.GetNextNo(CalculationSetup."No. Series Transfer", ItemJournalLine."Posting Date", true);
                                        ItemJournalLine.validate("Line No.", ItemJLine);
                                        ItemJournalLine.validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
                                        ItemJournalLine.validate("Item No.", CalculationSetup."Item No. 2");
                                        ItemJournalLine.validate("Location Code", 'GLAVNO GAS');
                                        ItemJournalLine.validate("Gen. Bus. Posting Group", 'PRENOS');
                                        IUM.Reset();
                                        IUM.SetFilter("Item No.", '%1', CalculationSetup."Item No. 2");
                                        //od kilograma
                                        IUm.SetFilter(Code, '%1', 'KG');
                                        if IUM.FindFirst() then begin
                                            ItemJournalLine.validate(Quantity, SalesL.Quantity * ium."Qty. per Unit of Measure");
                                        end
                                        else begin
                                            ItemJournalLine.validate(Quantity, SalesL.Quantity);
                                        end;

                                        //   ItemJournalLine.validate(Quantity, SalesL.Quantity);
                                        ItemJournalLine.validate("Document No.", DocItemJournal);
                                        UnitCostGAS := ItemJournalLine."Unit Cost";
                                        ItemLedgerEntry.Reset();
                                        ItemLedgerEntry.SetFilter(Open, '%1', true);
                                        ItemLedgerEntry.SetFilter("Item No.", '%1', ItemJournalLine."Item No.");
                                        ItemLedgerEntry.setfilter("Location Code", '%1', ItemJournalLine."Location Code");
                                        ItemLedgerEntry.SetFilter("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Purchase);
                                        ItemLedgerEntry.SetCurrentKey("Posting Date");
                                        ItemLedgerEntry.Ascending;
                                        if ItemLedgerEntry.FindLast() then
                                            ItemJournalLine.validate("Applies-to Entry", ItemLedgerEntry."Entry No.");
                                        ItemJournalLine."Sales Header No." := SalesL."Document No.";
                                        ItemJournalLine."Sales Line No." := SalesL."Line No.";
                                        ItemJournalLine.Insert();
                                        COMMIT;

                                        ItemJLine := ItemJLine + 1000;
                                        //kraj

                                        //dodala prvo prenos s jednog na drugi
                                        ItemJournalLine.Init();
                                        ItemJournalLine.Validate("Journal Template Name", 'ITEM');
                                        ItemJournalLine.Validate("Journal Batch Name", 'PRENOS');
                                        ItemJournalLine.validate("Line No.", ItemJLine);


                                        ItemJournalLine.validate("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                                        ItemJournalLine.validate("Posting Date", SalesL."Posting Date2");
                                        ItemJournalLine.validate("Item No.", CalculationSetup."Item No.");
                                        ItemJournalLine.validate("Location Code", 'GLAVNO GAS');
                                        ItemJournalLine.validate("Gen. Bus. Posting Group", 'PRENOS');
                                        //   ItemJournalLine.validate(Quantity, SalesL.Quantity);

                                        /*    IUM.Reset();
                                            IUM.SetFilter("Item No.", '%1', CalculationSetup."Item No. 2");
                                            //od kilograma
                                            IUm.SetFilter(Code, '%1', ItemJournalLine."Unit of Measure Code");
                                            if IUM.FindFirst() then begin
                                                ItemJournalLine.validate(Quantity, SalesL.Quantity * ium."Qty. per Unit of Measure");
                                            end
                                            else begin
                                                ItemJournalLine.validate(Quantity, SalesL.Quantity);
                                            end;*/
                                        ItemJournalLine.validate(Quantity, SalesL.Quantity);

                                        ItemJournalLine.validate("Document No.", DocItemJournal);
                                        CalculationSetup.get;
                                        ItemUnitOfMeasure.Reset();
                                        ItemUnitOfMeasure.SetFilter("Item No.", '%1', CalculationSetup."Item No. 2");
                                        ItemUnitOfMeasure.SetFilter(Code, '%1', ItemJournalLine."Unit of Measure Code");
                                        if ItemUnitOfMeasure.findfirst then begin
                                            ItemJournalLine.validate("Unit Cost", UnitCostGAS * ItemUnitOfMeasure."Qty. per Unit of Measure");
                                            ItemJournalLine.validate("Unit Amount", ItemJournalLine."Unit Cost");
                                            g.Get;
                                            ItemJournalLine.Validate(amount, (ItemJournalLine.Quantity * ItemJournalLine."Unit Cost"));
                                        end;

                                        ItemJournalLine."Sales Header No." := SalesL."Document No.";
                                        ItemJournalLine."Sales Line No." := SalesL."Line No.";

                                        ItemJournalLine.Insert();
                                        COMMIT;



                                        /*      ItemJournalLine2.Reset();
                                              ItemJournalLine2.SetFilter("Document No.", ItemJournalLine."Document No.");
          if ItemJournalLine2.findfirst then*/

                                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournalLine);

                                    end;

                                end;

                                ILeAdd.Reset();
                                ILeAdd.SetFilter("Sales Header No.", '%1', SalesL."Document No.");
                                ILeAdd.SetFilter("Sales Line No.", '%1', SalesL."Line No.");
                                ILeAdd.SetFilter("Entry Type", '%1', ILeAdd."Entry Type"::Transfer);
                                ILeAdd.SetFilter("Location Code", '%1', 'GLAVNO GAS');
                                ILeAdd.SetFilter("Posting Date", '%1', SalesL."Posting Date2");
                                if not ILeAdd.FindFirst() then begin

                                    TransferHeader.Validate("Transfer-from Code", 'GLAVNO GAS');
                                    TransferHeader.validate("Posting Date", SalesL."Posting Date2");
                                    TransferHeader."Sales Line No." := SalesL."Line No.";
                                    Locat.Reset();
                                    Locat.SetFilter(Code, '%1', SalesL."Location Code");
                                    if Locat.FindFirst() then begin
                                        if (Locat."CNG VP" = true) or (Locat."CNG VL" = true) then begin
                                            TransferHeader.Validate("Transfer-to Code", SalesL."Location Code");
                                            if (Locat."CNG VL" = true) then
                                                TransferHeader.Validate("Hide CNG MP", false);
                                        end
                                        else begin
                                            Locat2.reset;
                                            Locat2.setfilter("CNG VP", '%1', true);
                                            if Locat2.findfirst then begin
                                                TransferHeader.Validate("Transfer-to Code", Locat2.Code);
                                                TransferHeader.Validate("Hide CNG MP", TRUE);
                                            end;
                                        end;
                                    end
                                    else begin
                                        Locat2.reset;
                                        Locat2.setfilter("CNG VP", '%1', true);
                                        if Locat2.findfirst then begin
                                            TransferHeader.Validate("Transfer-to Code", Locat2.Code);
                                            TransferHeader.Validate("Hide CNG MP", false);
                                        end;
                                    end;

                                    //VRATILA NA TRANZIT
                                    TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                    if (Locat."CNG VL" = true) and (SalesL."Type of vehicle" = SalesL."Type of vehicle"::"Cargo vehicles") then
                                        TransferHeader.Validate("In-Transit Code", 'TRANZIT')
                                    else
                                        TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                    TransferHeader.Validate("Sales Header No.", Rec."No.");
                                    TransferHeader."Sales Line No." := SalesL."Line No.";
                                    TransferHeader.Insert(true);


                                    commit;
                                    Linija += 10000;




                                    TransferLine.init;
                                    TransferLine.Validate("Document No.", TransferHeader."No.");

                                    TransferLine.Validate("Line No.", Linija);
                                    TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                    TransferLine.Validate(Quantity, SalesL.Quantity);

                                    TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                    TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                                    TransferLine.Insert(true);

                                    //lansiraj
                                    commit;
                                    if TGet.get(TransferHeader."No.") then begin
                                        RTD.Run(TGet);
                                        commit;
                                    end;


                                    //za glavno gas


                                    TransferHeaderPost_GAS(TGet);
                                    Commit();
                                    //završeno knjiženje
                                end;
                                //možda imam sada dodatni nalog za pren

                                // kreiraj nalog za prenos

                                //u slučaju maloprodaje


                                Locat2.reset;
                                Locat2.setfilter("CNG MP", '%1', true);
                                if Locat2.findfirst then begin
                                    if Locat2.Code = SalesL."Location Code" then begin

                                        ILeAdd.Reset();
                                        ILeAdd.SetFilter("Sales Header No.", '%1', SalesL."Document No.");
                                        ILeAdd.SetFilter("Sales Line No.", '%1', SalesL."Line No.");
                                        ILeAdd.SetFilter("Entry Type", '%1', ILeAdd."Entry Type"::Transfer);
                                        ILeAdd.SetFilter("Location Code", '%1', Locat.Code);
                                        ILeAdd.SetFilter("Posting Date", '%1', SalesL."Posting Date2");
                                        if not ILeAdd.FindFirst() then begin

                                            TransferHeader.init;
                                            Locat.reset;
                                            Locat.SetFilter("CNG VP", '%1', true);
                                            if Locat.findfirst then
                                                TransferHeader.Validate("Transfer-from Code", Locat.Code);
                                            TransferHeader.Validate("Transfer-to Code", SalesL."Location Code");
                                            TransferHeader.validate("Posting Date", SalesL."Posting Date2");

                                            TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                            TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                            TransferHeader.Validate("Sales Header No.", Rec."No.");
                                            TransferHeader."Sales Line No." := SalesL."Line No.";
                                            TransferHeader.Validate("Hide CNG MP", false);
                                            //

                                            TransferHeader.Insert(true);


                                            commit;
                                            Linija += 10000;




                                            TransferLine.init;
                                            TransferLine.Validate("Document No.", TransferHeader."No.");
                                            TransferLine.Validate("Line No.", Linija);
                                            TransferLine.Validate("Item No.", CalculationSetup."Item No.");
                                            TransferLine.Validate(Quantity, SalesL.Quantity);
                                            TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                            TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                                            TransferLine.Insert(true);

                                            //lansiraj
                                            commit;
                                            if TGet.get(TransferHeader."No.") then begin
                                                RTD.Run(TGet);
                                                commit;
                                            end;


                                            //za glavno gas


                                            TransferHeaderPost_GAS(TGet);
                                            Commit();
                                            //kraj                            
                                            //kraj                            
                                        end;
                                    end;
                                end;





                                UpdateSalesLines.reset;
                                UpdateSalesLines.get(SalesL."Document Type", SalesL."Document No.", SalesL."Line No.");
                                UpdateSalesLines."Cargo done" := true;
                                UpdateSalesLines.MODIFY;

                            until SalesL.Next() = 0;


                        //kreiraj otpremu, pa izdaj fiskalni račun

                        //    PostDocument(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"Posted Document");

                        //    PostDocument(CODEUNIT::"Sales-Post (Yes/No)", NavigateAfterPost::"Posted Document");

                        if not REc.Find then
                            Error(NothingToPostErr);

                        SalesHeader.Copy(Rec);
                        Code_SalesHeader(Rec, false);
                        commit;







                        //da na kraju kreiraj otpremu za ovo

                        //ovdje bi sada ispisala fiskalni račun





                        //open card nal knj uplata
                        /* IF SalesL."Payment Method Code" = 'GOTOVINA' then
                             GJL.Run();*/

                    end;
                end;



                //  end;

            }

            //

            action("Print only Fiscal")
            {
                Caption = 'Print only Fiscal';
                Ellipsis = true;
                Image = Import;
                Visible = not cng;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseLine: Record "Purchase Line";
                    CalculationSetup: Record "Calculation Setup";
                    Locat: record "Location";
                    Locat2: record "Location";
                    Linija: Integer;
                    SalesL: Record "Sales Line";
                    SalesLGet: Record "Sales Line";
                    UpdateSalesLines: Record "Sales Line";
                    GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    TransferHeader: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    GenL: Record "General Ledger Setup";
                    DocNo: code[20];
                    HideDialog: Boolean;
                    IsPosted: Boolean;
                    //  WhsePostReceipt: Codeunit 
                    SSL: Record "Sales Shipment Line";
                    SSLModify: Codeunit "Modiy Permissions";

                    ReleasePurchDoc: Codeunit "Release Purchase Document";
                    WareHouseRH: Record "Warehouse Receipt Header";
                    WarehouseRL: Record "Warehouse Receipt Line";
                    WarehouseReceipt: page "Warehouse Receipt";
                    WhseRcptLine: Record "Warehouse Receipt Line";
                    RTD: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    WhseShptLine: Record "Warehouse Shipment Line";
                    WhseShptLine1: Record "Warehouse Shipment Line";

                    TXTTab: Char;
                    File1: File;
                    GJL: Page "Payment Journal";
                    SystemDokument: Dotnet SystemXmlDocument;
                    NavigateAfterPost: Option "Posted Document","New Document","Do Nothing";
                    Putanja2: text[250];
                    SubText: Text[2000];

                    PurchaseHeaderCopy: Record "Purchase Header";
                    WhsePostReceipt: Codeunit "Whse.-Post Receipt";
                    RecRef: RecordRef;
                    RecordRefExample: Codeunit "Modiy Permissions";


                    Iznoss: Decimal;
                    Custt: Record Customer;
                    ImaZarez: Integer;
                    Rezultat: Text[2000];
                    RezultatKolicina: Text[2000];
                    CijenaRez: Decimal;
                    PurchExist: Record "Purchase Header";
                    PurchLineExist: Record "Purchase Line";
                    TransferHeaderExist: Record "Transfer Header";
                    TransferLineExist: Record "Transfer Line";
                    Selection: Integer;
                    ShipInvoiceQst: Label '&Ship,Ship &and Invoice';
                    WhseShptLineRez: Record "Warehouse Shipment Line";
                    WhsePostShipment: Codeunit "Whse.-Post Shipment";
                    ium: Record "Item Unit of Measure";
                    SalesLine_First: Record "Sales Line";
                    TransferHeaderEx: Record "Transfer Header";
                    SalesSetup: Record "Sales & Receivables Setup";
                    IJL: Record "Item Journal Line";

                    ItemJournalLine: Record "Item Journal Line";
                    ItemJLine: Integer;
                    DocItemJournal: Text[250];
                    UnitCostGAS: Decimal;

                    ItemUnitOfMeasure: Record "Item Unit of Measure";
                    ItemJournalLine2: Record "Item Journal Line";
                    G: Record "General Ledger Setup";
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    TGet: Record "Transfer Header";

                    CZkF: record "User Setup";
                    BankAccocunt: Record "Bank Account";
                    BrojfiskInt: Integer;




                begin
                    if (Rec."Internal Customer" = false) or (rec."Internal Customer" = true) then begin
                        GenL.geT;
                        SalesL.Reset();
                        SalesL.SetFilter("Document Type", '%1', SalesL."Document Type"::Order);
                        SalesL.SetFilter("Document No.", '%1', Rec."No.");
                        SalesL.SetFilter("Fiscal printed", '%1', false);
                        if (rec."Internal Customer" = true) then
                            SalesL.SetFilter("Type of vehicle", '<>%1', SalesL."Type of vehicle"::"Cargo vehicles");
                        if SalesL.FindSet() then
                            repeat



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


                                TXTTab := 13;
                                TXTTab := 13;

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
                                SalesSetup.get;

                                if SalesSetup."NN Customer Code" <> SalesL."Sell-to Customer No." then begin
                                    plite := '<Datum>0001-01-01T00:00:00</Datum>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    plite := '<Kupac>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();
                                    Custt.RESET;
                                    Custt.SETFILTER("No.", '%1', Rec."Bill-to Customer No.");
                                    IF Custt.FINDFIRST THEN
                                        plite := '<IDbroj>' + Custt."VAT Registration No." + '</IDbroj>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();


                                    //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
                                    plite := '<Naziv>' + Rec."Bill-to Name" + '</Naziv>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

                                    plite := '<Adresa>' + Rec."Bill-to Address" + '</Adresa>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    //<PostanskiBroj>75320</PostanskiBroj>

                                    plite := '<PostanskiBroj>' + Rec."Bill-to Post Code" + '</PostanskiBroj>';
                                    OutStreamObj.WRITETEXT(plite);
                                    OutStreamObj.WRITETEXT();

                                    //<Grad>Gračanica</Grad>
                                    plite := '<Grad>' + Rec."Bill-to City" + '</Grad>';
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
                                plite := '<Naziv>' + FORMAT('Iznos po nalogu ' + Rec."No." + ' za CNG') + '</Naziv>';
                                OutStreamObj.WRITETEXT(plite);
                                OutStreamObj.WRITETEXT();
                                plite := '<JM>' + SalesL."Unit of Measure Code" + '</JM>';
                                OutStreamObj.WRITETEXT(plite);
                                OutStreamObj.WRITETEXT();
                                if salesl.Quantity <> 0 then
                                    ImaZarez := STRPOS(FORMAT(round(salesl."Amount Including VAT" / salesl.Quantity, 0.01, '=')), ',') + 1
                                else
                                    ImaZarez := STRPOS(FORMAT(round(0, 0.01, '=')), ',') + 1;
                                //ROUND(s121, 0.01, '=');

                                /*    IF STRPOS(FORMAT(COPYSTR(FORMAT(salesl."Unit Price" / salesl.Quantity), ImaZarez, 2)), '00') = 0 THEN
                                        Rezultat := ChangeSeparator(FORMAT(salesl."Amount Including VAT" / salesl.Quantity, 0, '<Sign><Integer><Decimals><Comma,.>'))
                                    ELSE
                                        Rezultat := ChangeSeparator(FORMAT(ROUND(salesl."Amount Including VAT" / salesl.Quantity)));*/

                                CijenaRez := round(salesl."Unit Price" + salesl."Unit Price" * SalesL."VAT %" / 100, 0.01, '=');

                                IF STRPOS(FORMAT(COPYSTR(FORMAT(CijenaRez), ImaZarez, 2)), '00') = 0 THEN
                                    Rezultat := ChangeSeparator(FORMAT(CijenaRez, 0, '<Sign><Integer><Decimals><Comma,.>'))
                                ELSE
                                    Rezultat := ChangeSeparator(FORMAT(ROUND(CijenaRez), 0, '<Precision,2:2><Standard Format,2>'));


                                plite := '<Cijena>' + Rezultat + '</Cijena>';
                                OutStreamObj.WRITETEXT(plite);
                                OutStreamObj.WRITETEXT();
                                IF SalesL.Amount - salesl."Amount Including VAT" < 0 THEN
                                    plite := '<Stopa>E</Stopa>'
                                ELSE
                                    plite := '<Stopa>K</Stopa>';
                                OutStreamObj.WRITETEXT(plite);
                                OutStreamObj.WRITETEXT();

                                plite := '</artikal>';
                                OutStreamObj.WRITETEXT(plite);
                                OutStreamObj.WRITETEXT();
                                IF STRPOS(FORMAT(COPYSTR(FORMAT(salesl.Quantity), ImaZarez, 2)), '00') = 0 THEN
                                    RezultatKolicina := ChangeSeparator(FORMAT(salesl.Quantity, 0, '<Sign><Integer><Decimals><Comma,.>'))
                                ELSE
                                    RezultatKolicina := ChangeSeparator(FORMAT(ROUND(salesl.Quantity), 0, '<Precision,2:2><Standard Format,2>'));

                                plite := '<Kolicina>' + format(RezultatKolicina) + '</Kolicina>';
                                OutStreamObj.WRITETEXT(plite);
                                OutStreamObj.WRITETEXT();
                                ImaZarez := STRPOS(FORMAT(salesl."Line Discount %"), ',') + 1;

                                IF STRPOS(FORMAT(COPYSTR(FORMAT(salesl."Line Discount %"), ImaZarez, 2)), '00') = 0 THEN
                                    Rezultat := ChangeSeparator(FORMAT(salesl."Line Discount %", 0, '<Sign><Integer><Decimals><Comma,.>'))
                                ELSE
                                    Rezultat := ChangeSeparator(FORMAT(ROUND(salesl."Line Discount %"), 0, '<Precision,2:2><Standard Format,2>'));



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
                                if SalesL."Payment Method Code" = 'VIRMAN' then
                                    plite := '<Oznaka>' + 'Virman' + '</Oznaka>';
                                if SalesL."Payment Method Code" = 'GOTOVINA' then
                                    plite := '<Oznaka>' + 'Gotovina' + '</Oznaka>';
                                if SalesL."Payment Method Code" = 'KARTIČNO' then
                                    plite := '<Oznaka>' + 'Kartica' + '</Oznaka>';
                                if SalesL."Payment Method Code" = 'VLASTITA' then
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


                                //
                                if SalesL."Driver Name" <> '' then
                                    plite := '<Napomena>Vozač: ' + UpperCase(salesl."Driver Name") + '              ' + 'Vozilo: ' + UpperCase(salesl."Driver Registration No.") + '</Napomena>'
                                else
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


                                Commit();
                                // IF SalesL."Fiscal printed" = FALSE THEN
                                //   FileManagement.DownloadToFile(Putanja + 'Stampatifiskalniracunv1.000', Putanja + 'Stampatifiskalniracun.000');
                                Commit();
                                GenL.get;
                                Commit();
                                //  SLEEP(GenL."Sleep value");


                                commit;
                                IF SalesL."Fiscal printed" = FALSE THEN BEGIN
                                    Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';

                                    CZkF.Get(UserId);
                                    BankAccocunt.Reset();
                                    BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                                    if BankAccocunt.findfirst then begin

                                        Putanja2 := BankAccocunt."Path for fiscal printer" + 'odgovori\';
                                    end
                                    else begin

                                        Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';
                                    end;
                                    Commit();


                                    //   Odgovor(Putanja2 + 'Stampatifiskalniracun.000');
                                    //Key1; "Document Type", "Document No.", "Line No.")
                                    CZkF.Get(UserId);
                                    BankAccocunt.Reset();
                                    BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                                    if BankAccocunt.findfirst then begin
                                        BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series FIscal No.", TODAY, true);

                                    end;

                                    UpdateSalesLines.reset;
                                    UpdateSalesLines.get(SalesL."Document Type", SalesL."Document No.", SalesL."Line No.");
                                    if Evaluate(BrojfiskInt, BrojFiskalnogRacuna) then
                                        UpdateSalesLines."Fiscal No." := format(BrojfiskInt + 1)
                                    else
                                        UpdateSalesLines."Fiscal No." := BrojFiskalnogRacuna;
                                    //UserSetup.GET(USERID);
                                    //FiscalPrinterSetup.GET(UserSetup."Fiscal Printer Code");


                                    UpdateSalesLines."Fiscal printed" := TRUE;
                                    UpdateSalesLines."Fiscal DateTime" := CURRENTDATETIME;
                                    UpdateSalesLines."Fiscal User" := USERID;
                                    UpdateSalesLines.MODIFY;
                                    //odmah i duplikat
                                    //  PrintDuplicateFiscal(true, BrojFiskalnogRacuna);


                                    //Otpremnica uraditi provjeru
                                    SSL.SETFILTER("Order No.", '%1', UpdateSalesLines."Document No.");
                                    SSL.SETFILTER("Order Line No.", '%1', UpdateSalesLines."Line No.");
                                    IF SSL.FIndFirst then begin


                                        if Evaluate(BrojfiskInt, BrojFiskalnogRacuna) then
                                            SSL."Fiscal No." := format(BrojfiskInt + 1)

                                        else
                                            SSL."Fiscal No." := BrojFiskalnogRacuna;



                                        SSL."Fiscal printed" := TRUE;
                                        SSL."Fiscal DateTime" := CURRENTDATETIME;
                                        SSL."Fiscal User" := USERID;

                                        RecRef.GetTable(SSL);
                                        RecordRefExample.ModifyRecords(RecRef);


                                        //   CODEUNIT.Run(CODEUNIT::"Modiy Permissions", SSL);

                                    end;

                                END
                                else begin
                                    PrintDuplicateFiscal(true, SalesL."Fiscal No.");
                                end;



                                //umjesto u opšte unesi


                                GLSetup.GET;
                                T_GJL.SETFILTER("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");

                                T_GJL.SETFILTER("Journal Batch Name", '%1', GLSetup."Cash Batch Name");
                                IF T_GJL.FIND('+') THEN
                                    LineNo := T_GJL."Line No." + 100
                                ELSE
                                    LineNo := 100;
                                T_GJL.validate("Journal Template Name", GLSetup."Cash Receipt Journal Template");
                                T_GJL.validate("Journal Batch Name", GLSetup."Cash Batch Name");
                                T_GJL.validate("Document Type", T_GJL."Document Type"::Payment);
                                T_GJL.Validate("Payment Type", rec."Bill type");
                                T_GJL.validate("Bill type", rec."Bill type");
                                T_GJL.validate("Bill Category", rec."Bill Category");
                                T_GJL.validate("Account Type", T_GJL."Account Type"::"Customer");
                                T_GJL.validate("Account No.", SalesL."Bill-to Customer No.");

                                T_GJL."Line No." := LineNo;

                                T_GJL.validate("Posting Date", salesl."Posting Date2");
                                T_GJL.validate("Document Date", SalesL."Posting Date2");
                                T_GJL.Validate("Payment Method Code", SalesL."Payment Method Code");


                                GenJBatch.Reset();
                                GenJBatch.SetFilter("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");
                                GenJBatch.SetFilter(Name, '%1', GLSetup."Cash Batch Name");
                                if GenJBatch.FindFirst() then
                                    Docno := NoSeriesMgt.GetNextNo(GenJBatch."No. Series", SalesL."Posting Date", false);



                                T_GJL."Document No." := Docno;
                                T_GJL.VALIDATE("External Document No.", SalesL."Document No.");
                                T_GJL.Description := '';
                                T_GJL.VALIDATE(Amount, -round(abs(SalesL."Amount Including VAT"), 0.01, '='));
                                //   T_GJL.VALIDATE("Posting Group", "Customer Posting Group");

                                T_GJL.Validate("Bal. Account Type", GenJBatch."Bal. Account Type"::"Bank Account");
                                T_GJL.Validate("Bal. Account No.", GenJBatch."Bal. Account No.");
                                T_GJL.validate("Posting Date", SalesL."Posting Date2");
                                T_GJL.validate("Document Date", SalesL."Posting Date2");
                                IF (SalesL."Payment Method Code" = 'GOTOVINA') or (SalesL."Payment Method Code" = 'KARTIČNO') then begin
                                    if strpos(T_GJL."External Document No.", '08-') <> 0 then begin
                                        T_GJL."Bill type" := '08';
                                        T_GJL."Payment Type" := '08';
                                    end;

                                    if strpos(T_GJL."External Document No.", '04-') <> 0 then begin
                                        T_GJL."Bill type" := '04';
                                        T_GJL."Payment Type" := '04';
                                    end;

                                    T_GJL.INSERT(TRUE);
                                    LineNo += 100;
                                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", T_GJL);

                                    if SalesLGet.get("Document Type", SalesL."Document No.", SalesL."Line No.") then begin
                                        SalesLGet."CNG BLG" := true;
                                        SalesLGet.modify;
                                    end;
                                end;

                            until SalesL.Next() = 0;

                        SalesL.Reset();
                        SalesL.SetFilter("Document Type", '%1', SalesL."Document Type"::Order);
                        SalesL.SetFilter("Document No.", '%1', Rec."No.");
                        SalesL.SetFilter("Fiscal printed", '%1', false);
                        if (rec."Internal Customer" = true) then
                            SalesL.SetFilter("Type of vehicle", '%1', SalesL."Type of vehicle"::"Cargo vehicles");
                        SalesL.SetFilter("Cargo done", '%1', false);
                        if SalesL.FindSet() then
                            repeat

                                UpdateSalesLines.reset;
                                UpdateSalesLines.get(SalesL."Document Type", SalesL."Document No.", SalesL."Line No.");
                                //  UpdateSalesLines."Cargo done" := true;
                                UpdateSalesLines.MODIFY;


                                //umjesto u opšte unesi

                                GLSetup.GET;
                                T_GJL.SETFILTER("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");
                                T_GJL.SETFILTER("Journal Batch Name", '%1', GLSetup."Cash Batch Name");
                                IF T_GJL.FIND('+') THEN
                                    LineNo := T_GJL."Line No." + 100
                                ELSE
                                    LineNo := 100;
                                T_GJL.validate("Journal Template Name", GLSetup."Cash Receipt Journal Template");
                                T_GJL.validate("Journal Batch Name", GLSetup."Cash Batch Name");
                                T_GJL.validate("Document Type", T_GJL."Document Type"::Payment);
                                T_GJL.validate("Account Type", T_GJL."Account Type"::"Customer");
                                T_GJL.validate("Account No.", SalesL."Bill-to Customer No.");
                                T_GJL."Line No." := LineNo;
                                T_GJL.validate("Posting Date", SalesL."Posting Date2");


                                T_GJL.validate("Document Date", SalesL."Posting Date2");

                                T_GJL.Validate("Payment Method Code", SalesL."Payment Method Code");


                                GenJBatch.Reset();
                                GenJBatch.SetFilter("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");
                                GenJBatch.SetFilter(Name, '%1', GLSetup."Cash Batch Name");
                                if GenJBatch.FindFirst() then
                                    Docno := NoSeriesMgt.GetNextNo(GenJBatch."No. Series", SalesL."Posting Date", false);



                                T_GJL."Document No." := Docno;
                                T_GJL.VALIDATE("External Document No.", SalesL."Document No.");
                                T_GJL.Description := '';
                                T_GJL.VALIDATE(Amount, -abs(round(SalesL."Amount Including VAT", 0.01, '=')));
                                //   T_GJL.VALIDATE("Posting Group", "Customer Posting Group");

                                T_GJL.Validate("Bal. Account Type", GenJBatch."Bal. Account Type"::"Bank Account");
                                T_GJL.Validate("Bal. Account No.", GenJBatch."Bal. Account No.");
                                T_GJL.validate("Posting Date", salesL."Posting Date2");
                                T_GJL.validate("Document Date", salesL."Posting Date2");

                                T_GJL.Validate("Payment Type", rec."Bill type");
                                T_GJL.validate("Bill type", rec."Bill type");
                                T_GJL.validate("Bill Category", rec."Bill Category");

                                IF (SalesL."Payment Method Code" = 'GOTOVINA') or (SalesL."Payment Method Code" = 'KARTIČNO') then begin

                                    if strpos(T_GJL."External Document No.", '08-') <> 0 then begin
                                        T_GJL."Bill type" := '08';
                                        T_GJL."Payment Type" := '08';
                                    end;

                                    if strpos(T_GJL."External Document No.", '04-') <> 0 then begin
                                        T_GJL."Bill type" := '04';
                                        T_GJL."Payment Type" := '04';
                                    end;
                                    T_GJL.INSERT(TRUE);
                                    CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", T_GJL);

                                    LineNo += 100;
                                    if SalesLGet.get("Document Type", SalesL."Document No.", SalesL."Line No.") then begin
                                        SalesLGet."CNG BLG" := true;
                                        SalesLGet.modify;
                                    end;
                                end;

                            until SalesL.Next() = 0;
                    end;
                end;
            }
            action(ChangePrice)
            {
                Caption = 'ChangePrice';
                Ellipsis = true;
                Image = Import;
                Visible = not cng and not CNGUser;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ConfirmLbl: Label 'Do you want to update a new price?';
                    Saesl: Record "Sales Line";
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

                    UpdateSalesLines: Record "Sales Header";
                    SalesL: Record "Sales Line";
                    ImaZarez: Integer;
                    Rezultat: Text[2000];
                    Putanja2: Text[250];
                    ReleaseSalesDoc: Codeunit "Release Sales Document";
                    RTD: Codeunit "Release Transfer Document";
                    GLGet: Record "General Ledger Setup";

                    CZkF: record "User Setup";
                    BankAccocunt: Record "Bank Account";
                    BrojfiskInt: Integer;

                begin
                    if Confirm(ConfirmLbl) then begin

                        rec.TestField("Old Price Date");
                        Rec.TestField("New Price");

                        ReleaseSalesDoc.PerformManualReopen(Rec);

                        Saesl.Reset();
                        Saesl.SetFilter("Document No.", '%1', Rec."No.");
                        Saesl.SetFilter("Posting Date", '<=%1', "Old Price Date");
                        Saesl.SetFilter("Fiscal printed", '%1', true);
                        if Saesl.FindSet() then
                            repeat

                                Saesl.validate("Old Price", Saesl."Unit Price");
                                Saesl.validate("Total Old Price", Saesl.Amount);

                                Saesl.validate("Unit Price", "New Price");
                                Saesl.validate(Difference, Saesl.Amount - Saesl."Total Old Price");
                                Saesl."New Price" := true;
                                Saesl.Modify(true);
                                Commit();

                            until Saesl.Next() = 0;

                        Commit();
                        //po potvrdi

                        Saesl.Reset();
                        Saesl.SetFilter(Difference, '>%1', 0);
                        Saesl.SetFilter("Document No.", '%1', rec."No.");
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
                            plite := '<BrojZahtjeva>233</BrojZahtjeva>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            plite := '<VrstaZahtjeva>0</VrstaZahtjeva>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '<NoviObjekat>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            plite := '<Kupac>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            Custt.RESET;
                            Custt.SETFILTER("No.", '%1', Rec."Bill-to Customer No.");
                            IF Custt.FINDFIRST THEN
                                plite := '<IDbroj>' + Custt."Registration No." + '</IDbroj>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();


                            //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
                            plite := '<Naziv>' + Rec."Bill-to Customer No." + '</Naziv>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

                            plite := '<Adresa>' + Rec."Bill-to Address" + '</Adresa>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            //<PostanskiBroj>75320</PostanskiBroj>

                            plite := '<PostanskiBroj>' + Rec."Bill-to Post Code" + '</PostanskiBroj>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            //<Grad>Gračanica</Grad>
                            plite := '<Grad>' + Rec."Bill-to City" + '</Grad>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            plite := '</Kupac>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            //</Kupac>



                            plite := '<StavkeRacuna>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '<RacunStavka>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '<artikal>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();

                            plite := '<Sifra>' + FORMAT(Saesl."No.") + '</Sifra>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '<Naziv>' + FORMAT('Iznos po nalogu ' + Rec."No.") + '</Naziv>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '<JM>' + 'KO' + '</JM>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            Saesl.Difference := round(Saesl.Difference, 0.01, '=');
                            ImaZarez := STRPOS(FORMAT(Saesl.Difference), ',') + 1;

                            IF STRPOS(FORMAT(COPYSTR(FORMAT(Saesl.Difference), ImaZarez, 2)), '00') = 0 THEN
                                Rezultat := ChangeSeparator(FORMAT(Saesl.Difference, 0, '<Sign><Integer><Decimals><Comma,.>'))
                            ELSE
                                Rezultat := ChangeSeparator(FORMAT(ROUND(Saesl.Difference), 0, '<Precision,2:2><Standard Format,2>'));
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
                            plite := '<Oznaka>Virman</Oznaka>';

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
                            plite := '</NoviObjekat>';
                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();
                            plite := '</RacunZahtjev>';

                            OutStreamObj.WRITETEXT(plite);
                            OutStreamObj.WRITETEXT();


                            File1.CLOSE;

                            IF Rec."Fiscal printed" = FALSE THEN
                                FileManagement.DownloadToFile(Putanja + 'Stampatifiskalniracun.000', Putanja + 'Stampatifiskalniracun.000');
                            GL.get;
                            Commit();
                            SLEEP(GL."Sleep value");



                            IF Rec."Fiscal printed" = FALSE THEN BEGIN
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

                                //  Odgovor(Putanja2 + 'snd');
                                //Key1; "Document Type", "Document No.", "Line No.")
                                CZkF.Get(UserId);
                                BankAccocunt.Reset();
                                BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                                if BankAccocunt.findfirst then begin
                                    BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series FIscal No.", TODAY, true);

                                end;


                                UpdateSalesLines.reset;
                                UpdateSalesLines.get(Rec."Document Type", Rec."No.");
                                //UpdateSalesLines."Fiscal No." := BrojFiskalnogRacuna;

                                if Evaluate(BrojfiskInt, BrojFiskalnogRacuna) then
                                    UpdateSalesLines."Fiscal No." := format(BrojfiskInt + 1)

                                else
                                    UpdateSalesLines."Fiscal No." := BrojFiskalnogRacuna;

                                //UserSetup.GET(USERID);
                                //FiscalPrinterSetup.GET(UserSetup."Fiscal Printer Code");


                                UpdateSalesLines."Fiscal printed" := TRUE;
                                UpdateSalesLines."Fiscal DateTime" := CURRENTDATETIME;
                                UpdateSalesLines."Fiscal User" := USERID;
                                UpdateSalesLines.MODIFY;
                                //odmah i duplikat
                                // PrintDuplicateFiscal(true, BrojFiskalnogRacuna);

                            END
                            else begin
                                PrintDuplicateFiscal(true, Rec."Fiscal No.");
                            end;


                            //kraj

                        end;

                    end;

                    Saesl.Reset();
                    Saesl.SetFilter(Difference, '<%1', 0);
                    Saesl.SetFilter("Document No.", '%1', rec."No.");
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
                                SHeader.SetFilter("Order No.", '%1', Rec."No.");
                                SHeader.SetFilter("Posting Date", '<=%1', rec."Old Price Date");

                                //ovdje već nalazim dvije otpremnice, pa sve storniram
                                if SHeader.FindSet() then
                                    repeat

                                        SalesShptLine2.Reset();
                                        SalesShptLine2.SetFilter("Order No.", '%1', Rec."No.");
                                        SalesShptLine2.SetFilter("Document No.", '%1', SHeader."No.");
                                        //storno npr. *37
                                        SalesShptLine2.SetFilter(Quantity, '<>0');
                                        SalesShptLine2.SetRange(Correction, false);
                                        SalesShptLine2.SetFilter("Posting Date", '<=%1', rec."Old Price Date");
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
                                                    TransferHeader.Validate("Sales Header No.", Rec."No.");
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

                                                    TransferHeaderPost_GAS(TransferHeader);


                                                    TransferHeader.init;
                                                    TransferHeader.Validate("Transfer-from Code", 'CNG VLP');
                                                    TransferHeader.Validate("Transfer-to Code", 'GLAVNO GAS');
                                                    TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                                    TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                                    TransferHeader.Validate("Sales Header No.", Rec."No.");
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

                                                    TransferHeaderPost_GAS(TransferHeader);


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
                                                    TransferHeader.Validate("Sales Header No.", Rec."No.");
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

                                                    TransferHeaderPost_GAS(TransferHeader);



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

                            PrintReklamirani(true, Saesl);
                            commit;
                            //ovdje trebam dodatni storno otpremnica i treba mi dio koji se odnosi na primke prijenosa i označenu kvačicu correction


                            if GLGet."Undo Shipment for CP" = true then begin
                                SalesL.Reset();
                                SalesL.SetFilter("Document Type", '%1', SalesL."Document Type"::Order);
                                SalesL.SetFilter("Document No.", '%1', Rec."No.");
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
                                        TransferHeader.Validate("Sales Header No.", Rec."No.");

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


                                        TransferHeaderPost_GAS(TransferHeader);
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


                                if not REc.Find then
                                    Error(NothingToPostErr);

                                SalesHeader.Copy(Rec);
                                Code_SalesHeader(Rec, false);
                                commit;



                            end;



                            //da na kraju kreiraj otpremu za ovo

                            //ovdje bi sada ispisala fiskalni račun

                            PrintFiscal_New(true, Saesl);


                        //

                        until Saesl.Next() = 0;

                end;

            }






            action(PostCNG)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post CNG';
                Ellipsis = true;
                Visible = not cng;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    SalesL: Record "Sales Line";
                    SalesSetup: Record "Sales & Receivables Setup";

                begin
                    SalesSetup.get;
                    if rec."Bill-to Customer No." = SalesSetup."NN Customer Code" then begin

                        SalesL.Reset();
                        SalesL.SetFilter("Document No.", '%1', rec."No.");
                        SalesL.SetFilter("Fiscal No.", '%1', '');
                        if SalesL.FindFirst() then begin
                            error('Ne možete proknjižiti fakturu, ne postoji fiskalni br. računa!')
                        end;
                    end;


                    if not REc.Find then
                        Error(NothingToPostErr);

                    SalesHeader.Copy(Rec);
                    Code_SalesHeaderPost(Rec, false);
                    ShowPostedConfirmationMessage_CNG;


                    //Da li želite otvorite kreiranu proknjiženu izlaznu fakturu
                    commit;
                end;
            }

            action(PreviewPostingCNG)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Preview Posting';
                Visible = not cng;
                Image = ViewPostedOrder;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                begin
                    ShowPreview;
                end;
            }


            action(UndoShipmentPosting)
            {

                Caption = 'Undo Shipment Posting';
                Ellipsis = true;
                Visible = not cng and Not CNGUser;
                Image = UndoShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var

                    SalesShptLine: Record "Sales Shipment Line";
                    SalesShptLine2: Record "Sales Shipment Line";
                    SHeader: Record "Sales Shipment Header";
                    WhseShptLineRez: Record "Warehouse Shipment Line";
                    HideDialog: Boolean;
                    IsPosted: Boolean;
                    Selection: Integer;
                    IsHandled: Boolean;
                    SalesL: Record "Sales Line";
                    TransferHeader: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    Linija: Integer;
                    CalculationSetup: Record "Calculation Setup";
                    RTD: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    WhseShptLine: Record "Warehouse Shipment Line";
                    WhseShptLine1: Record "Warehouse Shipment Line";
                    WhsePostShipment: Codeunit "Whse.-Post Shipment";
                    TransferRH: Record "Transfer Receipt Header";
                    TransferRL: Record "Transfer Receipt Line";
                    CorrectionFind: boolean;
                    TRL: Record "Transfer Receipt Line";
                    TRH: Record "Transfer Receipt Header";

                begin
                    if Confirm(Text006) then begin

                        TRH.RESET;
                        TRH.SETFILTER("Sales Header No.", '%1', Rec."No.");
                        IF TRH.findfirst then
                            repeat
                                TRL.SETFILTER("Document No.", '%1', TRH."No.");
                                IF TRL.FindFirst() then begin
                                    TRL.Correction := TRUE;
                                    TRL.MODIFY;
                                end;

                            until trh.next = 0;
                        CalculationSetup.get;
                        SHeader.Reset();
                        SHeader.SetFilter("Order No.", '%1', Rec."No.");

                        //ovdje već nalazim dvije otpremnice, pa sve storniram
                        if SHeader.FindSet() then
                            repeat


                                SalesShptLine2.Reset();
                                SalesShptLine2.SetFilter("Order No.", '%1', Rec."No.");
                                SalesShptLine2.SetFilter("Document No.", '%1', SHeader."No.");
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

                        //

                        TransferRH.Reset();
                        TransferRH.SetFilter("Sales Header No.", '%1', "No.");
                        TransferRH.SetFilter(Correction, '%1', false);
                        if TransferRH.FindSet() then
                            repeat


                                if TransferRH."Transfer-to Code" <> 'GLAVNO GAS' then begin

                                    // kreiraj nalog za prenos
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

                                            TransferLine.Insert(true);

                                        until TransferRL.Next() = 0;

                                    //lansiraj
                                    commit;
                                    RTD.Run(TransferHeader);
                                    commit;





                                    //   GetSourceDocOutbound.CreateFromOutbndTransferOrderHideDialog(TransferHeader);

                                    //lansiraj

                                    TransferHeaderPost_GAS(TransferHeader);


                                    Commit();


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
                                end;

                            until TransferRH.next = 0;




                        Message(Mess);
                    end;
                end;


            }

        }



        modify(Statistics) { Visible = CNG; }
        modify(AttachAsPDF) { Visible = cng; }
        modify("Post and Print Prepmt. Invoic&e") { Visible = cng; }
        modify(PreviewPrepmtInvoicePosting) { Visible = cng; }
        modify(PagePostedSalesPrepaymentInvoices) { Visible = cng; }
        modify(PostPrepaymentCreditMemo) { Visible = cng; }
        modify(PagePostedSalesPrepaymentCrMemos) { Visible = cng; }


        modify(Customer) { Visible = CNG; }
        modify(Dimensions) { Visible = CNG; }
        modify(Approvals) { Visible = cng; }
        modify("Co&mments") { Visible = cng; }
        modify(AssemblyOrders) { Visible = cng; }
        modify(DocAttach) { Visible = cng; }
        modify(ActionGroupCRM) { Visible = false; }
        modify(Invoices) { Visible = cng; }
        modify("In&vt. Put-away/Pick Lines") { Visible = cng; }
        modify("Prepa&yment") { Visible = cng; }
        modify(History) { Visible = cng; }
        modify(Approval) { Visible = cng; }
        modify("Create Purchase Document") { Visible = cng; }
        modify(CreatePurchaseInvoice) { Visible = cng; }
        modify(CalculateInvoiceDiscount) { Visible = cng; }
        modify(GetRecurringSalesLines) { Visible = cng; }
        modify(CopyDocument) { Visible = cng; }
        modify(MoveNegativeLines) { Visible = cng; }
        modify("Archive Document") { Visible = cng; }
        modify("Send IC Sales Order") { Visible = cng; }
        modify(IncomingDocument) { Visible = cng; }
        modify(SelectIncomingDoc) { Visible = cng; }
        modify(IncomingDocAttachFile) { Visible = cng; }
        modify(RemoveIncomingDoc) { Visible = cng; }
        modify(Plan) { Visible = cng; }
        modify(Flow) { Visible = false; }
        modify(SeeFlows) { Visible = false; }
        modify(CreateFlow) { Visible = false; }
        modify(CancelApprovalRequest) { Visible = cng; }
        modify(SendApprovalRequest) { Visible = cng; }

        modify(SendEmailConfirmation) { Visible = cng; }
        modify("Create Inventor&y Put-away/Pick") { Visible = cng; }
        modify(Post) { Visible = cng; }
        modify(PostAndNew) { Visible = cng; }
        modify(PostAndSend) { Visible = cng; }
        modify("Test Report") { Visible = cng; }
        modify("Remove From Job Queue") { Visible = false; }
        modify(PreviewPosting) { Visible = cng; }
        modify(ProformaInvoice) { Visible = cng; }

        modify("&Print") { Visible = cng; }
        modify("Print Confirmation") { Visible = false; } //Ovaj Microsoftov sakriti a pokazati Customized Print Confirmation
        modify("&Order Confirmation") { Visible = cng; }
        modify("Request Approval") { Visible = cng; }
        modify("P&osting") { Visible = true; }
        modify("F&unctions") { visible = true; }


        // Add changes to page actions here
        addafter("Print Confirmation")
        {
            action("Customized Print Confirmation")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Confirmation';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Print a sales order confirmation.';

                trigger OnAction()
                var
                    Rpt: Report "Customized Sales Order Conf";
                    SH: Record "Sales Header";
                begin
                    SH.Reset();
                    SH.SetRange("No.", Rec."No.");
                    SH.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(Report::"Customized Sales Order Conf", true, true, SH);
                    //DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                end;
            }
            action("Prepare mail notification")
            {
                Caption = 'Prepare mail notification';
                Ellipsis = true;

                Image = SendMail;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    //   DocumentAdd: Record Documents
                    Attachments: array[10] of Integer;
                    AttachmentsName: array[10] of Text;
                    ReportLayoutSelection: Record "Report Layout Selection";
                    CRL: Record "Custom Report Layout";
                //    MailSending: Report "Mail Sending";

                begin

                    //max 10 priloga
                    /* i := 1;
                     IF Rec.FINDFIRST THEN
                         REPEAT
                             DocumentAdd.Reset();
                             DocumentAdd.SetFilter("Document No", '%1', Rec."No.");
                             if DocumentAdd.FindSet() then
                                 repeat

                                     Attachments[i] := DocumentAdd."Attachment No";
                                     AttachmentsName[i] := DocumentAdd."Document Name";
                                     i += 1;
                                     IF i >= 10 THEN
                                         BREAK;
                                 until DocumentAdd.Next() = 0;

                         until Rec.Next() = 0;
                     CLEAR(ReportLayoutSelection);
                     CRL.RESET;
                     CRL.SETFILTER("Report ID", '%1', 50080);
                     IF CRL.FINDLAST THEN BEGIN
                         ReportLayoutSelection.SetTempLayoutSelected(CRL.Code);

                         //     MailSending.SetParam(Attachments, AttachmentsName, rec."No.", 0, '', '', '', Rec."Message Code");
                         //   MailSending.RUN;
                     END;
                     COMMIT;

                 end;
 */
                end;

            }


            action("Send mail notification2")
            {
                Caption = 'Send mail notification';
                Ellipsis = true;
                Image = SendMail;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    //   DocumentAdd: Record Documents;
                    Attachments: array[10] of Integer;
                    AttachmentsName: array[10] of Text;
                    ReportLayoutSelection: Record "Report Layout Selection";
                    CRL: Record "Custom Report Layout";
                //ĐK   MailSending: Report "Mail Sending2";

                begin

                    //max 10 priloga
                    /*  i := 1;
                      IF Rec.FINDFIRST THEN
                          REPEAT
                              DocumentAdd.Reset();
                              DocumentAdd.SetFilter("Document No", '%1', Rec."No.");
                              if DocumentAdd.FindSet() then
                                  repeat

                                      Attachments[i] := DocumentAdd."Attachment No";
                                      AttachmentsName[i] := DocumentAdd."Document Name";
                                      i += 1;
                                      IF i >= 10 THEN
                                          BREAK;
                                  until DocumentAdd.Next() = 0;

                          until Rec.Next() = 0;
                      CLEAR(ReportLayoutSelection);
                      CRL.RESET;
                      CRL.SETFILTER("Report ID", '%1', 50084);
                      IF CRL.FINDLAST THEN BEGIN
                          ReportLayoutSelection.SetTempLayoutSelected(CRL.Code);

                          //   MailSending.SetParam(Attachments, AttachmentsName, rec."No.", 0, '', '', '', Rec."Message Code");
                          // MailSending.RUN;
                      END;
                      COMMIT;

                  end;

  */
                end;
            }



        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
        US: Record "User Setup";

    begin

        if Rec."Bill type" <> '' then begin
            Cut.Reset();
            Cut.SetFilter(Code, '%1', Rec."Bill type");
            cut.SetFilter(CNG, '%1', true);
            if cut.FindFirst() then
                CNG := false
            else
                CNG := true;

            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            us.SetFilter("CNG User", '%1', true);
            if us.FindFirst() then begin
                CngUser := TRUE;
            end
        end
        else begin

            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            us.SetFilter("CNG User", '%1', true);
            if us.FindFirst() then begin
                cng := false;
                CngUser := TRUE;
            end
            else begin
                CNG := true;
            end;
        end;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        US: Record "User Setup";

    begin
        if Rec."Bill type" <> '' then begin
            Cut.Reset();
            Cut.SetFilter(Code, '%1', Rec."Bill type");
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

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        CustomerT: Record "Customer Templ.";
        CustomerPage: page "Customer Templ. List";
        UserSetup: Record "User Setup";
        SalesH: Record "Sales Header";
        SalesO: page "Sales Order";
        SalesOH: Record "Sales Header";
        Docno: text[250];
        NoSeriesMgt: Codeunit NoSeriesExtented;


        SalesSetup: Record "Sales & Receivables Setup";

    begin
        SalesSetup.Get();
        CngUser := FALSE;
        CLEAR(CustomerPage);
        CustomerT.Reset();
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."CNG User" = true then begin
                CngUser := TRUE;
                CustomerT.SetFilter(CNG, '%1', true);
                CustomerPage.SetTableView(CustomerT);
            end;


        end;

        // CustomerPage.Run();
        CustomerPage.LOOKUPMODE(TRUE);
        IF CustomerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            CustomerPage.GETRECORD(CustomerT);
            "Bill type" := CustomerT.Code;
            "Bill Category" := customert."Bill Category";



            if CustomerT.NN = true then begin

                SalesH.Init();
                SalesH."Bill type" := CustomerT.Code;
                SalesH."Bill Category" := CustomerT."Bill Category";
                SalesH.Validate("Document Type", SalesH."Document Type"::Order);
                SalesH.validate("Document Date", Today);
                SalesH.validate("VAT Date", today);
                Docno := NoSeriesMgt.GetNextNo(CustomerT."No. Series Bill", TODAY, false);
                SalesH.Validate("No.", Docno);
                SalesH.Validate("Posting No. Series", CustomerT."Posting No. Series Bill");
                SalesH.Validate("Assigned User ID", UserId);
                SalesH.validate("Order Date", today);

                SalesH.validate("Posting Date", today);
                SalesH.Validate("Sell-to Customer No.", SalesSetup."NN Customer Code");
                SalesH.Insert();

                SalesH.Reset();
                SalesH.SetFilter("No.", '%1', Docno);
                CurrPage.Close();
                SalesO.SetTableView(SalesH);
                Commit();
                SalesO.Run();
                Commit();




            end;




        END;






    end;


    local procedure ConfirmPost_SalesHeader(var SalesHeader: Record "Sales Header"; DefaultOption: Integer; Selec: Integer): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
    begin
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;

        with SalesHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin
                        Selection := Selec;
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                        exit(false);
                    end;
                "Document Type"::"Return Order":
                    begin
                        Selection := Selec;
                        if Selection = 0 then
                            exit(false);
                        Receive := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end
                else
                    if not ConfirmManagement.GetResponseOrDefault(
                         StrSubstNo(PostConfirmQst, LowerCase(Format("Document Type"))), true)
                    then
                        exit(false);
            end;
            "Print Posted Documents" := false;
        end;
        exit(true);
    end;

    procedure Code_SalesHeader(var SalesHeader: Record "Sales Header"; PostAndSend: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        HideDialog: Boolean;
        IsHandled: Boolean;
        DefaultOption: Integer;
    begin
        HideDialog := true;
        IsHandled := false;
        DefaultOption := 1;
        if IsHandled then
            exit;

        ConfirmPost_SalesHeader(SalesHeader, DefaultOption, 1);

        SalesSetup.Get();
        if SalesSetup."Post with Job Queue" and not PostAndSend then
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        else
            CODEUNIT.Run(CODEUNIT::"Sales-Post", SalesHeader);
    end;


    local procedure Code_SalesHeaderPost(var SalesHeader: Record "Sales Header"; PostAndSend: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        HideDialog: Boolean;
        IsHandled: Boolean;
        DefaultOption: Integer;
    begin
        HideDialog := true;
        IsHandled := false;
        DefaultOption := 2;
        if IsHandled then
            exit;

        ConfirmPost_SalesHeader(SalesHeader, DefaultOption, 2);

        SalesSetup.Get();
        if SalesSetup."Post with Job Queue" and not PostAndSend then
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        else
            CODEUNIT.Run(CODEUNIT::"Sales-Post", SalesHeader);
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
        StartTime: DateTime;
        NowTime: DateTime;
        Elapsed: Integer;


    begin
        TXTTab := 13;
        //Upit:='\\DESKTOP-B6A3125\odgovori\sfr';
        IF EXISTS(Upit + '_1' + '.xml') THEN
            ERASE(Upit + '_1' + '.xml');

        Commit();

        Sleep(5000);


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

    procedure ShowPostedConfirmationMessage()
    var
        OrderPurchaseHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedPurchaseOrderQst: Label 'The order is posted as number %1 and moved to the Posted Purchase Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

    begin
        if not OrderPurchaseHeader.Get("Document Type", "No.") then begin
            PurchInvHeader.SetRange("No.", "Last Posting No.");
            if PurchInvHeader.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedPurchaseOrderQst, PurchInvHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Purchase Invoice", PurchInvHeader);
        end;
    end;



    local procedure CodeFunction(var PurchaseHeader: Record "Purchase Header")
    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchPostViaJobQueue: Codeunit "Purchase Post via Job Queue";
        HideDialog: Boolean;
        IsHandled: Boolean;
        DefaultOption: Integer;
    begin
        HideDialog := false;
        IsHandled := false;
        DefaultOption := 3;

        if IsHandled then
            exit;

        if not HideDialog then
            if not ConfirmPost(PurchaseHeader, DefaultOption) then
                exit;

        PurchSetup.Get();
        if PurchSetup."Post with Job Queue" then
            PurchPostViaJobQueue.EnqueuePurchDoc(PurchaseHeader)
        else begin
            CODEUNIT.Run(CODEUNIT::"Purch.-Post", PurchaseHeader);
        end;

    end;


    procedure TransferHeaderPost_GAS(var TransHeader: Record "Transfer Header")
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


    local procedure ShowPostedConfirmationMessage_CNG()
    var
        OrderSalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        OpenPostedSalesOrderQst: Label 'The order is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

    begin
        if not OrderSalesHeader.Get("Document Type", "No.") then begin
            SalesInvoiceHeader.SetRange("No.", "Last Posting No.");
            if SalesInvoiceHeader.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesOrderQst, SalesInvoiceHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

    local procedure ConfirmPost(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer): Boolean
    var
        ConfirmManagement: Codeunit "Confirm Management";
        Selection: Integer;
    begin
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;


        Selection := 3;

        with PurchaseHeader do begin
            case "Document Type" of
                "Document Type"::Order:
                    begin
                        Selection := 3;
                        if Selection = 0 then
                            exit(false);
                        Receive := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end;
                "Document Type"::"Return Order":
                    begin
                        Selection := 3;
                        if Selection = 0 then
                            exit(false);
                        Ship := Selection in [1, 3];
                        Invoice := Selection in [2, 3];
                    end
                else
                    if not ConfirmManagement.GetResponseOrDefault(
                         StrSubstNo(PostConfirmQst, LowerCase(Format("Document Type"))), true)
                    then
                        exit(false);
            end;
            "Print Posted Documents" := false;
        end;
        exit(true);
    end;


    procedure PostDocument_PH(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting"; PH: Record "Purchase Header")
    var
        PurchaseHeader: Record "Purchase Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        IsScheduledPosting: Boolean;
        DocumentIsPosted: Boolean;
        PO: page "Purchase Order";
    begin
        if ApplicationAreaMgmtFacade.IsFoundationEnabled then
            LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(PH);

        PH.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not PurchaseHeader.Get("Document Type", "No.")) or IsScheduledPosting;



        if PostingCodeunitID <> CODEUNIT::"Purch.-Post (Yes/No)" then
            exit;

        case Navigate of
            "Navigate After Posting"::"Posted Document":
                if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                    ShowPostedConfirmationMessage;
            "Navigate After Posting"::"New Document":
                if DocumentIsPosted then begin
                    Clear(PurchaseHeader);
                    PurchaseHeader.Init();
                    PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.Insert(true);
                    PAGE.Run(PAGE::"Purchase Order", PurchaseHeader);
                end;
        end;
    end;

    procedure PrintDuplicateFiscal(Allow: Boolean; Fisc: code[20])
    var
        GenL: Record "General Ledger Setup";


        CZkF: record "User Setup";
        BankAccocunt: Record "Bank Account";
    begin
        GenL.get;
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

        if Allow = true then begin

            File1.CREATE(Putanja + 'stampatiduplikatfiskalnogracuna.xml', TEXTENCODING::UTF8);
            //File1.CREATE('\\FORTNAV\Temp\snd.xml',TEXTENCODING::UTF8);

            File1.CREATEOUTSTREAM(OutStreamObj);
            plite := '';

            plite := '<?xml version="1.0" encoding="utf-8"?>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<BrojZahtjeva>607356</BrojZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<VrstaZahtjeva>3</VrstaZahtjeva>';
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
            plite := '<Vrijednost>' + Fisc + '</Vrijednost>';
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
            FileManagement.DownloadToFile(Putanja + 'stampatiduplikatfiskalnogracuna.xml', Putanja + 'stampatiduplikatfiskalnogracuna.xml');
        end;

    end;


    procedure PrintDuplicateReklamniFiscal(Allow: Boolean; Fisc: code[20])
    var
        GenL: Record "General Ledger Setup";

        CZkF: record "User Setup";
        BankAccocunt: Record "Bank Account";
    begin

        GenL.get;
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


        if Allow = true then begin

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
            plite := '<Vrijednost>' + Fisc + '</Vrijednost>';
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

    end;


    procedure Split(VAR TextSplit: Text[1024]; Separator: Text[1]) Part: Text[1024]
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

    local procedure ShowFileOrder(var File: Record File)
    var
        myInt: Integer;
    begin
        if File.FindSet() then
            repeat
                MessageText := StrSubstNo('%1%2%3', MessageText, Separator, File.Name);
                Separator := '\';
            until File.Next() = 0;


    end;

    procedure Replacestring(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
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

    procedure PrintReklamirani(Allow: Boolean; SalesL_R: Record "Sales Line")
    var
        Custt: Record Customer;
        Putanja2: text[250];
        GenL: Record "General Ledger Setup";
        SalesL_R2: Record "Sales Line";

        CZkF: record "User Setup";
        BankAccocunt: Record "Bank Account";
    begin
        GenL.get;
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


        File1.CREATE(Putanja + 'srr.reklamirani.xml', TEXTENCODING::UTF8);
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
        Linije := '<Iznos>' + FORMAT(SalesL_R."Total Old Price") + '</Iznos>';
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

        plite := '<BrojZahtjeva>20</BrojZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<VrstaZahtjeva>2</VrstaZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<NoviObjekat>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<Kupac>';
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


        plite := '<StavkeRacuna>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<RacunStavka>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        plite := '<artikal>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Sifra>' + FORMAT(SalesL_R."No.") + '</Sifra>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Naziv>' + FORMAT('Iznos po fakturi ' + SalesL_R."Document No.") + '</Naziv>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<JM>' + 'KO' + '</JM>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        plite := '<Cijena>' + format(round(SalesL_R."Total Old Price", 0.01, '=')) + '</Cijena>';


        //strsubstno(text01,format(100.10,0,'<Precision,2:2><Standard Format,0>'))
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        IF SalesL_R.Amount - SalesL_R."Amount Including VAT" < 0 THEN
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




        plite := '<Kolicina>1</Kolicina>';
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

        plite := '<VrstePlacanja />';
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


            FileManagement.DownloadToFile(Putanja + 'srr.reklamirani.xml', Putanja + 'srr.reklamirani.xml');



            //      Odgovor(Putanja2 + 'srr.reklamirani');
            CZkF.Get(UserId);
            BankAccocunt.Reset();
            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
            if BankAccocunt.findfirst then begin
                BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series R. FIscal No.", TODAY, true);

            end;

            SalesL_R2.get(SalesL_R."Document Type", SalesL_R."Document No.", SalesL_R."Line No.");
            SalesL_R2."R. Fiscal printed" := true;
            SalesL_R2."R. Fiscal No." := BrojFiskalnogRacuna;
            SalesL_R2."R. Fiscal DateTime" := CURRENTDATETIME;
            SalesL_R2."R. Fiscal User" := USERID;

            SalesL_R2.Type := SalesL_R2.type::" ";
            SalesL_R2."No." := '';
            SalesL_R2."Location Code" := '';

            //ovdje G
            SalesL_R2.MODIFY(true);


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



    procedure PrintFiscal_New(Allow: Boolean; SalesLine_New: record "Sales line")

    var
        Custt: record Customer;
        ImaZarez: Integer;
        UpdateSalesLine_P: Record "Sales Line";
        Rezultat: Text[2000];
        Putanja2: text[250];
        GenL: Record "General Ledger Setup";


        CZkF: record "User Setup";
        BankAccocunt: Record "Bank Account";
    begin
        GenL.get;
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


        File1.CREATE(Putanja + 'Stampatifiskalniracun.000', TEXTENCODING::UTF8);

        File1.CREATEOUTSTREAM(OutStreamObj);

        plite := '<?xml version="1.0" encoding="utf-8"?>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<BrojZahtjeva>233</BrojZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<VrstaZahtjeva>0</VrstaZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<NoviObjekat>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<Kupac>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        Custt.RESET;
        Custt.SETFILTER("No.", '%1', Rec."Bill-to Customer No.");
        IF Custt.FINDFIRST THEN
            plite := '<IDbroj>' + Custt."Registration No." + '</IDbroj>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
        plite := '<Naziv>' + Rec."Bill-to Customer No." + '</Naziv>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

        plite := '<Adresa>' + Rec."Bill-to Address" + '</Adresa>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        //<PostanskiBroj>75320</PostanskiBroj>

        plite := '<PostanskiBroj>' + Rec."Bill-to Post Code" + '</PostanskiBroj>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        //<Grad>Gračanica</Grad>
        plite := '<Grad>' + Rec."Bill-to City" + '</Grad>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '</Kupac>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        //</Kupac>



        plite := '<StavkeRacuna>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<RacunStavka>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<artikal>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();

        plite := '<Sifra>' + FORMAT(SalesLine_New."No.") + '</Sifra>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Naziv>' + FORMAT('Iznos po nalogu ' + SalesLine_New."Document No.") + '</Naziv>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<JM>' + 'KO' + '</JM>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        SalesLine_New.Amount := round(SalesLine_New.Amount, 0.01, '=');

        ImaZarez := STRPOS(FORMAT(SalesLine_New.Amount), ',') + 1;

        IF STRPOS(FORMAT(COPYSTR(FORMAT(SalesLine_New.Amount), ImaZarez, 2)), '00') = 0 THEN
            Rezultat := ChangeSeparator(FORMAT(SalesLine_New.Amount, 0, '<Sign><Integer><Decimals><Comma,.>'))
        ELSE
            Rezultat := ChangeSeparator(FORMAT(ROUND(SalesLine_New.Amount), 0, '<Precision,2:2><Standard Format,2>'));
        plite := '<Cijena>' + Rezultat + '</Cijena>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        IF round(SalesLine_New.Amount, 0.01, '=') - round(SalesLine_New."Amount Including VAT", 0.01, '=') < 0 THEN
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
        plite := '<Oznaka>Virman</Oznaka>';

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
        plite := '</NoviObjekat>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</RacunZahtjev>';

        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();


        File1.CLOSE;

        IF SalesLine_New."New Fiscal printed" = FALSE THEN
            FileManagement.DownloadToFile(Putanja + 'Stampatifiskalniracun.000', Putanja + 'Stampatifiskalniracun.000');
        GL.get;
        Commit();
        SLEEP(GL."Sleep value");



        IF SalesLine_New."New Fiscal printed" = FALSE THEN BEGIN
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


            //   Odgovor(Putanja2 + 'snd');
            //Key1; "Document Type", "Document No.", "Line No.")
            CZkF.Get(UserId);
            BankAccocunt.Reset();
            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
            if BankAccocunt.findfirst then begin
                BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series FIscal No.", TODAY, true);

            end;


            UpdateSalesLine_P.reset;
            UpdateSalesLine_P.get(SalesLine_New."Document Type", SalesLine_New."Document No.", SalesLine_New."Line No.");
            UpdateSalesLine_P."New Fiscal No." := BrojFiskalnogRacuna;
            UpdateSalesLine_P."Shipment create" := false;
            //UserSetup.GET(USERID);
            //FiscalPrinterSetup.GET(UserSetup."Fiscal Printer Code");


            UpdateSalesLine_P."New Fiscal printed" := TRUE;
            UpdateSalesLine_P."New Fiscal DateTime" := CURRENTDATETIME;
            UpdateSalesLine_P."New Fiscal User" := USERID;
            UpdateSalesLine_P.MODIFY;
            //odmah i duplikat
            PrintDuplicateFiscal(true, BrojFiskalnogRacuna);

        END
        else begin
            PrintDuplicateFiscal(true, UpdateSalesLine_P."New Fiscal No.");
        end;

    end;

    local procedure ShowPreview()
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Preview(Rec);
    end;


    procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    var
        myInt: Integer;

        BrojFiskalnogRacuna: Text[2000];
        VrijemeFiskalnogRacuna: Text[2000];
        Cut: Record "Customer Templ.";
        SalesHeader: Record "Sales Header";
        NoSeriesMgt: Codeunit NoSeriesExtented;


        DatumFiskalnogRacuna: Text[2000];
        IznosFiskalnogRacuna: Text[2000];
        Text12_T: array[4, 4] of Text[2500];
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        ShipInvoiceQst: Label '&Ship,&Invoice,Ship &and Invoice';

        CNG: Boolean;
        ukupno: Decimal;
        NothingToPostErr: Label 'There is nothing to post.';

        LineNo: Integer;
        Text006: Label 'Are you sure that you want to undo Shipment Line';

        Mess: Label 'Undo Shipment Posting is done!';
        FileD: Record File;
        GL: Record "General Ledger Setup";
        importFile: File;
        StreamInTest: InStream;
        Text12: array[4, 4] of Text[2500];
        ReadLine: Text;
        //  ReadLineNew: Text;
        BrojaInt: Integer;
        FileManagement: Codeunit "File Management";
        File1: File;

        GLSetup: Record "General Ledger Setup";
        T_GJL: Record "Gen. Journal Line";
        FileBuffer: record File;
        Separator: text[1000];
        MessageText: text[2000];
        GenJBatch: Record "Gen. Journal Batch";
        i: Integer;
        Quantity_Read: Decimal;
        worktype: Record "Work Type";
        worktypes: Page "Work Types";
        OutStreamObj: OutStream;
        Putanja: text[250];
        plite: text[250];
        File5: File;
        OutStreamObj2: OutStream;
        Linije: Text[2000];
        CNGUser: Boolean;


}