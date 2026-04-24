pageextension 50018 CashReceiptJournal extends "Cash Receipt Journal"
{

    //ED

    layout
    {
        addafter("Total Balance")
        {

            group(TotalCard)

            {
                Caption = 'Total Card';
                field(TotalCard2; TotalCard)
                {
                    caption = 'Total Card';

                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group(TotalCash)
            {
                Caption = 'Total Cash';
                field(TotalCash2; TotalCash)
                {
                    caption = 'Total Cash';
                    ShowCaption = true;
                    ApplicationArea = all;
                    Editable = false;
                }

            }


            group(TotalCardAndCash)
            {
                Caption = 'Total Card and Cash';
                field(TotalCardAndCash2; TotalCardAndCash)
                {
                    Caption = 'Total Card And Cash';
                    ShowCaption = true;
                    ApplicationArea = all;
                    Editable = falsE;


                }

            }

        }


        //pocetka 

        addafter(CurrentJnlBatchName)
        {


            grid(Groups)
            {
                GridLayout = Rows;
                ShowCaption = false;

                group(Postis3)
                {

                    field(CurrentJnlBatchName2; CurrentJnlBatchName2)
                    {

                        ApplicationArea = Basic, Suite;
                        Caption = 'Batch Name';
                        Lookup = true;
                        ToolTip = 'Specifies the name of the journal batch, a personalized journal layout, that the journal is based on.';

                        //  Visible = false;


                    }
                }

                group(Postis)
                {
                    ShowCaption = false;

                    field("Posting Date Cash"; "Posting Date Cash")
                    {
                        ApplicationArea = all;
                        Caption = 'Posting Date (Cash)';
                    }

                    field("Posting Date Card"; "Posting Date Card")
                    {
                        ApplicationArea = all;
                        Caption = 'Posting Date (Card)';
                    }
                }

                group(Postis2)
                {
                    ShowCaption = false;

                    field(TotalAmountRow; TotalAmountRow)
                    {
                        ApplicationArea = all;
                        Caption = 'Total Amount';
                        Visible = NOT (Show);
                    }

                    field(TotalAmountRow2; TotalAmountRow2)
                    {
                        ApplicationArea = all;
                        Caption = 'Total Amount';
                        Visible = NOT (Show);
                    }
                }
            }

        }
        //kraj

        addafter(Description)
        {
            field("Gauge Code"; "Gauge Code")
            {

                Style = AttentionAccent;
                DrillDownPageId = "Installation History Page";
                //    LookupPageId = "Installation History Page";

                StyleExpr = ColorStyle;
            }

        }

        modify(IncomingDocAttachFactBox)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Applies-to Doc. No.")
        {
            ShowMandatory = true;
            Style = AttentionAccent;

            StyleExpr = ColorStyle;
            trigger OnAfterValidate()
            var
                myInt: Integer;
                TempRec: Record "Gen. Journal Line";
            begin



                //   CurrPage."JournalLineDetails".PAGE.Update();

                // Save key fields
                TempRec := Rec;

                // Forsiraj promjenu "fokusa"
                //  Clear(Rec);
                Rec := TempRec;
                CurrPage.SaveRecord();
                CurrPage.update();
            end;

        }

        addafter("Posting Date")
        {
            field("Payment No."; "Payment No.") { Editable = false; visible = false; }
            field("Payment No. order"; "Payment No. order")
            {
                Editable = false;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
            }
            field("Payment DT"; "Payment DT")
            {
                ApplicationArea = all;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
            }
            field("Payment Type"; "Payment Type")
            {
                ApplicationArea = all;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    CustT: Record "Customer Templ.";
                    CustPage: page "Customer Templ. List";
                begin
                    CustT.Reset();
                    CustPage.Run();



                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    CustT: Record "Customer Templ.";
                    CustPage: page "Customer Templ. List";
                begin
                    CustPage.LOOKUPMODE(TRUE);
                    IF CustPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        CustPage.GETRECORD(CustT);
                        "Payment Type" := CustT.Code;
                    end;


                    //CustT.Reset();
                    //CustPage.Run();

                end;

            }
            field("Payment Method"; "Payment Method")
            {
                ApplicationArea = all;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
            }
        }



        movebefore(Amount; "Applies-to Doc. No.")

        addafter("Applies-to Doc. No.")
        {
            field("Mupltiple customers"; "Mupltiple customers")
            {
                ApplicationArea = all;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
                trigger OnValidate()
                begin
                    TotalAmountMultipleCustomers := 0;
                    GJline.Reset();
                    GJline.SetFilter("Cashier Employer", '%1', Rec."Cashier Employer");
                    GJline.SetFilter("Mupltiple customers", '%1', true);
                    if GJline.FindFirst() then
                        repeat
                            TotalAmountMultipleCustomers += Abs(GJline.Amount);
                        until GJline.Next() = 0;
                end;
            }
        }

        moveafter("Bal. VAT Amount"; "Applies-to Doc. Type")
        moveafter("Document No."; "Account Type")
        movebefore("Applies-to Doc. Type"; "Document Type")

        addafter("Applies-to Doc. No.")
        {
            field("Request Document"; "Request Document")
            {
                ApplicationArea = all;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
                DrillDownPageId = 50189;
                LookupPageId = 50189;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    SH: Record "Service Header";
                    RList: page Requests;
                begin
                    sh.Reset;
                    if rec."Account No." <> '' then
                        sh.SetFilter("Customer No.", '%1', rec."Account No.");
                    sh.setfilter("Request Type", '%1|%2|%3|%4|%5|%6|%7', 0, 1, 3, 5, 8, 9, 10);
                    RList.SetTableView(SH);
                    RList.LOOKUPMODE(TRUE);

                    IF RList.RUNMODAL = ACTION::LookupOK THEN BEGIN

                        RList.GETRECORD(sh);
                        rec.validate("Request Document", sh."No.");
                    END;



                end;
            }
        }

        addafter("Account No.")
        {
            field("Account No. Change"; "Account No. Change")
            {
                Visible = true;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;

                trigger OnValidate()
                var
                    myInt: Integer;
                    TempRec: Record "Gen. Journal Line";
                begin
                    //   CurrPage."JournalLineDetails".PAGE.Update();

                    // Save key fields
                    TempRec := Rec;

                    // Forsiraj promjenu "fokusa"
                    //  Clear(Rec);
                    Rec := TempRec;
                    CurrPage.SaveRecord();
                    CurrPage.update();

                end;

            }
        }
        modify("Account No.")
        {
            Visible = false;
            Style = AttentionAccent;

            StyleExpr = ColorStyle;
        }


        addafter("Amount (LCY)")
        {
            field("Given amount"; "Given amount")
            {
                ApplicationArea = all;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
            }
            field("To return"; "To return")
            {
                ApplicationArea = all;
                Style = AttentionAccent;

                StyleExpr = ColorStyle;
            }
        }
        moveafter("Bal. Account No."; "Posting Date")
        moveafter("To return"; "Document No.")
        modify("Applied (Yes/No)")
        {
            Visible = false;

        }
        modify(Description)
        {
            Editable = false;
            Style = AttentionAccent;

            StyleExpr = ColorStyle;
        }

        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify(CurrentJnlBatchName)
        {
            Visible = false;
        }
        modify("Account Type")
        {
            Style = AttentionAccent;
            StyleExpr = ColorStyle;

        }
        modify("Document No.")
        {
            Style = AttentionAccent;
            StyleExpr = ColorStyle;
        }
        modify("Document Type")
        {
            Style = AttentionAccent;
            StyleExpr = ColorStyle;
        }
        modify("Applies-to Doc. Type")
        {
            Style = AttentionAccent;
            StyleExpr = ColorStyle;
        }
        modify("Bal. Account Type")
        {
            Style = AttentionAccent;
            StyleExpr = ColorStyle;
        }
        modify("Bal. Account No.")
        {
            Style = AttentionAccent;
            StyleExpr = ColorStyle;
        }
        modify("Posting Date")
        {
            Style = AttentionAccent;
            StyleExpr = ColorStyle;
        }




        modify(Amount)
        {

            Style = AttentionAccent;
            StyleExpr = ColorStyle;

            trigger OnAfterValidate()
            var
                TOtalJ: Record "Gen. Journal Line";
                US: record "User Setup";
            begin


                //   if "Given amount" <> 0 then
                //     Validate("Given amount", rec."Given amount");
                /*      if Rec."Given amount" <> 0 then
                          Rec."To return" := Rec."Given amount" - abs(Rec.Amount);*/
                /*  if rec."Given amount" <> 0 then begin
                      TOtalJ.Reset();
                      TOtalJ.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                      TOtalJ.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
                      TOtalJ.SetFilter("Payment No. int", '>=%1', rec."Payment No. int");
                      if TOtalJ.FindFirst() then begin
                          TOtalJ.CalcSums("Amount (LCY)");
                          rec."To return" := rec."Given amount" - abs(TOtalJ."Amount (LCY)");
                      end

                  end
                  else begin
                      rec."To return" := 0;

                  end;*/

                RecCurrent.Reset();
                RecCurrent.CopyFilters(Rec);
                RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Card);
                if RecCurrent.FindFirst() then begin
                    RecCurrent.calcsums(amount);
                    TotalCard := abs(RecCurrent.amount);
                end
                else begin
                    TotalCard := 0;
                end;

                RecCurrent.Reset();
                RecCurrent.CopyFilters(Rec);
                RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Cash);
                if RecCurrent.FindFirst() then begin
                    RecCurrent.calcsums(amount);
                    TotalCash := abs(RecCurrent.amount);
                end
                else begin
                    TotalCash := 0;
                end;

                TotalCardAndCash := TotalCash + TotalCard;
                if "Document Type" = "Document Type"::Payment then begin
                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);

                    if US.FindFirst() then begin
                        if US.CurrentJnlBatchName <> '' then begin
                            if "Amount (LCY)" > 0 then begin
                                validate("Amount (LCY)", -abs("Amount (LCY)"));
                                validate("Amount", -abs(Amount));
                            end;
                        end;

                    end;
                end;
            end;

        }


    }

    actions
    {
        addafter(Card)
        {

            action("Print")
            {
                Caption = 'Payment slip or non fiscal print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = NOT (Show);

                trigger OnAction()
                begin
                    if (Rec."Payment Type" = '01') OR (Rec."Payment Type" = '02') then begin //štampa A4 za vrste uplata 01 i 02
                        CurrPage.SETSELECTIONFILTER(GJline);
                        Report.RunModal(50077, true, false, GJline);
                        /*    end else
                                if Rec."Payment Type" = '03' then begin //štampa nefiskalnog dokumenta za vrstu uplata 03

                                    NonFiscal(Rec."Line No.", Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Document No.");
                                end else
                                    Message(Text001);*/
                    end;
                end;
            }
            /*action("Payment Slip")
            {
                Caption = 'Payment Slip';
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(GJline);
                    Report.RunModal(50077, true, false, GJline);
                end;
            }
            action("Non Fiscal Print")
            {
                Caption = 'Non Fiscal Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Fiscal: Codeunit "Non Fiscal print";
                begin
                    Fiscal.SetParam(Rec."Line No.", Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Document No.");
                    Fiscal.Run();

                end;
            }*/

            action("Transfer")
            {
                Caption = 'Transfer';
                Image = TransferFunds;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = NOT Show;

                trigger OnAction()
                var
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    DocumentSeries: record "Gen. Journal Batch";
                    Us: Record "User Setup";
                begin

                    //sada resetujem samo gotovinu, brojčanu seriju na broj 1.

                    GJline.Reset(); //insertujem novi red kada se vrsi prenos uplata u "racunski centar"
                    GJline.CopyFilters(Rec);

                    GJline.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    GJline.SetFilter("Journal Batch Name", '%1', "Journal Batch Name");
                    GJline.SetFilter("Bal. Account No.", '%1', Rec."Bal. Account No.");
                    GJline.SetFilter("Payment Method", '%1', rec."Payment Method");
                    TotalAmount := 0;

                    if GJline.FindFirst() then
                        repeat
                            TotalAmount += GJline."Credit Amount";
                        until GJline.Next() = 0;


                    Rec.FINDFIRST;
                    BEGIN
                        IF Rec."Main Cashier" = FALSE THEN BEGIN //postavljam true da svaki red ide na pregled kod glavnog blagajnika
                            REPEAT
                                Validate(Rec."Main Cashier", TRUE);
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                    END;


                    GJline.Reset(); //insertujem novi red kada se vrsi prenos uplata u "racunski centar"
                    GJline.SetCurrentKey("Line No.");
                    GJline.Ascending;

                    if GJline.FindLast() then begin
                        LineNo := GJline."Line No." + 10000;
                    end
                    else
                        LineNo := 10000;

                    GJline.Init();
                    GJline."Line No." := LineNo;
                    GJline."Journal Template Name" := Rec."Journal Template Name";
                    GJline."Journal Batch Name" := Rec."Journal Batch Name";
                    GJline."Posting Date" := rec."Posting Date";
                    GJline.Amount := TotalAmount;

                    DocumentSeries.Reset();
                    DocumentSeries.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    DocumentSeries.SetFilter(Name, '%1', Rec."Journal Batch Name");
                    if DocumentSeries.FindFirst() then begin
                        NoSeriesMgt.InitSeries(DocumentSeries."No. Series", xRec."No. Series", 0D, GJline."Document No.", "No. Series");
                    end;


                    //NoSeriesMgt.InitSeries('DOK CZK1', xRec."No. Series", 0D, GJline."Document No.", "No. Series");

                    //GJline."Document No." := GenerateLineDocNo(rec."Journal Batch Name", Rec."Posting Date", Rec."Journal Template Name");
                    GJline."Payment DT" := System.CurrentDateTime;
                    GJline."Main Cashier" := true;
                    GJline."Debit Amount" := TotalAmount;
                    GJline.Description := 'Polog pazara';

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin

                        GJline."Cashier Employer" := UserSetup."Cashier Table";
                    end;

                    // 

                    GJline."Bal. Account Type" := "Bal. Account Type"::"Bank Account";
                    GJline."Bal. Account No." := Rec."Bal. Account No.";
                    GJline."Account Type" := "Account Type"::"G/L Account";

                    BankAccount.get(Rec."Bal. Account No."); //broj računa je tranzitni konto koji je postavljen na kartici bankovnog racuna
                    GJline."Account No." := BankAccount."Transit G/L account";

                    GJline.Insert();

                    if Confirm('Da li želite prvi put izvršiti zaključenje, kako bi se redni broj resetovao ?') then begin

                        //ĐK
                        //resetovanje na 1
                        NoSeriesLIne.Reset();
                        if rec."Payment Method" = rec."Payment Method"::Cash then begin
                            NoSeriesLIne.SetFilter("Series Code", '%1', DocumentSeries."No. series Payment Int");
                            if NoSeriesLIne.FindSet() then
                                repeat
                                    NoSeriesLIne."Last Date Used" := 0D;
                                    NoSeriesLIne."Last No. Used" := '';
                                    NoSeriesLIne.Modify();

                                    us.Reset();
                                    us.SetFilter("User ID", '%1', UserId);
                                    if us.findfirst then begin
                                        us."Posting Date Cash" := CalcDate('<+1D>', Today);
                                        us.Modify();
                                    end;
                                until NoSeriesLIne.Next() = 0;
                        end;


                        //ĐK
                        //resetovanje na 1 za kartice
                        NoSeriesLIne.Reset();
                        if rec."Payment Method" = rec."Payment Method"::Card then begin
                            NoSeriesLIne.SetFilter("Series Code", '%1', DocumentSeries."No. series Payment Int Card");
                            if NoSeriesLIne.FindSet() then
                                repeat
                                    NoSeriesLIne."Last Date Used" := 0D;
                                    NoSeriesLIne."Last No. Used" := '';
                                    NoSeriesLIne.Modify();

                                    us.Reset();
                                    us.SetFilter("User ID", '%1', UserId);
                                    if us.findfirst then begin
                                        us."Posting Date Card" := Today;
                                        us.Modify();
                                    end;
                                until NoSeriesLIne.Next() = 0;
                        end;
                    end;

                end;
            }

            action("Verify")
            {
                Caption = 'Verify';
                Image = Questionaire;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = NOT Show;

                trigger OnAction()
                var
                    BalJournal: Record "Gen. Journal Line";
                    BalJournal2: Record "Gen. Journal Line";
                begin
                    BalJournal2.Reset();

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        GenJournalBatch.Reset();
                        GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);


                        if GenJournalBatch.FindFirst() then
                            BalJournal2.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");

                        BalJournal.reset;
                        BalJournal.SetFilter("Main Cashier", '%1', true);
                        BalJournal.SetFilter("Bal. Account No.", '%1', GenJournalBatch."Bal. Account No.");
                        BalJournal.setcurrentkey("Posting Date");

                        if BalJournal.findlast then
                            BalJournal2.SetFilter("Posting Date", '%1', BalJournal."Posting Date");
                        if BalJournal2.FindFirst() then
                            repeat

                                //trebam posmatrati i šifru blagajnika da se blagajniku na provjeri ne bi pojavile sve uplate za taj czk
                                //odnosno uplate od oba blagajnika

                                IF (BalJournal2."Main Cashier") AND (BalJournal2."Cashier Employer" = UserSetup."Cashier Table") THEN //postavljam false da svaki record vratim od glavnog blagajnika

                                    if BalJournal2.Description <> 'Polog pazara' then begin
                                        BalJournal2.Validate("Main Cashier", false); //za svaku uplatu mijenjam checkbox (glavni blagajnik)
                                        BalJournal2.MODIFY;
                                    end else
                                        BalJournal2.Delete(); //red sa pologom pazara brisem                                                                               

                            until BalJournal2.Next() = 0;


                    end;
                end;
            }
        }
        addafter(Print)
        {
            action("isplatnica dz")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                Caption = 'Isplatnica dz';
                PromotedCategory = Process;

                trigger OnAction()
                var
                    jnl2: Record "Gen. Journal Line";
                    TempFile: Text[250];
                    FileRef: File;
                    OutStr: OutStream;
                    RecRef: RecordRef;
                    VarRec: Variant;
                    GLS: Record "General Ledger Setup";
                    PathForPaySlip: Text[250];
                    file: file;
                    filename: text[250];
                    FileContent: Text;
                    FirstString: Text;
                    Instr: InStream;

                    TempBlob: Codeunit "Temp Blob";
                    CUstF: Record Customer;

                    Br: Integer;
                    JournalB: Record "Gen. Journal Batch";
                    JournalTemp: Record "Gen. Journal Template";
                begin

                    jnl2.Reset();
                    jnl2.SETFILTER("Document No.", '%1', Rec."Document No.");
                    jnl2.copyfilters(Rec);

                    jnl2.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                    jnl2.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
                    if rec."Payment Method" = rec."Payment Method"::Cash then begin
                        jnl2.SetFilter("Payment No. int", '>=%1', rec."Payment No. int");
                        jnl2.SetFilter("Payment Method", '%1', "Payment Method"::cash);

                    end
                    else begin

                        jnl2.SetFilter("Payment No. int Card", '>=%1', rec."Payment No. int Card");
                        jnl2.SetFilter("Payment Method", '%1', "Payment Method"::Card);

                    end;


                    JournalB.Reset();
                    JournalB.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    JournalB.SetFilter(Name, '%1', rec."Journal Batch Name");
                    if JournalB.FindFirst() then begin

                        FileName := 'ISPLATA.txt';
                        File1.CREATE(JournalB."Path for Cashier" + 'ISPLATA.txt', TEXTENCODING::UTF8);
                        //  TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                        File1.CREATEOUTSTREAM(OutStr);
                        /*



                                                            03-377940/25

            03-377940/25                                                29776 SPILJAK ADIS
                                                            KEMAL BEGOVA 12
            29776 SPILJAK ADIS
            KEMAL BEGOVA 12                                        

            CZK4_2 007 R.b.18                                         
            30.07.2025 15:05:55                                         CZK4_2 007 R.b.18
            (G)=445.46KM                                                30.07.2025 15:05:55                                                                   
                                                            (G)=445.46KM
            */
                        FirstString := '';

                        for Br := 1 to 6 do begin

                            OutStr.WRITETEXT(); // This command is to move to next line
                        end;

                        for i := 1 to 72 do begin
                            FirstString += ' ';
                        end;


                        OutStr.WRITETEXT(FirstString);

                        OutStr.WRITETEXT(rec."Applies-to Doc. No.");
                        OutStr.WRITETEXT();
                        OutStr.WRITETEXT(rec."Applies-to Doc. No.");
                        OutStr.WRITETEXT();
                        //desno
                        FirstString := '';
                        for i := 1 to 71 - 3 do begin
                            FirstString += ' ';
                        end;

                        OutStr.WRITETEXT(FirstString);
                        OutStr.WRITETEXT(rec."Account No. Change" + ' ');
                        OutStr.WRITETEXT(copystr(rec.Description, 1, 16));
                        //lijeva strana
                        OutStr.WRITETEXT();
                        OutStr.WRITETEXT(rec."Account No. Change" + ' ');

                        //EK OutStr.WRITETEXT(copystr(rec.Description, 1, 16));
                        //EK
                        OutStr.WRITETEXT(copystr(rec.Description, 1, 45));

                        OutStr.WRITETEXT();

                        //


                        //desno
                        FirstString := '';
                        for i := 1 to 71 do begin
                            FirstString += ' ';
                        end;
                        OutStr.WRITETEXT(FirstString);


                        FirstString := '';

                        CUstF.Reset();
                        CUstF.setfilter("No.", '%1', rec."Account No. Change");
                        //desna
                        if CUstF.FindFirst() then begin
                            OutStr.WRITETEXT(copystr(CustF."Address", 1, 16));
                        end
                        else begin
                            FirstString := '';
                            for i := 1 to 16 do begin
                                FirstString += ' ';
                                OutStr.WRITETEXT(FirstString);
                            end;
                        end;

                        OutStr.WRITETEXT();
                        FirstString := '';
                        CUstF.Reset();
                        CUstF.setfilter("No.", '%1', rec."Account No. Change");
                        //lijeva
                        if CUstF.FindFirst() then begin

                            //EK   OutStr.WRITETEXT(copystr(CustF."Address", 1, 16));
                            //EK
                            OutStr.WRITETEXT(copystr(CustF."Address", 1, 45));
                            //
                        end
                        else begin
                            FirstString := '';
                            for i := 1 to 16 do begin
                                FirstString += ' ';
                                OutStr.WRITETEXT(FirstString);
                            end;
                        end;
                        //
                        OutStr.WRITETEXT();

                        OutStr.WRITETEXT();


                        OutStr.WRITETEXT(rec."Journal Batch Name" + ' ');
                        OutStr.WRITETEXT(rec."Cashier Employer" + ' ');
                        OutStr.WRITETEXT('R.b.' + ' ' + format(Rec."Payment No. order"));
                        OutStr.WRITETEXT();



                        //30.07.2025 15:05:55
                        FirstString := '';
                        OutStr.WRITETEXT(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ');
                        if StrLen(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ') < 58 then begin
                            for i := 1 to 52 + 18 - StrLen(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ') do begin
                                FirstString += ' ';
                            end;
                        end;
                        OutStr.WRITETEXT(FirstString);

                        OutStr.WRITETEXT(rec."Journal Batch Name" + ' ');
                        OutStr.WRITETEXT(rec."Cashier Employer" + ' ');
                        OutStr.WRITETEXT('R.b.' + ' ' + format(Rec."Payment No. order"));
                        OutStr.WRITETEXT();


                        FirstString := '';

                        if "Payment Method" = "Payment Method"::Cash then
                            FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM'
                        else
                            //EK   FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM';
                            FirstString += '(K)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM';

                        OutStr.WRITETEXT(FirstString);

                        FirstString := '';
                        for i := 1 to 52 + 7 do begin
                            FirstString += ' ';

                        end;
                        OutStr.WRITETEXT(FirstString);


                        FirstString := '';
                        OutStr.WRITETEXT(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ');

                        OutStr.WRITETEXT();

                        FirstString := '';
                        for i := 1 to 79 do begin
                            FirstString += ' ';

                        end;
                        OutStr.WRITETEXT(FirstString);
                        FirstString := '';
                        if "Payment Method" = "Payment Method"::Cash then
                            FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM'
                        else
                            //EK FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM';
                            FirstString += '(K)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM';
                        OutStr.WRITETEXT(FirstString);
                        OutStr.WRITETEXT(); // This command is to move to next line





                        File1.CLOSE;
                        //   TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
                        //  DownloadFromStream(Instr, '', '', '', FileName);
                        // FileManagement.DownloadToFile('\\192.168.14.105\Temp KOPIRAJ\' + FileName, 'C:\Users\anisa.krnjic.TENEO\Desktop\Izvjestaji' + FileName);
                        FileManagement.DownloadToFile(JournalB."Path for Cashier" + FileName, JournalB."Path for Cashier" + FileName);


                        //  Sleep(000);
                        //   Hyperlink('runfrombc:');


                        /* if (Rec."Payment Type" = '01') OR (Rec."Payment Type" = '02') then begin //štampa A4 za vrste uplata 01 i 02
                             CurrPage.SETSELECTIONFILTER(GJline);
                             Report.RunModal(50077, true, false, GJline);
                         end else
                             if Rec."Payment Type" = '03' then begin //štampa nefiskalnog dokumenta za vrstu uplata 03

                                 NonFiscal(Rec."Line No.", Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Document No.");
                             end else
                                 Message(Text001);*/
                        //potvrda txt fajla, za print
                    end;



                    //ići ćemo po redovima, a ne po broju dokumenta
                    //ĐK dodaj
                    //     jnl2.SETFILTER("Line No.", '%1', Rec."Line No.");


                    //  REPORT.RUN(50115, TRUE, TRUE, jnl2);

                    //  Report.Print(50115, Parameters, '', jnl2);

                    //  Report.RunModal();

                    /* ne može    begin
                            TempFile := 'C:\Temp\Izvjestaj.pdf'; // Postavi putanju
                            REPORT.SAVEASPDF(50115, TempFile, Rec);
                            SHELL('cmd /c start /min "" "C:\Temp\Izvjestaj.pdf"');
                        end; */

                    //ne može      REPORT.RUN(50115, false, false, Rec);

                    //  Report.Print(50115, '', 'ET0021B7F35476', recref);  - nista se ne desi

                    /*  TempFile := 'C:\Temp\Izvjestaj.pdf'; // Putanja do PDF fajla
                      REPORT.SAVEASPDF(50115, TempFile, Rec);
                      RUNLINK('file:///' + TempFile);  // Pokreće PDF fajl  -ne može */


                    /*  TempFile := 'C:\\Users\\anisa.krnjic.TENEO\\Desktop\\Izvjestaji\\Izvjestaj.txt';

                      // Kreiraj fajl i dobavi OutStream
                      FileRef.Create(TempFile);
                      FileRef.CreateOutStream(OutStr);

                      // Konvertuj Record u Variant
                      RecRef.GetTable(Rec);
                      VarRec := RecRef;

                      // Sačuvaj izveštaj kao PDF
                      Report.SaveAs(50115, VarRec, ReportFormat::Pdf, OutStr);
                      FileRef.Close();
                      MESSAGE('Fajl je kreiran: ' + TempFile);


                      HYPERLINK('cmd:///start "" notepad /p "' + TempFile + '"');*/


                    //27.02.
                    /*GLS.GET;
                                        PathForPaySlip := GLS."Path for pay slip"; // Postavi folder gde će se čuvati fajlovi za štampu

                                        // Postavi putanju fajla
                                        FileName := '\\192.168.14.105\Temp KOPIRAJ\ISPL_273849.txt';

                                        // Kreiraj fajl
                                        File.CREATE(FileName, TEXTENCODING::UTF8);
                                        File.WRITE('Ovo je testni sadržaj izvještaja za downloads.');
                                        File.CLOSE;

                                        // Opcionalno: Ako treba da se fajl prebaci u drugi folder
                                        //  FileManagement.DownloadToFile(FileName, PathForPaySlip + '\Izvjestaj.txt')
                                        DownloadFile(FileName, PathForPaySlip + '\ISPL_273849.txt');*/

                    // 28.02. Spremanje u  word formatu
                    /*    GLS.GET;
                         PathForPaySlip := GLS."Path for pay slip"; // Preuzimanje podešene putanje

                         // Generisanje imena fajla na osnovu podataka
                         FileName := PathForPaySlip + 'Isplatnica123.docx';

                         // Sačuvaj izveštaj kao Word fajl
                         //REPORT.SAVEAS(50115, FileName, Rec, ReportFormat::CSV);

                         Message('Sacuvano');

                         // Preuzmi fajl na klijentovu mašinu
                         DownloadFile(FileName, PathForPaySlip + '\Isplatnica123.docx')*/

                end;


            }



            action("Print on Bill")
            {
                Caption = 'Print on Bill';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = NOT (Show);

                trigger OnAction()
                var
                    FirstString: Text;
                    Instr: InStream;
                    OutStr: OutStream;
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                    Br: Integer;
                    JournalB: Record "Gen. Journal Batch";
                    JournalTemp: Record "Gen. Journal Template";

                begin

                    JournalB.Reset();
                    JournalB.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    JournalB.SetFilter(Name, '%1', rec."Journal Batch Name");
                    if JournalB.FindFirst() then begin

                        FileName := 'ISPLATA.txt';
                        File1.CREATE(JournalB."Path for Cashier" + 'ISPLATA.txt', TEXTENCODING::UTF8);
                        //  TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
                        File1.CREATEOUTSTREAM(OutStr);
                        for Br := 1 to 12 do begin

                            OutStr.WRITETEXT(); // This command is to move to next line
                        end;

                        FirstString := '';
                        for Br := 1 to 68 do begin
                            FirstString += ' ';
                        end;

                        OutStr.WRITETEXT(FirstString);

                        OutStr.WRITETEXT(rec."Journal Batch Name" + ' ');
                        OutStr.WRITETEXT(rec."Cashier Employer" + ' ');
                        OutStr.WRITETEXT('R.b.' + ' ' + format(Rec."Payment No. order"));
                        OutStr.WRITETEXT();


                        OutStr.WRITETEXT(rec."Journal Batch Name" + ' ');
                        OutStr.WRITETEXT(rec."Cashier Employer" + ' ');

                        OutStr.WRITETEXT('R.b.' + ' ' + format(Rec."Payment No. order"));

                        OutStr.WRITETEXT();



                        //30.07.2025 15:05:55
                        FirstString := '';
                        OutStr.WRITETEXT(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ');
                        if StrLen(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ') < 58 then begin
                            for i := 1 to 68 - StrLen(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ') do begin
                                FirstString += ' ';
                            end;
                        end;
                        OutStr.WRITETEXT(FirstString);

                        OutStr.WRITETEXT(format(SystemCreatedAt, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '  ');

                        OutStr.WRITETEXT();
                        FirstString := '';

                        if "Payment Method" = "Payment Method"::Cash then
                            FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM'
                        else
                            FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM';


                        OutStr.WRITETEXT(FirstString);


                        FirstString := '';
                        for i := 1 to 65 - StrLen(format(FirstString)) do begin
                            FirstString += ' ';
                        end;

                        OutStr.WRITETEXT(FirstString);

                        FirstString := '';

                        if "Payment Method" = "Payment Method"::Cash then
                            FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM'
                        else
                            FirstString += '(G)=' + FORMAT(abs(Amount), 0, '<Precision,2:2><Standard Format,2>') + 'KM';
                        OutStr.WRITETEXT(FirstString);
                        OutStr.WRITETEXT(); // This command is to move to next line

                        File1.CLOSE;
                        //   TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
                        //  DownloadFromStream(Instr, '', '', '', FileName);
                        // FileManagement.DownloadToFile('\\192.168.14.105\Temp KOPIRAJ\' + FileName, 'C:\Users\anisa.krnjic.TENEO\Desktop\Izvjestaji' + FileName);
                        FileManagement.DownloadToFile(JournalB."Path for Cashier" + FileName, JournalB."Path for Cashier" + FileName);


                        //  Sleep(000);
                        //   Hyperlink('runfrombc:');


                        /* if (Rec."Payment Type" = '01') OR (Rec."Payment Type" = '02') then begin //štampa A4 za vrste uplata 01 i 02
                             CurrPage.SETSELECTIONFILTER(GJline);
                             Report.RunModal(50077, true, false, GJline);
                         end else
                             if Rec."Payment Type" = '03' then begin //štampa nefiskalnog dokumenta za vrstu uplata 03

                                 NonFiscal(Rec."Line No.", Rec."Journal Batch Name", Rec."Journal Template Name", Rec."Document No.");
                             end else
                                 Message(Text001);*/
                        //potvrda txt fajla, za print
                    end;

                end;
            }
            action(CashPrint)
            {

                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    IzvjestajPortoBlagajne.SetParam(1, Rec."Bal. Account No.", rec."Journal Batch Name");
                    IzvjestajPortoBlagajne.Run();

                end;
            }



            action("POS terminali - dnevni izvještaj")
            {
                Caption = 'POS terminali - dnevni izvještaj';
                // Image = CreditCard;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    IzvjestajPortoBlagajne.SetParam(2, Rec."Bal. Account No.", rec."Journal Batch Name");
                    IzvjestajPortoBlagajne.Run();
                end;
            }

            action("Specifikacija karticnog placanja")
            {
                Caption = 'Specifikacija karticnog placanja';
                Image = CreditCard;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    BankAccount.Reset();
                    BankAccount.SetFilter("No.", '%1', 'CZK*');
                    SpecifikacijaKarticnog.SetTableView(BankAccount);
                    SpecifikacijaKarticnog.Run();
                end;
            }

            action("Rekapitulacija uplata/isplata")
            {
                Caption = 'Rekapitulacija uplata/isplata';
                Image = PostedPayableVoucher;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ShowReport;
                trigger OnAction()

                begin
                    /*BankAccount.Reset();
                    BankAccount.SetFilter("No.", '%1', 'CZK*');
                    RekapitulacijaUplataIsplata.SetTableView(BankAccount);*/
                    RekapitulacijaUplataIsplata.Run();
                end;
            }

            action("Izvještaj o prometu na dan")
            {
                Caption = 'Izvještaj o prometu na dan';
                Image = CreditCardLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //    GLEntry.SetFilter("Bal. Account No.", '%1', Rec."No.");
                    //GLEntry.SetFilter("Posting Date", '%1', System.Today);



                    "IzvještajOPrometuNaDan".SetTableView(Rec);
                    "IzvještajOPrometuNaDan".SetParam(Rec."Bal. Account No.");
                    "IzvještajOPrometuNaDan".Run();
                end;
            }

            action("Cash Diary")
            {
                Caption = 'Cash Diary';
                Image = Journal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    BlagajnickiDnevnik.SetTableView(rec);
                    BlagajnickiDnevnik.Run();
                end;
            }



        }
        modify("Post and &Print")
        {
            Visible = Show;
        }
        modify(Post)
        {
            Visible = Show;
        }
        modify(Preview)
        {
            Visible = Show;
        }
        modify(Reconcile)
        {
            Visible = Show;
        }
        modify("Apply Entries")
        {
            Visible = Show;
        }
        modify(Approvals)
        {
            Visible = Show;
        }
        modify(Dimensions)
        {
            Visible = Show;
        }
        modify(IncomingDoc)
        {
            Visible = Show;
        }
        modify(Card)
        {
            Visible = Show;
        }
        modify("Ledger E&ntries")
        {
            Visible = Show;
        }
        modify("F&unctions")
        {
            Visible = Show;
        }
        modify("Request Approval")
        {
            Visible = Show;
        }
        modify("P&osting")
        {
            Visible = Show;
        }
        modify("A&ccount")
        {
            Visible = Show;
        }








    }

    trigger OnAfterGetRecord()
    begin


        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Card);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCard := abs(RecCurrent.amount);
        end
        else begin
            TotalCard := 0;
        end;

        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Cash);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCash := abs(RecCurrent.amount);
        end
        else begin
            TotalCash := 0;
        end;
        TotalCardAndCash := TotalCash + TotalCard;



        if "Payment Method" = "Payment Method"::Card then
            ColorStyle := true
        else
            ColorStyle := falsE;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            SetFilter("Main Cashier", '%1', UserSetup."Main Cashier");

        if UserSetup."Main Cashier" = true then begin
            Rec.FILTERGROUP(2);
            Rec.SetFilter("Journal Template Name", '%1', 'CASH RECE');
            Rec.SetFilter("Journal Batch Name", '<>%1', '');
            Rec.FILTERGROUP(0);
        end;

        if UserSetup."Cashier Report" then
            ShowReport := true
        else
            showReport := false;

        TotalAmountMultipleCustomers := 0;
        GJline.Reset();
        GJline.SetFilter("Cashier Employer", '%1', Rec."Cashier Employer");
        GJline.SetFilter("Mupltiple customers", '%1', true);
        if GJline.FindFirst() then
            repeat
                TotalAmountMultipleCustomers += Abs(GJline.Amount);
            until GJline.Next() = 0;

        setcurrentkey("Payment DT");
        Ascending(true);
    end;



    trigger OnOpenPage()
    begin


        CurrentJnlBatchName2 := "Journal Batch Name";


        if "Payment Method" = "Payment Method"::Card then
            ColorStyle := true
        else
            ColorStyle := falsE;



        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            Show := UserSetup."Main Cashier";

            if UserSetup."Cashier Report" then
                ShowReport := true
            else
                showReport := false;
            IF (UserSetup.CurrentJnlBatchName <> '') THEN BEGIN
                BatchText := UserSetup.CurrentJnlBatchName;

                Rec.FILTERGROUP(2);
                Rec.SetFilter("Journal Template Name", '%1', 'CASH RECE');
                Rec.SetFilter("Journal Batch Name", '%1', BatchText);
                Rec.FILTERGROUP(0);

                GenJournalBatch.FilterGroup(2);
                GenJournalBatch.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                GenJournalBatch.SetFilter(Name, '%1', Rec."Journal Batch Name");
                GenJournalBatch.FilterGroup(0);

            end;

            SetFilter("Main Cashier", '%1', UserSetup."Main Cashier");
            if UserSetup."Main Cashier" = true then begin
                Rec.FILTERGROUP(2);
                Rec.SetFilter("Journal Template Name", '%1', 'CASH RECE');
                Rec.SetFilter("Journal Batch Name", '<>%1', '');
                Rec.FILTERGROUP(0);
            end;

            setcurrentkey("Payment DT");
            Ascending(true);
        end;

        TotalAmountMultipleCustomers := 0;
        GJline.Reset();
        GJline.SetFilter("Cashier Employer", '%1', Rec."Cashier Employer");
        GJline.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GJline.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
        GJline.SetFilter("Mupltiple customers", '%1', true);
        if GJline.FindFirst() then
            repeat
                TotalAmountMultipleCustomers += Abs(GJline.Amount);
            until GJline.Next() = 0;
    end;



    trigger OnNewRecord(BelowxRec: Boolean)
    var
        CUsTF: record "Customer";
    begin


        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Card);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCard := abs(RecCurrent.amount);
        end
        else begin
            TotalCard := 0;
        end;

        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Cash);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCash := abs(RecCurrent.amount);
        end
        else begin
            TotalCash := 0;
        end;

        TotalCardAndCash := TotalCash + TotalCard;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            Validate("Cashier Employer", UserSetup."Cashier Table");
        end;

        //  Validate(Rec."Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
        Rec."Applies-to Doc. Type" := "Applies-to Doc. Type"::Invoice;
        Rec."Document Type" := "Document Type"::Payment;
        Validate(Rec."Account Type", "Account Type"::Customer);
        Validate(Rec."Bal. Account Type", "Bal. Account Type"::"Bank Account");
        Validate(Rec."Payment Method", 1);

        GenJournalBatch.Reset();
        GenJournalBatch.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
        GenJournalBatch.SetFilter(Name, '%1', BatchText);
        if GenJournalBatch.FindFirst() then
            Validate(rec."Bal. Account No.", GenJournalBatch."Bal. Account No.");

        "Payment DT" := System.CurrentDateTime;
        "Posting Date" := System.Today;
        "Account No." := "Account No. Change";
        if "Account No." = '' then
            Description := '';

        if "Applies-to Doc. No." = '' then begin
            CUsTF.Reset();
            CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
            if CUsTF.FindFirst() then begin
                if CUsTF."Customer Category" = CUsTF."Customer Category"::Household then
                    "Payment Type" := '03';

                if CUsTF."Customer Category" = CUsTF."Customer Category"::"Small Economy" then
                    "Payment Type" := '02';
                if CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy" then
                    "Payment Type" := '01';

            end;
        end;

        CUsTF.Reset();
        CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
        if CUsTF.FindFirst() then begin
            if CUsTF."Name 2" <> '' then
                Description := CUsTF."Name" + ' ' + CUsTF."Name 2"
            else
                Description := CUsTF."Name";
        end;


    end;

    procedure Odgovor(Upit: Text[2000])




    begin
        TXTTab := 13;
        //Upit:='\\DESKTOP-B6A3125\odgovori\sfr';
        IF EXISTS(Upit + '_1' + '.xml') THEN
            ERASE(Upit + '_1' + '.xml');
        IF EXISTS(Upit + '.xml') THEN BEGIN
            Charr := 10;
            importFile.WRITEMODE(TRUE);
            importFile.TEXTMODE(TRUE);
            importFile.OPEN(Upit + '.xml');
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



    procedure NonFiscal(BrojRacuna: Integer; JBatch: Code[20]; JTemp: Code[20]; Document: Text[250])

    var

    begin
        UlazniRacun := BrojRacuna;
        GBatch := JBatch;
        GTem := JTemp;
        GDocument := Document;



        GL.Get();


        Putanja := GL."Path for fiscal printer";



        TXTTab := 13;
        TXTTab := 13;

        GJL.RESET;
        GJL.SetFilter("Line No.", '%1', UlazniRacun);
        GJL.SetFilter("Journal Template Name", '%1', GTem);
        GJL.SetFilter("Journal Batch Name", '%1', GBatch);
        GJL.SetFilter("Document No.", '%1', GDocument);

        IF GJL.FINDFIRST THEN BEGIN

            File1.CREATE(Putanja + 'Stampatifiskalniracun.000', TEXTENCODING::UTF8);

            File1.CREATEOUTSTREAM(OutStreamObj);
            plite := '<?xml version="1.0" encoding="utf-8"?>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<BrojZahtjeva>837650</BrojZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := ' <VrstaZahtjeva>6</VrstaZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<Naziv>Text</Naziv>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<Vrijednost>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '\x1B\x61\x01';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '\x1D\x54\x00';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '\x1C\x70\x01\x30';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();

            plite := '\x1b\x61\x08POTVRDA PLAĆANJA\x1b\x21\x00';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();
            Custt.RESET;
            Custt.SETFILTER("No.", '%1', GJL."Account No.");
            IF Custt.FINDFIRST THEN
                plite := Format(GJL."Account No.") + ' ' + GJL.Description + ' ' + Custt.Address
            else
                plite := Format(GJL."Account No.") + ' ' + GJL.Description;
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '\x1B\x21\x00REFERENCE' + ' ' + GJL."Applies-to Doc. No." + '\x1B\x21\x20';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();
            Iznoss := abs(GJL.Amount);
            ImaZarez := STRPOS(FORMAT(abs(GJL.Amount)), ',') + 1;

            IF STRPOS(FORMAT(COPYSTR(FORMAT(Iznoss), ImaZarez, 2)), '00') = 0 THEN
                Rezultat := ChangeSeparator(FORMAT(Iznoss, 0, '<Sign><Integer><Decimals><Comma,.>'))
            ELSE
                Rezultat := ChangeSeparator(FORMAT(ROUND(Iznoss), 0, '<Precision,2:2><Standard Format,2>'));


            plite := '\x1b\x21\x08     IZNOS UPLATE : ' + Rezultat + 'KM     \x1B\x21\x00';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();



            plite := GBatch + ' ' + 'B ' + GJL."Cashier Employer";
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            OutStreamObj.WRITETEXT('R.B. ' + format(GJL."Payment No."));
            OutStreamObj.WRITETEXT();
            plite := '';

            plite := '################################';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '\x1B\x4d\x01POTVRDA O PLAĆANJU JE ';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := 'IZDATA ELEKTRONSKI I VAŽEĆA JE';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := 'BEZ PEČATA I POTPISA ';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := 'OVLAŠTENE OSOBE ';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Vrijednost>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Zahtjev>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();


            //CZK 1 BLG 1 B 013



            //<Naziv>Text</Naziv>













            File1.CLOSE;
            FileManagement.DownloadToFile(Putanja + 'Stampatifiskalniracun.000', Putanja + 'Stampatifiskalniracun.000');


        END;





    end;

    procedure DownloadFile(ServerFileName: Text; ClientFileName: Text)
    var
        FileObj: File;
        InStream: InStream;
    begin
        // Proverite da li fajl postoji na serveru
        if File.Exists(ServerFileName) then begin
            // Kreirajte instancu objekta File
            FileObj.Open(ServerFileName, TextEncoding::UTF8);

            // Preuzmite fajl putem DownloadFromStream
            FileObj.CreateInStream(InStream);
            DownloadFromStream(InStream, '', '', '', ClientFileName);
        end else
            Error('Fajl nije pronađen na serveru.');
    end;




    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;



    begin
        CurrentJnlBatchName2 := "Journal Batch Name";
        setcurrentkey("Payment DT");
        Ascending(false);
        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Card);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCard := abs(RecCurrent.amount);
        end
        else begin
            TotalCard := 0;
        end;

        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Cash);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCash := abs(RecCurrent.amount);
        end
        else begin
            TotalCash := 0;
        end;
        TotalCardAndCash := TotalCash + TotalCard;

        SetCurrentKey("Payment No. int", "Payment No. int Card");
        Ascending(false);
        GJLCurr.Reset();
        GJLCurr.copyfilters(Rec);
        GJLCurr.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GJLCurr.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
        GJLCurr.SetFilter("Payment No. int", '>=%1', rec."Payment No. int");
        GJLCurr.SetFilter("Payment Method", '%1', "Payment Method"::cash);
        GJLCurr.SetFilter("Payment DT", '>=%1', rec."Payment DT");
        if GJLCurr.FindFirst() then begin
            GJLCurr.CalcSums("Amount (LCY)");

            TotalAmountRow := abs(GJLCurr."Amount (LCY)");
        end
        else begin
            TotalAmountRow := 0;
        end;

        GJLCurr.Reset();
        GJLCurr.copyfilters(Rec);
        GJLCurr.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GJLCurr.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
        GJLCurr.SetFilter("Payment No. int Card", '>=%1', rec."Payment No. int Card");
        GJLCurr.SetFilter("Payment Method", '%1', "Payment Method"::Card);
        GJLCurr.SetFilter("Payment DT", '>=%1', rec."Payment DT");
        if GJLCurr.FindFirst() then begin
            GJLCurr.CalcSums("Amount (LCY)");

            TotalAmountRow2 := abs(GJLCurr."Amount (LCY)");
        end
        else begin
            TotalAmountRow2 := 0;
        end;


        CurrPage.JournalLineDetails.PAGE.Update();
    end;


    trigger OnModifyRecord(): Boolean
    var
        myInt: Integer;
    begin

        "Account No." := "Account No. Change";

        GJLCurr.Reset();
        GJLCurr.copyfilters(Rec);
        GJLCurr.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GJLCurr.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
        GJLCurr.SetFilter("Payment No. int", '>=%1', rec."Payment No. int");
        GJLCurr.SetFilter("Payment Method", '%1', GJLCurr."Payment Method"::Cash);
        GJLCurr.SetFilter("Payment DT", '>=%1', rec."Payment DT");
        if GJLCurr.FindFirst() then begin
            GJLCurr.CalcSums("Amount (LCY)");

            TotalAmountRow := abs(GJLCurr."Amount (LCY)");
        end
        else begin
            TotalAmountRow := 0;
        end;

        GJLCurr.Reset();
        GJLCurr.copyfilters(Rec);
        GJLCurr.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GJLCurr.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
        GJLCurr.SetFilter("Payment No. int Card", '>=%1', rec."Payment No. int Card");
        GJLCurr.SetFilter("Payment Method", '%1', "Payment Method"::Card);
        GJLCurr.SetFilter("Payment DT", '>=%1', rec."Payment DT");
        if GJLCurr.FindFirst() then begin
            GJLCurr.CalcSums("Amount (LCY)");

            TotalAmountRow2 := abs(GJLCurr."Amount (LCY)");
        end
        else begin
            TotalAmountRow2 := 0;
        end;

    end;


    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin

        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Card);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCard := abs(RecCurrent.amount);
        end
        else begin
            TotalCard := 0;
        end;

        RecCurrent.Reset();
        RecCurrent.CopyFilters(Rec);
        RecCurrent.SetFilter("Payment Method", '%1', RecCurrent."Payment Method"::Cash);
        if RecCurrent.FindFirst() then begin
            RecCurrent.calcsums(amount);
            TotalCash := abs(RecCurrent.amount);
        end
        else begin
            TotalCash := 0;
        end;

        TotalCardAndCash := TotalCash + TotalCard;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
        CUsTF: record "Customer";

    begin
        GJLCurr.Reset();
        GJLCurr.copyfilters(Rec);
        GJLCurr.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GJLCurr.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
        GJLCurr.SetFilter("Payment No. int", '>=%1', rec."Payment No. int");
        GJLCurr.SetFilter("Payment Method", '%1', "Payment Method"::Cash);
        GJLCurr.SetFilter("Payment DT", '>=%1', rec."Payment DT");
        if GJLCurr.FindFirst() then begin
            GJLCurr.CalcSums("Amount (LCY)");

            TotalAmountRow := abs(GJLCurr."Amount (LCY)");
        end
        else begin
            TotalAmountRow := 0;
        end;
        GJLCurr.Reset();
        GJLCurr.copyfilters(Rec);
        GJLCurr.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
        GJLCurr.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
        GJLCurr.SetFilter("Payment No. int Card", '>=%1', rec."Payment No. int Card");
        GJLCurr.SetFilter("Payment Method", '%1', "Payment Method"::Card);
        GJLCurr.SetFilter("Payment DT", '>=%1', rec."Payment DT");
        if GJLCurr.FindFirst() then begin
            GJLCurr.CalcSums("Amount (LCY)");

            TotalAmountRow2 := abs(GJLCurr."Amount (LCY)");
        end
        else begin
            TotalAmountRow2 := 0;
        end;

        if "Cashier Employer" = '' then begin

            UserSetup.Reset();
            UserSetup.SetFilter("User ID", '%1', UserId);
            if UserSetup.FindFirst() then begin

                Validate("Cashier Employer", UserSetup."Cashier Table");
            end;

            Validate(Rec."Applies-to Doc. Type", "Applies-to Doc. Type"::Invoice);
            Validate(Rec."Document Type", "Document Type"::Payment);
            Validate(Rec."Account Type", "Account Type"::Customer);
            Validate(Rec."Bal. Account Type", "Bal. Account Type"::"Bank Account");
            Validate(Rec."Payment Method", 1);

            GenJournalBatch.Reset();
            GenJournalBatch.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
            GenJournalBatch.SetFilter(Name, '%1', BatchText);
            if GenJournalBatch.FindFirst() then
                Validate(rec."Bal. Account No.", GenJournalBatch."Bal. Account No.");

            "Payment DT" := System.CurrentDateTime;
            "Posting Date" := System.Today;
            "Account No." := "Account No. Change";
            if "Account No." = '' then
                Description := '';

            if "Applies-to Doc. No." = '' then begin
                CUsTF.Reset();
                CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                if CUsTF.FindFirst() then begin
                    if CUsTF."Customer Category" = CUsTF."Customer Category"::Household then
                        "Payment Type" := '03';

                    if CUsTF."Customer Category" = CUsTF."Customer Category"::"Small Economy" then
                        "Payment Type" := '02';
                    if CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy" then
                        "Payment Type" := '01';

                end;
            end;

            CUsTF.Reset();
            CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
            if CUsTF.FindFirst() then begin
                if CUsTF."Name 2" <> '' then
                    Description := CUsTF."Name" + ' ' + CUsTF."Name 2"
                else
                    Description := CUsTF."Name";
            end;

        end;
    end;


    var
        GJLCurr: Record "Gen. Journal Line";
        IzvjestajPortoBlagajne: report "Report2Cash GenJournal";
        SpecifikacijaKarticnog: report "Card Payment Spec. GenJ";

        TotalAmountMultipleCustomers: Decimal;
        //  Fiscal: Codeunit "Non Fiscal print";
        IzvjestajPorto: Report Report2Cash;
        TotalAmount: Decimal;
        CZKNoSeries: Record "Bank Account";
        NoSeriesLIne: Record "No. Series Line";
        LineNo: Integer;
        UserSetup: Record "User Setup";
        BankAccount: Record "Bank Account";
        GJline: Record "Gen. Journal Line";
        CLEntry: Record "Cust. Ledger Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        Customer: Record Customer;
        Text000: Label 'Today is %1';
        LastDocumentNo: Code[20];
        BatchText: text[20];
        CashierEmployerCode: Code[10];
        Show: Boolean;
        ShowReport: Boolean;
        Text001: Label 'The document is not printed for this type of payment.';

        myInt: Integer;
        GTem: Code[20];
        GBatch: Code[20];
        GDocument: Text[250];
        GL: Record "General Ledger Setup";
        XMLManagement: Codeunit "XML DOM Management";
        UlazniRacun: Integer;
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

        TotalAmountRow: Decimal;
        TotalAmountRow2: Decimal;
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
        TotalCardAndCash: Decimal;
        XMLFileOutStr: OutStream;
        ToFileName: Text[2000];
        x5: Text[2000];
        x6: Text[2000];
        Zamjena: Text[2000];
        BrojFiskalnogRacuna: Text[2000];
        VrijemeFiskalnogRacuna: Text[2000];


        DatumFiskalnogRacuna: Text[2000];
        IznosFiskalnogRacuna: Text[2000];

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
        GJL: Record "Gen. Journal Line";
        XMLDomDocParam: DotNet SystemXmlDocument;
        BlagajnickiDnevnik: Report "Cash Book GL";
        TotalCash: decimal;
        TotalCard: Decimal;
        File1: File;
        SystemDokument: Dotnet SystemXmlDocument;
        SubText: Text[2000];
        OutStreamObj: OutStream;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        plite: Text[2000];
        SalesInvoiceLine: Record "Sales Invoice Line";
        Salles: Record "Sales Invoice Line";
        TotalCijena: Decimal;
        FileManagement: Codeunit "File Management";
        RecCurrent: Record "Gen. Journal Line";

        ColorStyle: Boolean;
        RekapitulacijaUplataIsplata: report "Recapitulation GenJournal";

        IzvještajOPrometuNaDan: report "Daily Payment Report GL";
        Isplatnica: report "paymentdz";
        CurrentJnlBatchName2: Code[10];
        GenJnlManagement: Codeunit GenJnlManagement;
    /*
    Style = Unfavorable;

                StyleExpr = "Difference Out of range 1";*/

    //    FiscalPrinterSetup: Record "BaH Fiscal Printer Setup";
}