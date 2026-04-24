report 50068 "Read bank statement"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Read bank statement.rdlc';
    ShowPrintStatus = false;
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Import; Import)
                {
                    Caption = 'Import';
                }
                field(Type; Type)
                {
                    Caption = 'Type';
                }
                field(StartExport; StartExport)
                {
                    Caption = 'Start Date';
                }
                field(EndExport; EndExport)
                {
                    Caption = 'End Date';
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

    trigger OnPostReport()
    begin
        IF Import = Import::Uvoz THEN BEGIN
            FirstLine := TRUE;
            Tab := 9;
            TempFile.CREATETEMPFILE(TEXTENCODING::UTF8);
            FileName := TempFile.NAME + '.txt';
            TempFile.CLOSE;

            Proceed := UPLOAD(Text000, '', Text040, '', FileName);

            IF NOT Proceed THEN
                ERROR(Text005);

            IF FILE.EXISTS(FileName) THEN
                DataFile.OPEN(FileName)
            ELSE
                ERROR(Text005);
            Brojac := 1;

            IF GUIALLOWED THEN
                Window.OPEN(Text004, Proc);
            DataFile.TEXTMODE := TRUE;
            //WHILE DataFile.POS < DataFile.LEN DO BEGIN
            /* CLEAR(Character);
             FOR i := 1 TO 489 DO
               DataFile.READ(Character[i]);
             CLEAR(DataLine);
             FOR i := 1 TO 489 DO
               DataLine := DataLine + FORMAT(Character[i]);*/

            DataFile.CLOSE;
            DataFile.OPEN(FileName);

            DataFile.CREATEINSTREAM(StreamInTest);
            WHILE NOT StreamInTest.EOS DO BEGIN
                StreamInTest.READTEXT(DataLine);


                IF FirstLine = TRUE THEN BEGIN

                    FirstLine := FALSE;
                END
                ELSE BEGIN

                    //pročitati druge redove
                    IF STRPOS(DataLine, FORMAT(Tab)) <> 0 THEN BEGIN
                        Dugujee := COPYSTR(DataLine, 1, 1);
                        EVALUATE(PostingEva, COPYSTR(DataLine, STRPOS(DataLine, FORMAT(Tab)), 10));
                        PostingDate := PostingEva;

                    END;


                    Brojac := 0;
                    WHILE (Brojac <> 13) DO BEGIN

                        DataLine2 := DataLine;
                        DataLine2 := COPYSTR(DataLine2, STRPOS(DataLine, FORMAT(Tab)) + 1, STRLEN(DataLine));

                        Brojac := Brojac + 1;
                        ArrayList[Brojac] := COPYSTR(DataLine, STRPOS(DataLine, FORMAT(Tab)), STRPOS(DataLine2, FORMAT(Tab)));
                        IF Brojac = 1 THEN BEGIN
                            Datum := COPYSTR(DataLine, STRPOS(DataLine, FORMAT(Tab)), 11);
                            EVALUATE(PostingEva, COPYSTR(DataLine, STRPOS(DataLine, FORMAT(Tab)), 11));
                            PostingDate := PostingEva;
                            PaymentLine.INIT;
                            PaymentLine."Journal Batch Name" := 'OPŠTE';
                            PaymentLine."Journal Template Name" := 'OPŠTE';

                            PaymentLine."Posting Date" := PostingDate;
                        END;

                        IF Brojac = 2 THEN BEGIN

                            PaymentLine."Document No." := DELCHR(ArrayList[Brojac], '=', FORMAT(Tab));
                        END;
                        IF Brojac = 3 THEN BEGIN
                            PaymentLine.Comment := DELCHR(ArrayList[Brojac], '=', FORMAT(Tab));
                        END;

                        IF Brojac = 11 THEN BEGIN

                            IF Dugujee = '-' THEN BEGIN
                                EVALUATE(Amount2, DELCHR(ArrayList[Brojac], '=', FORMAT(Tab)));
                                PaymentLine."Debit Amount" := Amount2;

                            END
                            ELSE BEGIN

                                EVALUATE(Amount2, DELCHR(ArrayList[Brojac], '=', FORMAT(Tab)));
                                PaymentLine."Credit Amount" := Amount2;

                            END;
                        END;
                        IF Brojac = 9 THEN BEGIN
                            PaymentLine.Description := COPYSTR(DELCHR(ArrayList[Brojac], '=', FORMAT(Tab)), 1, 50);
                        END;

                        IF Brojac = 7 THEN BEGIN
                            ReceiversBankAccount := ArrayList[Brojac];
                            ReceiversBankAccount := DELCHR(ReceiversBankAccount, '=', ' ');
                            ReceiversBankAccount := DELCHR(ReceiversBankAccount, '=', FORMAT(Tab));

                            IF ReceiversBankAccount = '' THEN BEGIN
                                Comppp.GET;
                                ReceiversBankAccount := Comppp."Bank Account No.";
                            END;
                            CustomerRecord.RESET;
                            VendorRecord.RESET;
                            CustomerBankAccount.RESET;
                            CustomerBankAccount.SETFILTER("Bank Account No.", '%1', ReceiversBankAccount);
                            IF CustomerBankAccount.FINDFIRST THEN BEGIN
                                CustomerRecord.RESET;
                                CustomerRecord.SETFILTER("Preferred Bank Account Code", '%1', CustomerBankAccount.Code);
                                IF CustomerRecord.FINDFIRST THEN BEGIN
                                    PaymentLine."Account Type" := PaymentLine."Account Type"::Customer;
                                    PaymentLine.VALIDATE("Account No.", CustomerRecord."No.");

                                END;
                                CurenceCode := CustomerRecord."Currency Code";

                            END
                            ELSE BEGIN



                                VendorBankAccount.RESET;
                                VendorBankAccount.SETFILTER("Bank Account No.", '%1', ReceiversBankAccount);
                                IF VendorBankAccount.FINDFIRST THEN BEGIN
                                    VendorRecord.SETFILTER("Preferred Bank Account Code", '%1', VendorBankAccount.Code);
                                    IF VendorRecord.FIND('-') THEN BEGIN
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::Vendor;
                                        PaymentLine.VALIDATE("Account No.", VendorRecord."No.");
                                        PaymentLine.Description := MoneyOrderMadeBy;
                                        CurenceCode := VendorRecord."Currency Code";

                                    END
                                    ELSE BEGIN
                                        PaymentLine."Account Type" := PaymentLine."Account Type"::"Bank Account";
                                        //PaymentLine.VALIDATE("Account No.",CustomerRecord."Preferred Bank Account");
                                        CurenceCode := '';

                                    END;
                                END;







                            END;




                        END;





                        DataLine := COPYSTR(DataLine, STRPOS(DataLine, ArrayList[Brojac]) + 1, STRLEN(DataLine));




                    END;
                    PaymentLine2.RESET;
                    PaymentLine2.SETFILTER("Line No.", '<>%1', 0);
                    PaymentLine2.SETCURRENTKEY("Line No.");
                    PaymentLine2.ASCENDING;
                    IF PaymentLine2.FINDLAST THEN
                        PaymentLine."Line No." := PaymentLine2."Line No." + 1
                    ELSE
                        PaymentLine."Line No." := 1;
                    PaymentLine.INSERT;

                END;
            END;



        END
        ELSE BEGIN
            //izvoz


            File1.CREATE('\\INFODOM-PC1\Users\ajna.gazibegovic\Documents\KIF_KUF\Izvod.txt');
            File1.CREATEOUTSTREAM(OutStreamObj);
            FirstString := FORMAT(Type);
            FirstString += FORMAT(Tab);
            FirstString += FORMAT(StartExport);
            FirstString += FORMAT(Tab);
            FirstString += FORMAT(EndExport);
            OutStreamObj.WRITETEXT(FirstString);

            OutStreamObj.WRITETEXT(); // This command is to move to next line
            PaymentLine.RESET;
            PaymentLine.SETFILTER("Journal Template Name", '%1', 'OPŠTE');
            PaymentLine.SETFILTER("Journal Batch Name", '%1', 'OPŠTE');
            IF PaymentLine.FINDSET THEN
                REPEAT
                    LastString := '';
                    IF PaymentLine."Debit Amount" <> 0 THEN
                        LastString := '-'
                    ELSE
                        LastString := '+';
                    LastString += FORMAT(Tab);
                    LastString += FORMAT(PaymentLine."Posting Date");
                    LastString += ' 00:00:00';
                    LastString += FORMAT(Tab);
                    LastString += PaymentLine."Document No.";
                    LastString += FORMAT(Tab);
                    LastString += PaymentLine.Comment;
                    LastString += '';
                    LastString += FORMAT(Tab);
                    LastString += FORMAT(Tab);
                    LastString += '140';
                    LastString += FORMAT(Tab);
                    LastString += FORMAT(Tab);

                    IF PaymentLine."Account Type" = PaymentLine."Account Type"::Customer THEN BEGIN
                        CustomerBankAccount.RESET;
                        CustomerBankAccount.SETFILTER("Customer No.", '%1', PaymentLine."Account No.");
                        IF CustomerBankAccount.FINDFIRST THEN
                            LastString += CustomerBankAccount."Bank Account No.";

                    END;


                    IF PaymentLine."Account Type" = PaymentLine."Account Type"::Vendor THEN BEGIN

                        VendorBankAccount.RESET;
                        VendorBankAccount.SETFILTER("Vendor No.", '%1', PaymentLine."Account No.");
                        IF VendorBankAccount.FINDFIRST THEN
                            LastString += VendorBankAccount."Bank Account No.";

                    END;
                    Comppp.GET;

                    IF PaymentLine."Account Type" = PaymentLine."Account Type"::"Bank Account" THEN BEGIN

                        IF PaymentLine."Account No." <> '' THEN
                            LastString += PaymentLine."Account No."
                        ELSE
                            LastString += Comppp."Bank Account No.";

                    END;
                    LastString += FORMAT(Tab);
                    LastString += PaymentLine.Description;
                    LastString += FORMAT(Tab);
                    LastString += FORMAT('BAM');
                    LastString += FORMAT(Tab);
                    IF PaymentLine."Debit Amount" <> 0 THEN
                        LastString += FORMAT(PaymentLine."Debit Amount")
                    ELSE
                        LastString += FORMAT(PaymentLine."Credit Amount");
                    LastString += FORMAT(Tab);
                    OutStreamObj.WRITETEXT(LastString);

                    OutStreamObj.WRITETEXT();

                UNTIL PaymentLine.NEXT = 0;

            File1.CLOSE;
            Message('Fajl je pohranjen na lokaciji \\INFODOM-PC1\Users\ajna.gazibegovic\Documents\KIF_KUF\');
        END;


    end;

    var
        TempFile: File;
        FileName: Text;
        Proceed: Boolean;
        DataFile: File;
        Brojac: Integer;
        Window: Dialog;
        Proc: Integer;
        Tab: Char;
        StreamInTest: InStream;
        Import: Option " ",Uvoz,Izvoz;
        DataLine: Text;
        File1: File;
        OutStreamObj: OutStream;
        ReceiversBankAccount: Text;
        Tab2: Text;
        AmountText: Text;
        Amount3: Decimal;
        Amount2: Decimal;
        AmountText2: Text;
        Comppp: Record "Company Information";
        Dugujee: Text;
        PaymentBasisCode: Text;
        Datum: Text;
        Type: Option " ","102","14";
        LastString: Text;
        FirstString: Text;
        Purpose: Text;
        MoneyOrderMadeBy: Text;
        CreditBankAccountNo: Text;
        BankAccNo: Text;
        FirstLine: Boolean;
        PDateDay: Integer;
        PDateMonth: Integer;
        PDateYear: Integer;
        DataLine2: Text;
        PostingDate: Date;
        PaymentLine: Record "Gen. Journal Line";
        ArrayList: array[200] of Text;
        CustomerRecord: Record Customer;
        VendorRecord: Record Vendor;
        CustomerBankAccount: Record "Customer Bank Account";
        VendorBankAccount: Record "Vendor Bank Account";
        PaymentLine2: Record "Gen. Journal Line";
        CurenceCode: Text;
        DatePre: Text;
        Character: array[489] of Text;
        I: Integer;
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        Text005: Label 'Please select a valid File name first!';
        Text040: Label 'Xml file(*.xml)|*.xml|Text file(*.txt)|*.txt';
        Text000: Label 'Import File';
        Text004: Label 'Importing Data from file @1@@@@@@@@';
        PostingEva: Date;
        StartExport: Date;
        EndExport: Date;
}


