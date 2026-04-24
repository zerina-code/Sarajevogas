tableextension 50032 Gen_JournalLineExtends extends "Gen. Journal Line"
{
    //ED

    fields
    {
        //    VAT Base (retro.)




        modify("Amount (LCY)")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                US: Record "User Setup";
            begin
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
                if "Given amount" <> 0 then begin
                    MultipleBills := 0;
                    TotalGivenAmount := Rec."Given amount"; //ukupni dati iznos za sve racune
                    Counter := 1;

                    GJLine.Reset();
                    GJLine.CopyFilters(rec);

                    //    GJLine.SetFilter("Bal. Account No.", '%1', CurrentCZK); //broj proturacuna jer su blagajnici u razlicitim CZK
                    //  GJLine.SetFilter("Posting Date", '%1', System.Today); //datum knjizenja
                    GJLine.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                    GJLine.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");

                    if Rec."Payment Method" = Rec."Payment Method"::Cash then
                        GJLine.SetFilter("Payment No. int", '>%1', rec."Payment No. int")
                    else
                        GJLine.SetFilter("Payment No. int Card", '>%1', rec."Payment No. int Card");

                    if GJLine.FindFirst() then begin
                        GJLine.CalcSums("Amount (LCY)");
                        //ovo je iznos svih faktura



                    end;

                    if ("Amount (LCY)" <> 0) AND ("Given amount" > 0) then
                        "To return" := ABS("Given amount") - ABS(GJLine."Amount (LCY)") - abs(rec."Amount (LCY)");

                    if ("To return" <> 0) then begin
                        if ("Given amount" >= Abs(GJLine."Amount (LCY)" + rec."Amount (LCY)")) then
                            Message('Vrati kusur: ' + Format("To return") + ' KM.')
                        else
                            Message('Kupcu ostaje dug: ' + Format(Abs("To return")) + ' KM.'); //kupac ne uplaćuje puni iznos racuna
                    end;
                end
                else begin
                    "Given amount" := 0;
                    "To return" := 0;
                end;

            end;
        }

        modify(Amount)
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

                if "Document Type" = "Document Type"::Payment then begin
                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);

                    if US.FindFirst() then begin
                        if US.CurrentJnlBatchName <> '' then begin
                            if Amount > 0 then begin
                                validate(Amount, -abs(Amount));
                                validate("Amount (LCY)", -abs("Amount (LCY)"));
                            end;

                        end;
                    end;
                end;


                if "Given amount" <> 0 then begin
                    MultipleBills := 0;
                    TotalGivenAmount := Rec."Given amount"; //ukupni dati iznos za sve racune
                    Counter := 1;

                    GJLine.Reset();
                    GJLine.CopyFilters(rec);
                    //    GJLine.SetFilter("Bal. Account No.", '%1', CurrentCZK); //broj proturacuna jer su blagajnici u razlicitim CZK
                    //  GJLine.SetFilter("Posting Date", '%1', System.Today); //datum knjizenja
                    GJLine.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                    GJLine.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
                    //  GJLine.SetFilter("Payment No. int", '>%1', rec."Payment No. int");
                    if Rec."Payment Method" = Rec."Payment Method"::Cash then
                        GJLine.SetFilter("Payment No. int", '>%1', rec."Payment No. int")
                    else
                        GJLine.SetFilter("Payment No. int Card", '>%1', rec."Payment No. int Card");

                    if GJLine.FindFirst() then begin
                        GJLine.CalcSums(Amount);
                        //ovo je iznos svih faktura



                    end;

                    if (rec.Amount + GJLine."Amount" <> 0) AND ("Given amount" > 0) then
                        "To return" := ABS("Given amount") - ABS(GJLine."Amount") - abs(rec.Amount);

                    if ("To return" <> 0) then begin
                        if ("Given amount" >= Abs(GJLine.Amount + rec.Amount)) then
                            Message('Vrati kusur: ' + Format("To return") + ' KM.')
                        else
                            Message('Kupcu ostaje dug: ' + Format(Abs("To return")) + ' KM.'); //kupac ne uplaćuje puni iznos racuna
                    end;
                end
                else begin
                    "Given amount" := 0;
                    "To return" := 0;
                end;

            end;
        }

        field(50110; "VAT Difference CNG"; Decimal)
        {
            Caption = 'VAT Difference CNG';
            DecimalPlaces = 1 : 10;
        }
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                ReadGLSetup: Record "General Ledger Setup";
                GLSetupRead: Boolean;
            begin

                ReadGLSetup.get;
                GLSetupRead := true;

                "Postponed VAT" := ("VAT Date" <> 0D) AND ("VAT Date" <> "Posting Date") AND ReadGLSetup."Unrealized VAT";
            end;
        }
        modify("Credit Amount")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

                if ("Credit Amount" < 0) then begin
                    Correction := false;
                    "Debit Correction" := "Debit Amount";
                    "Credit Correction" := "Credit Amount";
                end;


            end;


        }

        modify("Debit Amount")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

                if ("Debit Amount" < 0) then begin
                    Correction := false;
                    "Debit Correction" := "Debit Amount";
                    "Credit Correction" := "Credit Amount";

                end;
            end;
        }


        modify(Correction)
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                DebitV := Rec."Debit Amount";
                CreditV := Rec."Credit Amount";
                AmountV := Rec.Amount;
                AmountL := rec."Amount (LCY)";

            end;

            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

                "Debit Amount" := DebitV;
                "Credit Amount" := CreditV;
                Amount := AmountV;
                "Amount (LCY)" := AmountL;

                "Debit Correction" := "Debit Amount";
                "Credit Correction" := "Credit Amount";

            end;

        }



        field(50122; "Nivelacija"; Boolean)
        {
            Caption = 'Nivelacija';
        }

        field(50005; "Employee"; Code[20])
        {
            Caption = 'Employee';
            TableRelation = Employee;
        }
        field(50006; "Contact"; Code[20])
        {
            Caption = 'Contact';
            TableRelation = Contact;
        }
        field(50050; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";
            trigger OnValidate()
            var
                myInt: Integer;
                US: record "User Setup";
            begin
                US.reset;
                US.setfilter("User ID", '%1', userid);
                if US.findfirst then begin
                    if (US."CNG Administrator" = true) or (us."CNG User" = true) then begin
                        "Payment Type" := "Bill type";
                    end;
                end;

            end;
        }

        field(50111; "Request Document"; Code[20]) //ED
        {
            Caption = 'Request Document';
            //     TableRelation = "Service Header"."No." where("Request Type" = filter(0 | 1 | 3 | 5 | 8 | 9 | 10), "Customer No." = field("Account No."));

            trigger OnValidate()
            var
                myInt: Integer;
                SH: Record "Service Header";
                GLEntry: Record "G/L Entry";
                GenJournalTodaY: Record "Gen. Journal Line";
                GenJournalTodaY2: Record "Gen. Journal Line";
            begin
                if rec."Request Document" <> '' then begin
                    sh.Reset();
                    SH.SetFilter("No.", '%1', Rec."Request Document");
                    if sh.FindFirst() then begin
                        sh."Proforma Paid" := true;
                        sh.modify;
                        sh.CalcFields("Amount Including VAT");


                        Validate("Account No.", sh."Bill-to Customer No.");
                        validate("Account No. Change", sh."Bill-to Customer No.");
                        Validate(Amount, sh."Amount Including VAT");
                        validate("Payment Type", sh."Bill type");
                    end;
                end;



                if (xRec."Request Document" <> '') then begin

                    sh.Reset();
                    SH.SetFilter("No.", '%1', xRec."Request Document");
                    if SH.FindFirst() then begin

                        GLEntry.Reset();
                        GLEntry.SetFilter("Request Document", '%1', xrec."Request Document");
                        GLEntry.setfilter("Document Type", '%1', GLEntry."Document Type"::Payment);
                        if GLEntry.FindFirst() then begin
                            sh."Proforma Paid" := true;
                            sh.modify;
                        end
                        else begin
                            GenJournalTodaY.Reset();
                            GenJournalTodaY.SetFilter("Request Document", '%1', xrec."Request Document");
                            GenJournalTodaY.SetFilter("Journal Batch Name", '<>%1', rec."Journal Batch Name");
                            if GenJournalTodaY.findfirst then begin
                                sh."Proforma Paid" := true;
                                sh.modify;
                            end
                            else begin
                                GenJournalTodaY2.Reset();
                                GenJournalTodaY2.SetFilter("Request Document", '%1', xrec."Request Document");
                                GenJournalTodaY2.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
                                GenJournalTodaY2.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                                GenJournalTodaY2.SetFilter("Line No.", '<>%1', rec."Line No.");
                                if GenJournalTodaY2.FindFirst() then begin
                                    sh."Proforma Paid" := true;
                                    sh.modify;
                                end
                                else begin
                                    sh."Proforma Paid" := false;
                                    sh.modify;
                                end;
                            end;

                        end;

                    end;
                end;


            end;
        }




        modify("Applies-to Doc. No.") //ED
        {


            trigger OnBeforeValidate()
            var
                Test: Text[50];
                BankAccount: record "Bank Account";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                PayInt: Integer;
                CustLedgerEntry: Record "Cust. Ledger Entry";
                BLG: record "User Setup";

            begin
                BLG.reset;
                BLG.SetFilter("User ID", '%1', UserId);
                if blg.FindFirst() then begin
                    if BLG."Cashier Table" <> '' then begin
                        if xRec."Applies-to Doc. No." <> '' then begin
                            if confirm('Prethodna referenca nije bila prazna, pa da li želite pregaziti unos?') then begin

                            end
                            else begin
                                Error('');
                            end;

                        end;
                    end;
                end;


                "Amount Payment Before" := rec."Amount (LCY)";



                if StrPos(rec."Journal Batch Name", 'CZK') <> 0 then begin
                    Charr := 39;
                    if "Main Cashier" = false then
                        rec."Document Type" := rec."Document Type"::Payment;

                    if StrPos(rec."Applies-to Doc. No.", Format(Charr)) <> 0 then begin


                        Test := ReplaceString(Rec."Applies-to Doc. No.", '-', '/');
                        Test := ReplaceString(Test, Format(Charr), '-');
                    end
                    else begin
                        Test := "Applies-to Doc. No.";
                    end;

                    Rec."Applies-to Doc. No." := Test;

                    if rec."Applies-to Doc. No." <> '' then begin
                        //Message('Poruka da radi na validate');
                        SalesInvoiceHeader.Reset(); //trazim vrstu uplate na dokumentu za zatvaranje

                        SalesInvoiceHeader.SetFilter("No.", Rec."Applies-to Doc. No.");
                        if SalesInvoiceHeader.FindFirst() then begin
                            Rec."Payment Type" := SalesInvoiceHeader."Payment Type Invoice";
                            rec."Payment Type" := SalesInvoiceHeader."Bill type";

                        end
                        else begin
                            //stavke analitike kupca

                            CustLedgerEntry.Reset();
                            CustLedgerEntry.SetFilter("Document No.", '%1', rec."Applies-to Doc. No.");
                            if CustLedgerEntry.findfirst then begin
                                rec.validate("Account No.", CustLedgerEntry."Customer No.");
                                if StrLen(rec."Applies-to Doc. No.") >= 3 then
                                    rec."Payment Type" := CopyStr(rec."Applies-to Doc. No.", 1, 2)
                                else
                                    rec."Payment Type" := '';


                                if CustLedgerEntry."Bill type" <> ''
    then
                                    rec."Payment Type" := CustLedgerEntry."Bill type";
                                CustLedgerEntry.CalcFields(Amount);
                                rec.Amount := CustLedgerEntry.Amount;
                            end;
                        end;
                    end

                    else begin
                        CustF.Reset();
                        CustF.setfilter("No.", '%1', Rec."Account No.");
                        if CustF.findfirst then begin
                            if (CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"Special Customer")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"KJKP Heating plant") then begin
                                Rec."Payment Type" := '01';
                                rec."Payment Type" := '01';
                                Rec."Bill type" := '01'
                            end;

                            if CustF."Customer Category" = CustF."Customer Category"::"Small Economy" then begin
                                Rec."Payment Type" := '02';
                                rec."Payment Type" := '02';
                                Rec."Bill type" := '02'
                            end;

                            if CustF."Customer Category" = CustF."Customer Category"::Household then begin
                                Rec."Payment Type" := '03';
                                rec."Payment Type" := '03';
                                Rec."Bill type" := '03'
                            end;

                        end
                        else begin


                        end;
                    end;

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        GenJournalBatch.Reset();
                        GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
                        if GenJournalBatch.FindFirst() then begin

                            Validate("Bal. Account Type", GenJournalBatch."Bal. Account Type");
                            validate("Bal. Account No.", GenJournalBatch."Bal. Account No.");
                            if "Payment Method" = "Payment Method"::Cash then begin

                                if ("Payment No." = '') and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin

                                    if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                                        //ĐK

                                        NoSeriesMgt.InitSeries(GenJournalBatch."No. series Payment Int", '', 0D, "Payment No.", "No. Series");
                                        if Evaluate(PayInt, "Payment No.") then
                                            "Payment No. int" := PayInt;
                                    end;
                                end;
                            end
                            else begin

                                if ("Payment No. Card" = '') and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin

                                    if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                                        //ĐK

                                        NoSeriesMgt.InitSeries(GenJournalBatch."No. series Payment Int Card", '', 0D, "Payment No. Card", "No. Series");
                                        if Evaluate(PayInt, "Payment No. Card") then
                                            "Payment No. int Card" := PayInt;
                                        "Payment No." := "Payment No. Card";
                                    end;
                                end;

                            end;
                        end;
                    end;
                end;

                if "Payment No." <> '' then begin
                    Evaluate("Payment No. order", "Payment No.");


                    if ("Posting Date Card" = 0D) or ("Posting Date Cash" = 0D) then begin
                        Us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            if "Payment Method" = "Payment Method"::Cash then
                                validate("Posting Date", us."Posting Date Cash");

                            if "Payment Method" = "Payment Method"::Card then
                                validate("Posting Date", us."Posting Date Card");

                            if (us."Posting Date Cash" = 0D) and (us."Posting Date Card" = 0D)
                            then begin
                                validate("Posting Date", Today);

                            end;
                        end;
                    end;
                    us.reset;

                    us.setfilter("User ID", '%1', userid);
                    if us.findfirst then begin
                        if "Payment Method" = "Payment Method"::Card then
                            "Posting Date Card" := us."Posting Date Card";

                        if "Payment Method" = "Payment Method"::Cash then
                            "Posting Date Cash" := us."Posting Date Cash";

                    end;
                end;


            end;

            trigger OnAfterValidate()
            var
                myInt: Integer;
                DocumentSeries: Record "Gen. Journal Batch";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                ServInvoiceLine: Record "Service Invoice Line";
                CustLedgerEntry: record "Cust. Ledger Entry";
                GenJnlTemplateSeries: Record "Gen. Journal Template";
                GenJnlBatchSeries: Record "Gen. Journal Batch";
                GenJnlLineSeries: record "Gen. Journal Line";
                LastGenJnlLine: Record "Gen. Journal Line";
            begin



                if Rec."Document No." = '' then begin

                    if "Main Cashier" = false
                    then
                        "Document type" := "Document Type"::Payment;

                    //vjerujem da je ovo samo za blagajnu
                    DocumentSeries.Reset();
                    DocumentSeries.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                    DocumentSeries.SetFilter(Name, '%1', Rec."Journal Batch Name");
                    if DocumentSeries.FindFirst() then begin
                        // if DocumentSeries."Posting No. Series" <> '' then
                        // NoSeriesMgt.InitSeries(DocumentSeries."Posting No. Series", xRec."No. Series", 0D, "Document No.", "No. Series");

                        GenJnlTemplateSeries.Get("Journal Template Name");
                        GenJnlBatchSeries.Get("Journal Template Name", "Journal Batch Name");
                        GenJnlLineSeries.SetRange("Journal Template Name", "Journal Template Name");
                        GenJnlLineSeries.SetRange("Journal Batch Name", "Journal Batch Name");
                        if GenJnlLineSeries.FindFirst then begin
                            LastGenJnlLine.Reset();
                            LastGenJnlLine.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                            LastGenJnlLine.SetFilter("Journal Batch Name", '%1', "Journal Batch Name");

                            UserSetup.get(USERID);
                            if "Payment Method" = "Payment Method"::Cash then
                                LastGenJnlLine.SetFilter("Posting Date", '%1', UserSetup."Posting Date Cash");
                            if "Payment Method" = "Payment Method"::Card then
                                LastGenJnlLine.SetFilter("Posting Date", '%1', UserSetup."Posting Date Card");
                            LastGenJnlLine.SetFilter("Document No.", '<>%1', '');
                            if LastGenJnlLine.findfirst then begin

                                "Document Date" := LastGenJnlLine."Posting Date";
                                "Document No." := LastGenJnlLine."Document No.";

                            end
                            else begin

                                if GenJnlBatchSeries."No. Series" <> '' then begin
                                    Clear(NoSeriesMgt);
                                    NoSeriesMgt.InitSeries(GenJnlBatchSeries."No. Series", xRec."No. Series", 0D, "Document No.", "No. Series");
                                end;

                            end;
                        end;
                    end;
                end;
                if rec."Applies-to Doc. No." <> '' then begin
                    SalesInvoiceHeader.Reset(); //trazim vrstu uplate na dokumentu za zatvaranje
                    SalesInvoiceHeader.SetFilter("No.", Rec."Applies-to Doc. No.");
                    if SalesInvoiceHeader.FindFirst() then begin
                        Rec."Payment Type" := SalesInvoiceHeader."Payment Type Invoice";
                        rec."Payment Type" := SalesInvoiceHeader."Bill type";
                    end
                    else begin
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetFilter("Document No.", '%1', rec."Applies-to Doc. No.");
                        if CustLedgerEntry.findfirst then begin
                            rec.validate("Account No.", CustLedgerEntry."Customer No.");
                            if StrLen(rec."Applies-to Doc. No.") >= 3 then
                                rec."Payment Type" := CopyStr(rec."Applies-to Doc. No.", 1, 2)
                            else
                                rec."Payment Type" := '';

                            if CustLedgerEntry."Bill type" <> '' then
                                rec."Payment Type" := CustLedgerEntry."Bill type";
                            CustLedgerEntry.CalcFields(Amount);
                            rec.Amount := CustLedgerEntry.Amount;
                        end;
                    end;
                end;
                if rec."Applies-to Doc. No." <> '' then begin
                    ServInvoiceLine.reset;
                    ServInvoiceLine.SetFilter("Document No.", '%1', rec."Applies-to Doc. No.");
                    if ServInvoiceLine.FindFirst() then begin
                        //na fakturi treba pored mjernog mjesta, prikazati i mjerač ServInvoiceLine.
                    end
                    else begin
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetFilter("Document No.", '%1', rec."Applies-to Doc. No.");
                        if CustLedgerEntry.findfirst then begin
                            validate("Account No.", CustLedgerEntry."Customer No.");
                            CustLedgerEntry.CalcFields("Remaining Amount");
                            validate(Amount, -abs(CustLedgerEntry."Remaining Amount"));
                        end;
                    end;

                    "Account No. Change" := "Account No.";
                end;

                if rec."Journal Template Name" = 'PAYMENTS' then
                    validate("Amount (LCY)", "Amount Payment Before");
                Commit();

            end;

        }

        field(50001; "Postponed VAT"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Activation"; Boolean)
        {
            Caption = 'Activation';
        }

        field(50003; "Compensation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Due Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Due Date 3"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Bin Checked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50021; "Note 1"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Note 2"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50048; "Note 3"; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Payment DT"; DateTime)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                DatumPomocni := DT2Date("Payment DT");
            end;
        }
        field(50025; "Given amount"; Decimal)
        {
            //ĐK TEST VRATITI   Caption = 'Given amount';

            trigger OnValidate()
            begin
                if "Given amount" <> 0 then begin
                    MultipleBills := 0;
                    TotalGivenAmount := Rec."Given amount"; //ukupni dati iznos za sve racune
                    Counter := 1;

                    GJLine.Reset();
                    GJLine.CopyFilters(rec);
                    //    GJLine.SetFilter("Bal. Account No.", '%1', CurrentCZK); //broj proturacuna jer su blagajnici u razlicitim CZK
                    //  GJLine.SetFilter("Posting Date", '%1', System.Today); //datum knjizenja
                    GJLine.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                    GJLine.SetFilter("Journal Batch Name", '%1', rec."Journal Batch Name");
                    //   GJLine.SetFilter("Payment No. int", '>%1', rec."Payment No. int");
                    if Rec."Payment Method" = Rec."Payment Method"::Cash then
                        GJLine.SetFilter("Payment No. int", '>%1', rec."Payment No. int")
                    else
                        GJLine.SetFilter("Payment No. int Card", '>%1', rec."Payment No. int Card");
                    if GJLine.FindFirst() then begin
                        GJLine.CalcSums("Amount (LCY)");
                        //ovo je iznos svih faktura



                    end;

                    if (Amount <> 0) AND ("Given amount" > 0) then
                        "To return" := ABS("Given amount") - ABS(GJLine."Amount (LCY)") - abs(rec."Amount (LCY)");

                    if ("To return" <> 0) then begin
                        if ("Given amount" >= Abs(GJLine."Amount (LCY)" + rec.Amount)) then
                            Message('Vrati kusur: ' + Format("To return") + ' KM.')
                        else
                            Message('Kupcu ostaje dug: ' + Format(Abs("To return")) + ' KM.'); //kupac ne uplaćuje puni iznos racuna
                    end;
                end
                else begin
                    "Given amount" := 0;
                    "To return" := 0;
                end;


            end;


        }
        field(50026; "To return"; Decimal)
        {
            Caption = 'To return';
            Editable = false;
        }
        field(50027; "No. Line"; Integer)
        {
            Caption = 'Redni broj uplate';
        }
        field(50028; "Social status"; enum "Social Status")
        {
            Caption = 'Social status category';
        }
        field(50030; "Address_Cust"; Text[100])
        {
            Caption = 'Address';
        }
        field(50031; "RegistrationNo_Cust"; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(50032; "VATRegistrationNo_Cust"; Text[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(50033; "Payment Type"; Code[10])
        {
            Caption = 'Payment Type';
            TableRelation = "Customer Templ.";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Bill type" := "Payment Type";

            end;
        }
        field(50034; "Payment Method"; enum "Payment Method")
        {
            Caption = 'Payment Method';
            trigger OnValidate()
            var
                myInt: Integer;
                BankAccount: Record "Bank Account";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                GJLine: Record "Gen. Journal Line";
                PayInt: Integer;
                GL: Record "Gen. Journal Line";
                NoSeriesLine: Record "No. Series Line";
            begin

                if "Payment Method" = "Payment Method"::Cash then
                    VALIDATE("Payment Method Code", 'GOTOVINA');
                if "Payment Method" = "Payment Method"::Card then
                    VALIDATE("Payment Method Code", 'KARTIČNO');

                //ovdje ću resetovati brojčanu seriju i sve vratiti na 0. Ostalo nek ostane kako treba
                if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                    if rec."Payment Method" <> xRec."Payment Method" then begin
                        //znači ako se desila promjena u načinu


                        GL.Reset();
                        GL.CopyFilters(Rec);
                        gl.SetFilter("Payment No. int", '<>%1&<>%2', 0, rec."Payment No. int");
                        gl.SetCurrentKey("Payment No. int");
                        gl.Ascending;
                        if gl.FindLast() then begin

                            NoSeriesLine.Reset();
                            NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment");
                            NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                            NoSeriesLine.SetCurrentKey("Starting Date");
                            NoSeriesLine.Ascending;
                            if NoSeriesLine.findlast then begin
                                NoSeriesLine."Last No. Used" := format(gl."Payment No. int");
                                NoSeriesLine.modify;
                            end;
                        end
                        else begin

                            NoSeriesLine.Reset();
                            NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment");
                            NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                            NoSeriesLine.SetCurrentKey("Starting Date");
                            NoSeriesLine.Ascending;
                            if NoSeriesLine.findlast then begin
                                NoSeriesLine."Last No. Used" := format(1);
                                NoSeriesLine.modify;

                            end;

                        end;

                        //novi

                        GL.Reset();
                        GL.CopyFilters(Rec);
                        gl.SetFilter("Payment No. int Card", '<>%1&<>%2', 0, rec."Payment No. int Card");
                        gl.SetCurrentKey("Payment No. int Card");
                        gl.Ascending;
                        if gl.FindLast() then begin

                            NoSeriesLine.Reset();
                            NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment Card");
                            NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                            NoSeriesLine.SetCurrentKey("Starting Date");
                            NoSeriesLine.Ascending;
                            if NoSeriesLine.findlast then begin
                                NoSeriesLine."Last No. Used" := format(gl."Payment No. int Card");
                                NoSeriesLine.modify;
                            end;
                        end
                        else begin

                            NoSeriesLine.Reset();
                            NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment Card");
                            NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                            NoSeriesLine.SetCurrentKey("Starting Date");
                            NoSeriesLine.Ascending;
                            if NoSeriesLine.findlast then begin
                                NoSeriesLine."Last No. Used" := format(1);
                                NoSeriesLine.modify;

                            end;

                        end;

                    end;
                    //kraj


                    "Payment No. int" := 0;
                    "Payment No. int Card" := 0;
                    "Payment No." := '';
                    "Payment No. Card" := '';
                    "Payment No. order" := 0;
                end;

                if "Payment Method" = "Payment Method"::Cash then begin

                    if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                        //ĐK

                        NoSeriesMgt.InitSeries(BankAccount."No. series for Payment", '', 0D, "Payment No.", "No. Series");
                        if Evaluate(PayInt, "Payment No.") then
                            "Payment No. int" := PayInt;
                    end;

                end
                else begin
                    if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                        //ĐK

                        NoSeriesMgt.InitSeries(BankAccount."No. series for Payment Card", '', 0D, "Payment No. Card", "No. Series");
                        if Evaluate(PayInt, "Payment No. Card") then
                            "Payment No. int Card" := PayInt;
                        "Payment No." := "Payment No. Card";
                    end;

                end;
                if "Payment No." <> '' then begin
                    Evaluate("Payment No. order", "Payment No.");


                    if ("Posting Date Card" = 0D) or ("Posting Date Cash" = 0D) then begin
                        Us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            if "Payment Method" = "Payment Method"::Cash then
                                validate("Posting Date", us."Posting Date Cash");

                            if "Payment Method" = "Payment Method"::Card then
                                validate("Posting Date", us."Posting Date Card");

                        end;
                    end;
                    us.reset;

                    us.setfilter("User ID", '%1', userid);
                    if us.findfirst then begin
                        if "Payment Method" = "Payment Method"::Card then
                            "Posting Date Card" := us."Posting Date Card";

                        if "Payment Method" = "Payment Method"::Cash then
                            "Posting Date Cash" := us."Posting Date Cash";

                    end;
                end;
            end;
        }
        field(50035; "City_Cust"; Text[30])
        {
            Caption = 'City';
        }
        field(50036; Phone_Cust; Text[30])
        {
            Caption = 'Phone';
        }
        field(50037; MobilePhone_Cust; Text[30])
        {
            Caption = 'Mobile Phone';
        }
        field(50038; Email_Cust; Text[80])
        {
            Caption = 'E-mail';
        }

        field(50040; "GlobalDimension1Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 filter';
            NotBlank = true;
        }
        field(50041; "GlobalDimension2Filter"; Code[20])
        {
            Caption = 'Global Dimension 2 filter';
            NotBlank = true;
        }
        field(50042; "CurrencyFilter"; Code[10])
        {
            Caption = 'Currency Filter';
            NotBlank = true;
        }
        /*field(50043; Avans_Cust; Decimal)
        {
            Caption = 'Avans';
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("Account No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD(GlobalDimension1Filter),
                                                                                 "Initial Entry Global Dim. 2" = FIELD(GlobalDimension2Filter),
                                                                                 "Currency Code" = FIELD(CurrencyFilter), Prepayment = FILTER(TRUE)));

        }*/
        field(50044; "Complaint"; Boolean)
        {
            Caption = 'Complaint';
            Editable = false;
        }
        field(50045; "Interest"; Boolean)
        {
            Caption = 'Interest';
            Editable = false;
        }
        field(50046; "Apoeni"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Apoeni.Amount WHERE("Bal. Account No." = field("Bal. Account No."), "Posting Date" = field("Posting Date")));
        }
        field(50047; "Cash Register"; Text[100])
        {
            Caption = 'Cash Register';
        }
        field(50049; "Main Cashier"; Boolean)
        {
            Caption = 'Main Cashier';
            InitValue = false;
        }
        field(50051; "Cashier Employer"; Code[10])
        {
            Caption = 'Cashier Employer';
        }
        field(50052; "No. Series"; Code[20])
        { }
        field(50053; "Payment No."; Code[20])
        {
            Caption = 'Redni broj uplate';
        }
        field(50054; "Mupltiple customers"; Boolean)
        {
            Caption = 'Multiple Customers To Return';

            trigger OnValidate()
            begin
                Rec.Modify();


            end;
        }
        field(50055; "Donation"; Code[20])
        {
            Caption = 'Donation';
            TableRelation = "G/L Account";
        }
        field(50056; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(50057; "Donation Percentage"; Decimal)
        {
            Caption = 'Donation Percentage';

        }

        field(50058; "OS"; Code[20])
        {
            Caption = 'OS';

        }
        field(50059; "FA Posting Group"; Code[50])
        {
            Caption = 'FA Posting Group';
            TableRelation = "FA Posting Group";
        }
        field(50060; "Total Retail Amount"; Decimal)
        {
            Caption = 'Total Retail Amout';
            AutoFormatType = 2;
        }
        field(50061; "Retail RUC"; Decimal)
        {
            Caption = 'Retail RUC';
            AutoFormatType = 2;
        }
        field(50062; "Retail Unit Price"; Decimal)
        {
            Caption = 'Retail Unit Price';
            AutoFormatType = 2;

        }

        field(50063; "Retail Unit Price with VAT"; Decimal)
        {
            Caption = 'Retail Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50064; "Retail VAT"; Decimal)
        {
            Caption = 'Retail VAT';
            AutoFormatType = 2;

        }
        field(50065; "T.Retail Unit Price with VAT"; Decimal)
        {
            Caption = 'Total Retail Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50067; "CNG MP"; Boolean) { Caption = 'CNG MP'; }
        field(50068; "CNG VP"; Boolean) { Caption = 'CNG VP'; }

        field(50090; "Hide CNG MP"; Boolean)
        {
            Caption = 'Hide CNG MP';
        }
        field(50091; "R. CNG MP"; Boolean)
        {
            Caption = 'R. CNG MP';
        }



        field(50066; "Document Type_2"; Enum "Item Ledger Document Type")
        {
            Caption = 'Document Type';
        }
        field(50069; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }

        field(50070; "Total Wholesale Amount"; Decimal)
        {
            Caption = 'Wholesale Retail Amout';
            AutoFormatType = 2;
        }
        field(50071; "Wholesale RUC"; Decimal)
        {
            Caption = 'Wholesale RUC';
            AutoFormatType = 2;
        }
        field(50072; "Wholesale Unit Price"; Decimal)
        {
            Caption = 'Wholesale Unit Price';
            AutoFormatType = 2;

        }

        field(50073; "Wholesale Unit Price with VAT"; Decimal)
        {
            Caption = 'Wholesale Unit Price with VAT';
            AutoFormatType = 2;

        }
        field(50074; "Wholesale VAT"; Decimal)
        {
            Caption = 'Wholesale VAT';
            AutoFormatType = 2;

        }
        field(50075; "T.Wholesale Unit Price with V"; Decimal)
        {
            Caption = 'Total Wholesale Unit Price with VAT';
            AutoFormatType = 2;

        }

        field(50076; "Transfer Header"; Boolean)
        {
            Caption = 'Transfer Header';
            AutoFormatType = 2;

        }
        field(50077; "Calculate Retail VAT"; Decimal)
        {
            Caption = 'Calculate Retail VAT';
            AutoFormatType = 2;

        }
        field(50078; "Calculate Wholesale VAT"; Decimal)
        {
            Caption = 'Calculate Wholesale VAT';
            AutoFormatType = 2;

        }

        field(50079; "Debit Correction"; Decimal)
        {
            Caption = 'Debit Correction';
            AutoFormatType = 2;

        }
        field(50080; "Credit Correction"; Decimal)
        {
            Caption = 'Credit Correction';
            AutoFormatType = 2;

        }
        field(50081; "Payment No. int"; Integer)
        {
            Caption = 'Payment No. int';
            AutoFormatType = 2;

        }
        field(50082; "KUF_Entry"; code[20])

        {
            Caption = 'KUF Entry';
        }
        field(50083; "KIF_Entry"; code[20])

        {
            Caption = 'KIF Entry';
        }
        field(50084; "KUF_Type"; Option)
        {
            Caption = 'KUF Type';
            OptionCaption = 'DOMAĆI,INO,AVANSI';
            OptionMembers = "DOMAĆI",INO,AVANSI;
        }
        field(50085; "CNG VL"; Boolean) { Caption = 'CNG VL'; }

        field(50086; "Gen Bus Posting"; Code[20])
        {
            Caption = 'Gen Bus Posting';
        }
        field(50087; "Prod Bus Posting"; Code[20])
        {
            Caption = 'Prod Bus Posting';
        }
        field(50088; "Court Boolean"; Boolean)
        {
            Caption = 'Court Boolean';
        }

        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }
        field(50099; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        field(50100; "MALS"; Text[200])
        {
            Caption = 'MALS';
        }

        field(50101; ServiceItemLine; Code[20])
        {
            Caption = 'ServiceItemLine';
            AutoFormatType = 1;
            CalcFormula = lookup("Service Invoice Line"."Service Item No." where("Document No." = field("Applies-to Doc. No.")));
            FieldClass = FlowField;
        }

        field(50102; "Gauge Code"; Code[20])
        {
            Caption = 'Gauge Code';
            TableRelation = "Service Item"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                IH: Record "Service Item";
            begin
                IH.Reset();
                IH.SetFilter("No.", '%1', "Gauge Code");
                if ih.FindFirst() then begin
                    if ih."Customer No." <> '' then begin
                        validate("Account No.", ih."Customer No.");
                        validate("Account No. Change", ih."Customer No.");
                    end;
                end;

            end;
        }
        field(50103; "Payment No. int Card"; Integer)
        {
            Caption = 'Payment No. int Card';
            AutoFormatType = 2;

        }
        field(50104; "Payment No. Card"; Code[20])
        {
            Caption = 'Redni broj uplate Card';
        }
        field(50105; "Account No. Change"; Code[20])

        {


            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST("IC Partner")) "IC Partner"
            ELSE
            IF ("Account Type" = CONST(Employee)) Employee;
            ValidateTableRelation = false;


            trigger OnValidate()
            var
                IsHandled: Boolean;
                CustomerNo: code[20];
                CUsTF: record "CUstomer";
                GLAcc: Record "G/L Account";
            begin
                /*       if "Account No. Change" <> xRec."Account No. Change" then begin
                           ClearAppliedAutomatically;
                           BlankJobNo(FieldNo("Account No. Change"));
                       end;

                       if xRec."Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"IC Partner"] then
                           "IC Partner Code" := '';

                       if "Account No. Change" = '' then begin
                           CleanLine;
                           exit;
                       end;


                       case "Account Type" of
                           "Account Type"::"G/L Account":
                               GetGLAccount;
                           "Account Type"::Customer:
                               GetCustomerAccount;
                           "Account Type"::Vendor:
                               GetVendorAccount;
                           "Account Type"::Employee:
                               GetEmployeeAccount;
                           "Account Type"::"Bank Account":
                               GetBankAccount;
                           "Account Type"::"Fixed Asset":
                               GetFAAccount;
                           "Account Type"::"IC Partner":
                               GetICPartnerAccount;
                       end;



                       Validate("Currency Code");
                       Validate("VAT Prod. Posting Group");
                       UpdateLineBalance;
                       UpdateSource;

                       IsHandled := false;

                       if IsHandled then
                           exit;

                       CreateDim(
                         DimMgt.TypeToTableID1("Account Type".AsInteger()), "Account No. Change",
                         DimMgt.TypeToTableID1("Bal. Account Type".AsInteger()), "Bal. Account No.",
                         DATABASE::Job, "Job No.",
                         DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
                         DATABASE::Campaign, "Campaign No.");

                       Validate("IC Partner G/L Acc. No.", GetDefaultICPartnerGLAccNo);
                       ValidateApplyRequirements(Rec);

                       case "Account Type" of
                           "Account Type"::"G/L Account":
                               UpdateAccountID;
                           "Account Type"::Customer:
                               UpdateCustomerID;
                           "Account Type"::"Bank Account":
                               UpdateBankAccountID;
                       end;
                   end;*/


                if rec."Account Type" = rec."Account Type"::Customer then begin
                    if "Account No. Change" <> '' then begin
                        CustomerNo := CopyStr("Account No. Change", 1, 6);
                        CustomerNo := DelChr(CustomerNo, '<', '0');
                        Validate("Account No.", CustomerNo);
                    end
                    else begin
                        Validate("Account No.", "Account No. Change");
                    end;

                end
                else begin
                    Validate("Account No.", "Account No. Change");
                end;


                //EK
                if (Rec."Account Type" = Rec."Account Type"::"G/L Account") and ("Account No. Change" <> '') then begin
                    if GLAcc.Get("Account No. Change") then
                        Description := GLAcc.Name;
                end;
                //

                "Account No." := "Account No. Change";


                if ("Account No. Change" <> '') and ("Applies-to Doc. No." = '') then begin
                    CUsTF.Reset();
                    CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                    if CUsTF.FindFirst() then begin
                        if CUsTF."Customer Category" = CUsTF."Customer Category"::Household then
                            "Payment Type" := '03';

                        if CUsTF."Customer Category" = CUsTF."Customer Category"::"Small Economy" then
                            "Payment Type" := '02';
                        if (CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"Special Customer")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"KJKP Heating plant") then
                            "Payment Type" := '01';
                        "Bill type" := "Payment Type";

                    end;
                end;

                "Account No. Change" := "Account No.";
                if (rec."Payment Type" = '') and ("Account Type" = "Account Type"::"Customer") and ("Account No. Change" <> '') then begin
                    CUsTF.Reset();
                    CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                    if CUsTF.FindFirst() then begin
                        if CUsTF."Customer Category" = CUsTF."Customer Category"::Household then
                            "Payment Type" := '03';

                        if CUsTF."Customer Category" = CUsTF."Customer Category"::"Small Economy" then
                            "Payment Type" := '02';
                        if (CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"Special Customer")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"KJKP Heating plant") then
                            "Payment Type" := '01';
                        "Bill type" := "Payment Type";
                    end;
                end;
                /*
                //EK Zak. vratiti ako ne bude radilo moje rjesenje

                CUsTF.Reset();
                CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                if CUsTF.FindFirst() then begin
                    if CUsTF."Name 2" <> '' then
                        Description := CUsTF."Name" + ' ' + CUsTF."Name 2"
                    else
                        Description := CUsTF."Name";
                end;
                "Account No. Change" := "Account No.";
                //   Commit();
            end;
            */
                //EK

                if Rec."Account Type" = Rec."Account Type"::Customer then begin
                    CUsTF.Reset();
                    CUsTF.SetFilter("No.", '%1', Rec."Account No. Change");
                    if CUsTF.FindFirst() then begin
                        if CUsTF."Name 2" <> '' then
                            Description := CUsTF."Name" + ' ' + CUsTF."Name 2"
                        else
                            Description := CUsTF."Name";
                    end;
                end;
            end;

            //EK
        }


        field(50109; "Accusations"; Integer)
        {
            Caption = 'Accusations';
            FieldClass = FlowField;
            CalcFormula = count("Accusation Header" where("Customer No." = field("Account No."), Withdrawn = filter(false), Archive = filter(false)));

        }
        field(50106; "Payment No. order"; Integer)

        {
            Caption = 'Payment No. Order';
        }
        field(50107; "Posting Date Cash"; date)
        {
            caption = 'Posting Date Cash';
            trigger OnValidate()
            var
                myInt: Integer;
                US: Record "User Setup";
            begin
                us.reset;
                us.SetFilter("User ID", '%1', userid);
                if us.FindFirst() then begin
                    us."Posting Date Cash" := rec."Posting Date Cash";
                    if rec."Payment Method" = rec."Payment Method"::card then
                        rec.validate("Posting Date", "Posting Date Card");

                    if rec."Payment Method" = rec."Payment Method"::cash then
                        rec.validate("Posting Date", "Posting Date Cash");
                    us.modify;
                end;

            end;
        }
        field(50108; "Posting Date Card"; date)
        {
            caption = 'Posting Date Card';
            trigger OnValidate()
            var
                myInt: Integer;
                US: Record "User Setup";
            begin
                us.reset;
                us.SetFilter("User ID", '%1', userid);
                if us.FindFirst() then begin
                    us."Posting Date Card" := rec."Posting Date Card";
                    if rec."Payment Method" = rec."Payment Method"::card then
                        rec.validate("Posting Date", "Posting Date Card");

                    if rec."Payment Method" = rec."Payment Method"::cash then
                        rec.validate("Posting Date", "Posting Date Cash");

                    us.modify;
                end;

            end;
        }
        field(50119; "Hide PP"; Boolean) { Caption = 'Hide PP'; }
        field(50120; "Debit Amount Payroll"; Decimal)
        {
            DecimalPlaces = 2 : 6;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                "Amount Payroll" := "Debit Amount Payroll";
            end;

        }
        field(50121; "Credit Amount Payroll"; Decimal)
        {
            DecimalPlaces = 2 : 6;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Credit Amount Payroll" := Round("Credit Amount Payroll", 0.00001);
                "Amount Payroll" := "Credit Amount Payroll";
            end;
        }
        field(50123; "Amount Payroll"; Decimal) { DecimalPlaces = 2 : 6; }
        field(50124; "Amount Payment Before"; Decimal) { DecimalPlaces = 2 : 6; }






        modify("Account No.")
        {


            //            validatetablerelation = False;



            trigger OnBeforeValidate()
            var
                myInt: Integer;
                CustomerNo: code[20];
                CUstF: Record Customer;

            begin

                rec."Account No. Change" := "Account No.";

                if rec."Account Type" = rec."Account Type"::Customer then begin
                    if "Account No." <> '' then begin
                        CustomerNo := CopyStr("Account No.", 1, 6);
                        CustomerNo := DelChr(CustomerNo, '<', '0');
                    end;

                    CUsTF.Reset();
                    CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                    if CUsTF.FindFirst() then begin
                        if CUsTF."Name 2" <> '' then
                            Description := copystr(CUsTF."Name" + ' ' + CUsTF."Name 2", 1, 100)
                        else
                            Description := CUsTF."Name";
                    end;


                end;

                if "Applies-to Doc. No." = '' then begin
                    CUsTF.Reset();
                    CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                    if CUsTF.FindFirst() then begin
                        if CUsTF."Customer Category" = CUsTF."Customer Category"::Household then
                            "Payment Type" := '03';

                        if CUsTF."Customer Category" = CUsTF."Customer Category"::"Small Economy" then
                            "Payment Type" := '02';
                        if (CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"Special Customer")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"KJKP Heating plant") then
                            "Payment Type" := '01';
                        "Bill type" := "Payment Type";

                    end;
                end;

            end;


            trigger OnAfterValidate()
            var
                FX: Record "Fixed Asset";
                FD: Record "FA Depreciation Book";
                DocumentSeries: Record "Gen. Journal Batch";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                BankAccount: Record "Bank Account";
                CUsTF: record "CUstomer";
                PayInt: Integer;
                GenJnlTemplateSeries: Record "Gen. Journal Template";
                GenJnlBatchSeries: Record "Gen. Journal Batch";
                GenJnlLineSeries: record "Gen. Journal Line";
                LastGenJnlLine: Record "Gen. Journal Line";
                UserSetup: Record "User Setup";
            begin
                if ("Account Type" = "Account Type"::Customer) and ("Account No." <> '') then begin

                    Customer.Get("Account No.");
                    "Social status" := Customer."Social status category";
                    Address_Cust := Customer.Address;
                    RegistrationNo_Cust := Customer."Registration No.";
                    VATRegistrationNo_Cust := Customer."VAT Registration No.";
                    City_Cust := Customer.City;
                    //    Balance_Cust := Customer."Balance Due";
                    Phone_Cust := Customer."Phone No.";
                    MobilePhone_Cust := Customer."Mobile Phone No.";
                    Email_Cust := Customer."E-Mail";
                    "Social status" := Customer."Social status category";
                    GlobalDimension1Filter := Customer."Global Dimension 1 Filter";
                    GlobalDimension2Filter := Customer."Global Dimension 2 Filter";
                    CurrencyFilter := Customer."Currency Filter";


                    if Rec."Document No." = '' then begin

                        if "Main Cashier" = false then
                            "Document Type" := "Document Type"::Payment;

                        //vjerujem da je ovo samo za blagajnu
                        DocumentSeries.Reset();
                        DocumentSeries.SetFilter("Journal Template Name", '%1', Rec."Journal Template Name");
                        DocumentSeries.SetFilter(Name, '%1', Rec."Journal Batch Name");
                        if DocumentSeries.FindFirst() then begin
                            // if DocumentSeries."Posting No. Series" <> '' then
                            // NoSeriesMgt.InitSeries(DocumentSeries."Posting No. Series", xRec."No. Series", 0D, "Document No.", "No. Series");

                            GenJnlTemplateSeries.Get("Journal Template Name");
                            GenJnlBatchSeries.Get("Journal Template Name", "Journal Batch Name");
                            GenJnlLineSeries.SetRange("Journal Template Name", "Journal Template Name");
                            GenJnlLineSeries.SetRange("Journal Batch Name", "Journal Batch Name");
                            if GenJnlLineSeries.FindFirst then begin
                                LastGenJnlLine.Reset();
                                LastGenJnlLine.SetFilter("Journal Template Name", '%1', rec."Journal Template Name");
                                LastGenJnlLine.SetFilter("Journal Batch Name", '%1', "Journal Batch Name");
                                UserSetup.get(USERID);
                                if "Payment Method" = "Payment Method"::Cash then
                                    LastGenJnlLine.SetFilter("Posting Date", '%1', UserSetup."Posting Date Cash");
                                if "Payment Method" = "Payment Method"::Card then
                                    LastGenJnlLine.SetFilter("Posting Date", '%1', UserSetup."Posting Date Card");
                                LastGenJnlLine.SetFilter("Document No.", '<>%1', '');
                                if LastGenJnlLine.findfirst then begin

                                    "Document Date" := LastGenJnlLine."Posting Date";
                                    "Document No." := LastGenJnlLine."Document No.";

                                end
                                else begin

                                    if GenJnlBatchSeries."No. Series" <> '' then begin
                                        Clear(NoSeriesMgt);
                                        NoSeriesMgt.InitSeries(GenJnlBatchSeries."No. Series", xRec."No. Series", 0D, "Document No.", "No. Series");
                                    end;

                                end;
                            end;
                        end;
                    end;
                    SalesInvoiceHeader.Reset(); //trazim vrstu uplate na dokumentu za zatvaranje
                    SalesInvoiceHeader.SetFilter("No.", Rec."Applies-to Doc. No.");
                    if SalesInvoiceHeader.FindFirst() then begin
                        Rec."Payment Type" := SalesInvoiceHeader."Payment Type Invoice";
                        rec."Payment Type" := SalesInvoiceHeader."Bill type";
                    end;


                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        GenJournalBatch.Reset();
                        GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
                        if GenJournalBatch.FindFirst() then begin

                            Validate("Bal. Account Type", GenJournalBatch."Bal. Account Type");
                            validate("Bal. Account No.", GenJournalBatch."Bal. Account No.");
                            if "Payment Method" = "Payment Method"::Cash then begin

                                if ("Payment No." = '') and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin

                                    if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                                        //ĐK

                                        NoSeriesMgt.InitSeries(BankAccount."No. series for Payment", '', 0D, "Payment No.", "No. Series");
                                        if Evaluate(PayInt, "Payment No.") then
                                            "Payment No. int" := PayInt;
                                    end;
                                end;
                            end
                            else begin

                                if ("Payment No. Card" = '') and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin

                                    if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                                        //ĐK

                                        NoSeriesMgt.InitSeries(BankAccount."No. series for Payment Card", '', 0D, "Payment No. Card", "No. Series");
                                        if Evaluate(PayInt, "Payment No. Card") then
                                            "Payment No. int Card" := PayInt;
                                        "Payment No." := "Payment No. Card";
                                    end;
                                end;

                            end;
                        end;
                    end;

                    if "Payment No." <> '' then begin
                        Evaluate("Payment No. order", "Payment No.");

                        if ("Posting Date Card" = 0D) or ("Posting Date Cash" = 0D) then begin
                            Us.reset;
                            us.setfilter("User ID", '%1', userid);
                            if us.findfirst then begin
                                if "Payment Method" = "Payment Method"::Cash then
                                    validate("Posting Date", us."Posting Date Cash");

                                if "Payment Method" = "Payment Method"::Card then
                                    validate("Posting Date", us."Posting Date Card");

                            end;
                        end;
                        us.reset;

                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            if "Payment Method" = "Payment Method"::Card then
                                Rec."Posting Date Card" := us."Posting Date Card";

                            if "Payment Method" = "Payment Method"::Cash then
                                Rec."Posting Date Cash" := us."Posting Date Cash";

                        end;
                    end;


                end;
                if ("Account Type" = "Account Type"::"Fixed Asset") and ("Account No." <> '') then begin

                    "VAT Prod. Posting Group" := '';
                    FD.Reset();
                    FD.SetFilter("FA No.", '%1', "Account No.");
                    if FD.FindFirst() then begin
                        "FA Posting Group" := FD."FA Posting Group";
                    end
                    else begin
                        "FA Posting Group" := '';
                    end;

                end;

                if "Applies-to Doc. No." = '' then begin
                    CUsTF.Reset();
                    CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                    if CUsTF.FindFirst() then begin
                        if CUsTF."Customer Category" = CUsTF."Customer Category"::Household then
                            "Payment Type" := '03';

                        if CUsTF."Customer Category" = CUsTF."Customer Category"::"Small Economy" then
                            "Payment Type" := '02';
                        if (CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"Special Customer")
                        or (CUsTF."Customer Category" = CUsTF."Customer Category"::"KJKP Heating plant") then
                            "Payment Type" := '01';
                        "Bill Type" := "Payment Type";
                    end;
                end;

            end;
        }
        modify("FA Posting Type") //R
        {
            trigger OnAfterValidate()
            begin
                if "FA Posting Type" = "FA Posting Type"::"Acquisition Cost" then begin
                    "Gen. Prod. Posting Group" := '';
                    "VAT Prod. Posting Group" := '';
                end;
                if "FA Posting Type" = "FA Posting Type"::Disposal then begin
                    "Gen. Prod. Posting Group" := '';
                    "VAT Prod. Posting Group" := '';
                end;
            end;
        }
        modify("Bal. Account No.") //R
        {
            trigger OnAfterValidate()
            begin
                if "Bal. Account No." <> '' then begin
                    "Bal. Gen. Prod. Posting Group" := '';
                    "VAT Prod. Posting Group" := '';


                    "Bal. VAT Prod. Posting Group" := '';
                end;
            end;
        }

        modify("Account Type")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                UserS: Record "User Setup";
            begin
                UserS.Reset();
                UserS.SetFilter("User ID", '%1', UserId);
                if UserS.FindFirst() then begin
                    UserS.Description := Rec.Description;
                    UserS.Modify();
                end;

            end;

            trigger OnAfterValidate()
            var
                myInt: Integer;
                UserS: Record "User Setup";
            begin

                UserS.Reset();
                UserS.SetFilter("User ID", '%1', UserId);
                if UserS.FindFirst() then begin
                    validate(Description, UserS.Description);

                end;

                UserS.Reset();
                UserS.SetFilter("User ID", '%1', UserId);
                if UserS.FindFirst() then begin
                    UserS.Description := '';
                    UserS.Modify();
                end;


            end;

        }

    }

    trigger OnInsert()
    var
        myInt: Integer;
        BankAccount: Record "Bank Account";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        GJLine: Record "Gen. Journal Line";
        PayInt: Integer;
        CUsTF: record "Customer";
    begin

        if ("Source Code" = 'NALGOTUPL') and (rec."Applies-to Doc. No." = '') then begin

            if "Account No. Change" <> '' then begin

            end
            else begin
                CUsTF.Reset();
                CUsTF.SetFilter("No.", '%1', rec."Account No. Change");
                if CUsTF.FindFirst() then begin
                    if CUsTF."Customer Category" = CUsTF."Customer Category"::Household then
                        "Payment Type" := '03';

                    if CUsTF."Customer Category" = CUsTF."Customer Category"::"Small Economy" then
                        "Payment Type" := '02';
                    if (CUsTF."Customer Category" = CUsTF."Customer Category"::"Large Economy")
                       or (CUsTF."Customer Category" = CUsTF."Customer Category"::"Special Customer")
                       or (CUsTF."Customer Category" = CUsTF."Customer Category"::"KJKP Heating plant") then
                        "Payment Type" := '01';
                    "Bill Type" := "Payment Type";
                end;
            end;
        end;




        /*    if GJLine.FindLast() then
                Rec."No. Line" := GJLine."No. Line" + 1
            else
                Rec."No. Line" := 1;*/


        /*  if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
               //ĐK

               NoSeriesMgt.InitSeries(BankAccount."No. series for Payment", '', 0D, "Payment No.", "No. Series");
               if Evaluate(PayInt, "Payment No.") then
                   "Payment No. int" := PayInt;
           end;*/
        if "Payment Method" = "Payment Method"::Cash then begin

            VALIDATE("Payment Method Code", 'GOTOVINA');
        end;
        if "Payment Method" = "Payment Method"::Card then begin
            VALIDATE("Payment Method Code", 'KARTIČNO');
        end;
    end;

    trigger onModify()
    begin
        if "Payment Method" = "Payment Method"::Cash then
            VALIDATE("Payment Method Code", 'GOTOVINA');
        if "Payment Method" = "Payment Method"::Card then
            VALIDATE("Payment Method Code", 'KARTIČNO');
    end;

    trigger OnDelete()
    var
        myInt: Integer;
        BankAccount: Record "Bank Account";
        GL: Record "Gen. Journal Line";
        NoSeriesLine: Record "No. Series Line";

    begin


        if (("Payment No. int" <> 0) or ("Payment No. int Card" <> 0)) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin

            if (BankAccount.get(Rec."Bal. Account No.")) and (StrPos(Rec."Bal. Account No.", 'CZK') <> 0) then begin
                //ĐK
                if rec."Payment Method" = rec."Payment Method"::Card then begin

                    GL.Reset();
                    GL.CopyFilters(Rec);
                    gl.SetFilter("Payment No. int Card", '<>%1&<>%2', 0, rec."Payment No. int Card");
                    gl.SetCurrentKey("Payment No. int Card");
                    gl.Ascending;
                    if gl.FindLast() then begin
                        NoSeriesLine.Reset();
                        NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment Card");
                        NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                        NoSeriesLine.SetCurrentKey("Starting Date");
                        NoSeriesLine.Ascending;
                        if NoSeriesLine.findlast then begin
                            NoSeriesLine."Last No. Used" := format(gl."Payment No. int Card");
                            NoSeriesLine.modify;
                        end;
                    end
                    else begin

                        NoSeriesLine.Reset();
                        NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment Card");
                        NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                        NoSeriesLine.SetCurrentKey("Starting Date");
                        NoSeriesLine.Ascending;
                        if NoSeriesLine.findlast then begin
                            NoSeriesLine."Last No. Used" := format(1);
                            NoSeriesLine.modify;

                        end;
                        //azuriram brojčanu seriju
                        //NoSeriesMgt.InitSeries(BankAccount."No. series for Payment", '', 0D, "Payment No.", "No. Series");

                    end;
                end;

                if rec."Payment Method" = rec."Payment Method"::Cash then begin


                    //ovdje ubaciti drugu verziju

                    GL.Reset();
                    GL.CopyFilters(Rec);
                    gl.SetFilter("Payment No. int", '<>%1&<>%2', 0, rec."Payment No. int");
                    gl.SetCurrentKey("Payment No. int");
                    gl.Ascending;
                    if gl.FindLast() then begin
                        NoSeriesLine.Reset();
                        NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment");
                        NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                        NoSeriesLine.SetCurrentKey("Starting Date");
                        NoSeriesLine.Ascending;
                        if NoSeriesLine.findlast then begin
                            NoSeriesLine."Last No. Used" := format(gl."Payment No. int");
                            NoSeriesLine.modify;
                        end;
                    end
                    else begin

                        NoSeriesLine.Reset();
                        NoSeriesLine.SetFilter("Series Code", '%1', BankAccount."No. series for Payment");
                        NoSeriesLine.setfilter("Starting Date", '<=%1', rec."Posting Date");
                        NoSeriesLine.SetCurrentKey("Starting Date");
                        NoSeriesLine.Ascending;
                        if NoSeriesLine.findlast then begin
                            NoSeriesLine."Last No. Used" := format(1);
                            NoSeriesLine.modify;

                        end;

                        //kraj

                    end;
                end;
            end;
        end;
    end;



    local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    local procedure CheckGLAcc(GLAcc: Record "G/L Account")
    begin
        GLAcc.CheckGLAcc;
        if GLAcc."Direct Posting" or ("Journal Template Name" = '') or "System-Created Entry" then
            exit;
        if "Posting Date" <> 0D then
            if "Posting Date" = ClosingDate("Posting Date") then
                exit;

        CheckDirectPosting(GLAcc);
    end;

    local procedure CheckDirectPosting(var GLAccount: Record "G/L Account")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        GLAccount.TestField("Direct Posting", true);


    end;

    local procedure UpdateDescription(Name: Text[100])
    begin
        if not IsAdHocDescription then
            Description := Name;
    end;


    local procedure IsAdHocDescription(): Boolean
    var
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        BankAccount: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        Employee: Record Employee;
    begin
        if Description = '' then
            exit(false);
        if xRec."Account No." = '' then
            exit(true);

        case xRec."Account Type" of
            xRec."Account Type"::"G/L Account":
                exit(GLAccount.Get(xRec."Account No.") and (GLAccount.Name <> Description));
            xRec."Account Type"::Customer:
                exit(Customer.Get(xRec."Account No.") and (Customer.Name <> Description));
            xRec."Account Type"::Vendor:
                exit(Vendor.Get(xRec."Account No.") and (Vendor.Name <> Description));
            xRec."Account Type"::"Bank Account":
                exit(BankAccount.Get(xRec."Account No.") and (BankAccount.Name <> Description));
            xRec."Account Type"::"Fixed Asset":
                exit(FixedAsset.Get(xRec."Account No.") and (FixedAsset.Description <> Description));
            xRec."Account Type"::"IC Partner":
                exit(ICPartner.Get(xRec."Account No.") and (ICPartner.Name <> Description));
            xRec."Account Type"::Employee:
                exit(Employee.Get(xRec."Account No.") and (Employee.FullName <> Description));
        end;
        exit(false);
    end;


    local procedure ReplaceDescription(): Boolean
    begin
        if "Bal. Account No." = '' then
            exit(true);
        GenJnlBatch.Get("Journal Template Name", "Journal Batch Name");
        exit(GenJnlBatch."Bal. Account No." <> '');
    end;

    local procedure GetGLAccount()
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get("Account No.");
        CheckGLAcc(GLAcc);
        if ReplaceDescription and (not GLAcc."Omit Default Descr. in Jnl.") then
            UpdateDescription(GLAcc.Name)
        else
            if GLAcc."Omit Default Descr. in Jnl." then
                Description := '';
        if ("Bal. Account No." = '') or
           ("Bal. Account Type" in
            ["Bal. Account Type"::"G/L Account", "Bal. Account Type"::"Bank Account"])
        then begin
            "Posting Group" := '';
            "Salespers./Purch. Code" := '';
            "Payment Terms Code" := '';
        end;
        if "Bal. Account No." = '' then
            "Currency Code" := '';
        if CopyVATSetupToJnlLines then begin
            "Gen. Posting Type" := GLAcc."Gen. Posting Type";
            "Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
            "Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
            "VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
            "VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
        end;
        "Tax Area Code" := GLAcc."Tax Area Code";
        "Tax Liable" := GLAcc."Tax Liable";
        "Tax Group Code" := GLAcc."Tax Group Code";
        if "Posting Date" <> 0D then
            if "Posting Date" = ClosingDate("Posting Date") then
                ClearPostingGroups;
        Validate("Deferral Code", GLAcc."Default Deferral Template Code");


    end;


    local procedure CopyVATSetupToJnlLines(): Boolean
    begin
        if ("Journal Template Name" <> '') and ("Journal Batch Name" <> '') then
            if GenJnlBatch.Get("Journal Template Name", "Journal Batch Name") then
                exit(GenJnlBatch."Copy VAT Setup to Jnl. Lines");
        exit("Copy VAT Setup to Jnl. Lines");
    end;

    local procedure GetGLBalAccount()
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get("Bal. Account No.");
        CheckGLAcc(GLAcc);
        if "Account No." = '' then begin
            Description := GLAcc.Name;
            "Currency Code" := '';
        end;
        if ("Account No." = '') or
           ("Account Type" in
            ["Account Type"::"G/L Account", "Account Type"::"Bank Account"])
        then begin
            "Posting Group" := '';
            "Salespers./Purch. Code" := '';
            "Payment Terms Code" := '';
        end;
        if CopyVATSetupToJnlLines then begin
            "Bal. Gen. Posting Type" := GLAcc."Gen. Posting Type";
            "Bal. Gen. Bus. Posting Group" := GLAcc."Gen. Bus. Posting Group";
            "Bal. Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
            "Bal. VAT Bus. Posting Group" := GLAcc."VAT Bus. Posting Group";
            "Bal. VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
        end;
        "Bal. Tax Area Code" := GLAcc."Tax Area Code";
        "Bal. Tax Liable" := GLAcc."Tax Liable";
        "Bal. Tax Group Code" := GLAcc."Tax Group Code";
        if "Posting Date" <> 0D then
            if "Posting Date" = ClosingDate("Posting Date") then
                ClearBalancePostingGroups;


    end;

    local procedure CheckICPartner(ICPartnerCode: Code[20]; AccountType: Enum "Gen. Journal Account Type"; AccountNo: Code[20])
    var
        ICPartner: Record "IC Partner";
    begin
        if ICPartnerCode <> '' then begin
            if GenJnlTemplate.Get("Journal Template Name") then;
            if (ICPartnerCode <> '') and ICPartner.Get(ICPartnerCode) then begin
                ICPartner.CheckICPartnerIndirect(Format(AccountType), AccountNo);
                "IC Partner Code" := ICPartnerCode;
            end;
        end;
    end;

    local procedure SetSalespersonPurchaserCode(SalesperPurchCodeToCheck: Code[20]; var SalesperPuchCodeToAssign: Code[20])
    begin
        if SalesperPurchCodeToCheck <> '' then
            if SalespersonPurchaser.Get(SalesperPurchCodeToCheck) then
                if SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then
                    SalesperPuchCodeToAssign := ''
                else
                    SalesperPuchCodeToAssign := SalesperPurchCodeToCheck;
    end;

    local procedure GetCustomerAccount()
    var
        Cust: Record Customer;
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        Cust.Get("Account No.");
        Cust.CheckBlockedCustOnJnls(Cust, "Document Type", false);
        CheckICPartner(Cust."IC Partner Code", "Account Type", "Account No.");
        UpdateDescription(Cust.Name);
        "Payment Method Code" := Cust."Payment Method Code";
        Validate("Recipient Bank Account", Cust."Preferred Bank Account Code");
        "Posting Group" := Cust."Customer Posting Group";
        SetSalespersonPurchaserCode(Cust."Salesperson Code", "Salespers./Purch. Code");
        "Payment Terms Code" := Cust."Payment Terms Code";
        Validate("Bill-to/Pay-to No.", "Account No.");
        Validate("Sell-to/Buy-from No.", "Account No.");
        if not SetCurrencyCode("Bal. Account Type", "Bal. Account No.") then
            "Currency Code" := Cust."Currency Code";
        ClearPostingGroups;
        if (Cust."Bill-to Customer No." <> '') and (Cust."Bill-to Customer No." <> "Account No.") and
           not HideValidationDialog
        then
            if not ConfirmManagement.GetResponseOrDefault(
                 StrSubstNo(
                   Text014, Cust.TableCaption, Cust."No.", Cust.FieldCaption("Bill-to Customer No."),
                   Cust."Bill-to Customer No."), true)
            then
                Error('');
        Validate("Payment Terms Code");
        CheckPaymentTolerance;

    end;

    local procedure CheckPaymentTolerance()
    begin
        if Amount <> 0 then
            if ("Bal. Account No." <> xRec."Bal. Account No.") or ("Account No." <> xRec."Account No.") then
                PaymentToleranceMgt.PmtTolGenJnl(Rec);
    end;

    local procedure SetCurrencyCode(AccType2: Enum "Gen. Journal Account Type"; AccNo2: Code[20]): Boolean
    var
        BankAcc: Record "Bank Account";
    begin
        "Currency Code" := '';
        if AccNo2 <> '' then
            if AccType2 = AccType2::"Bank Account" then
                if BankAcc.Get(AccNo2) then
                    "Currency Code" := BankAcc."Currency Code";
        exit("Currency Code" <> '');
    end;

    local procedure GetCustomerBalAccount()
    var
        Cust: Record Customer;
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        Cust.Get("Bal. Account No.");
        Cust.CheckBlockedCustOnJnls(Cust, "Document Type", false);
        CheckICPartner(Cust."IC Partner Code", "Bal. Account Type", "Bal. Account No.");
        if "Account No." = '' then
            Description := Cust.Name;
        "Payment Method Code" := Cust."Payment Method Code";
        Validate("Recipient Bank Account", Cust."Preferred Bank Account Code");
        "Posting Group" := Cust."Customer Posting Group";
        SetSalespersonPurchaserCode(Cust."Salesperson Code", "Salespers./Purch. Code");
        "Payment Terms Code" := Cust."Payment Terms Code";
        Validate("Bill-to/Pay-to No.", "Bal. Account No.");
        Validate("Sell-to/Buy-from No.", "Bal. Account No.");
        if ("Account No." = '') or ("Account Type" = "Account Type"::"G/L Account") then
            "Currency Code" := Cust."Currency Code";
        if ("Account Type" = "Account Type"::"Bank Account") and ("Currency Code" = '') then
            "Currency Code" := Cust."Currency Code";
        ClearBalancePostingGroups;
        if (Cust."Bill-to Customer No." <> '') and (Cust."Bill-to Customer No." <> "Bal. Account No.") and
           not HideValidationDialog
        then
            if not ConfirmManagement.GetResponseOrDefault(
                 StrSubstNo(
                   Text014, Cust.TableCaption, Cust."No.", Cust.FieldCaption("Bill-to Customer No."),
                   Cust."Bill-to Customer No."), true)
            then
                Error('');
        Validate("Payment Terms Code");
        CheckPaymentTolerance;


    end;

    local procedure GetVendorAccount()
    var
        Vend: Record Vendor;
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        Vend.Get("Account No.");
        Vend.CheckBlockedVendOnJnls(Vend, "Document Type", false);
        CheckICPartner(Vend."IC Partner Code", "Account Type", "Account No.");
        UpdateDescription(Vend.Name);
        "Payment Method Code" := Vend."Payment Method Code";
        "Creditor No." := Vend."Creditor No.";

        OnGenJnlLineGetVendorAccount(Vend);

        Validate("Recipient Bank Account", Vend."Preferred Bank Account Code");
        "Posting Group" := Vend."Vendor Posting Group";
        SetSalespersonPurchaserCode(Vend."Purchaser Code", "Salespers./Purch. Code");
        "Payment Terms Code" := Vend."Payment Terms Code";
        Validate("Bill-to/Pay-to No.", "Account No.");
        Validate("Sell-to/Buy-from No.", "Account No.");
        if not SetCurrencyCode("Bal. Account Type", "Bal. Account No.") then
            "Currency Code" := Vend."Currency Code";
        ClearPostingGroups;
        if (Vend."Pay-to Vendor No." <> '') and (Vend."Pay-to Vendor No." <> "Account No.") and
           not HideValidationDialog
        then
            if not ConfirmManagement.GetResponseOrDefault(
                 StrSubstNo(
                   Text014, Vend.TableCaption, Vend."No.", Vend.FieldCaption("Pay-to Vendor No."),
                   Vend."Pay-to Vendor No."), true)
            then
                Error('');
        Validate("Payment Terms Code");
        CheckPaymentTolerance;


    end;

    local procedure UpdateDescriptionWithEmployeeName(Employee: Record Employee)
    begin
        if StrLen(Employee.FullName) <= MaxStrLen(Description) then
            UpdateDescription(CopyStr(Employee.FullName, 1, MaxStrLen(Description)))
        else
            UpdateDescription(Employee.Initials);
    end;

    local procedure GetEmployeeAccount()
    var
        Employee: Record Employee;
    begin
        Employee.Get("Account No.");
        Employee.CheckBlockedEmployeeOnJnls(false);
        UpdateDescriptionWithEmployeeName(Employee);
        "Posting Group" := Employee."Employee Posting Group";
        SetSalespersonPurchaserCode(Employee."Salespers./Purch. Code", "Salespers./Purch. Code");
        "Currency Code" := '';
        ClearPostingGroups;

    end;

    local procedure GetVendorBalAccount()
    var
        Vend: Record Vendor;
        ConfirmManagement: Codeunit "Confirm Management";
    begin
        Vend.Get("Bal. Account No.");
        Vend.CheckBlockedVendOnJnls(Vend, "Document Type", false);
        CheckICPartner(Vend."IC Partner Code", "Bal. Account Type", "Bal. Account No.");
        if "Account No." = '' then
            Description := Vend.Name;
        "Payment Method Code" := Vend."Payment Method Code";
        Validate("Recipient Bank Account", Vend."Preferred Bank Account Code");
        "Posting Group" := Vend."Vendor Posting Group";
        SetSalespersonPurchaserCode(Vend."Purchaser Code", "Salespers./Purch. Code");
        "Payment Terms Code" := Vend."Payment Terms Code";
        Validate("Bill-to/Pay-to No.", "Bal. Account No.");
        Validate("Sell-to/Buy-from No.", "Bal. Account No.");
        if ("Account No." = '') or ("Account Type" = "Account Type"::"G/L Account") then
            "Currency Code" := Vend."Currency Code";
        if ("Account Type" = "Account Type"::"Bank Account") and ("Currency Code" = '') then
            "Currency Code" := Vend."Currency Code";
        ClearBalancePostingGroups;
        if (Vend."Pay-to Vendor No." <> '') and (Vend."Pay-to Vendor No." <> "Bal. Account No.") and
           not HideValidationDialog
        then
            if not ConfirmManagement.GetResponseOrDefault(
                 StrSubstNo(
                   Text014, Vend.TableCaption, Vend."No.", Vend.FieldCaption("Pay-to Vendor No."),
                   Vend."Pay-to Vendor No."), true)
            then
                Error('');
        Validate("Payment Terms Code");
        CheckPaymentTolerance;

    end;

    local procedure GetEmployeeBalAccount()
    var
        Employee: Record Employee;
    begin
        Employee.Get("Bal. Account No.");
        Employee.CheckBlockedEmployeeOnJnls(false);
        if "Account No." = '' then
            UpdateDescriptionWithEmployeeName(Employee);
        "Posting Group" := Employee."Employee Posting Group";
        SetSalespersonPurchaserCode(Employee."Salespers./Purch. Code", "Salespers./Purch. Code");
        "Currency Code" := '';
        ClearBalancePostingGroups;

    end;

    local procedure GetBankAccount()
    var
        BankAcc: Record "Bank Account";
    begin
        BankAcc.Get("Account No.");
        BankAcc.TestField(Blocked, false);
        if ReplaceDescription then
            UpdateDescription(BankAcc.Name);
        if ("Bal. Account No." = '') or
           ("Bal. Account Type" in
            ["Bal. Account Type"::"G/L Account", "Bal. Account Type"::"Bank Account"])
        then begin
            "Posting Group" := '';
            "Salespers./Purch. Code" := '';
            "Payment Terms Code" := '';
        end;
        if BankAcc."Currency Code" = '' then begin
            if "Bal. Account No." = '' then
                "Currency Code" := '';
        end else
            if SetCurrencyCode("Bal. Account Type", "Bal. Account No.") then
                BankAcc.TestField("Currency Code", "Currency Code")
            else
                "Currency Code" := BankAcc."Currency Code";
        ClearPostingGroups;


    end;

    local procedure GetBankBalAccount()
    var
        BankAcc: Record "Bank Account";
    begin
        BankAcc.Get("Bal. Account No.");
        BankAcc.TestField(Blocked, false);
        if "Account No." = '' then
            Description := BankAcc.Name;

        if ("Account No." = '') or
           ("Account Type" in
            ["Account Type"::"G/L Account", "Account Type"::"Bank Account"])
        then begin
            "Posting Group" := '';
            "Salespers./Purch. Code" := '';
            "Payment Terms Code" := '';
        end;
        if BankAcc."Currency Code" = '' then
            if "Account No." = '' then
                "Currency Code" := ''
            else
                ClearCurrencyCode
        else
            if SetCurrencyCode("Bal. Account Type", "Bal. Account No.") then
                BankAcc.TestField("Currency Code", "Currency Code")
            else
                "Currency Code" := BankAcc."Currency Code";
        ClearBalancePostingGroups;

    end;

    local procedure ClearCurrencyCode()
    var
        BankAccount: Record "Bank Account";
    begin
        if (xRec."Bal. Account Type" = xRec."Bal. Account Type"::"Bank Account") and (xRec."Bal. Account No." <> '') then begin
            BankAccount.Get(xRec."Bal. Account No.");
            if BankAccount."Currency Code" = "Currency Code" then
                "Currency Code" := '';
        end;
    end;

    local procedure GetFADeprBook(FANo: Code[20])
    var
        FASetup: Record "FA Setup";
        FADeprBook: Record "FA Depreciation Book";
        DefaultFADeprBook: Record "FA Depreciation Book";
    begin
        if "Depreciation Book Code" = '' then begin
            FASetup.Get();

            DefaultFADeprBook.SetRange("FA No.", FANo);
            DefaultFADeprBook.SetRange("Default FA Depreciation Book", true);

            case true of
                DefaultFADeprBook.FindFirst:
                    "Depreciation Book Code" := DefaultFADeprBook."Depreciation Book Code";
                FADeprBook.Get(FANo, FASetup."Default Depr. Book"):
                    "Depreciation Book Code" := FASetup."Default Depr. Book";
                else
                    "Depreciation Book Code" := '';
            end;
        end;

        if "Depreciation Book Code" <> '' then begin
            FADeprBook.Get(FANo, "Depreciation Book Code");
            "Posting Group" := FADeprBook."FA Posting Group";
        end;
    end;

    procedure GetTemplate()
    begin
        if not TemplateFound then
            GenJnlTemplate.Get("Journal Template Name");
        TemplateFound := true;
    end;

    local procedure UpdateSalesPurchLCY()
    begin
        "Sales/Purch. (LCY)" := 0;
        if (not "System-Created Entry") and ("Document Type" in ["Document Type"::Invoice, "Document Type"::"Credit Memo"]) then begin
            if ("Account Type" in ["Account Type"::Customer, "Account Type"::Vendor]) and
               (("Bal. Account No." <> '') or ("Recurring Method" <> "Recurring Method"::" "))
            then
                "Sales/Purch. (LCY)" := "Amount (LCY)" + "Bal. VAT Amount (LCY)";
            if ("Bal. Account Type" in ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor]) and ("Account No." <> '') then
                "Sales/Purch. (LCY)" := -("Amount (LCY)" - "VAT Amount (LCY)");
        end;
    end;

    local procedure GetFAAccount()
    var
        FA: Record "Fixed Asset";
    begin
        FA.Get("Account No.");
        FA.TestField(Blocked, false);
        FA.TestField(Inactive, false);
        FA.TestField("Budgeted Asset", false);
        UpdateDescription(FA.Description);
        GetFADeprBook("Account No.");
        GetFAVATSetup;
        GetFAAddCurrExchRate;

    end;

    local procedure GetFABalAccount()
    var
        FA: Record "Fixed Asset";
    begin
        FA.Get("Bal. Account No.");
        FA.TestField(Blocked, false);
        FA.TestField(Inactive, false);
        FA.TestField("Budgeted Asset", false);
        if "Account No." = '' then
            Description := FA.Description;
        GetFADeprBook("Bal. Account No.");
        GetFAVATSetup;
        GetFAAddCurrExchRate;

    end;

    local procedure GetICPartnerAccount()
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.Get("Account No.");
        ICPartner.CheckICPartner;
        UpdateDescription(ICPartner.Name);
        if ("Bal. Account No." = '') or ("Bal. Account Type" = "Bal. Account Type"::"G/L Account") then
            "Currency Code" := ICPartner."Currency Code";
        if ("Bal. Account Type" = "Bal. Account Type"::"Bank Account") and ("Currency Code" = '') then
            "Currency Code" := ICPartner."Currency Code";
        ClearPostingGroups;
        "IC Partner Code" := "Account No.";


    end;

    local procedure GetICPartnerBalAccount()
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.Get("Bal. Account No.");
        if "Account No." = '' then
            Description := ICPartner.Name;

        if ("Account No." = '') or ("Account Type" = "Account Type"::"G/L Account") then
            "Currency Code" := ICPartner."Currency Code";
        if ("Account Type" = "Account Type"::"Bank Account") and ("Currency Code" = '') then
            "Currency Code" := ICPartner."Currency Code";
        ClearBalancePostingGroups;
        "IC Partner Code" := "Bal. Account No.";


    end;

    local procedure ClearBalancePostingGroups()
    begin
        "Bal. Gen. Posting Type" := "Bal. Gen. Posting Type"::" ";
        "Bal. Gen. Bus. Posting Group" := '';
        "Bal. Gen. Prod. Posting Group" := '';
        "Bal. VAT Bus. Posting Group" := '';
        "Bal. VAT Prod. Posting Group" := '';

    end;

    local procedure ClearAppliedAutomatically()
    begin
        if CurrFieldNo <> 0 then
            "Applied Automatically" := false;
    end;

    local procedure BlankJobNo(CurrentFieldNo: Integer)
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        Validate("Job No.", '');
    end;

    local procedure CleanLine()
    begin
        UpdateLineBalance;
        UpdateSource;
        CreateDim(
          DimMgt.TypeToTableID1("Account Type".AsInteger()), "Account No.",
          DimMgt.TypeToTableID1("Bal. Account Type".AsInteger()), "Bal. Account No.",
          DATABASE::Job, "Job No.",
          DATABASE::"Salesperson/Purchaser", "Salespers./Purch. Code",
          DATABASE::Campaign, "Campaign No.");
        if not ("Bal. Account Type" in ["Bal. Account Type"::Customer, "Bal. Account Type"::Vendor]) then
            "Recipient Bank Account" := '';
        if xRec."Account No." <> '' then begin
            ClearPostingGroups;
            "Tax Area Code" := '';
            "Tax Liable" := false;
            "Tax Group Code" := '';
            "Bill-to/Pay-to No." := '';
            "Ship-to/Order Address Code" := '';
            "Sell-to/Buy-from No." := '';
            UpdateCountryCodeAndVATRegNo('');
        end;

        case "Account Type" of
            "Account Type"::"G/L Account":
                UpdateAccountID;
            "Account Type"::Customer:
                UpdateCustomerID;
            "Account Type"::"Bank Account":
                UpdateBankAccountID;
        end;
    end;

    local procedure UpdateCountryCodeAndVATRegNo(No: Code[20])
    var
        Cust: Record Customer;
        Vend: Record Vendor;
    begin


        if No = '' then begin
            "Country/Region Code" := '';
            "VAT Registration No." := '';
            exit;
        end;

        ReadGLSetup;
        case true of
            ("Account Type" = "Account Type"::Customer) or ("Bal. Account Type" = "Bal. Account Type"::Customer):
                begin
                    Cust.Get(No);
                    "Country/Region Code" := Cust."Country/Region Code";
                    "VAT Registration No." := Cust."VAT Registration No.";
                end;
            ("Account Type" = "Account Type"::Vendor) or ("Bal. Account Type" = "Bal. Account Type"::Vendor):
                begin
                    Vend.Get(No);
                    "Country/Region Code" := Vend."Country/Region Code";
                    "VAT Registration No." := Vend."VAT Registration No.";
                end;
        end;


    end;

    local procedure ReadGLSetup()
    begin
        if not GLSetupRead then begin
            GLSetup.Get();
            GLSetupRead := true;
        end;
    end;

    local procedure GetDefaultICPartnerGLAccNo(): Code[20]
    var
        GLAcc: Record "G/L Account";
        GLAccNo: Code[20];
    begin
        if "IC Partner Code" <> '' then begin
            if "Account Type" = "Account Type"::"G/L Account" then
                GLAccNo := "Account No."
            else
                GLAccNo := "Bal. Account No.";
            if GLAcc.Get(GLAccNo) then
                exit(GLAcc."Default IC Partner G/L Acc. No")
        end;
    end;


    local procedure ClearPostingGroups()
    begin
        "Gen. Posting Type" := "Gen. Posting Type"::" ";
        "Gen. Bus. Posting Group" := '';
        "Gen. Prod. Posting Group" := '';
        "VAT Bus. Posting Group" := '';
        "VAT Prod. Posting Group" := '';

    end;




    var
        DatumPomocni: Date;
        DebitV: Decimal;
        CustF: record "Customer";
        CreditV: Decimal;
        DebitVL: Decimal;
        CreditVL: Decimal;


        AmountL: Decimal;
        AmountV: Decimal;

        CD: Report "Calculate Depreciation";
        myInt: Integer;
        Customer: Record Customer;
        GJLine: Record "Gen. Journal Line";
        ApoeniTable: Record Apoeni;
        //ĐK TREBA VRATITI    Text001: Label 'Given amount cannot be less than amount.';
        //ĐK TREBA VRATITI    Text001: Label 'Given amount cannot be less than amount.';
        MultipleBills: Integer;
        Counter: Integer;
        TotalGivenAmount: Decimal;
        DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;
        GenJnlTemplate: Record "Gen. Journal Template";

        TemplateFound: Boolean;
        Charr: Char;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Text014: Label 'The %1 %2 has a %3 %4.\\Do you still want to use %1 %2 in this journal line?', Comment = '%1=Caption of Table Customer, %2=Customer No, %3=Caption of field Bill-to Customer No, %4=Value of Bill-to customer no.';

        GenJnlBatch: Record "Gen. Journal Batch";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLSetup: Record "General Ledger Setup";
        CurrentCZK: Code[20];
        UserSetup: Record "User Setup";
        TestInt: Integer;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        US: Record "User Setup";


}