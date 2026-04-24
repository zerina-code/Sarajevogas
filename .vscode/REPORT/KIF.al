report 50017 "Electronic Sales VAT Book"
{
    //    DefaultLayout = RDLC;
    // RDLCLayout = './KIF.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Electronic Sales VAT Book';
    ShowPrintStatus = false;

    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                ORDER(Ascending);
            RequestFilterFields = "VAT Date";
            UseTemporary = true;
            dataitem(DataItem2; "Detailed VAT Entry")
            {
                DataItemLink = "VAT Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("VAT Entry No.")
                                    ORDER(Ascending);
                UseTemporary = true;

                trigger OnAfterGetRecord()
                begin
                    c0 := 0;
                    /*IF
                      (Column1 = 0) AND
                      (Column2 = 0) AND
                      (Column3 = 0) AND
                      (Column4 = 0) AND
                      (Column5 = 0) AND
                      (Column6 = 0)
                    THEN*/
                    //CurrReport.SKIP;

                    c1 := 0;
                    c2 := 0;
                    c3 := 0;
                    c4 := 0;
                    c5 := 0;
                    c6 := 0;
                    fullvat2 := 0;
                    fullvat2db := 0;
                    fullvat2rs := 0;
                    c7 := 0;
                    c8 := 0;
                    c9 := 0;


                    Column711 := 0;
                    Column811 := 0;

                    ve10.RESET;
                    ve10.SETRANGE("Entry No.", DataItem2."VAT Entry No.");
                    ve10.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    IF ve10.FINDFIRST THEN BEGIN
                        Column711 := Column5;
                        Column811 := Column6;
                        Column5 := 0;
                        Column6 := 0;

                    END;

                    Total1 += Column1;
                    Total2 += Column2;
                    Total3 += Column3;
                    Total4 += Column4;
                    Total5 += Column5;
                    Total6 += Column6;




                    Total71 += Column711;
                    Total81 += Column811;



                    OutStreamObj.WRITETEXT(
                                           FORMAT(Replace(-Column1)) + ';' +
                                           FORMAT(Replace(-Column2)) + ';' +
                                           FORMAT(Replace(-Column3)) + ';' +
                                           FORMAT(Replace(-Column4)) + ';' +
                                           FORMAT(Replace(-Column5)) + ';' +
                                           FORMAT(Replace(-Column6)) + ';' +
                                           FORMAT(Replace(-Column711)) + ';' +
                                           FORMAT(Replace(-Column811) + ';')
                                       );


                    ve10.RESET;
                    ve10.SETRANGE("VAT Date", StartDate, EndDate);
                    ve10.SETFILTER("Customer Entity Code", '%1|%2', 'FBIH', '');
                    //  ve10.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve10.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');

                    ve10.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve10.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve10.SETFILTER(Type, '%1', ve10.Type::Sale);
                    IF ve10.FindFirst() then begin
                        ve10.CalcSums(Amount);
                        c0 := ve10.Amount;
                    end;
                    ve11.RESET;
                    ve11.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve11.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV MANJAK');
                    ve11.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve11.SETFILTER(Type, '%1', ve11.Type::Sale);
                    IF ve11.FindFirst() then begin
                        ve11.CalcSums(Amount);
                        c1 := ABS(ve11.Amount);
                    end;

                    ve12.RESET;
                    ve12.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve12.SETFILTER("Customer Entity Code", '%1|%2', 'FBIH', '');
                    ve12.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve12.SETFILTER("VAT Bus. Posting Group", '<>%1', 'K-INO');
                    ve12.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve12.SETFILTER(Type, '%1', ve12.Type::Sale);
                    IF ve12.FINDfirst then begin
                        ve12.CalcSums("VAT Amount (retro.)");
                        c2 := ve12."VAT Amount (retro.)";
                    end;

                    ve17.RESET;
                    ve17.SETRANGE("VAT Date", StartDate, EndDate);
                    ve17.SETFILTER("Customer Entity Code", '%1|%2', 'FBIH', '');
                    //  ve17.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve17.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');

                    ve17.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve17.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve17.SETFILTER(Type, '%1', ve17.Type::Purchase);
                    IF ve17.FINDfirst then begin
                        ve17.CalcSums(Amount);
                        c8 := ve17.Amount;
                    end;

                    ve19.RESET;
                    ve19.SETRANGE("VAT Date", StartDate, EndDate);
                    //NK ve19.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve19.SETFILTER("Customer Entity Code", '%1|%2', 'FBIH', '');
                    ve19.SETFILTER(Type, '%1', ve19.Type::Sale);
                    ve19.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve19.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve19.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    IF ve19.FINDfirst then begin
                        ve19.CalcSums("VAT Amount (retro.)");
                        fullvat2 := ve19."VAT Amount (retro.)";
                    end;


                    ve24.RESET;
                    ve24.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve24.SETFILTER("VAT Prod. Posting Group", '%1', 'SAMO PDV');
                    ve24.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve24.SETFILTER(Type, '%1', ve24.Type::Sale);
                    IF ve24.FindFirst() then begin
                        ve24.CalcSums(Amount);
                        c20 := ABS(ve24.Amount);
                    end;

                    //ROUND(c0+c1+c2+c8+fullvat2+c20,1,'<');


                    OutStreamObj.WRITETEXT(FORMAT(Replace(-ROUND(c0 + c1 + c2 + c8 + fullvat2 + c20, 0.01, '<'))) + ';');

                    IF ROUND(c0 + c1 + c2 + c8 + fullvat2 + c20, 0.01, '<') <> 0 THEN
                        Total7 := Total7 + ROUND(c0 + c1 + c2 + c8 + fullvat2 + c20, 0.01, '<');


                    //rs:=ROUND(c3+c4+c7+fullvat2rs,1,'<');


                    ve13.RESET;
                    ve13.SETRANGE("VAT Date", StartDate, EndDate);
                    ve13.SETFILTER("Customer Entity Code", '%1', 'RS');
                    //  ve13.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve13.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');

                    ve13.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve13.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve13.SETFILTER(Type, '%1', ve13.Type::Sale);
                    IF ve13.FINDfirst then begin
                        ve13.CalcSums(Amount);
                        c3 := ve13.Amount;
                    end;


                    ve14.RESET;
                    ve14.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve14.SETFILTER("Customer Entity Code", '%1', 'RS');
                    ve14.SETFILTER("VAT Bus. Posting Group", '<>%1', 'K-INO');
                    ve14.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve14.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve12.SETFILTER(Type, '%1', ve11.Type::Sale);
                    IF ve14.FindFirst() then begin
                        ve14.CalcSums("VAT Amount (retro.)");
                        c4 := ve14."VAT Amount (retro.)";
                    end;
                    ve20.RESET;
                    ve20.SETRANGE("VAT Date", StartDate, EndDate);
                    ve20.SETFILTER("Customer Entity Code", '%1', 'RS');
                    //ve20.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve20.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');

                    ve20.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve20.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve20.SETFILTER(Type, '%1', ve20.Type::Sale);
                    IF ve20.FINDfirst then begin
                        ve20.CalcSums(Amount);
                        c7 := ve20.Amount;
                    end;

                    ve21.RESET;
                    ve21.SETRANGE("VAT Date", StartDate, EndDate);


                    ve21.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');


                    ve21.SETFILTER("Customer Entity Code", '%1', 'RS');
                    ve21.SETFILTER(Type, '%1', ve21.Type::Sale);
                    ve21.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve21.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve21.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    IF ve21.FINDfirst then begin
                        ve21.CalcSums("VAT Amount (retro.)");
                        fullvat2rs := ve21."VAT Amount (retro.)";
                    end;



                    OutStreamObj.WRITETEXT(FORMAT(Replace(-ROUND(c3 + c4 + c7 + fullvat2rs, 0.01, '<'))) + ';');



                    IF ROUND(c3 + c4 + c7 + fullvat2rs, 0.01, '<') <> 0 THEN
                        Total8 := Total8 + ROUND(c3 + c4 + c7 + fullvat2rs, 0.01, '<');


                    //db:=ROUND(c5+c6+c9+fullvat2db,1,'<');

                    ve15.RESET;
                    ve15.SETRANGE("VAT Date", StartDate, EndDate);
                    ve15.SETFILTER("Customer Entity Code", '%1', 'DB');
                    ve15.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');

                    ve15.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve15.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve15.SETFILTER(Type, '%1', ve15.Type::Sale);
                    IF ve15.FINDfirst then begin
                        ve15.CalcSums(Amount);
                        c5 := ve15.Amount;
                    end;


                    ve16.RESET;
                    ve16.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve16.SETFILTER("Customer Entity Code", '%1', 'DB');
                    ve16.SETFILTER("VAT Bus. Posting Group", '<>%1', 'K-INO');
                    ve16.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve16.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    //ve12.SETFILTER(Type,'%1',ve11.Type::Sale);
                    IF ve16.FINDfirst then begin
                        ve16.CalcSums("VAT Amount (retro.)");
                        c6 := ve16."VAT Amount (retro.)";
                    end;

                    ve23.RESET;
                    ve23.SETRANGE("VAT Date", StartDate, EndDate);
                    ve23.SETFILTER("Customer Entity Code", '%1', 'DB');
                    ve23.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');
                    ve23.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve23.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve23.SETFILTER(Type, '%1', ve23.Type::Sale);
                    IF ve23.FINDfirst then begin
                        ve23.CalcSums(Amount);
                        c9 := ve23.Amount;
                    end;
                    ve22.RESET;
                    ve22.SETRANGE("VAT Date", StartDate, EndDate);
                    ve22.SETFILTER("Gen. Bus. Posting Group", '%1|%2|%3|%4|%5|%6', 'DOMAĆI', 'DOMAĆINSTVA', 'MALA PRIVREDA', 'VELIKA PRIVREDA', 'TOPLANE', 'SP');
                    ve22.SETFILTER("Customer Entity Code", '%1', 'DB');
                    ve22.SETFILTER(Type, '%1', ve22.Type::Sale);
                    ve22.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve22.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve22.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    IF ve22.FINDfirst then begin
                        ve22.CalcSums("VAT Amount (retro.)");
                        fullvat2db := ve22."VAT Amount (retro.)";
                    end;



                    OutStreamObj.WRITETEXT(FORMAT(Replace(-ROUND(c5 + c6 + c9 + fullvat2db, 0.01, '<'))));


                    IF ROUND(c5 + c6 + c9 + fullvat2db, 0.01, '<') <> 0 THEN
                        Total9 := Total9 + ROUND(c5 + c6 + c9 + fullvat2db, 0.01, '<');



                    /*Total7:=Total7+ROUND(c0+c1+c2+c8+fullvat2+c20,1,'<');
                    Total8:=Total8+ROUND(c3+c4+c7+fullvat2rs,1,'<');
                    Total9:=Total9+ROUND(c5+c6+c9+fullvat2db,1,'<');
                    */


                    OutStreamObj.WRITETEXT();
                    BrojRedova := BrojRedova + 1;



                    CALCFIELDS("Amount retro");

                end;

                trigger OnPreDataItem()
                begin
                    IF (DataItem1."VAT Calculation Type" = DataItem1."VAT Calculation Type"::"Reverse Charge VAT") THEN
                        SETFILTER(Type, '%1', DataItem1.Type::Sale)
                    ELSE
                        SETFILTER(Type, '%1', DataItem1.Type);
                end;
            }

            trigger OnAfterGetRecord()
            begin


                IF (Type = Type::Purchase) AND ("VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT")
                THEN
                    Type := Type::Sale;

                IF Type <> Type::Sale THEN
                    CurrReport.SKIP;
                CompIn.GET;
                Brojac := Brojac + 1;

                OutStreamObj.WRITETEXT('2;');
                OutStreamObj.WRITETEXT(PorezniPeriod);
                OutStreamObj.WRITETEXT(';');
                OutStreamObj.WRITETEXT(FORMAT(Redni));
                //ĐK OutStreamObj.WRITETEXT(';');
                SumaRed := Brojac;
                Redni := Redni + 1;
                OutStreamObj.WRITETEXT(';');



                //tip dokumenta
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                    IF VendorLedgerEntry.Prepayment = TRUE THEN BEGIN
                        //avansi

                        TipDokumenta := '03';

                    END
                    ELSE BEGIN


                        IF (
                            (
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'DOMAĆI') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'CNG MP') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'CNG VP') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'DOMAĆINSTVA') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'INTERNO') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'TOPLANE') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'VP') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'VELIKA PRIVREDA') <> 0) or
                                (StrPos(DataItem1."Gen. Bus. Posting Group", 'MALA PRIVREDA') <> 0)
                                or (StrPos(DataItem1."Gen. Bus. Posting Group", 'CNG VP') <> 0)
                                or (StrPos(DataItem1."Gen. Bus. Posting Group", 'SP') <> 0)
                            )

                            and (DataItem1.Import = false)
                        ) THEN BEGIN


                            TipDokumenta := '01';

                        END
                        ELSE BEGIN

                            IF (
       (
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'DOMAĆI') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'CNG MP') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'CNG VP') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'DOMAĆINSTVA') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'INTERNO') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'TOPLANE') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'VP') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'VELIKA PRIVREDA') = 0) or
           (StrPos(DataItem1."Gen. Bus. Posting Group", 'MALA PRIVREDA') = 0)
           or (StrPos(DataItem1."Gen. Bus. Posting Group", 'CNG VP') <> 0)
           or (StrPos(DataItem1."Gen. Bus. Posting Group", 'SP') <> 0)
       ) AND (DataItem1.Import = TRUE)) THEN BEGIN


                                TipDokumenta := '04';

                            END
                            ELSE BEGIN


                                Vendorr.RESET;
                                Vendorr.SETFILTER("No.", '%1', DataItem1."Bill-to/Pay-to No.");
                                IF Vendor.FINDFIRST THEN BEGIN
                                    IF Vendor."VAT Registration No." = CompIn."VAT Registration No." THEN BEGIN

                                        TipDokumenta := '02';

                                    END
                                    ELSE BEGIN

                                        TipDokumenta := '05';

                                    END;

                                END;
                            END;
                        END;
                    END;
                END;




                VatEntryReverse.RESET;
                VatEntryReverse.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                VatEntryReverse.SETFILTER("VAT Calculation Type", '%1', VatEntryReverse."VAT Calculation Type"::"Reverse Charge VAT");
                IF VatEntryReverse.FINDFIRST THEN
                    TipDokumenta := '05';


                if (DataItem1."Document No." = UpperCase('Zbirni računi')) then begin

                    DataItem1."External Document No." := 'Zbirni računi domaćinstvo';
                    TipDokumenta := '01';

                end;

                if (DataItem1."Document No." = UpperCase('Zbirni računi storno')) then begin

                    DataItem1."External Document No." := 'Zbirni storno računi domaćinstvo';
                    TipDokumenta := '01';
                end;

                if (DataItem1."Document No." = UpperCase('Zbirni računi CNG')) then begin

                    DataItem1."External Document No." := 'Zbirni računi CNG';
                    TipDokumenta := '01';
                end;



                if (DataItem1."Document No." = UpperCase('Zbirni storno CNG')) then begin

                    DataItem1."External Document No." := 'Zbirni storno računi CNG';
                    TipDokumenta := '01';
                end;


                if (DataItem1."Document No." = UpperCase('Zbirni avansi')) then begin

                    DataItem1."External Document No." := 'Zbirni avansi domaćinstvo';
                    TipDokumenta := '03';
                end;

                if (DataItem1."Document No." = UpperCase('Zbirni storno avansi')) then begin

                    DataItem1."External Document No." := 'Zbirni storno avansi domaćinstvo';
                    TipDokumenta := '03';
                end;

                if (DataItem1."Document No." = UpperCase('Zbirni avansi CNG')) then begin

                    DataItem1."External Document No." := 'Zbirni avansi CNG';
                    TipDokumenta := '03';
                end;

                if (DataItem1."Document No." = UpperCase('Zbirni storno A.CNG')) then begin

                    DataItem1."External Document No." := 'Zbirni storno avansi CNG';
                    TipDokumenta := '03';
                end;


                OutStreamObj.WRITETEXT(TipDokumenta);
                OutStreamObj.WRITETEXT(';');

                if DataItem1."External Document No." = '' then DataItem1."External Document No." := DataItem1."Document No.";

                IF (TipDokumenta = '01') OR (TipDokumenta = '02') OR (TipDokumenta = '03') THEN BEGIN

                    OutStreamObj.WRITETEXT(DataItem1."External Document No." + ';');
                END
                ELSE BEGIN
                    IF (TipDokumenta = '04') OR ((TipDokumenta = '05')) THEN
                        OutStreamObj.WRITETEXT(DataItem1."External Document No." + ';');
                END;



                //OutStreamObj.WRITETEXT(DataItem1."Document No."+';');
                OutStreamObj.WRITETEXT(FORMAT(DataItem1."Document Date", 10, '<Year4>-<Month,2>-<Day,2>') + ';');
                //ĐK OutStreamObj.WRITETEXT(FORMAT(DataItem1."Posting Date",10,'<Year4>-<Month,2>-<Day,2>')+';');


                Vendor.RESET;
                Vendor.SETFILTER("No.", '%1', DataItem1."Bill-to/Pay-to No.");
                IF Vendor.FINDFIRST THEN BEGIN
                    OutStreamObj.WRITETEXT(Vendor.Name + ';');
                    OutStreamObj.WRITETEXT(Vendor.Address + ';');

                    IF (TipDokumenta = '04') THEN BEGIN
                        OutStreamObj.WRITETEXT('000000000000' + ';');
                        OutStreamObj.WRITETEXT('0000000000000' + ';');


                    END

                    ELSE BEGIN


                        IF DataItem1."Gen. Bus. Posting Group" = 'K-0-PDV' THEN BEGIN
                            OutStreamObj.WRITETEXT('' + ';');
                            OutStreamObj.WRITETEXT('' + ';');

                        END
                        ELSE BEGIN
                            OutStreamObj.WRITETEXT(Vendor."Registration No." + ';');
                            OutStreamObj.WRITETEXT(Vendor."VAT Registration No." + ';');
                        END;
                    END;
                END
                ELSE BEGIN
                    /* OutStreamObj.WRITETEXT(''+';');

                   OutStreamObj.WRITETEXT(''+';');
                    OutStreamObj.WRITETEXT(''+';');*/
                    CustomerReal.RESET;
                    CustomerReal.SETFILTER("No.", '%1', DataItem1."Bill-to/Pay-to No.");
                    IF CustomerReal.FINDFIRST THEN BEGIN

                        if (strpos(DataItem1."External Document No.", 'Zbirni računi') <> 0) or
    (strpos(DataItem1."External Document No.", 'Zbirni storno') <> 0) or
    (strpos(DataItem1."External Document No.", 'Zbirni avansi') <> 0)
     then begin
                            OutStreamObj.WRITETEXT('Zbirni' + ';');
                            OutStreamObj.WRITETEXT('Zbirni' + ';');
                        End else begin
                            OutStreamObj.WRITETEXT(CustomerReal.Name + ';');
                            OutStreamObj.WRITETEXT(CustomerReal.Address + ';');

                        end;
                        IF (TipDokumenta = '04') THEN BEGIN
                            OutStreamObj.WRITETEXT('000000000000' + ';');
                            OutStreamObj.WRITETEXT('0000000000000' + ';');


                        END

                        ELSE BEGIN


                            IF DataItem1."Gen. Bus. Posting Group" = 'K-0-PDV' THEN BEGIN
                                OutStreamObj.WRITETEXT('' + ';');
                                OutStreamObj.WRITETEXT('' + ';');

                            END
                            ELSE BEGIN
                                OutStreamObj.WRITETEXT(CustomerReal."Registration No." + ';');
                                OutStreamObj.WRITETEXT(CustomerReal."VAT Registration No." + ';');
                            END;
                        END;

                    END;



                END;

                DetailedVATEntry.RESET;
                DetailedVATEntry.SETFILTER("VAT Entry No.", '%1', DataItem1."Entry No.");
                IF NOT DetailedVATEntry.FINDFIRST THEN BEGIN
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0) + ';'));
                    OutStreamObj.WRITETEXT();
                END;


                CurrentDateT := time;
                Broj2 += 1;
                Progress.UPDATE(1, ROUND(Broj2));
                Progress.UPDATE(2, CurrentDateT);



                //yymm format poreznog perioda}

            end;

            trigger OnPostDataItem()
            begin


                // Write totals footer
                OutStreamObj.WRITETEXT(
                    '3;' +
                    FORMAT(Replace(-Total1)) + ';' +
                    FORMAT(Replace(-Total2)) + ';' +
                    FORMAT(Replace(-Total3)) + ';' +
                    FORMAT(Replace(-Total4)) + ';' +
                    FORMAT(Replace(-Total5)) + ';' +
                    FORMAT(Replace(-Total6)) + ';' +
                    FORMAT(Replace(-Total71)) + ';' +
                    FORMAT(Replace(-Total81)) + ';' +
                    FORMAT(Replace(-Total7)) + ';' +
                    FORMAT(Replace(-Total8)) + ';' +
                    FORMAT(Replace(-Total9)) + ';' +
                    FORMAT(SumaRed)
                );

                FileDoc.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                PorezniPeriod := DataItem1.GETFILTER("VAT Date");

                IF PorezniPeriod = '' THEN
                    ERROR('Porezni period mora biti unesen');
                IF COPYSTR(PorezniPeriod, 1, 2) <> '..' THEN BEGIN
                    PorezniPeriod2 := PorezniPeriod;
                    IF STRPOS(PorezniPeriod2, '..') <> 0 THEN
                        PorezniPeriod := COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..'));
                    EVALUATE(PorezniOdDate, PorezniPeriod);
                    PorezniPeriod := COPYSTR(PorezniPeriod2, 7, 2);
                    PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
                END
                ELSE BEGIN
                    PorezniPeriod := DELCHR(PorezniPeriod2, '=', '..');
                    PorezniPeriod := COPYSTR(PorezniPeriod2, 4, 2);
                    PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
                    EVALUATE(PorezniOdDate, PorezniPeriod);
                END;



                WorkType.RESET;
                WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
                WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
                WorkType.SETFILTER(Type, '%1', WorkType.Type::KIF);
                WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
                WorkType.SETFILTER(Description, '%1', FORMAT(Type2));
                WorkType.SETCURRENTKEY("Number No. from");
                WorkType.ASCENDING;

                IF WorkType.FINDLAST THEN BEGIN
                    Redni := WorkType."Number No. from"
                END
                ELSE BEGIN
                    WorkType.RESET;
                    WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
                    WorkType.SETCURRENTKEY("Number No. from");
                    WorkType.SETFILTER(Type, '%1', WorkType.Type::KIF);
                    WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
                    WorkType.SETFILTER(Description, '%1', FORMAT(Type2));
                    WorkType.ASCENDING;

                    IF WorkType.FINDLAST THEN BEGIN
                        Redni := WorkType."Number No. to" + 1;
                    END
                    ELSE BEGIN
                        Redni := Redni + 1;
                    END;



                END;

                IDOd := Redni;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Type2; Type2)
                {
                    Visible = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Zaglavlje := '';
        NewLine := 13;
        Brojac := 0;
        Total1 := 0;
        Total3 := 0;
        Total2 := 0;
        Total10 := 0;
        Total4 := 0;
        Total5 := 0;
        Total6 := 0;
        Total7 := 0;
        Total8 := 0;
        Total9 := 0;
        BrojRedova := 0;

        //32 - fbih vlastita potrošnja
        //33 - RS vlastita potrošnja
        //34 - Brčko - vlastita potrošnja
    end;

    trigger OnPostReport()
    begin
        //OutStreamObj.WRITETEXT('3'+';');

        WorkType.RESET;
        WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
        WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
        WorkType.SETFILTER(Type, '%1', WorkType.Type::KIF);
        WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
        WorkType.SETFILTER(Description, '%1', FORMAT(Type2));
        WorkType.SETCURRENTKEY("Number No. from");
        WorkType.ASCENDING;

        IF WorkType.FINDLAST THEN BEGIN
            WorkType."Number No. to" := Redni - 1;
            IF DataItem1.ISEMPTY THEN
                WorkType.DELETE
            ELSE
                WorkType.MODIFY;
        END
        ELSE BEGIN
            IF DataItem1.ISEMPTY THEN BEGIN

            END
            ELSE BEGIN
                WorkType.INIT;
                WorkType.Description := FORMAT(Type2);
                WorkType.Types := WorkType.Types::"KIF KUF Logs";
                WorkType.Type := WorkType.Type::KIF;
                WorkType."Number No. to" := Redni - 1;
                WorkType."Number No. from" := IDOd;
                WorkType.Year := DATE2DMY(PorezniOdDate, 3);
                WorkType.Month := DATE2DMY(PorezniOdDate, 2);
                WorkType.INSERT;
            END;
        END;


        IF EXISTS(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '2' + '_' + '01.csv') THEN
            ERASE(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '2' + '_' + '01.csv');
        FileManagement.DownloadToFile(Comp."Path value" + 'TestFile.csv', Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '2' + '_' + '01.csv');
        MESSAGE('Dokument je kreiran na lokaciji ' + Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '2' + '_' + '01.csv');
    end;

    trigger OnPreReport()
    var
        ExistingFilter: Text;
        FilterPart: Text;
        CleanFilter: Text;
        FilterIndex: Integer;
    begin

        StartDaT := time;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;

        Comp.GET;


        VATTemp.DELETEALL;
        DVATTemp.DELETEALL;

        VATEOrg.RESET;
        VATEOrg.COPYFILTERS(DataItem1);
        VATEOrg.SETFILTER("VAT Prod. Posting Group", '<>%1', 'PDV NE');



        Broj2 := 0;

        ExistingFilter := DataItem1.GETFILTER("Document No.");

        CleanFilter := '';

        if ExistingFilter <> '' then begin
            CleanFilter := '';
            StartPos := 1;
            while ExistingFilter <> '' do begin
                NextPos := STRPOS(ExistingFilter, '|');
                if NextPos = 0 then begin
                    FilterPart := ExistingFilter;
                    ExistingFilter := '';
                end else begin
                    FilterPart := COPYSTR(ExistingFilter, 1, NextPos - 1);
                    ExistingFilter := COPYSTR(ExistingFilter, NextPos + 1);
                end;

                // Preskoči prazne dijelove
                // Preskoči prazne dijelove
                // Ako NE počinje sa "03", zadrži ga
                if (COPYSTR(FilterPart, 1, 3) <> '03-') and (COPYSTR(FilterPart, 1, 4) <> 'AV03') and (COPYSTR(FilterPart, 1, 3) <> '08-')
             and (COPYSTR(FilterPart, 1, 3) <> 'AVS') and (COPYSTR(FilterPart, 1, 3) <> 'SAVS') then begin
                    if CleanFilter = '' then
                        CleanFilter := FilterPart
                    else
                        CleanFilter := STRSUBSTNO('%1|%2', CleanFilter, FilterPart);
                end;
            end;
            FilterIndex += 1;

        end;

        VATEOrg.SETFILTER("Document No.", '<>%1 & <>%2 & <>%3 & <>%4 & <>%5', 'AV03*', '03-*', '08-*', 'AVS*', 'SAV*');

        if CleanFilter <> '' then begin
            TempFilter := CleanFilter;
            while STRLEN(TempFilter) > 0 do begin
                NextPos := STRPOS(TempFilter, '|');
                if NextPos = 0 then begin
                    FilterPart := TempFilter;
                    TempFilter := '';
                end else begin
                    FilterPart := COPYSTR(TempFilter, 1, NextPos - 1);
                    TempFilter := COPYSTR(TempFilter, NextPos + 1);
                end;

                if FilterPart <> '' then
                    VATEOrg.SETFILTER("Document No.", '%1|%2', VATEOrg.GETFILTER("Document No."), FilterPart);
            end;
        end;
        VATEOrg.setfilter("Bill type", '<>%1', '03');
        IF VATEOrg.FINDSET THEN
            REPEAT

                Broj2 += 1;
                Progress.UPDATE(1, ROUND(Broj2));
                Progress.UPDATE(2, CurrentDateT);
                VATTemp.RESET;
                VATTemp.SETFILTER("External Document No.", '%1', VATEOrg."External Document No.");
                VATTemp.SETFILTER("Document No.", '%1', VATEOrg."Document No.");
                VATTemp.SETFILTER("VAT Date", '%1', VATEOrg."VAT Date");
                IF VATTemp.FINDFIRST THEN BEGIN
                    VATTemp.Base := VATTemp.Base + VATEOrg.Base;
                    VATTemp.Amount := VATTemp.Amount + VATEOrg.Amount;
                    VATTemp."Unrealized Amount" := VATTemp."Unrealized Amount" + VATEOrg."Unrealized Amount";
                    VATTemp."Unrealized Base" := VATTemp."Unrealized Base" + VATEOrg."Unrealized Base";
                    VATTemp."Remaining Unrealized Amount" := VATTemp."Remaining Unrealized Amount" + VATEOrg."Remaining Unrealized Amount";

                    VATTemp."Remaining Unrealized Base" := VATTemp."Remaining Unrealized Base" + VATEOrg."Remaining Unrealized Base";

                    VATTemp."Remaining Unrealized Amount" := VATTemp."Remaining Unrealized Amount" + VATEOrg.Amount;
                    VATTemp.MODIFY;


                    DVATOrg.RESET;
                    DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                    IF DVATOrg.FINDFIRST THEN BEGIN
                        DVATTemp.RESET;
                        DVATTemp.SETFILTER("VAT Entry No.", '%1', VATTemp."Entry No.");
                        IF DVATTemp.FINDFIRST THEN BEGIN
                            DVATTemp.Column1 := DVATTemp.Column1 + DVATOrg.Column1;
                            DVATTemp.Column2 := DVATTemp.Column2 + DVATOrg.Column2;
                            DVATTemp.Column3 := DVATTemp.Column3 + DVATOrg.Column3;
                            DVATTemp.Column4 := DVATTemp.Column4 + DVATOrg.Column4;
                            DVATTemp.Column5 := DVATTemp.Column5 + DVATOrg.Column5;
                            DVATTemp.Column6 := DVATTemp.Column6 + DVATOrg.Column6;
                            DVATTemp.Column7 := DVATTemp.Column7 + DVATOrg.Column7;
                            DVATTemp.Column8 := DVATTemp.Column8 + DVATOrg.Column8;
                            DVATTemp.Column9 := DVATTemp.Column9 + DVATOrg.Column9;
                            DVATTemp.Column10 := DVATTemp.Column10 + DVATOrg.Column10;
                            DVATTemp."VAT retro" := DVATTemp."VAT retro" + DVATOrg."VAT retro";
                            DVATTemp."Amount retro" := DVATTemp."Amount retro" + DVATOrg."Amount retro";

                            DVATTemp.MODIFY;
                        END;
                    END;


                END
                ELSE BEGIN
                    VATTemp.INIT;
                    VATTemp.TRANSFERFIELDS(VATEOrg);
                    VATTemp.INSERT;
                    DVATOrg.RESET;
                    DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                    DVATOrg.SETFILTER(Type, '%1', DVATOrg.Type::Sale);
                    IF DVATOrg.FINDFIRST THEN BEGIN
                        DVATTemp.INIT;
                        DVATTemp.TRANSFERFIELDS(DVATOrg);
                        DVATTemp.INSERT;
                    END;

                END;


            UNTIL VATEOrg.NEXT = 0;

        //dodati samo za domaćinstvo

        ExistingFilter := DataItem1.GETFILTER("Document No.");

        CleanFilter := '';

        if ExistingFilter <> '' then begin
            CleanFilter := '';
            StartPos := 1;
            while ExistingFilter <> '' do begin
                NextPos := STRPOS(ExistingFilter, '|');
                if NextPos = 0 then begin
                    FilterPart := ExistingFilter;
                    ExistingFilter := '';
                end else begin
                    FilterPart := COPYSTR(ExistingFilter, 1, NextPos - 1);
                    ExistingFilter := COPYSTR(ExistingFilter, NextPos + 1);
                end;
                // Ako NE počinje sa "03", zadrži ga
                if (COPYSTR(FilterPart, 1, 3) = '03-') then begin
                    if CleanFilter = '' then
                        CleanFilter := FilterPart
                    else
                        CleanFilter := STRSUBSTNO('%1|%2', CleanFilter, FilterPart);
                end;
            end;
            FilterIndex += 1;

        end;


        VATEOrg.RESET;
        VATEOrg.COPYFILTERS(DataItem1);
        VATEOrg.SETFILTER("VAT Prod. Posting Group", '<>%1', 'PDV NE');
        if CleanFilter <> '' then
            VATEOrg.SetFilter("Document No.", '%1|%2', '03-*', CleanFilter)
        else
            VATEOrg.SetFilter("Document No.", '%1', '03-*');
        VATEOrg.SetFilter("Document Type", '<>%1', VATEOrg."Document Type"::"Credit Memo");
        IF VATEOrg.FindFirst() then begin
            VATEOrg.CalcSums(Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Remaining Unrealized Amount");

            Broj2 += 1;
            Progress.UPDATE(1, ROUND(Broj2));
            Progress.UPDATE(2, CurrentDateT);
            VATTemp.RESET;
            if CleanFilter <> '' then
                VATTemp.SetFilter("Document No.", '%1|%2', '03-*', CleanFilter)
            else
                VATTemp.SETFILTER("Document No.", '%1', '%1', '03-*');
            VATTemp.SETFILTER("VAT Prod. Posting Group", '<>%1', 'PDV NE');
            VATTemp.SETFILTER("VAT Date", '%1', VATEOrg."VAT Date");
            IF VATTemp.FINDFIRST THEN BEGIN
                // VATEOrg.CalcSums(Base,Amount,"Unrealized Amount","Unrealized Base", "Remaining Unrealized Amount","Remaining Unrealized Base","Remaining Unrealized Amount");
                VATTemp.Base := VATEOrg.Base;
                VATTemp.Amount := VATEOrg.Amount;
                VATTemp."Unrealized Amount" := VATEOrg."Unrealized Amount";
                VATTemp."Unrealized Base" := VATEOrg."Unrealized Base";
                VATTemp."Remaining Unrealized Amount" := VATEOrg."Remaining Unrealized Amount";

                VATTemp."Remaining Unrealized Base" := VATEOrg."Remaining Unrealized Base";

                VATTemp."Remaining Unrealized Amount" := VATEOrg.Amount;
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then begin
                    VATTemp."Document No." := 'Zbirni storno računi';
                end;

                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno avansi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi';
                VATTemp.MODIFY;


                DVATOrg.RESET;

                if CleanFilter <> '' then
                    DVATorg.SetFilter("Document No.", '%1|%2', '03-*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1', '03-*');
                DVATOrg.SetFilter("VAT Entry No.", '%1', VATEOrg."Entry No.");
                DVATOrg.SetFilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATTemp.RESET;
                    if CleanFilter <> '' then
                        DVATTemp.SetFilter("Document No.", '%1|%2', '03-*', CleanFilter)
                    else
                        DVATTemp.SETFILTER("Document No.", '%1', '%1', '03-*');
                    DVATTemp.SetFilter("VAT Date", DataItem1.GETFILTER("VAT Date"));

                    IF DVATTemp.FINDFIRST THEN BEGIN
                        DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);
                        DVATTemp.Column1 := DVATOrg.Column1;
                        DVATTemp.Column2 := DVATOrg.Column2;
                        DVATTemp.Column3 := DVATOrg.Column3;
                        DVATTemp.Column4 := DVATOrg.Column4;
                        DVATTemp.Column5 := DVATOrg.Column5;
                        DVATTemp.Column6 := DVATOrg.Column6;
                        DVATTemp.Column7 := DVATOrg.Column7;
                        DVATTemp.Column8 := DVATOrg.Column8;
                        DVATTemp.Column9 := DVATOrg.Column9;
                        DVATTemp.Column10 := DVATOrg.Column10;
                        DVATTemp."VAT retro" := DVATOrg."VAT retro";
                        DVATTemp."Amount retro" := DVATOrg."Amount retro";

                        DVATTemp.MODIFY;
                    END;
                END;


            END
            ELSE BEGIN
                VATTemp.INIT;
                VATTemp.TRANSFERFIELDS(VATEOrg);
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni storno računi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno avansi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi';

                VATTemp.INSERT;
                DVATOrg.RESET;
                if CleanFilter <> '' then
                    DVATOrg.SetFilter("Document No.", '%1|%2', '03-*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1', '03-*');
                DVATOrg.SETFILTER(Type, '%1', DVATOrg.Type::Sale);
                DVATOrg.SetFilter("Document Type", '<>%1', DVATOrg."Document Type"::"Credit Memo");
                //DVATOrg.SetFilter("VAT Entry No.", '%1', VATEOrg."Entry No.");
                DVATOrg.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);

                    DVATTemp.INIT;
                    DVATTemp.TRANSFERFIELDS(DVATOrg);
                    DVATTemp."VAT Entry No." := VATEOrg."Entry No.";
                    DVATTemp."Document No." := VATTemp."Document No.";
                    DVATTemp.INSERT;
                END;

            END;

        end;

        //kraj



        //dodati samo za storrno domaćinstvo avansi

        ExistingFilter := DataItem1.GETFILTER("Document No.");

        CleanFilter := '';

        if ExistingFilter <> '' then begin
            CleanFilter := '';
            StartPos := 1;
            while ExistingFilter <> '' do begin
                NextPos := STRPOS(ExistingFilter, '|');
                if NextPos = 0 then begin
                    FilterPart := ExistingFilter;
                    ExistingFilter := '';
                end else begin
                    FilterPart := COPYSTR(ExistingFilter, 1, NextPos - 1);
                    ExistingFilter := COPYSTR(ExistingFilter, NextPos + 1);
                end;
                // Ako NE počinje sa "03", zadrži ga
                if (COPYSTR(FilterPart, 1, 5) = 'AV03-') and (COPYSTR(FilterPart, 1, 3) = 'AVS') and (COPYSTR(FilterPart, 1, 3) = 'SAVS') then begin
                    if CleanFilter = '' then
                        CleanFilter := FilterPart
                    else
                        CleanFilter := STRSUBSTNO('%1|%2', CleanFilter, FilterPart);
                end;
            end;
            FilterIndex += 1;

        end;

        VATEOrg.RESET;
        VATEOrg.COPYFILTERS(DataItem1);
        VATEOrg.SETFILTER("VAT Prod. Posting Group", '<>%1', 'PDV NE');

        if CleanFilter <> '' then
            VATEOrg.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
        else
            VATEOrg.SetFilter("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
        VATEOrg.SetFilter("Bill type", '%1', '03');
        VATEOrg.SetFilter("Document Type", '<>%1', VATEOrg."Document Type"::"Credit Memo");
        IF VATEOrg.FindFirst() then begin
            VATEOrg.CalcSums(Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Remaining Unrealized Amount");

            Broj2 += 1;
            Progress.UPDATE(1, ROUND(Broj2));
            Progress.UPDATE(2, CurrentDateT);
            VATTemp.RESET;
            if CleanFilter <> '' then
                VATTemp.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
            else
                VATTemp.SETFILTER("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
            VATTemp.SETFILTER("VAT Date", '%1', VATEOrg."VAT Date");

            IF VATTemp.FINDFIRST THEN BEGIN
                // VATEOrg.CalcSums(Base,Amount,"Unrealized Amount","Unrealized Base", "Remaining Unrealized Amount","Remaining Unrealized Base","Remaining Unrealized Amount");
                VATTemp.Base := VATEOrg.Base;
                VATTemp.Amount := VATEOrg.Amount;
                VATTemp."Unrealized Amount" := VATEOrg."Unrealized Amount";
                VATTemp."Unrealized Base" := VATEOrg."Unrealized Base";
                VATTemp."Remaining Unrealized Amount" := VATEOrg."Remaining Unrealized Amount";
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni storno računi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno avansi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi';



                VATTemp."Remaining Unrealized Base" := VATEOrg."Remaining Unrealized Base";

                VATTemp."Remaining Unrealized Amount" := VATEOrg.Amount;
                VATTemp.MODIFY;


                DVATOrg.RESET;
                if CleanFilter <> '' then
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
                DVATOrg.SetFilter("Document Type", '<>%1', DVATOrg."Document Type"::"Credit Memo");
                DVATOrg.SetFilter("VAT Entry No.", '%1', VATEOrg."Entry No.");
                DVATOrg.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATTemp.RESET;
                    if CleanFilter <> '' then
                        DVATTemp.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
                    else
                        DVATTemp.SetFilter("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
                    DVATTemp.setfilter("VAT DAte", DataItem1.GETFILTER("VAT Date"));
                    IF DVATTemp.FINDFIRST THEN BEGIN
                        DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);
                        DVATTemp.Column1 := DVATOrg.Column1;
                        DVATTemp.Column2 := DVATOrg.Column2;
                        DVATTemp.Column3 := DVATOrg.Column3;
                        DVATTemp.Column4 := DVATOrg.Column4;
                        DVATTemp.Column5 := DVATOrg.Column5;
                        DVATTemp.Column6 := DVATOrg.Column6;
                        DVATTemp.Column7 := DVATOrg.Column7;
                        DVATTemp.Column8 := DVATOrg.Column8;
                        DVATTemp.Column9 := DVATOrg.Column9;
                        DVATTemp.Column10 := DVATOrg.Column10;
                        DVATTemp."VAT retro" := DVATOrg."VAT retro";
                        DVATTemp."Amount retro" := DVATOrg."Amount retro";

                        DVATTemp.MODIFY;
                    END;
                END;


            END
            ELSE BEGIN
                VATTemp.INIT;
                VATTemp.TRANSFERFIELDS(VATEOrg);
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni storno računi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno avansi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi';
                VATTemp.INSERT;
                DVATOrg.RESET;
                // DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                if CleanFilter <> '' then
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
                DVATOrg.SETFILTER(Type, '%1', DVATOrg.Type::Sale);
                DVATOrg.SetFilter("Document Type", '<>%1', DVATOrg."Document Type"::"Credit Memo");
                //DVATOrg.SetFilter("VAT Entry No.", '%1', VATEOrg."Entry No.");
                DVATOrg.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);

                    DVATTemp.INIT;
                    DVATTemp.TRANSFERFIELDS(DVATOrg);
                    DVATTemp."VAT Entry No." := VATEOrg."Entry No.";
                    DVATTemp."Document No." := VATTemp."Document No.";
                    DVATTemp.INSERT;
                END;

            END;

        end;
        //storno domaćinstvo verzija 2
        //dodati samo za storrno domaćinstvo avansi

        VATEOrg.RESET;
        VATEOrg.COPYFILTERS(DataItem1);
        VATEOrg.SETFILTER("VAT Prod. Posting Group", '<>%1', 'PDV NE');
        if CleanFilter <> '' then
            VATEOrg.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
        else
            VATEOrg.SetFilter("Document No.", '%1|%2|%4', 'AV03-*', 'AVS*', 'SAV*');
        VATEOrg.SetFilter("Bill type", '%1', '03');
        VATEOrg.SetFilter("Document Type", '%1', VATEOrg."Document Type"::"Credit Memo");
        IF VATEOrg.FindFirst() then begin
            VATEOrg.CalcSums(Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Remaining Unrealized Amount");

            Broj2 += 1;
            Progress.UPDATE(1, ROUND(Broj2));
            Progress.UPDATE(2, CurrentDateT);
            VATTemp.RESET;
            if CleanFilter <> '' then
                VATTemp.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
            else
                VATTemp.SETFILTER("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
            VATTemp.SETFILTER("VAT Date", '%1', VATEOrg."VAT Date");

            IF VATTemp.FINDFIRST THEN BEGIN
                // VATEOrg.CalcSums(Base,Amount,"Unrealized Amount","Unrealized Base", "Remaining Unrealized Amount","Remaining Unrealized Base","Remaining Unrealized Amount");
                VATTemp.Base := VATEOrg.Base;
                VATTemp.Amount := VATEOrg.Amount;
                VATTemp."Unrealized Amount" := VATEOrg."Unrealized Amount";
                VATTemp."Unrealized Base" := VATEOrg."Unrealized Base";
                VATTemp."Remaining Unrealized Amount" := VATEOrg."Remaining Unrealized Amount";
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni storno računi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno avansi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi';



                VATTemp."Remaining Unrealized Base" := VATEOrg."Remaining Unrealized Base";

                VATTemp."Remaining Unrealized Amount" := VATEOrg.Amount;
                VATTemp.MODIFY;


                DVATOrg.RESET;
                if CleanFilter <> '' then
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
                DVATOrg.SetFilter("Document Type", '%1', VATEOrg."Document Type"::"Credit Memo");
                DVATOrg.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));

                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATTemp.RESET;
                    if CleanFilter <> '' then
                        DVATTemp.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
                    else
                        DVATTemp.SetFilter("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
                    DVATTEmp.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                    IF DVATTemp.FINDFIRST THEN BEGIN
                        DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);
                        DVATTemp.Column1 := DVATOrg.Column1;
                        DVATTemp.Column2 := DVATOrg.Column2;
                        DVATTemp.Column3 := DVATOrg.Column3;
                        DVATTemp.Column4 := DVATOrg.Column4;
                        DVATTemp.Column5 := DVATOrg.Column5;
                        DVATTemp.Column6 := DVATOrg.Column6;
                        DVATTemp.Column7 := DVATOrg.Column7;
                        DVATTemp.Column8 := DVATOrg.Column8;
                        DVATTemp.Column9 := DVATOrg.Column9;
                        DVATTemp.Column10 := DVATOrg.Column10;
                        DVATTemp."VAT retro" := DVATOrg."VAT retro";
                        DVATTemp."Amount retro" := DVATOrg."Amount retro";

                        DVATTemp.MODIFY;
                    END;
                END;


            END
            ELSE BEGIN
                VATTemp.INIT;
                VATTemp.TRANSFERFIELDS(VATEOrg);
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni storno računi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno avansi';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi';
                VATTemp.INSERT;
                DVATOrg.RESET;
                // DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                if CleanFilter <> '' then
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3|%4', 'AV03-*', 'AVS*', 'SAV*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1|%2|%3', 'AV03-*', 'AVS*', 'SAV*');
                DVATOrg.SetFilter("Document Type", '%1', DVATOrg."Document Type"::"Credit Memo");
                DVATOrg.SETFILTER(Type, '%1', DVATOrg.Type::Sale);
                DVATOrg.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                //  DVATOrg.SetFilter("VAT Entry No.", '%1', VATEOrg."Entry No.");
                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);

                    DVATTemp.INIT;
                    DVATTemp.TRANSFERFIELDS(DVATOrg);
                    DVATTemp."VAT Entry No." := VATEOrg."Entry No.";
                    DVATTemp."Document No." := VATTemp."Document No.";
                    DVATTemp.INSERT;
                END;

            END;

        end;
        //kraj
        //dodati samo za storrno domaćinstvo

        ExistingFilter := DataItem1.GETFILTER("Document No.");

        CleanFilter := '';

        if ExistingFilter <> '' then begin
            CleanFilter := '';
            StartPos := 1;
            while ExistingFilter <> '' do begin
                NextPos := STRPOS(ExistingFilter, '|');
                if NextPos = 0 then begin
                    FilterPart := ExistingFilter;
                    ExistingFilter := '';
                end else begin
                    FilterPart := COPYSTR(ExistingFilter, 1, NextPos - 1);
                    ExistingFilter := COPYSTR(ExistingFilter, NextPos + 1);
                end;
                // Ako NE počinje sa "03", zadrži ga
                if (COPYSTR(FilterPart, 1, 3) = '08-') then begin
                    if CleanFilter = '' then
                        CleanFilter := FilterPart
                    else
                        CleanFilter := STRSUBSTNO('%1|%2', CleanFilter, FilterPart);
                end;
            end;
            FilterIndex += 1;

        end;


        VATEOrg.RESET;
        VATEOrg.COPYFILTERS(DataItem1);
        VATEOrg.SETFILTER("VAT Prod. Posting Group", '<>%1', 'PDV NE');
        if CleanFilter <> '' then
            VATEOrg.SetFilter("Document No.", '%1|%2', '08-*', CleanFilter)
        else
            VATEOrg.SetFilter("Document No.", '%1', '08-*');
        IF VATEOrg.FindFirst() then begin
            VATEOrg.CalcSums(Base, Amount, "Unrealized Amount", "Unrealized Base", "Remaining Unrealized Amount", "Remaining Unrealized Base", "Remaining Unrealized Amount");

            Broj2 += 1;
            Progress.UPDATE(1, ROUND(Broj2));
            Progress.UPDATE(2, CurrentDateT);
            VATTemp.RESET;
            if CleanFilter <> '' then
                VATTemp.SetFilter("Document No.", '%1|%2', '08-*', CleanFilter)
            else
                VATTemp.SETFILTER("Document No.", '%1', '08-*');
            IF VATTemp.FINDFIRST THEN BEGIN
                // VATEOrg.CalcSums(Base,Amount,"Unrealized Amount","Unrealized Base", "Remaining Unrealized Amount","Remaining Unrealized Base","Remaining Unrealized Amount");
                VATTemp.Base := VATEOrg.Base;
                VATTemp.Amount := VATEOrg.Amount;
                VATTemp."Unrealized Amount" := VATEOrg."Unrealized Amount";
                VATTemp."Unrealized Base" := VATEOrg."Unrealized Base";
                VATTemp."Remaining Unrealized Amount" := VATEOrg."Remaining Unrealized Amount";
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni storno CNG';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi CNG';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno CNG';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi CNG';



                VATTemp."Remaining Unrealized Base" := VATEOrg."Remaining Unrealized Base";

                VATTemp."Remaining Unrealized Amount" := VATEOrg.Amount;
                VATTemp.MODIFY;


                DVATOrg.RESET;
                if CleanFilter <> '' then
                    DVATOrg.SetFilter("Document No.", '%1|%2', '08-*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1', '08-*');
                //  DVATOrg.SetFilter("VAT Entry No.", '%1', VATEOrg."Entry No.");
                DVATOrg.SetFilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATTemp.RESET;
                    if CleanFilter <> '' then
                        DVATTemp.SetFilter("Document No.", '%1|%2', '08-*', CleanFilter)
                    else
                        DVATTemp.SETFILTER("Document No.", '%1', '08-*');
                    DVATTemp.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                    IF DVATTemp.FINDFIRST THEN BEGIN
                        DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);
                        DVATTemp.Column1 := DVATOrg.Column1;
                        DVATTemp.Column2 := DVATOrg.Column2;
                        DVATTemp.Column3 := DVATOrg.Column3;
                        DVATTemp.Column4 := DVATOrg.Column4;
                        DVATTemp.Column5 := DVATOrg.Column5;
                        DVATTemp.Column6 := DVATOrg.Column6;
                        DVATTemp.Column7 := DVATOrg.Column7;
                        DVATTemp.Column8 := DVATOrg.Column8;
                        DVATTemp.Column9 := DVATOrg.Column9;
                        DVATTemp.Column10 := DVATOrg.Column10;
                        DVATTemp."VAT retro" := DVATOrg."VAT retro";
                        DVATTemp."Amount retro" := DVATOrg."Amount retro";

                        DVATTemp.MODIFY;
                    END;
                END;


            END
            ELSE BEGIN
                VATTemp.INIT;
                VATTemp.TRANSFERFIELDS(VATEOrg);
                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni storno CNG';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = false) then
                    VATTemp."Document No." := 'Zbirni računi CNG';

                if (VATTemp."Document Type" = VATTemp."Document Type"::"Credit Memo") and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni storno A.CNG';


                if (VATTemp."Document Type" = VATTemp."Document Type"::Invoice) and (VATTemp.Prepayment = true) then
                    VATTemp."Document No." := 'Zbirni avansi CNG';

                VATTemp.INSERT;
                DVATOrg.RESET;
                //  DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                if CleanFilter <> '' then
                    DVATOrg.SetFilter("Document No.", '%1|%2', '08-*', CleanFilter)
                else
                    DVATOrg.SetFilter("Document No.", '%1', '08-*');
                DVATOrg.SETFILTER(Type, '%1', DVATOrg.Type::Sale);
                // DVATOrg.SetFilter("VAT Entry No.", '%1', VATEOrg."Entry No.");
                DVATOrg.setfilter("VAT Date", DataItem1.GETFILTER("VAT Date"));
                IF DVATOrg.FINDFIRST THEN BEGIN
                    DVATOrg.CalcSums(Column1, Column2, Column3, Column4, Column5, Column6, Column7, Column8, Column9, Column10);
                    DVATTemp.INIT;
                    DVATTemp.TRANSFERFIELDS(DVATOrg);
                    DVATTemp."VAT Entry No." := VATEOrg."Entry No.";
                    DVATTemp."Document No." := VATTemp."Document No.";
                    DVATTemp.INSERT;
                END;

            END;

        end;
        //kraj NN


        DataItem1.DELETEALL;
        DataItem2.DELETEALL;
        VATTemp.RESET;
        IF VATTemp.FINDSET THEN
            REPEAT
                DataItem1.INIT;
                DataItem1.TRANSFERFIELDS(VATTemp);

                DataItem1.INSERT;
            UNTIL VATTemp.NEXT = 0;


        DVATTemp.RESET;
        IF DVATTemp.FINDSET THEN
            REPEAT
                DataItem2.INIT;
                DataItem2.TRANSFERFIELDS(DVATTemp);

                DataItem2.INSERT;
            UNTIL DVATTemp.NEXT = 0;


        IF EXISTS(Comp."Path value" + 'TestFile.csv') THEN
            ERASE(Comp."Path value" + 'TestFile.csv');

        FileDoc.CREATE(Comp."Path value" + 'TestFile.csv', TEXTENCODING::UTF8);
        FIleName := Comp."Path value" + 'TestFile.csv';

        FileDoc.CREATEOUTSTREAM(OutStreamObj);

        //vrsta sloga
        Zaglavlje := Zaglavlje + '1;';
        Comp.GET;

        //PDV broj obveznika koji podnosi datoteku
        Zaglavlje := Zaglavlje + Comp."VAT Registration No." + ';';

        PorezniPeriod := DataItem1.GETFILTER("VAT Date");
        IF PorezniPeriod = '' THEN
            ERROR('Porezni period mora biti unesen');
        IF COPYSTR(PorezniPeriod, 1, 2) <> '..' THEN BEGIN
            PorezniPeriod2 := PorezniPeriod;
            IF STRPOS(PorezniPeriod2, '..') <> 0 THEN
                PorezniPeriod := COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..'));
            EVALUATE(StartDate, COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..')));

            //1.1.2019..31.12.2019


            PorezniPeriod := COPYSTR(PorezniPeriod2, 7, 2);
            PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
            EVALUATE(EndDate, COPYSTR(PorezniPeriod2, STRPOS(PorezniPeriod2, '..') + 2, STRLEN(PorezniPeriod2)));



        END
        ELSE BEGIN
            PorezniPeriod := DELCHR(PorezniPeriod2, '=', '..');
            PorezniPeriod := COPYSTR(PorezniPeriod2, 4, 2);
            PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
            StartDate := 0D;
            EVALUATE(EndDate, COPYSTR(PorezniPeriod2, STRPOS(PorezniPeriod2, '..') + 2, STRLEN(PorezniPeriod)));

        END;

        Zaglavlje := Zaglavlje + PorezniPeriod + ';';

        Zaglavlje := Zaglavlje + '2;';

        Zaglavlje := Zaglavlje + '01;';
        Datum2 := FORMAT(WORKDATE, 0, '<Day,2>.<Month,2>.<Year,4>');//11.03.2020
                                                                    //EVALUATE(Datum,Datum2);

        //Zaglavlje:=Zaglavlje+COPYSTR(Datum2,7,4)+'-'+COPYSTR(Datum2,4,2)+'-'+COPYSTR(Datum2,1,2)+';';
        Zaglavlje := Zaglavlje + FORMAT(WORKDATE, 10, '<Year4>-<Month,2>-<Day,2>') + ';';
        Zaglavlje := Zaglavlje + FORMAT(TIME);





        OutStreamObj.WRITETEXT(Zaglavlje);
        OutStreamObj.WRITETEXT();
        BrojRedova := BrojRedova + 1;

    end;

    var

        FileDoc: File;
        FIleName: Text;
        Progress: Dialog;
        Zaglavlje: Text;
        Broj2: Integer;
        NewLine: Char;
        OutStreamObj: OutStream;
        PorezniPeriod: Text;
        VatEntryUpdate: Record "VAT Entry";
        Type2: Option "DOMAĆI",INO,AVANSI;
        PorezniPeriod2: Text;
        Brojac: Integer;
        Comp: Record "Company Information";
        Datum: Date;
        Datum2: Text;
        Vendor: Record Customer;
        CustomerReal: Record Vendor;
        VatEntryReverse: Record "VAT Entry";
        Rezultat: Text;
        SumaRed: Integer;
        fullvat2db: Decimal;
        ve14: Record "VAT Entry";
        Res: Decimal;
        Total1: Decimal;
        ve20: Record "VAT Entry";
        VATEOrg: Record "VAT Entry";
        DVATOrg: Record "Detailed VAT Entry";
        Redni: Integer;
        VATTemp: Record "VAT Entry" temporary;
        IDOd: Integer;
        DVATTemp: Record "Detailed VAT Entry" temporary;
        VATOrg2: Record "VAT Entry";
        c5: Decimal;
        c6: Decimal;
        Total71: Decimal;
        Total81: Decimal;
        PorezniOdDate: Date;
        Column711: Decimal;
        WorkType: Record "Types Of Diseases";
        Column811: Decimal;
        ve15: Record "VAT Entry";
        ve23: Record "VAT Entry";
        ve22: Record "VAT Entry";
        ve13: Record "VAT Entry";
        ve16: Record "VAT Entry";
        Column7: Decimal;
        Column8: Decimal;
        TotalRecNo: Integer;
        StartDaT: Time;
        CurrentDateT: Time;
        DetailedVATEntry: Record "Detailed VAT Entry";
        c9: Decimal;
        ve21: Record "VAT Entry";
        Total2: Decimal;
        Total3: Decimal;
        Total4: Decimal;
        c3: Decimal;
        fullvat2rs: Decimal;
        c4: Decimal;
        c7: Decimal;
        Total5: Decimal;
        Total6: Decimal;
        Total7: Decimal;
        fullvat2: Decimal;
        Total8: Decimal;
        Total9: Decimal;
        Total10: Decimal;
        BrojRedova: Integer;
        FileManagement: Codeunit "File Management";
        VendorLedgerEntry: Record "Cust. Ledger Entry";
        CompIn: Record "Company Information";
        Vendorr: Record Customer;
        TipDokumenta: Text;
        ve10: Record "VAT Entry";
        StartDate: Date;
        EndDate: Date;
        c0: Decimal;
        ve11: Record "VAT Entry";
        StartPos: Integer;
        NextPos: Integer;
        c1: Decimal;
        ve12: Record "VAT Entry";
        TempFilter: text;
        c2: Decimal;
        ve17: Record "VAT Entry";
        c8: Decimal;
        ve19: Record "VAT Entry";
        ve24: Record "VAT Entry";
        c20: Decimal;

    procedure Replace(InsertValue: Decimal) ResultValue: Text
    begin
        Rezultat := FORMAT(InsertValue, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>');
        //1.053,51
        Rezultat := DELCHR(Rezultat, '=', '.');
        Rezultat := CONVERTSTR(Rezultat, ',', '.');

        EXIT(Rezultat);
    end;
}

