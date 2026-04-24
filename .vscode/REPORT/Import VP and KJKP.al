/*report 50123 "IMPORT VP"
{
    ProcessingOnly = true;
    //  UseRequestPage = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'IMPORT VP';

    dataset
    {
    }

xmlp
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



    labels
    {
    }

    trigger OnPostReport()
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
    begin
        
        StartDaT := Time;
        Gauge2.Reset();
        Gauge2.setfilter("Code", '%1', Billing_Code);
        // Gauge2.CopyFilters(Rec);
        if Gauge2.FindFirst() then
            TotalRecNo := Gauge2.COUNTAPPROX;

        Progress.OPEN('Preuzimanje podataka #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);

        Proceed := UPLOAD(Text000, '', Text040, '', FileName);

        IF NOT Proceed THEN
            ERROR(Text005);

        IF FILE.EXISTS(FileName) THEN
            DataFile.OPEN(FileName, TextEncoding::utf8)
        ELSE
            ERROR(Text005);
        Brojac := 1;

        //   IF GUIALLOWED THEN
        //     Window.OPEN(Text004, Proc);
        DataFile.TEXTMODE := TRUE;

        // DataFile.CLOSE;
        //  DataFile.OPEN(FileName, TextEncoding::utf8);
        //  TabDa := true;

        DataFile.CREATEINSTREAM(StreamInTest);

        UnkBroj.reset;
        UnkBroj.setcurrentkey(Autoin);
        UnkBroj.ascending;
        if unkbroj.findlast then
            AutoIn2 := UnkBroj.Autoin
        else
            AutoIn2 := 0;


        WHILE NOT StreamInTest.EOS DO BEGIN
            StreamInTest.ReadText(DataLine);
            Linija += 1;

            if Linija <> 1 then begin

                Charr := 9
                ;
                TabDa := true;
                if TabDa = true then begin
                    //DataLine
                    Text12[1] := Split(DataLine, Format(Charr));
                    Text12[2] := Split(DataLine, Format(Charr));
                    Text12[3] := Split(DataLine, Format(Charr));
                    Text12[4] := Split(DataLine, Format(Charr));
                    Text12[5] := Split(DataLine, Format(Charr));
                    Text12[6] := Split(DataLine, Format(Charr));
                    Text12[7] := Split(DataLine, Format(Charr));
                    Text12[8] := Split(DataLine, Format(Charr));
                    Text12[9] := Split(DataLine, Format(Charr));
                    Text12[10] := Split(DataLine, Format(Charr));
                    Text12[11] := Split(DataLine, Format(Charr));
                    Text12[12] := Split(DataLine, Format(Charr));


                    Text12[13] := Split(DataLine, Format(Charr));
                    Text12[14] := Split(DataLine, Format(Charr));
                    Text12[15] := Split(DataLine, Format(Charr));
                    Text12[16] := Split(DataLine, Format(Charr));
                    Text12[17] := Split(DataLine, Format(Charr));
                    Text12[18] := Split(DataLine, Format(Charr));
                    Text12[19] := Split(DataLine, Format(Charr));
                    Text12[20] := Split(DataLine, Format(Charr));
                    Text12[21] := Split(DataLine, Format(Charr));
                    Text12[22] := Split(DataLine, Format(Charr));
                    Text12[23] := Split(DataLine, Format(Charr));
                    Text12[24] := Split(DataLine, Format(Charr));
                    Text12[25] := Split(DataLine, Format(Charr));
                    Text12[26] := Split(DataLine, Format(Charr));
                    Text12[27] := Split(DataLine, Format(Charr));



                    CH.Reset();
                    CH.SetFilter(Status, '%1', CH.Status::Open);
                    ch.SetFilter(Code, '%1', Billing_Code);
                    //  CH.SetFilter("Category Calculation", '%1|%2', CH."Category Calculation"::"Large Economy", CH."Category Calculation"::"KJKP Heating plant");
                    if CH.FindFirst() then begin
                        calcJ.reset;
                        calcJ.SetFilter(Code, '%1', CH.Code);
                        //  calcJ.SetFilter("Proceedings No.", '%1', Text12[1]);
                      

                        Text12[2] := DelChr(Text12[2], '<', '0');
                        Text12[2] := DelChr(Text12[2], '<', '0');
                        Text12[2] := DelChr(Text12[2], '<', '0');
                        Text12[2] := DelChr(Text12[2], '<', '0');
                        Text12[2] := DelChr(Text12[2], '<', '0');
                        Text12[2] := DelChr(Text12[2], '<', '0');
                        calcJ.SetFilter("Customer No.", '%1', Text12[2]);



                        Text12[4] := DelChr(Text12[4], '<', '0');
                        Text12[4] := DelChr(Text12[2], '<', '0');
                        Text12[4] := DelChr(Text12[2], '<', '0');
                        Text12[4] := DelChr(Text12[2], '<', '0');
                        Text12[4] := DelChr(Text12[2], '<', '0');
                        Text12[4] := DelChr(Text12[2], '<', '0');

                        calcJ.SetFilter("Measuring Point Code", '%1', Text12[4]);

                        Evaluate(BrojM, Text12[12]);
                        if calcJ.FindFirst() then begin

                            //ako ima kupca i po tom broju
                            if Text12[13] = '' then
                                MjeracRanije := 0
                            else
                                Evaluate(MjeracRanije, Text12[13]);
                            calcJ.Validate("Old Value", MjeracRanije);

                            if Text12[14] = '' then
                                MjeracRanijeDatum := 0D
                            else
                                Evaluate(MjeracRanijeDatum, Text12[14]);



                            calcJ.Validate("Previous Date", MjeracRanijeDatum);

                            if text12[25] = '' then
                                DateV := 0DT
                            else
                                Evaluate(dateV, text12[25]);
                            calcJ.validate(Date, DateV);

                            if Text12[15] = '' then
                                MjeracTempRanije := 0
                            else
                                Evaluate(MjeracTempRanije, Text12[15]);
                            calcJ.Validate("Temperature previous - gauge", MjeracTempRanije);

                            if Text12[16] = '' then
                                MjeracPritisakRanije := 0
                            else
                                Evaluate(MjeracPritisakRanije, Text12[16]);
                            calcJ.Validate("Pressure previous - gauge", MjeracPritisakRanije);

                            if Text12[17] = '' then
                                KorektorRanije := 0
                            else
                                Evaluate(KorektorRanije, Text12[17]);

                            calcJ."Source Data" := SourceR;


                            calcJ.Validate("Temperature Correction", KorektorRanije);


                            if Text12[18] = '' then
                                KorigovanoRanije := 0
                            else
                                Evaluate(KorigovanoRanije, Text12[18]);
                            calcJ.Validate("Correction previous - gauge", KorektorRanije);




                            if Text12[26] = '' then begin
                                NovoStanjeM := 0;
                                if Text12[24] = '' then
                                    NovoStanjeM := 0
                                else
                                    Evaluate(NovoStanjeM, Text12[24]);

                            end

                            else begin
                                Evaluate(NovoStanjeM, Text12[26]);

                            end;

                            calcJ.Validate("New Value", NovoStanjeM);

                            if Text12[27] = '' then
                                NovoKorigovanoS := 0
                            else
                                Evaluate(NovoKorigovanoS, Text12[27]);
                            calcJ.Validate("Correction new- gauge", NovoKorigovanoS);
                            calcJ.Modify();
                            CurrRecNo += 1;
                            CurrentDateT := time;
                            Progress.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                            Progress.UPDATE(2, CurrentDateT);



                        end
                        else begin
                            unkE.Reset();
                            unkE.SetFilter(code, '%1', CH.Code);

                            Text12[2] := DelChr(Text12[2], '<', '0');
                            Text12[2] := DelChr(Text12[2], '<', '0');
                            Text12[2] := DelChr(Text12[2], '<', '0');
                            Text12[2] := DelChr(Text12[2], '<', '0');
                            Text12[2] := DelChr(Text12[2], '<', '0');
                            Text12[2] := DelChr(Text12[2], '<', '0');
                            unkE.SetFilter("Customer No.", '%1', Text12[2]);
                            CustomerFind := Text12[2];
                            Text12[4] := DelChr(Text12[2], '<', '0');
                            Text12[4] := DelChr(Text12[2], '<', '0');
                            Text12[4] := DelChr(Text12[2], '<', '0');
                            Text12[4] := DelChr(Text12[2], '<', '0');
                            Text12[4] := DelChr(Text12[2], '<', '0');
                            Text12[4] := DelChr(Text12[2], '<', '0');



                            unkE.SetFilter("Measuring Point Code", '%1', Text12[4]);

                            Evaluate(BrojM, Text12[12]);

                            if not unkE.FindFirst() then begin

                                //SifraKupca

                                unk.Init();
                                AutoIn2 += 1;
                                unk.Autoin := AutoIn2;
                                unk.Code := ch.Code;
                                unk.Validate("Source Data", SourceR);
                                unk."Serial Number" := BrojM;
                                unk."Proceedings No." := text12[1];
                                unk."Calculation Date From" := ch."Calculation Date From";
                                unk."Calculation Date To" := ch."Calculation Date To";
                                unk."Year of Calculation" := ch."Year of Calculation";
                                unk."Month of Calculation" := ch."Month of Calculation";
                                unk."Year Of GAS Calculation" := ch."Year Of GAS Calculation";
                                unk."Month Of GAS Calculation" := ch."Month Of GAS Calculation";
                                if copystr(Text12[2], 1, 1) = '0' then
                                    unk."Customer No." := copystr(Text12[2], 2, StrLen(text12[2]))
                                else
                                    unk."Customer No." := Text12[2];

                              



                                Evaluate(BrojM, Text12[12]);
                                unk."Serial Number" := BrojM;


                                if Text12[13] = '' then
                                    MjeracRanije := 0
                                else
                                    Evaluate(MjeracRanije, Text12[13]);
                                unk.Validate("Old Value", MjeracRanije);

                                if Text12[14] = '' then
                                    MjeracRanijeDatum := 0D
                                else
                                    Evaluate(MjeracRanijeDatum, Text12[14]);
                                unk.Validate("Previous Date", MjeracRanijeDatum);


                                if text12[25] = '' then
                                    DateV := 0DT
                                else
                                    Evaluate(dateV, text12[25]);
                                calcJ.validate(Date, DateV);



                                if Text12[15] = '' then
                                    MjeracTempRanije := 0
                                else
                                    Evaluate(MjeracTempRanije, Text12[15]);
                                unk.Validate("Temperature previous - gauge", MjeracTempRanije);

                                if Text12[16] = '' then
                                    MjeracPritisakRanije := 0
                                else
                                    Evaluate(MjeracPritisakRanije, Text12[16]);
                                unk.Validate("Pressure previous - gauge", MjeracPritisakRanije);

                                if Text12[17] = '' then
                                    KorektorRanije := 0
                                else
                                    Evaluate(KorektorRanije, Text12[17]);



                                unk.Validate("Temperature Correction", KorektorRanije);

                                if Text12[18] = '' then
                                    KorigovanoRanije := 0
                                else
                                    Evaluate(KorigovanoRanije, Text12[18]);
                                unk.Validate("Correction previous - gauge", KorektorRanije);


                                if Text12[26] = '' then begin
                                    NovoStanjeM := 0;
                                    if Text12[24] = '' then
                                        NovoStanjeM := 0
                                    else
                                        Evaluate(NovoStanjeM, Text12[24]);

                                end

                                else begin
                                    Evaluate(NovoStanjeM, Text12[26]);

                                end;
                                unk.Validate("New Value", NovoStanjeM);

                                if Text12[27] = '' then
                                    NovoKorigovanoS := 0
                                else
                                    Evaluate(NovoKorigovanoS, Text12[27]);
                                unk.Validate("Correction new- gauge", NovoKorigovanoS);

                                CurrRecNo += 1;
                                CurrentDateT := time;
                                Progress.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                                Progress.UPDATE(2, CurrentDateT);
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






                //  IF GUIALLOWED THEN
                //    Window.UPDATE;

            END;


        end;
        DataFile.CLOSE;
        Progress.close();
    end;



    var
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
        Character: array[489] of Text;
        I: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        Text005: Label 'Please select a valid File name first!';
        Text040: Label 'Xml file(*.xml)|*.xml|Text file(*.txt)|*.txt';
        Text000: Label 'Import File';
        Text004: Label 'Importing Data from file #1';
        Text12: array[34] of Text[2500];


    procedure SetParam2(No_Bill: code[20])
    begin
        Billing_Code := No_Bill;
    end;


    procedure SetParam(NameOfGroup: Text; NameOfJournalTemplate: Text; TabOrSPace: Boolean)
    begin
        DatePre := NameOfGroup;
        TabDa := TabOrSPace;
        Linija := 0;
        JournalPre := NameOfJournalTemplate;
        GenJournalBatch.RESET;
        GenJournalBatch.SETFILTER("Journal Template Name", '%1', JournalPre);
        GenJournalBatch.SetFilter(Name, '%1', DatePre);
        IF GenJournalBatch.FINDFIRST THEN
            Proturacun := GenJournalBatch."Bal. Account No."
        ELSE
            Proturacun := '';

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

    var
        Billing_Code: code[20];
        CustomerCateg: Record Customer;
}

*/