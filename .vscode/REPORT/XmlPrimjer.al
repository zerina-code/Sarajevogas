xmlport 50032 "Import VP and KJKP xml"
{
    Direction = Import;
    FieldDelimiter = '<None>';
    FieldSeparator = '<TAB>';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'MM Import';
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement("Calculation Journal Line"; "Calculation Journal Line")
            {
                AutoSave = false;
                MinOccurs = Zero;
                XmlName = 'Calculation_Journal_Line';
                UseTemporary = false;
                textelement(Text12_1_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_2_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_3_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_4_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_5_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_6_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_7_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_8_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_9_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_10_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_11_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_12_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_13_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_14_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_15_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_16_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_17_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_18_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_19_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_20_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_21_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_22_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_23_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_24_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_25_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_26_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_27_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_28_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_29_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_30_)
                {
                    MinOccurs = Zero;
                }
                textelement(Text12_31_)
                {
                    MinOccurs = Zero;
                }

                textelement(Text12_32_)
                {
                    MinOccurs = Zero;
                }





























                trigger OnAfterInsertRecord()
                var
                    CalJ: Record "Calculation Journal Line";
                    MobI: Integer;
                begin

                    Progress.OPEN('Preuzimanje podataka #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT));
                    //  Progress.UPDATE(1, 0);
                    // Progress.UPDATE(2, 0);
                    Linija += 1;

                    if Linija <> 1 then begin


                        CH.Reset();
                        CH.SetFilter(Status, '%1', CH.Status::Open);
                        ch.SetFilter(Code, '%1', Billing_Code);
                        //  CH.SetFilter("Category Calculation", '%1|%2', CH."Category Calculation"::"Large Economy", CH."Category Calculation"::"KJKP Heating plant");
                        if CH.FindFirst() then begin
                            calcJ.reset;
                            calcJ.SetFilter(Code, '%1', CH.Code);
                            //  calcJ.SetFilter("Proceedings No.", '%1', Text12_1_);
                            /*   if copystr(Text12_2_, 1, 1) = '0' then
                                   calcJ.SetFilter("Customer No.", '%1', copystr(Text12_2_, 2, StrLen(Text12_2_)))
                               else
                                   calcJ.SetFilter("Customer No.", '%1', Text12_2_);*/

                            Text12_2_ := DelChr(Text12_2_, '<', '0');
                            Text12_2_ := DelChr(Text12_2_, '<', '0');
                            Text12_2_ := DelChr(Text12_2_, '<', '0');
                            Text12_2_ := DelChr(Text12_2_, '<', '0');
                            Text12_2_ := DelChr(Text12_2_, '<', '0');
                            Text12_2_ := DelChr(Text12_2_, '<', '0');
                            calcJ.SetFilter("Customer No.", '%1', Text12_2_);



                            Text12_4_ := DelChr(Text12_4_, '<', '0');
                            Text12_4_ := DelChr(Text12_4_, '<', '0');
                            Text12_4_ := DelChr(Text12_4_, '<', '0');
                            Text12_4_ := DelChr(Text12_4_, '<', '0');
                            Text12_4_ := DelChr(Text12_4_, '<', '0');
                            Text12_4_ := DelChr(Text12_4_, '<', '0');

                            calcJ.SetFilter("Measuring Point Code", '%1', Text12_4_);

                            Evaluate(BrojM, Text12_12_);
                            calcJ.SetFilter("Old Gauge", '%1', false);
                            if calcJ.FindFirst() then begin

                                //ako ima kupca i po tom broju
                                if Text12_13_ = '' then
                                    MjeracRanije := 0
                                else
                                    Evaluate(MjeracRanije, Text12_13_);
                                // calcJ.Validate("Old Value", MjeracRanije);

                                if Text12_14_ = '' then
                                    MjeracRanijeDatum := 0D
                                else
                                    Evaluate(MjeracRanijeDatum, Text12_14_);



                                // calcJ.Validate("Previous Date", MjeracRanijeDatum);
                                DateV := 0DT;

                                if (text12_25_ = '') or (text12_25_ = '1.1.1900  00:00:00')
                                or (strpos(text12_25_, '01.01.1900') <> 0)
                                 then begin

                                    if not Evaluate(dateV, text12_22_)
                                    then
                                        DateV := 0DT;
                                end
                                else begin
                                    Evaluate(dateV, text12_25_);

                                end;
                                calcJ.validate(Date, DateV);
                                //ovdje je uzeo datum

                                Text12_15_ := Replacestring_T(Text12_15_, '.', ',');

                                if Text12_15_ = '' then
                                    MjeracTempRanije := 0
                                else
                                    Evaluate(MjeracTempRanije, Text12_15_);
                                //  calcJ.Validate("Temperature previous - gauge", MjeracTempRanije);

                                Text12_16_ := Replacestring_T(Text12_16_, '.', ',');

                                if Text12_16_ = '' then
                                    MjeracPritisakRanije := 0
                                else
                                    Evaluate(MjeracPritisakRanije, Text12_16_);

                                //   calcJ.Validate("Pressure previous - gauge", MjeracPritisakRanije);

                                if Text12_19_ = '' then
                                    KorektorRanije := 0
                                else
                                    Evaluate(KorektorRanije, Text12_19_);

                                calcJ."Source Data" := SourceR;


                                // calcJ.Validate("UnCorrection previous - gauge", KorektorRanije);


                                if Text12_20_ = '' then
                                    KorigovanoRanije := 0
                                else
                                    Evaluate(KorigovanoRanije, Text12_20_);
                                //     calcJ.Validate("Correction previous - gauge", KorigovanoRanije);

                                Text12_29_ := Replacestring_T(Text12_29_, '.', ',');


                                if Text12_29_ = '' then
                                    KorigovanoRanije := 0
                                else
                                    Evaluate(KorigovanoRanije, Text12_29_);
                                calcJ.Validate("Temperature new- gauge", KorigovanoRanije);
                                Text12_30_ := Replacestring_T(Text12_30_, '.', ',');

                                if Text12_30_ = '' then
                                    KorigovanoRanije := 0
                                else
                                    Evaluate(KorigovanoRanije, Text12_30_);
                                calcJ.Validate("Pressure new- gauge", KorigovanoRanije);

                                Text12_31_ := Replacestring_T(Text12_31_, '.', ',');


                                if Text12_31_ = '' then
                                    KorigovanoRanije := 0
                                else
                                    Evaluate(KorigovanoRanije, Text12_31_);
                                calcJ.Validate("Temperature Correction", KorigovanoRanije);

                                Text12_32_ := Replacestring_T(Text12_32_, '.', ',');


                                if Text12_32_ = '' then
                                    KorigovanoRanije := 0
                                else
                                    Evaluate(KorigovanoRanije, Text12_32_);
                                calcJ.Validate("Pressure Correction", KorigovanoRanije);




                                DateFixTime := 0DT;
                                DateFix := 0D;
                                DateNew := 0D;

                                if Evaluate(DateFixTime, text12_25_) then begin
                                    DateFix := dt2date(DateFixTime);
                                    if not Evaluate(DateNew, text12_22_) then
                                        DateNew := 0D
                                    else
                                        Evaluate(DateNew, text12_22_);
                                end;
                                if calcJ."Month Of GAS Calculation" = 12 then
                                    DateControl := DMY2Date(01, 01, calcJ."Year Of GAS Calculation" + 1)
                                else
                                    DateControl := DMY2Date(01, calcJ."Month Of GAS Calculation" + 1, calcJ."Year Of GAS Calculation");
                                if (DateFix < DateControl) or (DateFix > calcdate('<+1M>', calcJ."Calculation Date To")) then begin
                                    Text12_26_ := '';
                                end;
                                if Evaluate(ValueFix, Text12_26_) then;
                                if Evaluate(ValueNew, Text12_24_) then;
                                if ValueFix - calcJ."Old Value" < 0 then
                                    Text12_26_ := '';



                                if Text12_26_ = '' then begin

                                    NovoStanjeM := 0;
                                    if Text12_24_ = '' then
                                        NovoStanjeM := 0
                                    else
                                        Evaluate(NovoStanjeM, Text12_24_);

                                end

                                else begin
                                    if Text12_26_ = '0' then
                                        Evaluate(NovoStanjeM, Text12_24_)
                                    else
                                        Evaluate(NovoStanjeM, Text12_26_);

                                end;

                                calcJ.Validate("New Value", NovoStanjeM);


                                if Text12_27_ = '' then
                                    NovoKorigovanoS := 0
                                else
                                    Evaluate(NovoKorigovanoS, Text12_27_);
                                calcJ.Validate("UnCorrection new- gauge", NovoKorigovanoS);


                                if Text12_28_ = '' then
                                    NovoKorigovanoS := 0
                                else
                                    Evaluate(NovoKorigovanoS, Text12_28_);
                                calcJ.Validate("Correction new- gauge", NovoKorigovanoS);






                                //UnCorrection new - gauge
                                calcJ.Difference := calcJ."New Value" - calcJ."Old Value";

                                calcJ.Modify();
                                CurrRecNo += 1;
                                CurrentDateT := time;
                                Progress.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                                //  Progress.UPDATE(2, CurrentDateT);



                            end
                            else begin
                                unkE.Reset();
                                unkE.SetFilter(code, '%1', CH.Code);

                                Text12_2_ := DelChr(Text12_2_, '<', '0');
                                Text12_2_ := DelChr(Text12_2_, '<', '0');
                                Text12_2_ := DelChr(Text12_2_, '<', '0');
                                Text12_2_ := DelChr(Text12_2_, '<', '0');
                                Text12_2_ := DelChr(Text12_2_, '<', '0');
                                Text12_2_ := DelChr(Text12_2_, '<', '0');
                                unkE.SetFilter("Customer No.", '%1', Text12_2_);
                                CustomerFind := Text12_2_;
                                Text12_4_ := DelChr(Text12_2_, '<', '0');
                                Text12_4_ := DelChr(Text12_2_, '<', '0');
                                Text12_4_ := DelChr(Text12_2_, '<', '0');
                                Text12_4_ := DelChr(Text12_2_, '<', '0');
                                Text12_4_ := DelChr(Text12_2_, '<', '0');
                                Text12_4_ := DelChr(Text12_2_, '<', '0');



                                unkE.SetFilter("Measuring Point Code", '%1', Text12_4_);

                                Evaluate(BrojM, Text12_12_);

                                if not unkE.FindFirst() then begin

                                    //SifraKupca

                                    unk.Init();
                                    AutoIn2 += 1;
                                    unk.Autoin := AutoIn2;
                                    unk.Code := ch.Code;
                                    unk.Validate("Source Data", SourceR);
                                    unk."Serial Number" := BrojM;
                                    unk."Proceedings No." := Text12_1_;
                                    if "Calculation Journal Line"."Calculation Date From" <> 0D then
                                        unk."Calculation Date From" := "Calculation Journal Line"."Calculation Date From"
                                    else
                                        unk."Calculation Date From" := ch."Calculation Date From";

                                    if "Calculation Journal Line"."Calculation Date To" <> 0D then
                                        unk."Calculation Date To" := "Calculation Journal Line"."Calculation Date To"
                                    else
                                        unk."Calculation Date To" := ch."Calculation Date To";

                                    unk."Year of Calculation" := ch."Year of Calculation";
                                    unk."Month of Calculation" := ch."Month of Calculation";
                                    unk."Year Of GAS Calculation" := ch."Year Of GAS Calculation";
                                    unk."Month Of GAS Calculation" := ch."Month Of GAS Calculation";
                                    if copystr(Text12_2_, 1, 1) = '0' then
                                        unk."Customer No." := copystr(Text12_2_, 2, StrLen(Text12_2_))
                                    else
                                        unk."Customer No." := Text12_2_;

                                    /*   if copystr(Text12_4_, 1, 1) = '0' then
                                           unk."Measuring Point Code" := copystr(Text12_4_, 2, StrLen(text12_4_))
                                       else
                                           unk."Measuring Point Code" := Text12_4_;*/



                                    Evaluate(BrojM, Text12_12_);
                                    unk."Serial Number" := BrojM;


                                    if Text12_13_ = '' then
                                        MjeracRanije := 0
                                    else
                                        Evaluate(MjeracRanije, Text12_13_);
                                    //     unk.Validate("Old Value", MjeracRanije);

                                    if Text12_14_ = '' then
                                        MjeracRanijeDatum := 0D
                                    else
                                        Evaluate(MjeracRanijeDatum, Text12_14_);
                                    //  unk.Validate("Previous Date", MjeracRanijeDatum);


                                    if text12_25_ = '' then
                                        DateV := 0DT
                                    else
                                        Evaluate(dateV, text12_25_);
                                    calcJ.validate(Date, DateV);


                                    Text12_15_ := Replacestring_T(Text12_15_, '.', ',');
                                    if Text12_15_ = '' then
                                        MjeracTempRanije := 0
                                    else
                                        Evaluate(MjeracTempRanije, Text12_15_);
                                    //   unk.Validate("Temperature previous - gauge", MjeracTempRanije);

                                    Text12_16_ := Replacestring_T(Text12_16_, '.', ',');
                                    if Text12_16_ = '' then
                                        MjeracPritisakRanije := 0
                                    else
                                        Evaluate(MjeracPritisakRanije, Text12_16_);
                                    //  unk.Validate("Pressure previous - gauge", MjeracPritisakRanije);
                                    ///
                                    if Text12_19_ = '' then
                                        KorektorRanije := 0
                                    else
                                        Evaluate(KorektorRanije, Text12_19_);



                                    //     unk.Validate("UnCorrection previous - gauge", KorektorRanije);
                                    //


                                    /*   if Text12_20_ = '' then
                                           KorigovanoRanije := 0
                                       else
                                           Evaluate(KorigovanoRanije, Text12_20_);*/
                                    //  unk.Validate("Correction previous - gauge", KorektorRanije);

                                    if Text12_20_ = '' then
                                        KorigovanoRanije := 0
                                    else
                                        Evaluate(KorigovanoRanije, Text12_20_);
                                    //   unk.Validate("Correction previous - gauge", KorigovanoRanije);

                                    if Text12_28_ = '' then
                                        NovoKorigovanoS := 0
                                    else
                                        Evaluate(NovoKorigovanoS, Text12_28_);
                                    calcJ.Validate("Correction new- gauge", NovoKorigovanoS);
                                    Text12_29_ := Replacestring_T(Text12_29_, '.', ',');


                                    if Text12_29_ = '' then
                                        KorigovanoRanije := 0
                                    else
                                        Evaluate(KorigovanoRanije, Text12_29_);
                                    unk.Validate("Temperature new- gauge", KorigovanoRanije);
                                    Text12_30_ := Replacestring_T(Text12_30_, '.', ',');

                                    if Text12_30_ = '' then
                                        KorigovanoRanije := 0
                                    else
                                        Evaluate(KorigovanoRanije, Text12_30_);
                                    unk.Validate("Pressure new- gauge", KorigovanoRanije);

                                    Text12_31_ := Replacestring_T(Text12_31_, '.', ',');

                                    if Text12_31_ = '' then
                                        KorigovanoRanije := 0
                                    else
                                        Evaluate(KorigovanoRanije, Text12_31_);
                                    unk.Validate("Temperature Correction", KorigovanoRanije);
                                    Text12_32_ := Replacestring_T(Text12_32_, '.', ',');

                                    if Text12_32_ = '' then
                                        KorigovanoRanije := 0
                                    else
                                        Evaluate(KorigovanoRanije, Text12_32_);
                                    unk.Validate("Pressure Correction", KorigovanoRanije);


                                    //đemina dodala zbog logike 
                                    /*1. Datum fiksnog ako nije u okviru očitanja ovog mjeseca. (prvi u narednom, samo za daljinsko i samo za fiksno)
 2. Ako je razlika između fiksnog i starog manja od 0., onda uzeti novo stanje (tekuće)
 3. Ako je fiksno 0, uvijek ide tekuće
 4. */
                                    DateFixTime := 0DT;
                                    DateFix := 0D;
                                    DateNew := 0D;



                                    if Evaluate(DateFixTime, text12_25_) then begin
                                        DateFix := dt2date(DateFixTime);
                                        if not Evaluate(DateNew, text12_22_) then
                                            DateNew := 0D
                                        else
                                            Evaluate(DateNew, text12_22_);
                                    end;
                                    if calcJ."Month Of GAS Calculation" = 12 then
                                        DateControl := DMY2Date(01, 01, calcJ."Year Of GAS Calculation" + 1)
                                    else
                                        DateControl := DMY2Date(01, calcJ."Month Of GAS Calculation" + 1, calcJ."Year Of GAS Calculation");


                                    if calcJ."Calculation Date To" = 0D then
                                        calcJ."Calculation Date To" := ch."Calculation Date To";


                                    if (DateFix < DateControl) or (DateFix > calcdate('<+1M>', calcJ."Calculation Date To")) then begin


                                        Text12_26_ := '';
                                    end;


                                    if Evaluate(ValueFix, Text12_26_) then;
                                    if Evaluate(ValueNew, Text12_24_) then;
                                    if ValueFix - calcJ."Old Value" < 0 then
                                        Text12_26_ := '';


                                    if Text12_26_ = '' then begin
                                        NovoStanjeM := 0;
                                        if Text12_24_ = '' then
                                            NovoStanjeM := 0
                                        else
                                            Evaluate(NovoStanjeM, Text12_24_);

                                    end

                                    else begin
                                        Evaluate(NovoStanjeM, Text12_26_);

                                    end;
                                    unk.Validate("New Value", NovoStanjeM);

                                    if Text12_27_ = '' then
                                        NovoKorigovanoS := 0
                                    else
                                        Evaluate(NovoKorigovanoS, Text12_27_);
                                    unk.Validate("Correction new- gauge", NovoKorigovanoS);

                                    CurrRecNo += 1;
                                    CurrentDateT := time;
                                    Progress.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                                    //      Progress.UPDATE(2, CurrentDateT);
                                    CustomerCateg.Reset();
                                    CustomerCateg.SetFilter("No.", '%1', customerfind);
                                    if CustomerCateg.findfirst then begin
                                        if (CustomerCateg."Customer Category" = ch."Category Calculation") and (ch."All Customer" = false) then
                                            unk.Insert();
                                        if ch."All Customer" = true then
                                            unk.Insert();
                                    end
                                    else begin
                                        unk.Insert();
                                    end;

                                end;


                            end;



                        end;

                        //




                    end;


                    Progress.close();



                    //  IF GUIALLOWED THEN
                    //    Window.UPDATE;

                END;








            }
        }
    }


    requestpage
    {

        layout
        {
            area(content)
            {

                field(SourceR; SourceR)
                {
                    Caption = 'Source';
                }

            }
        }


    }

    trigger OnPreXmlPort()
    begin
        Linija := 0;
        UnkBroj.reset;
        UnkBroj.setcurrentkey(Autoin);
        UnkBroj.ascending;
        if unkbroj.findlast then
            AutoIn2 := UnkBroj.Autoin
        else
            AutoIn2 := 0;

        StartDaT := Time;
        Gauge2.Reset();
        Gauge2.setfilter("Code", '%1', Billing_Code);
        // Gauge2.CopyFilters(Rec);
        if Gauge2.FindFirst() then
            TotalRecNo := Gauge2.COUNTAPPROX;


    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
        Cust: Record Customer;
    begin

    end;



    procedure SetParam2(No_Bill: code[20])
    begin
        Billing_Code := No_Bill;
    end;

    procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;



    var
        BrojM: code[20];
        MjeracRanije: Decimal;
        MjeracRanijeDatum: Date;
        MjeracTempRanije: Decimal;
        MjeracPritisakRanije: Decimal;
        AutoIn2: Integer;
        UnkBroj: Record "Unknown data";
        TotalRecNo: integeR;
        KorektorRanije: Decimal;
        KorigovanoRanije: Decimal;
        NovoStanjeM: Decimal;
        NovoStanjeKore: Decimal;
        NovoKorigovanoS: Decimal;
        TempMjer: Decimal;
        TempKorek: Decimal;
        PritisakMj: Decimal;
        PritisakKo: Decimal;
        DateV: DateTime;
        Progress: Dialog;
        CurrRecNo: Integer;
        StartDaT: Time;
        CurrentDateT: Time;
        Gauge2: Record "Calculation Journal Line";
        Billing_Code: code[20];
        CustomerCateg: Record Customer;
        TempFile: File;
        PrviDIo: Integer;
        CustomerFind: code[20];
        calcJ: Record "Calculation Journal Line";
        CH: Record "Calcuation Header";
        CHChekc: record "Calcuation Header";
        DrugiDio: Integer;
        Dalje: Text[250];
        Dalje2: Text[250];
        Charr: Char;
        RedTransakcije: Text;
        Linija: Integer;
        FileName: Text;
        Selected: Option " ","Unicredit","Skrbništvo","Union","Zirat";
        Proceed: Boolean;
        DataFile: File;
        Brojac: Integer;
        Window: Dialog;
        Proc: Integer;
        Nal1: Text[250];
        Nal2: Text[250];
        Indikator: Text[250];
        Nal3: Text[250];
        Nal4: Text[250];
        Mjesec: Integer;
        Godina: Integer;
        Dan: Integer;
        Mjesec2: Integer;
        unk: Record "Unknown data";
        unkE: Record "Unknown data";
        Godina2: Integer;
        Dan2: Integer;
        StreamInTest: InStream;
        DataLine: Text;
        File1: File;
        BrojRacun: Text;
        PostDate: Date;
        OutStreamObj: OutStream;
        VrstaPrihoda: Text;
        ReceiversBankAccount: Text;
        AmountText: Text;
        Amount3: Decimal;
        DebitYesNo: Text;
        Amount2: Decimal;
        PoreskiBroj: Text;
        GenJournalBatch: Record "Gen. Journal Batch";
        Proturacun: Text;
        Postt: Text;
        AmountText2: Text;
        Organizacija: Text;
        Opstina: Text;
        Spacee: Integer;
        NoviSlash: Integer;
        PaymentBasisCode: Text;
        Slash: Integer;
        DateeeFrom: Text;
        SourceR: enum "Import Data";
        DateeeTo: Text;
        UplataNa: Text;
        RacunBr: Text;
        UplataNaRacun: Text;
        Purpose: Text;
        TekstualniDio: Text;
        MoneyOrderMadeBy: Text;
        NextText: Text;
        NextText2: Text;
        CreditBankAccountNo: Text;
        BankAccNo: Text;
        FirstLine: Boolean;
        PDateDay: Integer;
        PDateMonth: Integer;
        PozivNaBroj: Text;
        PDateYear: Integer;
        PostingDate: Date;
        PaymentLine: Record "Gen. Journal Line";
        CustomerRecord: Record "Customer";
        VendorRecord: Record "Vendor";
        CustomerBankAccount: Record "Customer Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
        PaymentLine2: Record "Gen. Journal Line";
        CurenceCode: Text;
        DatePre: Text;
        Sep: Decimal;
        TabDa: Boolean;
        JournalPre: Text;
        I: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        Text005: Label 'Please select a valid File name first!';
        Text040: Label 'Xml file(*.xml)|*.xml|Text file(*.txt)|*.txt';
        Text000: Label 'Import File';
        Text004: Label 'Importing Data from file #1';
        DateFix: Date;
        DateFixTime: DateTime;
        DateControl: Date;
        DateNew: Date;
        ValueFix: Decimal;
        ValueNew: Decimal;

}

