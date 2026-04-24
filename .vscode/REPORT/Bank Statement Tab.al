report 50063 "Bank Statement Tab"
{
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Bank Statement Tab';

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Choose Banke Statement")
                {
                    Caption = 'Choose Banke Statement';
                    field(Selected; Selected)
                    {
                        Caption = 'Izbor:';
                        Visible = false;

                    }
                }
            }
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        CustLedgerEntryFind: Record "Cust. Ledger Entry";
        InicijalnaStavka: code[20];
    begin

        TempFile.CREATETEMPFILE(TEXTENCODING::UTF8);
        FileName := TempFile.NAME + '.txt';
        TempFile.CLOSE;

        Proceed := UPLOAD(Text000, '', Text040, '', FileName);

        IF NOT Proceed THEN
            ERROR(Text005);

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
            Linija += 1;

            if Linija = 1 then begin
                if DatePre = 'ŽRR' then begin
                    BrojIzvoda := CopyStr(DataLine, 124, 5);
                    BrojIzvoda := DelChr(BrojIzvoda, '=', ' ');

                    GenJournalBatch.RESET;
                    GenJournalBatch.SETFILTER("Journal Template Name", '%1', JournalPre);
                    GenJournalBatch.SetFilter(Name, '%1', DatePre);
                    IF GenJournalBatch.FINDFIRST THEN begin
                        DatumZaglavlja := CopyStr(DataLine, 90, 8);
                        PartDate1 := CopyStr(DatumZaglavlja, 1, 4);
                        PartDate2 := CopyStr(DatumZaglavlja, 4, 2);
                        PartDate3 := CopyStr(DatumZaglavlja, 6, 2);
                        DatumZaglavlja := PartDate3 + '.' + PartDate2 + '.' + PartDate1 + '.';



                        NoSeriesU.Reset();
                        NoSeriesU.SetFilter("Series Code", '%1', GenJournalBatch."No. Series");
                        if Evaluate(DateEvaluate, DatumZaglavlja) then
                            NoSeriesU.SetFilter("Starting Date", '<=%1', DateEvaluate)
                        else
                            NoSeriesU.SetFilter("Starting Date", '<=%1', WorkDate());
                        NoSeriesU.SetCurrentKey("Starting Date");
                        NoSeriesU.Ascending;
                        if NoSeriesU.FindLast() then begin

                            NoSeriesU."Last No. Used" := CopyStr(NoSeriesU."Starting No.", 1, StrLen(NoSeriesU."Starting No.") - strlen(BrojIzvoda)) + BrojIzvoda;
                            BrojIzvodaIspis := NoSeriesU."Last No. Used";

                        end;

                    end;

                end;

                if DatePre = 'UCB' then begin
                    BrojIzvoda := CopyStr(DataLine, 69, 5);
                    BrojIzvoda := DelChr(BrojIzvoda, '=', ' ');

                    GenJournalBatch.RESET;
                    GenJournalBatch.SETFILTER("Journal Template Name", '%1', JournalPre);
                    GenJournalBatch.SetFilter(Name, '%1', DatePre);
                    IF GenJournalBatch.FINDFIRST THEN begin
                        DatumZaglavlja := CopyStr(DataLine, 74, 8);
                        PartDate1 := CopyStr(DatumZaglavlja, 1, 4);
                        PartDate2 := CopyStr(DatumZaglavlja, 4, 2);
                        PartDate3 := CopyStr(DatumZaglavlja, 6, 2);
                        DatumZaglavlja := PartDate1 + '.' + PartDate2 + '.' + PartDate3 + '.';



                        NoSeriesU.Reset();
                        NoSeriesU.SetFilter("Series Code", '%1', GenJournalBatch."No. Series");
                        if Evaluate(DateEvaluate, DatumZaglavlja) then
                            NoSeriesU.SetFilter("Starting Date", '<=%1', DateEvaluate)
                        else
                            NoSeriesU.SetFilter("Starting Date", '<=%1', WorkDate());
                        NoSeriesU.SetCurrentKey("Starting Date");
                        NoSeriesU.Ascending;
                        if NoSeriesU.FindLast() then begin

                            NoSeriesU."Last No. Used" := CopyStr(NoSeriesU."Starting No.", 1, StrLen(NoSeriesU."Starting No.") - strlen(BrojIzvoda)) + BrojIzvoda;
                            BrojIzvodaIspis := NoSeriesU."Last No. Used";

                        end;

                    end;

                end;

                if DatePre = 'RUB' then begin
                    Charr := 9;

                    BrojIzvoda := Split(DataLine, Format(Charr));//BROJ IZVODA
                    Text12[2] := Split(DataLine, Format(Charr));//DATUM IZVODA
                    GenJournalBatch.RESET;
                    GenJournalBatch.SETFILTER("Journal Template Name", '%1', JournalPre);
                    GenJournalBatch.SetFilter(Name, '%1', DatePre);
                    IF GenJournalBatch.FINDFIRST THEN begin

                        DatumZaglavlja := FORMAT(Text12[2] + '.');



                        NoSeriesU.Reset();
                        NoSeriesU.SetFilter("Series Code", '%1', GenJournalBatch."No. Series");
                        if Evaluate(DateEvaluate, DatumZaglavlja) then
                            NoSeriesU.SetFilter("Starting Date", '<=%1', DateEvaluate)
                        else
                            NoSeriesU.SetFilter("Starting Date", '<=%1', WorkDate());
                        NoSeriesU.SetCurrentKey("Starting Date");
                        NoSeriesU.Ascending;
                        if NoSeriesU.FindLast() then begin

                            NoSeriesU."Last No. Used" := CopyStr(NoSeriesU."Starting No.", 1, StrLen(NoSeriesU."Starting No.") - strlen(BrojIzvoda)) + BrojIzvoda;
                            BrojIzvodaIspis := NoSeriesU."Last No. Used";

                        end;

                    end;

                end;

            end;

            if (Linija <> 1) OR (StrPos(DatePre, 'NLB') <> 0) or (StrPos(DatePre, 'PRO') <> 0)
            or ((StrPos(DatePre, 'PTT') <> 0)) then begin

                Charr := 9
                ;

                if TabDa = true then begin
                    //DataLine


                    if StrPos(DataLine, format(Charr)) <> 0 then
                        PrviDIo := StrPos(DataLine, format(Charr));
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


                    //ovo je recimo tab za intesa san paolo

                    if (StrPos(DatePre, 'ISP') = 0) or (StrPos(DatePre, 'ASA') = 0) then begin



                        BrojRacun := Text12[8];


                        Postt := COPYSTR(text12[2], 1, 10);
                        //16.09.2022

                        IF EVALUATE(Dan, COPYSTR(Postt, 1, 2)) THEN
                            Dan2 := Dan
                        ELSE
                            Dan2 := 0;

                        IF EVALUATE(Mjesec, COPYSTR(Postt, 4, 2)) THEN
                            Mjesec2 := Mjesec
                        ELSE
                            Mjesec2 := 0;


                        IF EVALUATE(Godina, COPYSTR(Postt, 7, 4)) THEN
                            Godina2 := Godina
                        ELSE
                            Godina2 := 0;




                        PostingDate := DMY2DATE(Dan2, Mjesec2, Godina2);



                        //503.1

                        Text12[12] := ReplaceString(Text12[12], '.', ',');
                        IF EVALUATE(Amount3, Text12[12]) THEN
                            Amount3 := ROUND(Amount3, 0.01, '<');


                        Purpose := Text12[9];

                        /*    if Text12[1] = '-' then
                                Amount3 := -Amount3;*/

                        //




                        BrojRacun2 := ChangeBrojRacuna(text12[10], '01-');

                        if BrojRacun2 <> '' then begin
                            BrojRacun := BrojRacun2;
                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                        end;

                        if BrojRacun2 = '' then
                            BrojRacun2 := ChangeBrojRacuna(text12[10], '02-');

                        if BrojRacun2 <> '' then begin
                            BrojRacun := BrojRacun2;
                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                        end;

                        if BrojRacun2 = '' then
                            BrojRacun2 := ChangeBrojRacuna(text12[10], '03-');

                        if BrojRacun2 <> '' then begin
                            BrojRacun := BrojRacun2;
                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                        end;
                        if BrojRacun2 = '' then
                            BrojRacun2 := ChangeBrojRacuna(Purpose, '01-');

                        if BrojRacun2 <> '' then begin
                            BrojRacun := BrojRacun2;
                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                        end;
                        if BrojRacun2 = '' then
                            BrojRacun2 := ChangeBrojRacuna(Purpose, '02-');

                        if BrojRacun2 <> '' then begin
                            BrojRacun := BrojRacun2;
                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                        end;
                        if BrojRacun2 = '' then
                            BrojRacun2 := ChangeBrojRacuna(Purpose, '03-');

                        if BrojRacun2 <> '' then begin
                            BrojRacun := BrojRacun2;
                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                        end;






                        // PaymentLine."Message to Recipient" := text12[10];


                        PaymentLine.INIT;
                        PaymentLine."Posting Date" := PostingDate;
                        PaymentLine."Journal Batch Name" := DatePre;
                        PaymentLine."Journal Template Name" := JournalPre;

                        if StrPos(BrojRacun2, 'SAMOBROJFAKTURE') <> 0 then begin
                            //   InsertWithoutAccount(PaymentLine, BrojRacun2, Purpose);

                            No_ := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            SIH.Reset();
                            SIH.SetFilter("No.", '%1', No_);
                            if SIH.FindFirst() then begin

                                CustR.RESET;
                                CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
                                IF CustR.FINDFIRST THEN BEGIN
                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                    PaymentLine.VALIDATE("Account No.", CustR."No.");
                                    // PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                    PaymentLine."Currency Code" := CustR."Currency Code";
                                    //   CurenceCode := CustomerRecord."Currency Code";


                                end;

                            end
                            else begin

                                CustLedgerEntryFind.Reset();
                                CustLedgerEntryFind.SetFilter("External Document No.", '%1', InicijalnaStavka);
                                if CustLedgerEntryFind.findfirst then begin

                                    CustR.RESET;
                                    CustR.SETFILTER("No.", '%1', CustLedgerEntryFind."Customer No.");
                                    IF CustR.FINDFIRST THEN BEGIN
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                        PaymentLine.VALIDATE("Account No.", CustR."No.");
                                        //   PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                        PaymentLine."Currency Code" := CustR."Currency Code";
                                        //   CurenceCode := CustomerRecord."Currency Code";


                                    end;


                                end;
                            end;


                        end
                        else begin

                            /* CustomerRecord.RESET;
                             VendorRecord.RESET;
                             CustomerBankAccount.RESET;
                             CustomerBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                             IF CustomerBankAccount.FINDFIRST THEN BEGIN
                                 CustomerRecord.RESET;
                                 CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                 CustomerRecord.SETFILTER("No.", '%1', CustomerBankAccount."Customer No.");
                                 IF CustomerRecord.FINDFIRST THEN BEGIN
                                     PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                     // PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                     //   PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                     PaymentLine.Description := copystr(Purpose, 1, 100);
                                     CurenceCode := CustomerRecord."Currency Code";

                                 END;

                             END
                             ELSE BEGIN*/
                            VendorBankAccount.RESET;
                            VendorBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                            IF VendorBankAccount.FINDFIRST THEN BEGIN
                                VendorRecord.Reset();
                                VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                VendorRecord.SETFILTER("No.", '%1', VendorBankAccount."Vendor No.");
                                IF VendorRecord.FIND('-') THEN BEGIN
                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                    PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                    PaymentLine."Recipient Bank Account" := VendorRecord."Preferred Bank Account Code";
                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                    CurenceCode := VendorRecord."Currency Code";

                                END;
                            END
                            ELSE BEGIN


                                EmployeeRec.reset;
                                EmployeeRec.SetFilter("Bank Account No.", '%1', BrojRacun);
                                if EmployeeRec.FindFirst() then begin
                                    PaymentLine.VALIDATE("Account No.", '');
                                    PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                    CurenceCode := '';


                                end
                                else begin


                                    PaymentSetup.Reset();
                                    PaymentSetup.SetFilter("Payment Account", '%1', BrojRacun);
                                    if PaymentSetup.FindFirst() then begin

                                        PaymentLine.VALIDATE("Account No.", '');
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                        CurenceCode := '';

                                    end
                                    else begin






                                        PaymentLine.VALIDATE("Account No.", '');
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                        CurenceCode := '';

                                    end;
                                END;
                            end;


                            //     END;
                        end;

                    end;
                    PaymentLine."Message to Recipient" := text12[10];
                    PaymentLine."Payment Reference" := text12[3];
                    PaymentLine."Posting Group" := '';
                    if Br_ZATVARANJE <> '' then begin
                        PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                        PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);
                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                            ExternalDocumentF.Reset();
                            ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                            ExternalDocumentF.SetFilter(Open, '%1', true);
                            if ExternalDocumentF.FindFirst() then begin
                                PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";
                                PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                then
                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                then
                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                then
                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;


                            end
                            else begin
                                PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                PaymentLine."Applies-to Ext. Doc. No." := '';
                                PaymentLine."Applies-to Doc. No." := '';
                            end;
                        end;
                    end;






                    if (text12[3] = '') or (text12[3] = ' ') then
                        PaymentLine."Payment Reference" := text12[5];
                    if text12[11] = 'BAM' then
                        PaymentLine.Validate("Currency Code", '')
                    else
                        PaymentLine.validate("Currency Code", Text12[11]);

                    //da tražim sada na osnovu reference

                    if PaymentLine."Payment Reference" <> '' then begin
                        CustLedg.Reset();
                        CustLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                        if CustLedg.FindFirst() then begin
                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                            PaymentLine.Validate("Account No.", CustLedg."Customer No.");

                        end;

                        VendorLedg.Reset();
                        VendorLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                        if VendorLedg.FindFirst() then begin

                            PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                            PaymentLine.Validate("Account No.", VendorLedg."Vendor No.");
                        end;


                    end;
                    //

                    if text12[1] = '+' then
                        PaymentLine.VALIDATE("Credit Amount", Amount3)
                    else
                        PaymentLine.VALIDATE("Debit Amount", Amount3);

                    Text12[1] := Split(DataLine, Format(Charr));




                    //PaymentLine.VALIDATE("Debit Amount",Amount3);

                    PaymentLine2.RESET;
                    PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                    PaymentLine2.SETCURRENTKEY("Line No.");
                    PaymentLine2.ASCENDING;
                    IF PaymentLine2.FINDLAST THEN
                        PaymentLine."Line No." := PaymentLine2."Line No." + 10000
                    ELSE
                        PaymentLine."Line No." := 10000;

                    PaymentLine."Posting Date" := PostingDate;


                    PaymentLine."Journal Batch Name" := DatePre;
                    PaymentLine."Bal. Account Type" := PaymentLine."Bal. Account Type"::"Bank Account";
                    PaymentLine."Bal. Account No." := Proturacun;

                    GenJnlBatch.SETFILTER(Name, '%1', PaymentLine."Journal Batch Name");
                    IF GenJnlBatch.FINDFIRST THEN BEGIN
                        IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                            CLEAR(NoSeriesMgt);
                            if BrojIzvodaIspis <> '' then
                                PaymentLine."Document No." := BrojIzvodaIspis
                            else
                                PaymentLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PaymentLine."Posting Date", FALSE);
                        END;
                    END;
                    PaymentLine."Posting Date" := PostingDate;
                    PaymentLine.Description := copystr(Purpose, 1, 100);

                    PaymentLine."Journal Template Name" := JournalPre;
                    PaymentLine."Document Type" := PaymentLine."Document Type"::Payment;

                    PaymentLine."Posting Group" := '';
                    if Br_ZATVARANJE <> '' then begin
                        PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                        PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);

                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                            ExternalDocumentF.Reset();
                            ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                            ExternalDocumentF.SetFilter(Open, '%1', true);
                            if ExternalDocumentF.FindFirst() then begin
                                PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";
                                PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                then
                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                then
                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                then
                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;


                            end
                            else begin
                                PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                PaymentLine."Applies-to Ext. Doc. No." := '';
                                PaymentLine."Applies-to Doc. No." := '';
                            end;
                        end;
                    end;

                    /*if text12[1] = '+' then
                        PaymentLine.VALIDATE("Credit Amount", Amount3)
                    else
                        PaymentLine.VALIDATE("Debit Amount", Amount3);*/


                    // PaymentLine.Correction := false;
                    if PaymentLine."Amount (LCY)" > 0 then
                        PaymentLine."Document Type" := PaymentLine."Document Type"::" ";
                    PaymentLine.INSERT;
                    Brojac := Brojac + 1;

                    Proc := ROUND((DataFile.POS / DataFile.LEN * 10000), 1, '=');
                end
                else begin
                    //ovdje dodati space




                    //NLB 

                    if StrPos(DatePre, 'NLB') <> 0 then begin

                        //prva linija pamti datum knjiženja

                        if Linija = 1 then begin
                            Postt := COPYSTR(DataLine, 61, 8);
                            IF EVALUATE(Dan, COPYSTR(Postt, 7, 2)) THEN
                                Dan2 := Dan
                            ELSE
                                Dan2 := 0;

                            IF EVALUATE(Mjesec, COPYSTR(Postt, 5, 2)) THEN
                                Mjesec2 := Mjesec
                            ELSE
                                Mjesec2 := 0;


                            IF EVALUATE(Godina, COPYSTR(Postt, 1, 4)) THEN
                                Godina2 := Godina
                            ELSE
                                Godina2 := 0;




                            PostingDate := DMY2DATE(Dan2, Mjesec2, Godina2);

                        end;

                        if Linija <> 1 then begin

                            BrojRacun := COPYSTR(DataLine, 27, 16);
                            BrojRacun := DelChr(BrojRacun, '=', ' ');
                            BrojRacun := DelChr(BrojRacun);


                            Purpose := COPYSTR(DataLine, 143, 100);
                            Opis := CopyStr(DataLine, 43, 100);
                            Odliv := COPYSTR(DataLine, 243, 15);
                            Priliv := COPYSTR(DataLine, 258, 15);



                            BrojRacun2 := ChangeBrojRacuna(Opis, '01-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Opis, '02-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Opis, '03-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;
                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Purpose, '01-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Purpose, '02-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Purpose, '03-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            PaymentLine.INIT;
                            PaymentLine."Posting Date" := PostingDate;
                            PaymentLine."Journal Batch Name" := DatePre;
                            PaymentLine."Journal Template Name" := JournalPre;

                            if StrPos(BrojRacun2, 'SAMOBROJFAKTURE') <> 0 then begin
                                No_ := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                SIH.Reset();
                                SIH.SetFilter("No.", '%1', No_);
                                if SIH.FindFirst() then begin

                                    CustR.RESET;
                                    CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
                                    IF CustR.FINDFIRST THEN BEGIN
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                        PaymentLine.VALIDATE("Account No.", CustR."No.");
                                        //  PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                        PaymentLine.Description := copystr(Opis, 1, 100);
                                        PaymentLine."Currency Code" := CustR."Currency Code";
                                        //   CurenceCode := CustomerRecord."Currency Code";


                                    end;

                                end
                                else begin
                                    CustLedgerEntryFind.Reset();
                                    CustLedgerEntryFind.SetFilter("External Document No.", '%1', InicijalnaStavka);
                                    if CustLedgerEntryFind.findfirst then begin

                                        CustR.RESET;
                                        CustR.SETFILTER("No.", '%1', CustLedgerEntryFind."Customer No.");
                                        IF CustR.FINDFIRST THEN BEGIN
                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                            PaymentLine.VALIDATE("Account No.", CustR."No.");
                                            //   PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                            PaymentLine."Currency Code" := CustR."Currency Code";
                                            //   CurenceCode := CustomerRecord."Currency Code";


                                        end;


                                    end;
                                end;

                            end

                            else begin

                                CustomerRecord.RESET;
                                VendorRecord.RESET;
                                /* CustomerBankAccount.RESET;
                                 CustomerBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                 IF CustomerBankAccount.FINDFIRST THEN BEGIN
                                     CustomerRecord.RESET;
                                     CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                     CustomerRecord.SETFILTER("No.", '%1', CustomerBankAccount."Customer No.");
                                     IF CustomerRecord.FINDFIRST THEN BEGIN
                                         PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                         //   PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                         //    PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                         PaymentLine.Description := copystr(Opis, 1, 100);
                                         CurenceCode := CustomerRecord."Currency Code";

                                     END;
                                 END
                                 ELSE BEGIN*/
                                VendorBankAccount.RESET;
                                VendorBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                IF VendorBankAccount.FINDFIRST THEN BEGIN
                                    VendorRecord.Reset();
                                    VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                    VendorRecord.SETFILTER("No.", '%1', VendorBankAccount."Vendor No.");
                                    IF VendorRecord.FIND('-') THEN BEGIN
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                        PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                        PaymentLine."Recipient Bank Account" := VendorRecord."Preferred Bank Account Code";
                                        PaymentLine.Description := copystr(Opis, 1, 100);
                                        CurenceCode := VendorRecord."Currency Code";

                                    END;
                                END
                                ELSE BEGIN

                                    EmployeeRec.reset;
                                    EmployeeRec.SetFilter("Bank Account No.", '%1', BrojRacun);
                                    if EmployeeRec.FindFirst() then begin
                                        PaymentLine.VALIDATE("Account No.", '');
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                        CurenceCode := '';


                                    end
                                    else begin

                                        PaymentSetup.Reset();
                                        PaymentSetup.SetFilter("Payment Account", '%1', BrojRacun);
                                        if PaymentSetup.FindFirst() then begin

                                            PaymentLine.VALIDATE("Account No.", '');
                                            PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                            CurenceCode := '';

                                        end else begin
                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                            PaymentLine.VALIDATE("Account No.", '');
                                            PaymentLine.Description := copystr(Opis, 1, 100);
                                            CurenceCode := '';

                                            //   END;
                                        end;

                                    end;
                                END;

                            end;
                            if Priliv = '000000000000.00' then begin

                                //000000000050.00
                                Odliv := ReplaceString(Odliv, '.', ',');
                                Evaluate(Amount3, Odliv);
                                PaymentLine.VALIDATE("Debit Amount", Amount3);

                            end
                            else begin
                                Priliv := ReplaceString(Priliv, '.', ',');
                                Evaluate(Amount3, Priliv);
                                PaymentLine.VALIDATE("Credit Amount", Amount3);

                            end;


                            PaymentLine2.RESET;
                            PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                            PaymentLine2.SETCURRENTKEY("Line No.");
                            PaymentLine2.ASCENDING;
                            IF PaymentLine2.FINDLAST THEN
                                PaymentLine."Line No." := PaymentLine2."Line No." + 10000
                            ELSE
                                PaymentLine."Line No." := 10000;

                            PaymentLine."Posting Date" := PostingDate;

                            PaymentLine."Journal Batch Name" := DatePre;
                            PaymentLine."Bal. Account Type" := PaymentLine."Bal. Account Type"::"Bank Account";
                            PaymentLine."Bal. Account No." := Proturacun;

                            GenJnlBatch.SETFILTER(Name, '%1', PaymentLine."Journal Batch Name");
                            IF GenJnlBatch.FINDFIRST THEN BEGIN
                                IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                    CLEAR(NoSeriesMgt);
                                    if BrojIzvodaIspis <> '' then
                                        PaymentLine."Document No." := BrojIzvodaIspis
                                    else
                                        PaymentLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PaymentLine."Posting Date", FALSE);
                                END;
                            END;
                            PaymentLine."Posting Date" := PostingDate;
                            PaymentLine.Description := copystr(Opis, 1, 100);

                            PaymentLine."Journal Template Name" := JournalPre;
                            PaymentLine."Document Type" := PaymentLine."Document Type"::Payment;
                            PaymentLine."Message to Recipient" := Purpose;
                            if PaymentLine."Amount (LCY)" > 0 then
                                PaymentLine."Document Type" := PaymentLine."Document Type"::" ";

                            PaymentLine."Posting Group" := '';
                            if Br_ZATVARANJE <> '' then begin
                                PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                                PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);

                                PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                                if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                                    ExternalDocumentF.Reset();
                                    ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                                    ExternalDocumentF.SetFilter(Open, '%1', true);
                                    if ExternalDocumentF.FindFirst() then begin
                                        PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";
                                        PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                        PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                        if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                        then
                                            PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                        if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                        then
                                            PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                        if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                        then
                                            PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;

                                    end
                                    else begin
                                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                        PaymentLine."Applies-to Ext. Doc. No." := '';
                                        PaymentLine."Applies-to Doc. No." := '';
                                    end;
                                end;
                            end;
                            if Priliv = '000000000000.00' then begin

                                //000000000050.00
                                Odliv := ReplaceString(Odliv, '.', ',');
                                Evaluate(Amount3, Odliv);
                                PaymentLine.VALIDATE("Debit Amount", Amount3);

                            end
                            else begin
                                Priliv := ReplaceString(Priliv, '.', ',');
                                Evaluate(Amount3, Priliv);
                                PaymentLine.VALIDATE("Credit Amount", Amount3);

                            end;


                            PaymentLine.INSERT;
                            Brojac := Brojac + 1;






                        end;



                    end
                    else begin


                        //raif


                        if (StrPos(DatePre, 'UCB') <> 0) and (StrPos(DatePre, 'EUR') = 0) then begin
                            BrojRacun := COPYSTR(DataLine, 78, 16);
                            Purpose := CopyStr(DataLine, 228, 50);
                            Postt := COPYSTR(DataLine, 8, 8);
                            IF EVALUATE(Dan, COPYSTR(Postt, 1, 2)) THEN
                                Dan2 := Dan
                            ELSE
                                Dan2 := 0;

                            IF EVALUATE(Mjesec, COPYSTR(Postt, 3, 2)) THEN
                                Mjesec2 := Mjesec
                            ELSE
                                Mjesec2 := 0;


                            IF EVALUATE(Godina, COPYSTR(Postt, 5, 4)) THEN
                                Godina2 := Godina
                            ELSE
                                Godina2 := 0;




                            PostingDate := DMY2DATE(Dan2, Mjesec2, Godina2);




                            PaymentLine.INIT;
                            PaymentLine."Posting Date" := PostingDate;
                            PaymentLine."Journal Batch Name" := DatePre;
                            PaymentLine."Journal Template Name" := JournalPre;
                            PaymentLine."Message to Recipient" := CopyStr(DataLine, 94, 50);
                            PaymentLine."Payment Reference" := delchr(CopyStr(DataLine, 16, 32), '=', ' ');

                            BrojRacun2 := ChangeBrojRacuna(PaymentLine."Message to Recipient", '01-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(PaymentLine."Message to Recipient", '02-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(PaymentLine."Message to Recipient", '03-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Purpose, '01-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Purpose, '02-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;

                            if BrojRacun2 = '' then
                                BrojRacun2 := ChangeBrojRacuna(Purpose, '03-');

                            if BrojRacun2 <> '' then begin
                                BrojRacun := BrojRacun2;
                                InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                            end;


                            AmountText := COPYSTR(DataLine, 194, 17);
                            AmountText := DelChr(AmountText, '', '=');
                            AmountText := ReplaceString(AmountText, '.', ',');


                            IF EVALUATE(Amount3, AmountText) THEN
                                Amount3 := ROUND(Amount3, 0.01, '<');
                            PaymentLine.Validate("Debit Amount", Amount3);

                            AmountText := COPYSTR(DataLine, 211, 17);
                            AmountText := DelChr(AmountText, '', '=');
                            AmountText := ReplaceString(AmountText, '.', ',');
                            IF EVALUATE(Amount3, AmountText) THEN
                                Amount3 := ROUND(Amount3, 0.01, '<');
                            PaymentLine.Validate("Credit Amount", Amount3);



                            if StrPos(BrojRacun2, 'SAMOBROJFAKTURE') <> 0 then begin
                                No_ := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                SIH.Reset();
                                SIH.SetFilter("No.", '%1', No_);
                                if SIH.FindFirst() then begin

                                    CustR.RESET;
                                    CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
                                    IF CustR.FINDFIRST THEN BEGIN
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                        PaymentLine.VALIDATE("Account No.", CustR."No.");
                                        //   PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";

                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                        PaymentLine."Currency Code" := CustR."Currency Code";
                                        //   CurenceCode := CustomerRecord."Currency Code";


                                    end;

                                end
                                else begin
                                    CustLedgerEntryFind.Reset();
                                    CustLedgerEntryFind.SetFilter("External Document No.", '%1', InicijalnaStavka);
                                    if CustLedgerEntryFind.findfirst then begin

                                        CustR.RESET;
                                        CustR.SETFILTER("No.", '%1', CustLedgerEntryFind."Customer No.");
                                        IF CustR.FINDFIRST THEN BEGIN
                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                            PaymentLine.VALIDATE("Account No.", CustR."No.");
                                            //    PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                            PaymentLine."Currency Code" := CustR."Currency Code";
                                            //   CurenceCode := CustomerRecord."Currency Code";


                                        end;


                                    end;
                                end;


                            end
                            else begin

                                /*  CustomerRecord.RESET;
                                  VendorRecord.RESET;
                                  CustomerBankAccount.RESET;
                                  CustomerBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                  IF CustomerBankAccount.FINDFIRST THEN BEGIN
                                      CustomerRecord.RESET;
                                      CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                      CustomerRecord.SETFILTER("No.", '%1', CustomerBankAccount."Customer No.");
                                      IF CustomerRecord.FINDFIRST THEN BEGIN
                                          PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                          //   PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                          //   PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                          PaymentLine.Description := copystr(Purpose, 1, 100);
                                          CurenceCode := CustomerRecord."Currency Code";

                                      END;
                                  END
                                  ELSE BEGIN*/
                                VendorBankAccount.RESET;
                                VendorBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                IF VendorBankAccount.FINDFIRST THEN BEGIN
                                    VendorRecord.Reset();
                                    VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                    VendorRecord.SETFILTER("No.", '%1', VendorBankAccount."Vendor No.");
                                    IF VendorRecord.FIND('-') THEN BEGIN
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                        PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                        PaymentLine."Recipient Bank Account" := VendorRecord."Preferred Bank Account Code";
                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                        CurenceCode := VendorRecord."Currency Code";

                                    END;
                                END
                                ELSE BEGIN

                                    EmployeeRec.reset;
                                    EmployeeRec.SetFilter("Bank Account No.", '%1', BrojRacun);
                                    if EmployeeRec.FindFirst() then begin
                                        PaymentLine.VALIDATE("Account No.", '');
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                        CurenceCode := '';


                                    end
                                    else begin

                                        PaymentSetup.Reset();
                                        PaymentSetup.SetFilter("Payment Account", '%1', BrojRacun);
                                        if PaymentSetup.FindFirst() then begin

                                            PaymentLine.VALIDATE("Account No.", '');
                                            PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                            CurenceCode := '';

                                        end else begin

                                            PaymentLine.VALIDATE("Account No.", '');
                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                            PaymentLine.Description := Purpose;
                                            CurenceCode := '';

                                        END;
                                    end;
                                end;

                                //  end;
                            END;

                            if PaymentLine."Payment Reference" <> '' then begin
                                CustLedg.Reset();
                                CustLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                                if CustLedg.FindFirst() then begin
                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                    PaymentLine.Validate("Account No.", CustLedg."Customer No.");

                                end;

                                VendorLedg.Reset();
                                VendorLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                                if VendorLedg.FindFirst() then begin

                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                    PaymentLine.Validate("Account No.", VendorLedg."Vendor No.");
                                end;


                            end;
                            // PaymentLine.VALIDATE("Debit Amount", Amount3);
                            PaymentLine2.RESET;
                            PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                            PaymentLine2.SETCURRENTKEY("Line No.");
                            PaymentLine2.ASCENDING;
                            IF PaymentLine2.FINDLAST THEN
                                PaymentLine."Line No." := PaymentLine2."Line No." + 10000
                            ELSE
                                PaymentLine."Line No." := 10000;

                            PaymentLine."Posting Date" := PostingDate;


                            PaymentLine."Journal Batch Name" := DatePre;
                            PaymentLine."Bal. Account Type" := PaymentLine."Bal. Account Type"::"Bank Account";
                            PaymentLine."Bal. Account No." := Proturacun;

                            GenJnlBatch.SETFILTER(Name, '%1', PaymentLine."Journal Batch Name");
                            IF GenJnlBatch.FINDFIRST THEN BEGIN
                                IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                    CLEAR(NoSeriesMgt);
                                    if BrojIzvodaIspis <> '' then
                                        PaymentLine."Document No." := BrojIzvodaIspis
                                    else
                                        PaymentLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PaymentLine."Posting Date", FALSE);
                                END;
                            END;


                            PaymentLine.Description := copystr(Purpose, 1, 100);

                            PaymentLine."Journal Template Name" := JournalPre;
                            PaymentLine."Document Type" := PaymentLine."Document Type"::Payment;

                            if PaymentLine."Amount (LCY)" > 0 then
                                PaymentLine."Document Type" := PaymentLine."Document Type"::" ";

                            PaymentLine."Posting Group" := '';
                            if Br_ZATVARANJE <> '' then begin
                                PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                                PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);
                                PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                                if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                                    ExternalDocumentF.Reset();
                                    ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                                    ExternalDocumentF.SetFilter(Open, '%1', true);
                                    if ExternalDocumentF.FindFirst() then begin
                                        PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";
                                        PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                        PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                        if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                        then
                                            PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                        if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                        then
                                            PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                        if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                        then
                                            PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;

                                    end
                                    else begin
                                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                        PaymentLine."Applies-to Ext. Doc. No." := '';
                                        PaymentLine."Applies-to Doc. No." := '';
                                    end;
                                end;
                            end;
                            IF EVALUATE(Amount3, AmountText) THEN
                                Amount3 := ROUND(Amount3, 0.01, '<');
                            PaymentLine.Validate("Credit Amount", Amount3);

                            AmountText := COPYSTR(DataLine, 211, 17);
                            AmountText := DelChr(AmountText, '', '=');
                            AmountText := ReplaceString(AmountText, '.', ',');
                            IF EVALUATE(Amount3, AmountText) THEN
                                Amount3 := ROUND(Amount3, 0.01, '<');
                            PaymentLine.Validate("Credit Amount", Amount3);

                            PaymentLine.INSERT;
                            Brojac := Brojac + 1;


                        end
                        else begin


                            if strpos(DatePre, 'PRO') <> 0 then begin

                                //procredit banka
                                BrojRacun := COPYSTR(DataLine, 15, 16);
                                BrojRacun := DelChr(BrojRacun, '=', ' ');
                                BrojRacun := DelChr(BrojRacun);
                                Opis := COPYSTR(DataLine, 31, 80);

                                Odliv := COPYSTR(DataLine, 227, 15);
                                Priliv := COPYSTR(DataLine, 242, 15);
                                Purpose := copystr(DataLine, 272, 140);


                                if StrPos(DatePre, 'PRO') <> 0 then begin

                                    //prva linija pamti datum knjiženja

                                    if Linija = 1 then begin
                                        Postt := COPYSTR(DataLine, 106, 8);
                                        IF EVALUATE(Dan, COPYSTR(Postt, 7, 2)) THEN
                                            Dan2 := Dan
                                        ELSE
                                            Dan2 := 0;

                                        IF EVALUATE(Mjesec, COPYSTR(Postt, 5, 2)) THEN
                                            Mjesec2 := Mjesec
                                        ELSE
                                            Mjesec2 := 0;


                                        IF EVALUATE(Godina, COPYSTR(Postt, 1, 4)) THEN
                                            Godina2 := Godina
                                        ELSE
                                            Godina2 := 0;




                                        PostingDate := DMY2DATE(Dan2, Mjesec2, Godina2);

                                    end;
                                end;

                                if Linija <> 1 then begin
                                    PaymentLine.INIT;
                                    PaymentLine."Journal Batch Name" := DatePre;
                                    PaymentLine."Journal Template Name" := JournalPre;
                                    PaymentLine."Posting Date" := PostingDate;
                                    PaymentLine."Payment Reference" := delchr(CopyStr(DataLine, 572, 12), '=', ' ');


                                    BrojRacun2 := ChangeBrojRacuna(Opis, '01-');

                                    if BrojRacun2 <> '' then begin
                                        BrojRacun := BrojRacun2;
                                        InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                    end;

                                    if BrojRacun2 = '' then
                                        BrojRacun2 := ChangeBrojRacuna(Opis, '02-');

                                    if BrojRacun2 <> '' then begin
                                        BrojRacun := BrojRacun2;
                                        InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                    end;
                                    if BrojRacun2 = '' then
                                        BrojRacun2 := ChangeBrojRacuna(Opis, '03-');

                                    if BrojRacun2 <> '' then begin
                                        BrojRacun := BrojRacun2;
                                        InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                    end;

                                    if BrojRacun2 = '' then
                                        BrojRacun2 := ChangeBrojRacuna(Purpose, '01-');

                                    if BrojRacun2 <> '' then begin
                                        BrojRacun := BrojRacun2;
                                        InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                    end;

                                    if BrojRacun2 = '' then
                                        BrojRacun2 := ChangeBrojRacuna(Purpose, '02-');

                                    if BrojRacun2 <> '' then begin
                                        BrojRacun := BrojRacun2;
                                        InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                    end;
                                    if BrojRacun2 = '' then
                                        BrojRacun2 := ChangeBrojRacuna(Purpose, '03-');

                                    if BrojRacun2 <> '' then begin
                                        BrojRacun := BrojRacun2;
                                        InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                    end;



                                    if StrPos(BrojRacun2, 'SAMOBROJFAKTURE') <> 0 then begin
                                        No_ := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        SIH.Reset();
                                        SIH.SetFilter("No.", '%1', No_);
                                        if SIH.FindFirst() then begin

                                            CustR.RESET;
                                            CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
                                            IF CustR.FINDFIRST THEN BEGIN
                                                PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                //   PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                PaymentLine.Description := copystr(Opis, 1, 100);
                                                PaymentLine."Currency Code" := CustR."Currency Code";
                                                //   CurenceCode := CustomerRecord."Currency Code";


                                            end;

                                        end
                                        else begin
                                            CustLedgerEntryFind.Reset();
                                            CustLedgerEntryFind.SetFilter("External Document No.", '%1', InicijalnaStavka);
                                            if CustLedgerEntryFind.findfirst then begin

                                                CustR.RESET;
                                                CustR.SETFILTER("No.", '%1', CustLedgerEntryFind."Customer No.");
                                                IF CustR.FINDFIRST THEN BEGIN
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                    PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                    //  PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                                    PaymentLine."Currency Code" := CustR."Currency Code";
                                                    //   CurenceCode := CustomerRecord."Currency Code";


                                                end;


                                            end;
                                        end;


                                    end
                                    else begin

                                        /*   CustomerRecord.RESET;
                                           VendorRecord.RESET;
                                           CustomerBankAccount.RESET;
                                           CustomerBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                           IF CustomerBankAccount.FINDFIRST THEN BEGIN
                                               CustomerRecord.RESET;
                                               CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                               CustomerRecord.SETFILTER("No.", '%1', CustomerBankAccount."Customer No.");
                                               IF CustomerRecord.FINDFIRST THEN BEGIN
                                                   PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                   //       PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                                   //       PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                                   PaymentLine.Description := copystr(Opis, 1, 100);
                                                   CurenceCode := CustomerRecord."Currency Code";

                                               END;
                                           END
                                           ELSE BEGIN*/
                                        VendorBankAccount.RESET;
                                        VendorBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                        IF VendorBankAccount.FINDFIRST THEN BEGIN
                                            VendorRecord.Reset();
                                            VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                            VendorRecord.SETFILTER("No.", '%1', VendorBankAccount."Vendor No.");
                                            IF VendorRecord.FIND('-') THEN BEGIN
                                                PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                                PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                                PaymentLine."Recipient Bank Account" := VendorRecord."Preferred Bank Account Code";
                                                PaymentLine.Description := copystr(Opis, 1, 100);
                                                CurenceCode := VendorRecord."Currency Code";

                                            END;
                                        END
                                        ELSE BEGIN
                                            EmployeeRec.reset;
                                            EmployeeRec.SetFilter("Bank Account No.", '%1', BrojRacun);
                                            if EmployeeRec.FindFirst() then begin
                                                PaymentLine.VALIDATE("Account No.", '');
                                                PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                PaymentLine.Description := copystr(Purpose, 1, 100);
                                                CurenceCode := '';


                                            end
                                            else begin

                                                PaymentSetup.Reset();
                                                PaymentSetup.SetFilter("Payment Account", '%1', BrojRacun);
                                                if PaymentSetup.FindFirst() then begin

                                                    PaymentLine.VALIDATE("Account No.", '');
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                                    CurenceCode := '';

                                                end else begin

                                                    PaymentLine.VALIDATE("Account No.", '');
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                    PaymentLine.Description := copystr(Opis, 1, 100);
                                                    CurenceCode := '';

                                                END;
                                            end;
                                        end;

                                        // END;

                                    end;
                                    if PaymentLine."Payment Reference" <> '' then begin
                                        CustLedg.Reset();
                                        CustLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                                        if CustLedg.FindFirst() then begin
                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                            PaymentLine.Validate("Account No.", CustLedg."Customer No.");

                                        end;

                                        VendorLedg.Reset();
                                        VendorLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                                        if VendorLedg.FindFirst() then begin

                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                            PaymentLine.Validate("Account No.", VendorLedg."Vendor No.");
                                        end;


                                    end;

                                    if Priliv = '000000000000.00' then begin

                                        //000000000050.00
                                        Odliv := ReplaceString(Odliv, '.', ',');
                                        Evaluate(Amount3, Odliv);
                                        PaymentLine.VALIDATE("Debit Amount", Amount3);

                                    end
                                    else begin
                                        Priliv := ReplaceString(Priliv, '.', ',');
                                        Evaluate(Amount3, Priliv);
                                        PaymentLine.VALIDATE("Credit Amount", Amount3);

                                    end;


                                    PaymentLine2.RESET;
                                    PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                                    PaymentLine2.SETCURRENTKEY("Line No.");
                                    PaymentLine2.ASCENDING;
                                    IF PaymentLine2.FINDLAST THEN
                                        PaymentLine."Line No." := PaymentLine2."Line No." + 10000
                                    ELSE
                                        PaymentLine."Line No." := 10000;

                                    PaymentLine."Posting Date" := PostingDate;

                                    PaymentLine."Journal Batch Name" := DatePre;
                                    PaymentLine."Bal. Account Type" := PaymentLine."Bal. Account Type"::"Bank Account";
                                    PaymentLine."Bal. Account No." := Proturacun;

                                    GenJnlBatch.SETFILTER(Name, '%1', PaymentLine."Journal Batch Name");
                                    IF GenJnlBatch.FINDFIRST THEN BEGIN
                                        IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                            CLEAR(NoSeriesMgt);
                                            if BrojIzvodaIspis <> '' then
                                                PaymentLine."Document No." := BrojIzvodaIspis
                                            else
                                                PaymentLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PaymentLine."Posting Date", FALSE);
                                        END;
                                    END;
                                    PaymentLine."Posting Date" := PostingDate;
                                    PaymentLine.Description := copystr(Opis, 1, 100);

                                    PaymentLine."Journal Template Name" := JournalPre;
                                    PaymentLine."Document Type" := PaymentLine."Document Type"::Payment;
                                    PaymentLine."Message to Recipient" := Purpose;
                                    if PaymentLine."Amount (LCY)" > 0 then
                                        PaymentLine."Document Type" := PaymentLine."Document Type"::" ";

                                    PaymentLine."Posting Group" := '';
                                    if Br_ZATVARANJE <> '' then begin
                                        PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                                        PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);
                                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                                        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                                            ExternalDocumentF.Reset();
                                            ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                                            ExternalDocumentF.SetFilter(Open, '%1', true);
                                            if ExternalDocumentF.FindFirst() then begin
                                                PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";
                                                PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                                PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;

                                            end
                                            else begin
                                                PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                                PaymentLine."Applies-to Ext. Doc. No." := '';
                                                PaymentLine."Applies-to Doc. No." := '';
                                            end;
                                        end;
                                    end;
                                    if Priliv = '000000000000.00' then begin

                                        //000000000050.00
                                        Odliv := ReplaceString(Odliv, '.', ',');
                                        Evaluate(Amount3, Odliv);
                                        PaymentLine.VALIDATE("Debit Amount", Amount3);

                                    end
                                    else begin
                                        Priliv := ReplaceString(Priliv, '.', ',');
                                        Evaluate(Amount3, Priliv);
                                        PaymentLine.VALIDATE("Credit Amount", Amount3);

                                    end;

                                    PaymentLine.INSERT;
                                    Brojac := Brojac + 1;


                                end;

                            end


                            else begin

                                if StrPos(DatePre, 'PTT') <> 0 then begin

                                    Purpose := CopyStr(DataLine, 12, 16);

                                    BrojRacun := COPYSTR(DataLine, 1, 10);

                                    //sifra kupca za poštu 
                                    BrojRacun := DelChr(BrojRacun, '<', '0');

                                    BrojRacunaPTT := CopyStr(DataLine, 12, 13);
                                    if StrPos(BrojRacunaPTT, '01-') <> 0 then
                                        BrojRacunaPTT1 := CopyStr(BrojRacunaPTT, 3, strlen(BrojRacunaPTT));
                                    if StrPos(BrojRacunaPTT, '02-') <> 0 then
                                        BrojRacunaPTT1 := CopyStr(BrojRacunaPTT, 3, strlen(BrojRacunaPTT));
                                    if StrPos(BrojRacunaPTT, '03-') <> 0 then
                                        BrojRacunaPTT1 := CopyStr(BrojRacunaPTT, 4, strlen(BrojRacunaPTT));

                                    BrojRacunaPTT3 := DelChr(BrojRacunaPTT1, '<', '0');

                                    BrojRacunaPTT := CopyStr(DataLine, 12, 3) + BrojRacunaPTT3 + '/' + CopyStr(DataLine, 26, 2);
                                    Br_ZATVARANJE := BrojRacunaPTT;

                                    Priliv := COPYSTR(DataLine, 29, 16);

                                    /*    BrojRacun2 := ChangeBrojRacuna(Purpose, '01-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;
                                        if BrojRacun2 = '' then
                                            BrojRacun2 := ChangeBrojRacuna(Purpose, '02-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;
                                        if BrojRacun2 = '' then
                                            BrojRacun2 := ChangeBrojRacuna(Purpose, '03-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;
    */
                                    BrojRacun2 := '';

                                    CustomerRecord.reset;
                                    CustomerRecord.SetFilter("No.", '%1', BrojRacun);
                                    if CustomerRecord.FindFirst() then begin



                                        CustomerBankAccount.Reset();
                                        CustomerBankAccount.SetFilter(Code, '%1', CustomerRecord."Preferred Bank Account Code");
                                        CustomerBankAccount.SetFilter("Customer No.", '%1', CustomerRecord."No.");
                                        if CustomerBankAccount.FindFirst() then
                                            BrojRacun2 := '';
                                    end;



                                    //posta


                                    if Linija <> 0 then begin
                                        PaymentLine.INIT;
                                        PaymentLine."Journal Batch Name" := DatePre;
                                        PaymentLine."Posting Date" := PostingDate;
                                        PaymentLine."Journal Template Name" := JournalPre;

                                        if StrPos(BrojRacun2, 'SAMOBROJFAKTURE') <> 0 then begin
                                            No_ := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                            SIH.Reset();
                                            SIH.SetFilter("No.", '%1', No_);
                                            if SIH.FindFirst() then begin

                                                CustR.RESET;
                                                CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
                                                IF CustR.FINDFIRST THEN BEGIN
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                    PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                    //   PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                                    PaymentLine."Currency Code" := CustR."Currency Code";
                                                    //   CurenceCode := CustomerRecord."Currency Code";


                                                end;

                                            end
                                            else begin
                                                CustLedgerEntryFind.Reset();
                                                CustLedgerEntryFind.SetFilter("External Document No.", '%1', InicijalnaStavka);
                                                if CustLedgerEntryFind.findfirst then begin

                                                    CustR.RESET;
                                                    CustR.SETFILTER("No.", '%1', CustLedgerEntryFind."Customer No.");
                                                    IF CustR.FINDFIRST THEN BEGIN
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                        PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                        //     PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        PaymentLine."Currency Code" := CustR."Currency Code";
                                                        //   CurenceCode := CustomerRecord."Currency Code";


                                                    end;


                                                end;
                                            end;


                                        end
                                        else begin
                                            //djemina ovjde
                                            /*  CustomerRecord.SETFILTER("No.", '%1', BrojRacun);
                                              IF CustomerRecord.FINDFIRST THEN BEGIN
                                                  CustomerRecord.RESET;
                                                  // CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                                  CustomerRecord.SETFILTER("No.", '%1', CustomerRecord."No.");
                                                  IF CustomerRecord.FINDFIRST THEN BEGIN
                                                      PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                      // PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                                      // PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                                      PaymentLine.Description := copystr(Purpose, 1, 100);
                                                      CurenceCode := CustomerRecord."Currency Code";

                                                  END;
                                              END
                                              ELSE BEGIN*/
                                            CustomerRecord.Reset();
                                            CustomerRecord.SETFILTER("No.", '%1', BrojRacun);
                                            IF CustomerRecord.FINDFIRST THEN BEGIN
                                                CustomerRecord.RESET;
                                                // CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                                CustomerRecord.SETFILTER("No.", '%1', CustomerRecord."No.");
                                                IF CustomerRecord.FINDFIRST THEN BEGIN
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                    PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                                    // PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                                    CurenceCode := CustomerRecord."Currency Code";



                                                END;
                                            END
                                            ELSE BEGIN


                                                VendorBankAccount.RESET;
                                                VendorBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                                IF VendorBankAccount.FINDFIRST THEN BEGIN
                                                    VendorRecord.Reset();
                                                    VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                                    VendorRecord.SETFILTER("No.", '%1', VendorBankAccount."Vendor No.");
                                                    IF VendorRecord.FIND('-') THEN BEGIN
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                                        PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                                        PaymentLine."Recipient Bank Account" := VendorRecord."Preferred Bank Account Code";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        CurenceCode := VendorRecord."Currency Code";

                                                    END;
                                                END
                                                ELSE BEGIN
                                                    EmployeeRec.reset;
                                                    EmployeeRec.SetFilter("Bank Account No.", '%1', BrojRacun);

                                                    if EmployeeRec.FindFirst() then begin
                                                        PaymentLine.VALIDATE("Account No.", '');
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        CurenceCode := '';


                                                    end
                                                    else begin

                                                        PaymentSetup.Reset();
                                                        PaymentSetup.SetFilter("Payment Account", '%1', BrojRacun);
                                                        if PaymentSetup.FindFirst() then begin

                                                            PaymentLine.VALIDATE("Account No.", '');
                                                            PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                                            CurenceCode := '';

                                                        end else begin

                                                            PaymentLine.VALIDATE("Account No.", '');
                                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                                            CurenceCode := '';

                                                        END;
                                                    end;
                                                end;


                                            END;

                                        end;
                                    end;

                                    Evaluate(Amount3, Priliv);
                                    PaymentLine.VALIDATE("Credit Amount", Amount3 / 100);
                                    Postt := CopyStr(dataline, 46, 6);
                                    Evaluate(Godina2, '20' + CopyStr(Postt, 5, 2));
                                    Evaluate(Dan2, CopyStr(Postt, 1, 2));
                                    Evaluate(Mjesec2, CopyStr(Postt, 3, 2));

                                    PostingDate := DMY2Date(Dan2, Mjesec2, Godina2);

                                    PaymentLine."Message to Recipient" := CopyStr(DataLine, 52, 9);

                                    PaymentLine2.RESET;
                                    PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                                    PaymentLine2.SETCURRENTKEY("Line No.");
                                    PaymentLine2.ASCENDING;
                                    IF PaymentLine2.FINDLAST THEN
                                        PaymentLine."Line No." := PaymentLine2."Line No." + 10000
                                    ELSE
                                        PaymentLine."Line No." := 10000;

                                    PaymentLine."Posting Date" := PostingDate;

                                    PaymentLine."Journal Batch Name" := DatePre;
                                    PaymentLine."Bal. Account Type" := PaymentLine."Bal. Account Type"::"Bank Account";
                                    PaymentLine."Bal. Account No." := Proturacun;

                                    GenJnlBatch.SETFILTER(Name, '%1', PaymentLine."Journal Batch Name");
                                    IF GenJnlBatch.FINDFIRST THEN BEGIN
                                        IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                            CLEAR(NoSeriesMgt);
                                            if BrojIzvodaIspis <> '' then
                                                PaymentLine."Document No." := BrojIzvodaIspis
                                            else
                                                PaymentLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PaymentLine."Posting Date", FALSE);
                                        END;
                                    END;
                                    PaymentLine."Journal Template Name" := JournalPre;
                                    PaymentLine."Document Type" := PaymentLine."Document Type"::Payment;

                                    if PaymentLine."Amount (LCY)" > 0 then
                                        PaymentLine."Document Type" := PaymentLine."Document Type"::" ";

                                    PaymentLine."Posting Group" := '';
                                    if Br_ZATVARANJE <> '' then begin
                                        PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                                        PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);
                                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                                        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                                            ExternalDocumentF.Reset();
                                            ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                                            ExternalDocumentF.SetFilter(Open, '%1', true);
                                            if ExternalDocumentF.FindFirst() then begin
                                                PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";
                                                PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                                PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;

                                            end
                                            else begin
                                                PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                                PaymentLine."Applies-to Ext. Doc. No." := '';
                                                PaymentLine."Applies-to Doc. No." := '';
                                            end;
                                        end;
                                    end;
                                    Evaluate(Amount3, Priliv);
                                    PaymentLine.VALIDATE("Credit Amount", Amount3 / 100);

                                    if BrojRacunaPTT <> '' then begin
                                        Br_ZATVARANJE := BrojRacunaPTT;
                                        PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                                        PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);
                                        PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                                        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                                            ExternalDocumentF.Reset();
                                            ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                                            ExternalDocumentF.SetFilter(Open, '%1', true);
                                            if ExternalDocumentF.FindFirst() then begin
                                                PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";


                                                PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                                PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                                if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                                then
                                                    PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;

                                            end
                                            else begin
                                                PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                                PaymentLine."Applies-to Ext. Doc. No." := '';
                                                PaymentLine."Applies-to Doc. No." := '';
                                            end;
                                        end;

                                    end;

                                    PaymentLine.INSERT;
                                    Brojac := Brojac + 1;



                                end
                                else begin


                                    if StrPos(DatePre, 'EUR') <> 0 then begin
                                        Postt := CopyStr(DataLine, 8, 8);

                                        BrojRacun := COPYSTR(DataLine, 56, 16);

                                        Priliv := COPYSTR(DataLine, 136, 17);
                                        Odliv := CopyStr(DataLine, 153, 17);




                                        CustomerRecord.reset;
                                        CustomerRecord.SetFilter("No.", '%1', BrojRacun);
                                        if CustomerRecord.FindFirst() then begin
                                            CustomerBankAccount.Reset();
                                            CustomerBankAccount.SetFilter(Code, '%1', CustomerRecord."Preferred Bank Account Code");
                                            if CustomerBankAccount.FindFirst() then
                                                BrojRacun := '';
                                        end;
                                        Purpose := CopyStr(DataLine, 173, 80);


                                        //posta


                                        if Linija <> 1 then begin
                                            PaymentLine.INIT;
                                            PaymentLine."Journal Batch Name" := DatePre;
                                            PaymentLine."Posting Date" := PostingDate;
                                            PaymentLine."Journal Template Name" := JournalPre;

                                            if StrPos(BrojRacun2, 'SAMOBROJFAKTURE') <> 0 then begin
                                                No_ := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                                SIH.Reset();
                                                SIH.SetFilter("No.", '%1', No_);
                                                if SIH.FindFirst() then begin

                                                    CustR.RESET;
                                                    CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
                                                    IF CustR.FINDFIRST THEN BEGIN
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                        PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                        //  PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        PaymentLine."Currency Code" := CustR."Currency Code";
                                                        //   CurenceCode := CustomerRecord."Currency Code";


                                                    end;

                                                end
                                                else begin
                                                    CustLedgerEntryFind.Reset();
                                                    CustLedgerEntryFind.SetFilter("External Document No.", '%1', InicijalnaStavka);
                                                    if CustLedgerEntryFind.findfirst then begin

                                                        CustR.RESET;
                                                        CustR.SETFILTER("No.", '%1', CustLedgerEntryFind."Customer No.");
                                                        IF CustR.FINDFIRST THEN BEGIN
                                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                            PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                            //  PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                                            PaymentLine."Currency Code" := CustR."Currency Code";
                                                            //   CurenceCode := CustomerRecord."Currency Code";


                                                        end;


                                                    end;
                                                end;


                                            end else begin

                                                /*    CustomerBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                                    IF CustomerBankAccount.FINDFIRST THEN BEGIN
                                                        CustomerRecord.RESET;
                                                        CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                                        CustomerRecord.SETFILTER("No.", '%1', CustomerBankAccount."Customer No.");
                                                        IF CustomerRecord.FINDFIRST THEN BEGIN
                                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                            //   PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                                            //   PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                                            CurenceCode := CustomerRecord."Currency Code";

                                                        END;
                                                    END
                                                    ELSE BEGIN*/
                                                VendorBankAccount.RESET;
                                                VendorBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                                IF VendorBankAccount.FINDFIRST THEN BEGIN
                                                    VendorRecord.Reset();
                                                    VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                                    VendorRecord.SETFILTER("No.", '%1', VendorBankAccount."Vendor No.");
                                                    IF VendorRecord.FIND('-') THEN BEGIN
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                                        PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                                        PaymentLine."Recipient Bank Account" := VendorRecord."Preferred Bank Account Code";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        CurenceCode := VendorRecord."Currency Code";

                                                    END;
                                                END
                                                ELSE BEGIN

                                                    EmployeeRec.reset;
                                                    EmployeeRec.SetFilter("Bank Account No.", '%1', BrojRacun);
                                                    if EmployeeRec.FindFirst() then begin
                                                        PaymentLine.VALIDATE("Account No.", '');
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        CurenceCode := '';


                                                    end
                                                    else begin

                                                        PaymentSetup.Reset();
                                                        PaymentSetup.SetFilter("Payment Account", '%1', BrojRacun);
                                                        if PaymentSetup.FindFirst() then begin

                                                            PaymentLine.VALIDATE("Account No.", '');
                                                            PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                                            CurenceCode := '';

                                                        end else begin

                                                            PaymentLine.VALIDATE("Account No.", '');
                                                            PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                            PaymentLine.Description := copystr(Purpose, 1, 100);
                                                            CurenceCode := '';

                                                        END;
                                                    end;
                                                end;
                                            END;

                                            //  end;

                                        end;

                                        if Priliv <> '00000000000000.00' then begin

                                            Evaluate(Amount3, Priliv);
                                            PaymentLine.VALIDATE("Debit Amount", Amount3 / 100);
                                        end
                                        else begin

                                            Evaluate(Amount3, Odliv);
                                            PaymentLine.VALIDATE("Credit Amount", Amount3 / 100);

                                        end;
                                        //Postt := CopyStr(dataline, 46, 6);

                                        Evaluate(Godina2, CopyStr(Postt, 5, 4));
                                        Evaluate(Dan2, CopyStr(Postt, 1, 2));
                                        Evaluate(Mjesec2, CopyStr(Postt, 3, 2));

                                        PostingDate := DMY2Date(Dan2, Mjesec2, Godina2);

                                        PaymentLine."Message to Recipient" := CopyStr(DataLine, 24, 32);

                                        PaymentLine2.RESET;
                                        PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                                        PaymentLine2.SETCURRENTKEY("Line No.");
                                        PaymentLine2.ASCENDING;
                                        IF PaymentLine2.FINDLAST THEN
                                            PaymentLine."Line No." := PaymentLine2."Line No." + 10000
                                        ELSE
                                            PaymentLine."Line No." := 10000;

                                        PaymentLine."Posting Date" := PostingDate;

                                        PaymentLine."Journal Batch Name" := DatePre;
                                        PaymentLine."Bal. Account Type" := PaymentLine."Bal. Account Type"::"Bank Account";
                                        PaymentLine."Bal. Account No." := Proturacun;

                                        GenJnlBatch.SETFILTER(Name, '%1', PaymentLine."Journal Batch Name");
                                        IF GenJnlBatch.FINDFIRST THEN BEGIN
                                            IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                                CLEAR(NoSeriesMgt);
                                                if BrojIzvodaIspis <> '' then
                                                    PaymentLine."Document No." := BrojIzvodaIspis
                                                else
                                                    PaymentLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PaymentLine."Posting Date", FALSE);
                                            END;
                                        END;
                                        PaymentLine."Journal Template Name" := JournalPre;
                                        PaymentLine."Document Type" := PaymentLine."Document Type"::Payment;
                                        if PaymentLine."Amount (LCY)" > 0 then
                                            PaymentLine."Document Type" := PaymentLine."Document Type"::" ";

                                        PaymentLine."Posting Group" := '';
                                        if Br_ZATVARANJE <> '' then begin
                                            PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                                            PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);
                                            PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                                            if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                                                ExternalDocumentF.Reset();
                                                ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                                                ExternalDocumentF.SetFilter(Open, '%1', true);
                                                if ExternalDocumentF.FindFirst() then begin
                                                    PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";

                                                    PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                                    PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                                    if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                                    then
                                                        PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                                    if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                                    then
                                                        PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                                    if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                                    then
                                                        PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;
                                                end
                                                else begin
                                                    PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                                    PaymentLine."Applies-to Ext. Doc. No." := '';
                                                    PaymentLine."Applies-to Doc. No." := '';
                                                end;
                                            end;
                                        end;
                                        if Priliv <> '00000000000000.00' then begin

                                            Evaluate(Amount3, Priliv);
                                            PaymentLine.VALIDATE("Debit Amount", Amount3 / 100);
                                        end
                                        else begin

                                            Evaluate(Amount3, Odliv);
                                            PaymentLine.VALIDATE("Credit Amount", Amount3 / 100);

                                        end;

                                        PaymentLine.INSERT;
                                        Brojac := Brojac + 1;
                                    end
                                    else begin

                                        BrojRacun := COPYSTR(DataLine, 37, 35);
                                        BrojRacun := DelChr(BrojRacun, '=', '/');
                                        BrojRacun := DelChr(BrojRacun);



                                        Nal2 := COPYSTR(DataLine, 72, 35);
                                        skraceno := StrPos(Nal2, '  ');
                                        Nal2 := CopyStr(DataLine, 72, skraceno);


                                        Nal3 := COPYSTR(DataLine, 106, 35);
                                        Nal3 := DelChr(Nal3, '=', '  ');
                                        Nal4 := COPYSTR(DataLine, 142, 35);
                                        Nal4 := DelChr(Nal4, '=', '  ');

                                        Purpose := CopyStr(DataLine, 177, 70);
                                        Indikator := CopyStr(DataLine, 247, 1); //predznak
                                        AmountText := COPYSTR(DataLine, 248, 17);
                                        AmountText := DelChr(AmountText, '', '=');
                                        IF EVALUATE(Amount3, AmountText) THEN
                                            Amount3 := ROUND(Amount3 / 100, 0.01, '<');

                                        CurenceCode := COPYSTR(DataLine, 265, 3);
                                        Postt := COPYSTR(DataLine, 316, 8);
                                        IF EVALUATE(Dan, COPYSTR(Postt, 7, 2)) THEN
                                            Dan2 := Dan
                                        ELSE
                                            Dan2 := 0;

                                        IF EVALUATE(Mjesec, COPYSTR(Postt, 5, 2)) THEN
                                            Mjesec2 := Mjesec
                                        ELSE
                                            Mjesec2 := 0;


                                        IF EVALUATE(Godina, COPYSTR(Postt, 1, 4)) THEN
                                            Godina2 := Godina
                                        ELSE
                                            Godina2 := 0;




                                        PostingDate := DMY2DATE(Dan2, Mjesec2, Godina2);

                                        PaymentLine.INIT;
                                        PaymentLine."Journal Batch Name" := DatePre;
                                        PaymentLine."Journal Template Name" := JournalPre;
                                        PaymentLine."Posting Date" := PostingDate;
                                        PaymentLine."Message to Recipient" := Nal4 + Nal2 + Nal3;
                                        PaymentLine."Payment Reference" := CopyStr(DataLine, 21, 10);

                                        BrojRacun2 := ChangeBrojRacuna(PaymentLine."Message to Recipient", '01-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;
                                        if BrojRacun2 = '' then
                                            BrojRacun2 := ChangeBrojRacuna(PaymentLine."Message to Recipient", '02-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;
                                        if BrojRacun2 = '' then
                                            BrojRacun2 := ChangeBrojRacuna(PaymentLine."Message to Recipient", '03-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;

                                        if BrojRacun2 = '' then
                                            BrojRacun2 := ChangeBrojRacuna(Purpose, '01-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;
                                        if BrojRacun2 = '' then
                                            BrojRacun2 := ChangeBrojRacuna(Purpose, '02-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;

                                        if BrojRacun2 = '' then
                                            BrojRacun2 := ChangeBrojRacuna(Purpose, '03-');

                                        if BrojRacun2 <> '' then begin
                                            BrojRacun := BrojRacun2;
                                            InicijalnaStavka := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                        end;



                                        if StrPos(BrojRacun2, 'SAMOBROJFAKTURE') <> 0 then begin
                                            No_ := ReplaceString(BrojRacun2, 'SAMOBROJFAKTURE', '');
                                            SIH.Reset();
                                            SIH.SetFilter("No.", '%1', No_);
                                            if SIH.FindFirst() then begin

                                                CustR.RESET;
                                                CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
                                                IF CustR.FINDFIRST THEN BEGIN
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                    PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                    // PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                                    PaymentLine."Currency Code" := CustR."Currency Code";
                                                    //   CurenceCode := CustomerRecord."Currency Code";


                                                end;

                                            end
                                            else begin
                                                CustLedgerEntryFind.Reset();
                                                CustLedgerEntryFind.SetFilter("External Document No.", '%1', InicijalnaStavka);
                                                if CustLedgerEntryFind.findfirst then begin

                                                    CustR.RESET;
                                                    CustR.SETFILTER("No.", '%1', CustLedgerEntryFind."Customer No.");
                                                    IF CustR.FINDFIRST THEN BEGIN
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                        PaymentLine.VALIDATE("Account No.", CustR."No.");
                                                        // PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        PaymentLine."Currency Code" := CustR."Currency Code";
                                                        //   CurenceCode := CustomerRecord."Currency Code";


                                                    end;


                                                end;
                                            end;


                                        end

                                        else begin
                                            /*  CustomerRecord.RESET;
                                              VendorRecord.RESET;
                                              CustomerBankAccount.RESET;
                                              CustomerBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                              IF CustomerBankAccount.FINDFIRST THEN BEGIN
                                                  CustomerRecord.RESET;
                                                  CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                                  CustomerRecord.SETFILTER("No.", '%1', CustomerBankAccount."Customer No.");
                                                  IF CustomerRecord.FINDFIRST THEN BEGIN
                                                      PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                      //  PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");
                                                      //   PaymentLine."Recipient Bank Account" := CustomerRecord."Preferred Bank Account Code";
                                                      PaymentLine.Description := copystr(Purpose, 1, 100);
                                                      CurenceCode := CustomerRecord."Currency Code";

                                                  END;
                                              END
                                              ELSE BEGIN*/
                                            VendorBankAccount.RESET;
                                            VendorBankAccount.SETFILTER("Bank Account No.", '%1', BrojRacun);
                                            IF VendorBankAccount.FINDFIRST THEN BEGIN
                                                VendorRecord.Reset();
                                                VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                                VendorRecord.SETFILTER("No.", '%1', VendorBankAccount."Vendor No.");
                                                IF VendorRecord.FIND('-') THEN BEGIN
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                                    PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                                    PaymentLine."Recipient Bank Account" := VendorRecord."Preferred Bank Account Code";
                                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                                    CurenceCode := VendorRecord."Currency Code";

                                                END;
                                            END
                                            ELSE BEGIN
                                                EmployeeRec.reset;
                                                EmployeeRec.SetFilter("Bank Account No.", '%1', BrojRacun);

                                                if EmployeeRec.FindFirst() then begin
                                                    PaymentLine.VALIDATE("Account No.", '');
                                                    PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                    PaymentLine.Description := copystr(Purpose, 1, 100);
                                                    CurenceCode := '';


                                                end
                                                else begin

                                                    PaymentSetup.Reset();
                                                    PaymentSetup.SetFilter("Payment Account", '%1', BrojRacun);
                                                    if PaymentSetup.FindFirst() then begin

                                                        PaymentLine.VALIDATE("Account No.", '');
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::"G/L Account";
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        CurenceCode := '';

                                                    end else begin

                                                        PaymentLine.VALIDATE("Account No.", '');
                                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                        PaymentLine.Description := copystr(Purpose, 1, 100);
                                                        CurenceCode := '';

                                                    END;

                                                end;
                                            end;
                                            // END;
                                        end;

                                        if PaymentLine."Payment Reference" <> '' then begin
                                            CustLedg.Reset();
                                            CustLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                                            if CustLedg.FindFirst() then begin
                                                PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                                PaymentLine.Validate("Account No.", CustLedg."Customer No.");

                                            end;

                                            VendorLedg.Reset();
                                            VendorLedg.SetFilter("Payment Reference", '%1', PaymentLine."Payment Reference");
                                            if VendorLedg.FindFirst() then begin

                                                PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                                PaymentLine.Validate("Account No.", VendorLedg."Vendor No.");
                                            end;


                                        end;
                                        PaymentLine.VALIDATE("Credit Amount", Amount3);
                                        PaymentLine2.RESET;
                                        PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                                        PaymentLine2.SETCURRENTKEY("Line No.");
                                        PaymentLine2.ASCENDING;
                                        IF PaymentLine2.FINDLAST THEN
                                            PaymentLine."Line No." := PaymentLine2."Line No." + 10000
                                        ELSE
                                            PaymentLine."Line No." := 10000;

                                        PaymentLine."Posting Date" := PostingDate;


                                        PaymentLine."Journal Batch Name" := DatePre;
                                        PaymentLine."Bal. Account Type" := PaymentLine."Bal. Account Type"::"Bank Account";
                                        PaymentLine."Bal. Account No." := Proturacun;

                                        GenJnlBatch.SETFILTER(Name, '%1', PaymentLine."Journal Batch Name");
                                        IF GenJnlBatch.FINDFIRST THEN BEGIN
                                            IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                                                CLEAR(NoSeriesMgt);
                                                if BrojIzvodaIspis <> '' then
                                                    PaymentLine."Document No." := BrojIzvodaIspis
                                                else
                                                    PaymentLine."Document No." := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PaymentLine."Posting Date", FALSE);
                                            END;
                                        END;
                                        PaymentLine."Posting Date" := PostingDate;
                                        PaymentLine.Description := copystr(Purpose, 1, 100);

                                        PaymentLine."Journal Template Name" := JournalPre;
                                        PaymentLine."Document Type" := PaymentLine."Document Type"::Payment;
                                        if PaymentLine."Amount (LCY)" > 0 then
                                            PaymentLine."Document Type" := PaymentLine."Document Type"::" ";

                                        PaymentLine."Posting Group" := '';
                                        if Br_ZATVARANJE <> '' then begin
                                            PaymentLine.validate("Applies-to Doc. Type", PaymentLine."Applies-to Doc. Type"::Invoice);
                                            PaymentLine.Validate("Applies-to Doc. No.", Br_ZATVARANJE);
                                            PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";

                                            if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then begin
                                                ExternalDocumentF.Reset();
                                                ExternalDocumentF.SetFilter("Document No.", '%1', PaymentLine."Applies-to Doc. No.");
                                                ExternalDocumentF.SetFilter(Open, '%1', true);
                                                if ExternalDocumentF.FindFirst() then begin
                                                    PaymentLine."Applies-to Ext. Doc. No." := ExternalDocumentF."External Document No.";

                                                    PaymentLine."Bill type" := ExternalDocumentF."Bill type";
                                                    PaymentLine."Bill Category" := ExternalDocumentF."Bill Category";
                                                    if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '01')
                                                    then
                                                        PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Large Economy";

                                                    if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '02')
                                                    then
                                                        PaymentLine."Bill Category" := PaymentLine."Bill Category"::"Small Economy";

                                                    if (PaymentLine."Bill Category" = PaymentLine."Bill Category"::" ") and (PaymentLine."Bill type" = '03')
                                                    then
                                                        PaymentLine."Bill Category" := PaymentLine."Bill Category"::Household;

                                                end
                                                else begin
                                                    PaymentLine."Applies-to Doc. Type" := PaymentLine."Applies-to Doc. Type"::" ";
                                                    PaymentLine."Applies-to Ext. Doc. No." := '';
                                                    PaymentLine."Applies-to Doc. No." := '';
                                                end;
                                            end;
                                        end;
                                        PaymentLine.VALIDATE("Credit Amount", Amount3);
                                        PaymentLine.INSERT;
                                        Brojac := Brojac + 1;


                                    end;

                                end;
                            end;
                            Proc := ROUND((DataFile.POS / DataFile.LEN * 10000), 1, '=');


                        end;

                    end;

                end;
                IF GUIALLOWED THEN
                    Window.UPDATE;

            END;


        end;
        DataFile.CLOSE;
    end;

    var
        TempFile: File;
        Skraceno: Integer;
        Odliv: text[250];
        Priliv: text[250];
        PrviDIo: Integer;
        Opis: text[250];
        DrugiDio: Integer;
        Dalje: Text[250];
        Dalje2: Text[250];
        Charr: Char;
        RedTransakcije: Text;
        Linija: Integer;
        FileName: Text;
        Selected: Option " ","Unicredit","Intesa San Paolo","Union","Zirat";
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
        Sales_Invoice_Header: Record "Sales Invoice Header";
        PostingDate: Date;
        PaymentLine: Record "Gen. Journal Line";
        CustomerRecord: Record "Customer";
        VendorRecord: Record "Vendor";

        CustPrepo: Record Customer;
        CustomerBankAccount: Record "Customer Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
        PaymentLine2: Record "Gen. Journal Line";
        CurenceCode: Text;
        DatePre: Text;
        BrojRacun2: text[250];
        Sep: Decimal;
        TabDa: Boolean;
        JournalPre: Text;
        Character: array[489] of Text;
        I: Integer;
        No_: code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        Text005: Label 'Please select a valid File name first!';
        Text040: Label 'Xml file(*.xml)|*.xml|Text file(*.txt)|*.txt';
        BrojIzvoda: Text;
        DatumZaglavlja: Text;
        BrojIzvodaIspis: Text;
        BrojRacunaPTT: text;
        BrojRacunaPTT1: text;
        BrojRacunaPTT2: text;
        BrojRacunaPTT3: text;
        PartDate1: Text;
        ExternalDocumentF: Record "Cust. Ledger Entry";
        DateEvaluate: Date;
        PartDate2: Text;
        PartDate3: Text;
        Text000: Label 'Import File';
        NoSeriesU: Record "No. Series Line";
        Text004: Label 'Importing Data from file @1@@@@@@@@';
        CustR: Record Customer;

        Br_ZATVARANJE: Code[20];
        SIH: Record "Sales Invoice Header";
        Text12: array[12] of Text[2500];
        CustLedg: Record "Cust. Ledger Entry";
        VendorLedg: Record "Vendor Ledger Entry";

        EmployeeRec: Record Employee;
        PaymentSetup: Record "Contribution Payments Setup";



    procedure ChangeBrojRacuna(Input: Text; Output: text) NewBroj: text
    var
        CustLedgerEntryFind: Record "Cust. Ledger Entry";
        DocumentFilters: text;
    begin

        Br_ZATVARANJE := '';

        if (StrPos(Input, Output) <> 0) then begin

            //BrojRacu

            if copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 2), 1, 22) <> '' then
                DocumentFilters := copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 2), 1, 22) + '|' + copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 4), 1, 22)
            else
                DocumentFilters := copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 2), 1, 22);


            Sales_Invoice_Header.Reset();
            Sales_Invoice_Header.SetFilter("Document No_", DocumentFilters);
            //   Sales_Invoice_Header.SetFilter("No.",'%1',);

            if Sales_Invoice_Header.FindFirst() then begin

                Br_ZATVARANJE := Sales_Invoice_Header."No.";
                NewBroj := 'SAMOBROJFAKTURE' + Sales_Invoice_Header."No.";

                CustPrepo.Reset();
                CustPrepo.SetFilter("No.", '%1', Sales_Invoice_Header."Bill-to Customer No.");
                if CustPrepo.FindFirst() then begin
                    CustomerBankAccount.Reset();
                    CustomerBankAccount.SetFilter(Code, '%1', CustPrepo."Preferred Bank Account Code");
                    CustomerBankAccount.SetFilter("Customer No.", '%1', CustPrepo."No.");
                    if CustomerBankAccount.FindFirst() then
                        NewBroj := 'SAMOBROJFAKTURE' + Sales_Invoice_Header."No."
                end
                else begin
                    NewBroj := 'SAMOBROJFAKTURE' + Sales_Invoice_Header."No.";
                end;
            end
            else begin

                if copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 2), 1, 35) <> '' then
                    DocumentFilters := copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 2), 1, 35) + '|' + copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 4), 1, 35)
                else
                    DocumentFilters := copystr(CopyStr(Input, (StrPos(Input, Output)), strpos(CopyStr(Input, (StrPos(Input, Output)), StrLen(Input)), '/') + 2), 1, 35);


                CustLedgerEntryFind.Reset();
                CustLedgerEntryFind.SetFilter("External Document No.", DocumentFilters);
                if CustLedgerEntryFind.FindFirst() then begin
                    Br_ZATVARANJE := CustLedgerEntryFind."External Document No.";
                    NewBroj := 'SAMOBROJFAKTURE' + CustLedgerEntryFind."External Document No.";

                    CustPrepo.Reset();
                    CustPrepo.SetFilter("No.", '%1', CustLedgerEntryFind."Customer No.");
                    if CustPrepo.FindFirst() then begin
                        CustomerBankAccount.Reset();
                        CustomerBankAccount.SetFilter(Code, '%1', CustPrepo."Preferred Bank Account Code");
                        CustomerBankAccount.SetFilter("Customer No.", '%1', CustPrepo."No.");
                        if CustomerBankAccount.FindFirst() then
                            NewBroj := 'SAMOBROJFAKTURE' + CustLedgerEntryFind."External Document No."
                    end
                    else begin
                        NewBroj := 'SAMOBROJFAKTURE' + CustLedgerEntryFind."External Document No.";
                    end;
                end;

            end;

        end;

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

    procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250]
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;


    /*procedure InsertWithoutAccount(PaymentLine: Record "Gen. Journal Line"; RacunB: text[250]; PurposeT: Text[100])
    var
        SIH: Record "Sales Invoice Header";
        CustR: Record customer;
        No_: text[250];
    begin

        No_ := ReplaceString(RacunB, 'SAMOBROJFAKTURE', '');
        SIH.Reset();
        SIH.SetFilter("No.", '%1', No_);
        if SIH.FindFirst() then begin

            CustR.RESET;
            CustR.SETFILTER("No.", '%1', SIH."Bill-to Customer No.");
            IF CustR.FINDFIRST THEN BEGIN
                PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                PaymentLine.VALIDATE("Account No.", CustR."No.");
                PaymentLine."Recipient Bank Account" := CustR."Preferred Bank Account Code";
                PaymentLine.Description := PurposeT;
                PaymentLine."Currency Code" := CustR."Currency Code";
                //   CurenceCode := CustomerRecord."Currency Code";


            end;

        end;


*/

    //    end;

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
}

