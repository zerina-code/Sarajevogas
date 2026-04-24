report 50136 "TK"
{
    // BH1.00, TKV
    DefaultLayout = RDLC;
    RDLCLayout = './TK.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem; "Transfer Receipt Header")
        {
            RequestFilterFields = "Posting Date";
            DataItemTableView = SORTING("No.") ORDER(ASCENDING) WHERE("Transfer-to Code" = FILTER('CNG VLP|CNG MLP|VLASTITA'), "Correction" = filter(false));

            column(TRHNo; "No.") { }
            column(TRHType; "Transfer-to Code") { }
            column(TRHCalculationNo; "Calculation Number") { }
            column(TRHGroupCalculationNumber; "Group Calculation Number") { }

            dataitem(DataItem1; "Value Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = SORTING("Entry No.") ORDER(ASCENDING);
                column(CompInfoName; CompInfo.Name) { }
                column(Picture; CompInfo.Picture) { }
                column(CounterCaption; CounterCaption) { }
                column(column3; column3) { }
                column(column4; column4) { }
                column(column5; column5) { }
                column(HeaderText; HeaderText) { }
                column(DateRow; FORMAT("Posting Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
                column(DescriptionRow; Desc) { }
                column(CreditRow; Credit) { }
                column(DebitRow; Debit) { }
                column(Control; Control) { }
                column(docNo; docNo) { }
                column(locationText; locationText) { }
                column(detailText; detailText) { }
                column(VerifiedByLabel; VerifiedByLabel) { }
                column(ApprovedByLabel; ApprovedByLabel) { }
                column(PreparedByLabel; PreparedByLabel) { }

                trigger OnPreDataItem()
                begin
                    CompInfo.CALCFIELDS(Picture);
                    BrojacRedova := COUNT;
                end;

                trigger OnAfterGetRecord()
                var
                    ssl: Record "Sales Shipment Line";
                    iae: Record "Item Application Entry";
                    preskociOvajRed: Boolean; // Ovu varijablu ću koristiti kao indikator da li se trenutni red treba proslijediti RDLC-u ili ne
                    staPrikazati: Text; // Zavisno od tipa izvještaja - prikazivaće se iznosi ili količine
                begin
                    preskociOvajRed := false;

                    if reportText = 'TK' then
                        staPrikazati := 'Iznose'
                    else
                        staPrikazati := 'Količine';

                    // a) Ako je TRANZIT, kreiraj grupu 'Kalkulacija br...'
                    // b) ako je u SSL-u sifra lokacije VP ili VLASTITA - kreiraj grupu: Promet VIRMAN
                    // c) ako je u SSL-u sifra lokacije MP - kreiraj grupu: Prenosnica u maloprodaju br. 
                    if DataItem1."Location Code" = 'TRANZIT' then begin
                        if DataItem1."Order No." <> TekuciNalog then begin
                            // Rekurzivni poziv kojim ćemo pokušati dohvatiti vrijednost "Amount" ili "Quantity" iz Sales Shipment Line-a, 
                            // iako ovaj Value Entry zapis nema direktan zapis u toj tabeli!
                            Credit := GetFinalOutboundEntry(DataItem1."Item Ledger Entry No.", 2, 0, staPrikazati);
                            Debit := 0;
                            Desc := 'Kalkulacija br. ' + DataItem."Group Calculation Number" + '\' + Format(Year);
                            Control := Desc;
                        end
                        else begin
                            preskociOvajRed := true; // Ovo je slučaj kad se TRANZIT pojavljuje drugi put u nalogu, ali samo kao indikator da je u pitanju transfer u maloprodaju!
                        end;
                    end
                    else begin
                        iae.SetRange("Inbound Item Entry No.", DataItem1."Item Ledger Entry No.");
                        iae.SetRange("Transferred-from Entry No.", 0);

                        if iae.FindFirst() then begin
                            ssl.SetRange("Item Shpt. Entry No.", iae."Outbound Item Entry No.");

                            if ssl.FindFirst() then begin
                                Credit := 0;

                                if staPrikazati = 'Iznose' then
                                    Debit := ssl."Amount"
                                else
                                    Debit := ssl."Quantity";

                                if ssl."Location Code" = 'CNG MLP' then
                                    Desc := 'Prenosnica u maloprodaju br. ' + DataItem."Group Calculation Number" + '\' + Format(Year)
                                else
                                    Desc := 'Promet VIRMAN'; // Namjerno izostavljen dinamički metod jer i Virman i Vlastita su veleprodaja... ssl."Payment Method Code";

                                Control := Desc;
                            end
                            else begin
                                preskociOvajRed := true; // I ovaj zapis preskačemo jer se radi o CNG VLP koji je tu samo da prikaže prenos u maloprodaju!
                            end;
                        end;
                    end;

                    if TekuciNalog <> DataItem1."Order No." then begin
                        TekuciNalog := DataItem1."Order No.";
                    end;

                    if (preskociOvajRed) then begin
                        CurrReport.Skip();
                    end;

                    BrojacRedova -= 1;
                end;
            }

            trigger OnPreDataItem()
            begin
                DateFilter := GetFilter("Posting Date");

                if DateFilter <> '' then begin
                    StartDateFilter := GetRangeMin("Posting Date");
                    EndDateFilter := GetRangeMax("Posting Date");
                    Year := Date2DMY(StartDateFilter, 3);
                end;

                if locationText = 'CNG VLP' then
                    DataItem.SetFilter("Transfer-to Code", '%1|%2', locationText, 'VLASTITA')
                else
                    if locationText = 'CNG MLP' then
                        DataItem.SetFilter("Transfer-to Code", locationText);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(ReportSelection; ReportSelected)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = 'Trgovačka knjiga, Količine po zaključenim danima';
                    }
                }
                group("Izaberi skladište")
                {
                    Caption = 'Izaberi skladište';
                    field(WHSelected; WHSelected)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = 'Sve,Veleprodaja,Maloprodaja';
                    }
                }
                group("Izaberi prikaz")
                {
                    Caption = 'Izaberi prikaz';
                    field(DetailSelected; DetailSelected)
                    {
                        Caption = 'Detaljno:';
                        OptionCaption = 'Po datumu,Pojedinačno';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    var
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";
    begin
        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50136);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        locationText := FORMAT(WHSelected);
        reportText := FORMAT(ReportSelected);
        if reportText = 'TK' then begin
            column3 := 'Zadužuje';
            column4 := 'Razdužuje';
            column5 := 'Stanje';
            if locationText = 'CNG MLP' then
                HeaderText := 'TRGOVAČKA KNJIGA - TKM'
            else
                if locationText = 'CNG VLP' then
                    HeaderText := 'TRGOVAČKA KNJIGA - TKV'
                else
                    HeaderText := 'TRGOVAČKA KNJIGA - TKV';
        end
        else begin
            HeaderText := 'CNG KOLIČINE PO ZAKLJUČENIM DANIMA';
            column3 := 'Ulaz kg';
            column4 := 'Izlaz kg';
            column5 := 'Stanje kg';
        end;
        detailText := Format(DetailSelected);
    end;

    var
        column3: Text;
        column4: Text;
        column5: Text;
        CompInfo: Record "Company Information";
        locationText: Text;
        reportText: Text;
        detailText: Text;
        CounterCaption: Label 'No.';
        Control: Text;
        Year: Integer;
        Desc: Text;
        Debit: Decimal;
        Credit: Decimal;
        WHSelected: Option "Sve","CNG VLP","CNG MLP";
        ReportSelected: Option "TK","Količine";
        DetailSelected: Option "Detail","All";
        HeaderText: Text;
        docNo: Text;
        DateFilter: Text;
        StartDateFilter: Date;
        EndDateFilter: Date;
        VerifiedByLabel: Label 'Verified by';
        PreparedByLabel: Label 'Prepared by';
        ApprovedByLabel: Label 'Approved by';
        BrojacRedova: Integer;
        TekuciNalog: Text; // Ovu varijablu koristim za provjeru da li sam još uvijek na tekućem nalogu u Value Entry (jer nalozi objedinjuju više redova u istoj)

    // Svrha: Rekurzivna procedura koja nastoji pronaći zapis u Sales Shipment Line kroz hijerahiju tabele Item Application Entry
    // Parametri: 
    // 1. ILEN: Item Ledger Entry No. - primarni ključ tabele Itemd Ledger Entry
    // 2. inOut: 1 - uzmi Inbound ID, 2 - uzmi OutBound ID iz Item Application Ledger
    // 3. Depth: dubina, odnosno kontrola - koliko puta se rekurzija smije ponoviti. Dobro za slučaj kad imamo 'loše' knjiženje sa neispravnim relacijama!
    // 4. ReturnWhat: Procedura može vratiti iznose (opcija - 1) ili količine (opcija 2)
    procedure GetFinalOutboundEntry(ILEN: Integer; inOut: Integer; Depth: Integer; ReturnWhat: Text): Decimal
    var
        IAE: Record "Item Application Entry";
        SSL: Record "Sales Shipment Line";
    begin
        if ((ILEN = 0) or (Depth > 20)) then
            exit(0);

        if inOut = 1 then begin
            IAE.SetRange("Inbound Item Entry No.", ILEN);
            IAE.SetFilter("Transferred-from Entry No.", '=%1', 0);
        end
        else begin
            IAE.SetRange("OutBound Item Entry No.", ILEN);
            IAE.SetFilter("Transferred-from Entry No.", '<>%1', 0);
        end;

        if IAE.FindFirst() then begin
            if inOut = 1 then begin
                SSL.SetRange("Item Shpt. Entry No.", IAE."Outbound Item Entry No.");

                if SSL.FindFirst() then begin
                    if ReturnWhat = 'Iznose' then begin
                        exit(SSL."Amount");
                    end
                    else begin
                        exit(SSL."Quantity");
                    end;
                end
                else begin
                    exit(GetFinalOutboundEntry(IAE."Outbound Item Entry No.", 2, Depth + 1, ReturnWhat));
                end;
            end
            else begin
                // Ovdje se radi o transakciji Transfer -> VLP, gdje je Transfer ID na poziciji OutBound, dok je VLP ID na poziciji InBound!
                exit(GetFinalOutboundEntry(IAE."Inbound Item Entry No.", 1, Depth + 1, ReturnWhat));
            end;
        end
        else begin
            exit(0);
        end;
    end;
}