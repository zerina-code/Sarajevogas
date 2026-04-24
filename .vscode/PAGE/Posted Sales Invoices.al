pageextension 50062 PostedSalesInvoices extends "Posted Sales Invoices"
{
    layout


    {

        addafter("No.")
        {

            field("Payment Method Code"; "Payment Method Code")
            {
                ApplicationArea = all;
            }



        }
        // Add changes to page layout here
        addafter("Document Date")
        {
            field("Payment Type Invoice"; "Payment Type Invoice")
            {
                ApplicationArea = all;
            }

            field("VAT Date"; "VAT Date")
            {
                ApplicationArea = all;
            }
            field(KIF_Entry; KIF_Entry)
            {
                ApplicationArea = all;
            }
        }
        modify("External Document No.") { Visible = false; }
        modify("Payment Discount %") { Visible = false; }
        modify("Payment Terms Code") { Visible = false; }
        modify("Shipment Method Code") { Visible = false; }
        modify("Shipping Agent Code") { Visible = false; }
        modify(Closed) { Visible = false; }
        modify(Cancelled) { Visible = false; }
        modify(Corrective) { Visible = false; }






    }

    actions
    {
        // Add changes to page actions here

        addbefore(Correct)
        {
            action(Repost)
            {

                Caption = 'Repost';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()

                var
                    Calc: Record "Calculation Setup";

                    SalesInvoice: Record "Sales Invoice Header";
                    RecRef: RecordRef;
                    GenJnlLine: Record "Gen. Journal Line";
                    GenJnlLine2: Record "Gen. Journal Line";
                    GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                    Text000: Label 'Repost is successfully done!';
                    GeneralL: Record "General Ledger Setup";
                    RecordRefExample: Codeunit "Modiy Permissions";
                    SH2: Record "Sales Invoice Header";

                    LineNo: Integer;
                begin

                    Calc.get;
                    GeneralL.get;
                    if (Calc."Subsidies Date from" <> 0D) then begin

                        if (Calc."Subsidies Date to" <> 0D) // [THEN] 
                        then begin
                            SalesInvoice.Reset();
                            SalesInvoice.SetFilter("Posting Date", '%1..%2', Calc."Subsidies Date from", Calc."Subsidies Date to");
                            SalesInvoice.SetFilter("Subsidies Amount", '<>%1', 0);
                            SalesInvoice.SetFilter(Repost, '%1', false);

                        end
                        else begin

                            SalesInvoice.Reset();
                            SalesInvoice.SetFilter("Posting Date", '>=%1', Calc."Subsidies Date from");
                            SalesInvoice.SetFilter("Subsidies Amount", '<>%1', 0);
                            SalesInvoice.SetFilter(Repost, '%1', false);

                        end;

                        if SalesInvoice.FindSet() then
                            repeat

                                GenJnlLine.SETFILTER("Journal Template Name", GeneralL."Repost Journal Template");
                                GenJnlLine.SETFILTER("Journal Batch Name", GeneralL."Repost Batch Name");
                                IF GenJnlLine.FINDLAST THEN
                                    LineNo := GenJnlLine."Line No." + 10000
                                ELSE
                                    LineNo := 10000;


                                GenJnlLine."Journal Template Name" := GeneralL."Repost Journal Template";
                                GenJnlLine."Journal Batch Name" := GeneralL."Repost Batch Name";
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := SalesInvoice."Posting Date";
                                GenJnlLine."Document Date" := SalesInvoice."Document Date";
                                GenJnlLine.Description := SalesInvoice."Posting Description";
                                GenJnlLine."Document No." := SalesInvoice."No.";
                                GenJnlLine."External Document No." := SalesInvoice."External Document No.";
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                GenJnlLine."Account No." := SalesInvoice."Bill-to Customer No.";
                                GenJnlLine.Prepayment := TRUE;
                                GenJnlLine."Currency Code" := SalesInvoice."Currency Code";

                                SalesInvoice.CalcFields(Quantity);
                                // SalesInvoice.CALCFIELDS("Amount Including VAT");
                                // GenJnlLine.VALIDATE("Debit Amount", SalesInvoice.Quantity * Calc.Subsidies);
                                GenJnlLine.Validate("Debit Amount", SalesInvoice."Subsidies Amount");
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                                GenJnlLine."Gen. Bus. Posting Group" := '';
                                GenJnlLine."Gen. Prod. Posting Group" := '';
                                GenJnlLine."VAT Bus. Posting Group" := '';
                                GenJnlLine."VAT Prod. Posting Group" := '';
                                GenJnlLine."Posting Group" := SalesInvoice."Customer Posting Group";
                                GenJnlLine.INSERT(TRUE);

                                LineNo += 10000;
                                GenJnlLine."Journal Template Name" := GeneralL."Repost Journal Template";
                                GenJnlLine."Journal Batch Name" := GeneralL."Repost Batch Name";
                                GenJnlLine."Line No." := LineNo;
                                GenJnlLine."Posting Date" := SalesInvoice."Posting Date";
                                GenJnlLine."Document Date" := SalesInvoice."Document Date";
                                GenJnlLine.Description := SalesInvoice."Posting Description";
                                GenJnlLine."Document No." := SalesInvoice."No.";
                                GenJnlLine."External Document No." := SalesInvoice."External Document No.";
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                                GenJnlLine.validate("Account No.", Calc."Customer - Subsidies");
                                GenJnlLine.Prepayment := TRUE;
                                GenJnlLine."Currency Code" := SalesInvoice."Currency Code";
                                // SalesInvoice.CALCFIELDS("Amount Including VAT");
                                // GenJnlLine.VALIDATE("Credit Amount", SalesInvoice."Amount Including VAT");
                                SalesInvoice.CalcFields(Quantity);
                                GenJnlLine.VALIDATE("Credit Amount", SalesInvoice."Subsidies Amount");
                                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                                GenJnlLine."Gen. Bus. Posting Group" := '';
                                GenJnlLine."Gen. Prod. Posting Group" := '';
                                GenJnlLine."VAT Bus. Posting Group" := '';
                                GenJnlLine."VAT Prod. Posting Group" := '';
                                // GenJnlLine."Shortcut Dimension 1 Code" := "S;
                                // GenJnlLine."Shortcut Dimension 2 Code" := InvPostingBuffer[1]."Global Dimension 2 Code";
                                GenJnlLine.INSERT(TRUE);
                                GenJnlLine2.SETFILTER("Journal Template Name", GeneralL."Repost Journal Template");
                                GenJnlLine2.SETFILTER("Journal Batch Name", GeneralL."Repost Batch Name");
                                IF GenJnlLine2.FINDFIRST THEN
                                    REPEAT
                                        GenJnlPostLine.RunWithCheck(GenJnlLine2);
                                    UNTIL GenJnlLine2.NEXT = 0;
                                SalesInvoice.Repost := true;

                                RecRef.GetTable(SalesInvoice);
                                RecordRefExample.ModifyRecords(RecRef);


                            //   CODEUNIT.Run(CODEUNIT::"Modiy Permissions", SalesInvoice);

                            //   SalesInvoice.Modify();

                            until SalesInvoice.Next() = 0;

                        MESSAGE(Text000);

                    end;
                end;





            }
        }

        addafter(ActivityLog)
        {





            group(Fiscal)
            {
                Caption = 'Fiscal';
                Image = Print;


                /*   group(Fiscal2)
                   {
                       Caption = 'Fiscal2';
                       Image = Print;*/

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
                        Genl: Record "General Ledger Setup";
                        CZKf: Record "User Setup";
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
                        CZKf: Record "User Setup";
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
            // }
        }


    }


    var
        myInt: Integer;
        Putanja: Text[1000];
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


}
