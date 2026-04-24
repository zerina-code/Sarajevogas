report 50167 "Create Advance JOB"
{
    DefaultLayout = RDLC;
    Caption = 'Create Advance JOB';
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem("Service Invoice Header"; "Service Invoice Header")
        {


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                CustLedgerEntryI: Record "Cust. Ledger Entry";

            begin




                GetFiltersCOde.Reset();
                GetFiltersCOde.SetFilter("Month Of GAS Calculation", '%1', Date2DMY("Service Invoice Header"."Posting Date", 2));
                GetFiltersCOde.SetFilter("Year Of GAS Calculation", '%1', Date2DMY("Service Invoice Header"."Posting Date", 3));
                if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"KJKP Heating plant") or
                ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Special Customer") then
                    GetFiltersCOde.SetFilter("Category Calculation", '%1', "Service Invoice Header"."Customer Category"::"Large Economy")
                else
                    GetFiltersCOde.SetFilter("Category Calculation", '%1', "Service Invoice Header"."Customer Category");
                if GetFiltersCOde.FindFirst() then begin
                    SifraNew := GetFiltersCOde.Code;
                    CurrentDate := GetFiltersCOde."Calculation Date To";
                end;


                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup.Advance := true;
                    UserSetup.Modify();
                    Commit();
                end;


                FirstDate := AbsFill.GetMonthRange(Date2DMY(CurrentDate, 2), Date2DMY(CurrentDate, 3), true);
                LastDate := AbsFill.GetMonthRange(Date2DMY(CurrentDate, 2), Date2DMY(CurrentDate, 3), false);


                FirstDate1 := AbsFill.GetMonthRange(Date2DMY(calcdate('<-1M>', CurrentDate), 2), Date2DMY(calcdate('<-1M>', CurrentDate), 3), true);
                LastDate1 := AbsFill.GetMonthRange(Date2DMY(calcdate('<-1M>', CurrentDate), 2), Date2DMY(calcdate('<-1M>', CurrentDate), 3), false);

                //treba mi pretplata pod uslovom iz stavki obračuna, a onda ćemo

                CJL.Reset();
                CJL.SetFilter("Customer Prepayment", '>=%1', 0.01);
                cjl.SetFilter(Code, '%1', SifraNew);
                FiltersCust := GetFilter("Service Invoice Header"."Bill-to Customer No.");
                cjl.SetFilter("Document No. Posting", '<>%1', '');
                if cjl.FindSet() then
                    repeat

                        LogsAvansiObrada.Reset();
                        LogsAvansiObrada.SetFilter(Code, '%1', cjl."Customer No.");
                        LogsAvansiObrada.SetFilter(Purpose, '%1', 'Avansi');
                        LogsAvansiObrada.SetFilter(Billing_Code, '%1', cjl.Code);
                        if not LogsAvansiObrada.findfirst then begin
                            LogsAvansiObrada.init;
                            LogsAvansiObrada."Code" := cjl."Customer No.";
                            LogsAvansiObrada.Description := cjl."Customer Name" + '|' + cjl."Customer No.";
                            LogsAvansiObrada.Purpose := 'Avansi';
                            LogsAvansiObrada.Billing_Code := cjl.Code;
                            LogsAvansiObrada.CreditMemo := false;
                            LogsAvansiObrada.NewAdvance := false;
                            CJLSum.total := 0;
                            CJLSum."War Calculation (LVT)" := 0;
                            PostinD := cjl."Calculation Date To";
                            CJLSum.Reset();
                            CJLSum.SetFilter(Code, '%1', cjl.Code);
                            cjlSum.SetFilter("Document No. Posting", '<>%1', '');

                            CJLSum.SetFilter("Customer No.", '%1', cjl."Customer No.");
                            if CJLSum.FindFirst() then begin
                                CJLSum.CalcSums(Total, "War Calculation (LVT)");
                            end;

                            CustomerPrepayment.Reset();
                            CustomerPrepayment.setfilter("No.", '%1', cjl."Customer No.");

                            if CustomerPrepayment.FindSet() then begin
                                CurrentDateCredit := cjl."Calculation Date To";
                                FirstDate := AbsFill.GetMonthRange(Date2DMY(CurrentDateCredit, 2), Date2DMY(CurrentDateCredit, 3), true);
                                LastDate := AbsFill.GetMonthRange(Date2DMY(CurrentDateCredit, 2), Date2DMY(CurrentDateCredit, 3), false);

                                PostedSalesAdvance.Reset();
                                PostedSalesAdvance.SetFilter("Sell-to Customer No.", '%1', CustomerPrepayment."No.");
                                PostedSalesAdvance.SetFilter("Billing Created", '%1', true);
                                PostedSalesAdvance.SetFilter("Billing Credit Memo", '%1', false);
                                PostedSalesAdvance.SetFilter("Posting Date", '%1..%2', FirstDate1, LastDate1);
                                if PostedSalesAdvance.FindFirst() then begin

                                    PostinD := cjl."Calculation Date To";
                                    SalesSetup.Get();

                                    CustLedgerEntryI.Reset();
                                    CustLedgerEntryI.SetFilter("Document Type", '%1', SalesHeaderAdvance."Document Type"::"Credit Memo");
                                    CustLedgerEntryI.SetFilter("Customer No.", '%1', cjl."Customer No.");
                                    CustLedgerEntryI.SetFilter("Posting Date", '%1', PostinD);
                                    CustLedgerEntryI.SetFilter(Prepayment, '%1', true);
                                    if not CustLedgerEntryI.FindFirst() then begin
                                        SalesHeaderAdvance.init;
                                        SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";
                                        CustTemp.Reset();
                                        if CustomerPrepayment."Customer Category" = CustomerPrepayment."Customer Category"::" " then
                                            CustomerPrepayment."Customer Category" := "Service Invoice Header"."Customer Category";
                                        CustTemp.SetFilter("Bill Category", '%1', CustomerPrepayment."Customer Category");
                                        if CustTemp.FindFirst() then
                                            SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);
                                        if SalesHeaderAdvance."Bill type" = '' then
                                            SalesHeaderAdvance.Validate("Bill type", "Service Invoice Header"."Bill type");
                                        SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(CustTemp."Corr. Advance No. Series Bill", PostinD, true);
                                        SalesHeaderAdvance.Prepayment := TRUE;

                                        SalesHeaderAdvance.validate(Correction, true);


                                        SalesHeaderAdvance.validate("Sell-to Customer No.", CustomerPrepayment."No.");
                                        SalesHeaderAdvance.validate("Order Date", PostinD);
                                        SalesHeaderAdvance.validate("Posting Date", PostinD);
                                        SalesHeaderAdvance.validate("Shipment Date", PostinD);
                                        SalesHeaderAdvance.validate("VAT Date", PostinD);
                                        SalesHeaderAdvance.validate("Bill Category", CustomerPrepayment."Customer Category");
                                        SalesHeaderAdvance.validate("Billing Credit Memo", true);
                                        OpenAdvance.Reset();
                                        OpenAdvance.SetFilter("Document Type", '%1', SalesHeaderAdvance."Document Type"::Invoice);
                                        OpenAdvance.SetFilter("Document No.", '%1', PostedSalesAdvance."No.");
                                        OpenAdvance.SetFilter(Open, '%1', true);
                                        if OpenAdvance.FindFirst() then begin

                                            SalesHeaderAdvance.Validate("Applies-to Doc. Type", SalesHeaderAdvance."Document Type"::Invoice);
                                            SalesHeaderAdvance.Validate("Applies-to Doc. No.", PostedSalesAdvance."No.");
                                        end;
                                        SalesHeaderAdvance."Posting Description" := 'Storno avansne fakture ' + SalesHeaderAdvance."No.";
                                        //poredati po kategorijama
                                        CustTemp.Reset();
                                        if CustomerPrepayment."Customer Category" = CustomerPrepayment."Customer Category"::" " then
                                            CustomerPrepayment."Customer Category" := "Service Invoice Header"."Customer Category";
                                        CustTemp.SetFilter("Bill Category", '%1', CustomerPrepayment."Customer Category");
                                        if CustTemp.FindFirst() then
                                            SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);

                                        SalesHeaderAdvance.validate("No. Series", CustTemp."Corr. Advance No. Series Bill");
                                        SalesHeaderAdvance.validate("Posting No. Series", CustTemp."Corr. Post. Advance No. Series Bill");

                                        SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";
                                        SalesHeaderAdvance."Posting No. Series" := CustTemp."Corr. Post. Advance No. Series Bill";
                                        SalesHeaderAdvance."No. Series" := CustTemp."Corr. Advance No. Series Bill";
                                        if LogsAvansiObrada.CreditMemo = False then begin




                                            SalesHeaderAdvance.Insert(false);
                                            Commit();
                                        end;
                                        //sad i linije dodati

                                        PostedSalesInvoiceLIne.reset;
                                        PostedSalesInvoiceLIne.SetFilter("Document No.", '%1', PostedSalesAdvance."No.");
                                        PostedSalesInvoiceLIne.SetFilter("Sell-to Customer No.", '%1', PostedSalesAdvance."Sell-to Customer No.");

                                        if PostedSalesInvoiceLIne.FindSet() then
                                            repeat

                                                SalesLine.init;
                                                SalesLine."Document No." := SalesHeaderAdvance."No.";

                                                SalesLine."Line No." := 1000;
                                                SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                                SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                                SalesLine.Validate("No.", PostedSalesInvoiceLIne."No.");
                                                SalesLine.validate(Quantity, PostedSalesInvoiceLIne.Quantity);
                                                //."Balance (LCY)"

                                                SalesLine.validate("Unit Price", PostedSalesInvoiceLIne."Unit Price");
                                                //  SalesLine.validate("Avans Amount", PostedSalesInvoiceLIne."Avans Amount");
                                                SalesLine.validate(Amount, PostedSalesInvoiceLIne.Amount);
                                                SalesLine.validate("Amount Including VAT", PostedSalesInvoiceLIne."Amount Including VAT");
                                                SalesLine."Document Type" := SalesLine."Document Type"::"Credit Memo";
                                                if LogsAvansiObrada.CreditMemo = False then begin
                                                    SalesLine.Insert(false);
                                                    Commit();
                                                end;

                                            until PostedSalesInvoiceLIne.next = 0;

                                        if LogsAvansiObrada.CreditMemo = False then begin
                                            SalesHeader.Copy(SalesHeaderAdvance);
                                            Code_SHPost(SalesHeader, false);
                                            // PostDocument(CODEUNIT::"Sales-Post (Yes/No)");

                                            //zavrseno - test
                                            CJLBIll.reset;
                                            CJLBIll.SetFilter("Customer No.", '%1', SalesHeaderAdvance."Bill-to Customer No.");
                                            CJLBIll.SetFilter("Document No.", '%1', PostedSalesAdvance."No.");
                                            CJLBIll.SetFilter("Billing Credit Memo", '%1', false);
                                            if CJLBIll.FindFirst() then begin

                                                CustF_2.get(CJLBIll."Entry No.");
                                                CustF_2."Billing Credit Memo" := true;
                                                RecRef.GetTable(CustF_2);
                                                RecordRefExample.ModifyRecords(RecRef);
                                                Commit();
                                            end;
                                            LogsAvansiObrada.CreditMemo := true;

                                        end;
                                    end;

                                end;
                                //ovo su nove avansne fakture

                                if abs(cjl."Customer Prepayment") - (round(CJLSum.Total + CJLSum."War Calculation (LVT)", 0.01, '=')) > 0 then begin

                                    PostinD := today;
                                    SalesSetup.Get();

                                    CustLedgerEntryI.Reset();
                                    CustLedgerEntryI.SetFilter("Document Type", '%1', SalesHeaderAdvance."Document Type"::Invoice);
                                    CustLedgerEntryI.SetFilter("Customer No.", '%1', cjl."Customer No.");
                                    CustLedgerEntryI.SetFilter("Posting Date", '%1', CJL."Calculation Date To");
                                    CustLedgerEntryI.SetFilter(Prepayment, '%1', true);
                                    if not CustLedgerEntryI.FindFirst() then begin

                                        SalesHeaderAdvance.init;
                                        SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::Invoice;
                                        CustTemp.reset;
                                        CustTemp.SetFilter("Bill Category", '%1', cjl."Category Customer");
                                        if (cjl."Category Customer" = cjl."Category Customer"::"KJKP Heating plant") or (cjl."Category Customer" = cjl."Category Customer"::"Special Customer") then
                                            CustTemp.SetFilter("Bill Category", '%1', CustTemp."Bill Category"::"Large Economy");
                                        if CustTemp.FindFirst() then begin
                                            SalesHeaderAdvance.Validate("No. Series", CustTemp."Advance No. Series Bill");
                                            SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(CustTemp."Advance No. Series Bill", PostinD, true);
                                            SalesHeaderAdvance.Validate("Posting No. Series", CustTemp."Post. Advance No. Series Bill");

                                        end
                                        else begin
                                            SalesHeaderAdvance."No. Series" := SalesSetup."Prepayment Invoice Nos.";
                                            SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                                            SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
                                        end;
                                        SalesHeaderAdvance.Prepayment := TRUE;
                                        //ovdje bi trebala na osnovu bill type  Đem


                                        SalesHeaderAdvance.validate("Sell-to Customer No.", cjl."Customer No.");


                                        SalesHeaderAdvance.validate("Order Date", CJL."Calculation Date To");
                                        SalesHeaderAdvance.validate("Posting Date", CJL."Calculation Date To");
                                        SalesHeaderAdvance.validate("Shipment Date", CJL."Calculation Date To");
                                        SalesHeaderAdvance.validate("VAT Date", CJL."Calculation Date To");
                                        SalesHeaderAdvance.validate("Bill Category", cjl."Category Customer");
                                        SalesHeaderAdvance.validate("Billing Created", true);
                                        //poredati po kategorijama
                                        //poredati po kategorijama
                                        CustTemp.SetFilter("Bill Category", '%1', cjl."Category Customer");
                                        if CustTemp.FindFirst() then
                                            SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);

                                        if SalesHeaderAdvance."Bill type" = '' then
                                            SalesHeaderAdvance.Validate("Bill type", "Service Invoice Header"."Bill type");
                                        SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::Invoice;
                                        SalesHeaderAdvance."Posting Description" := 'Avansna Faktura ' + SalesHeaderAdvance."No.";
                                        SalesHeaderAdvance."Posting No. Series" := CustTemp."Post. Advance No. Series Bill";
                                        SalesHeaderAdvance."No. Series" := CustTemp."Advance No. Series Bill";
                                        if LogsAvansiObrada.NewAdvance = False then begin
                                            SalesHeaderAdvance.Insert(false);

                                            commit;
                                        end;

                                        //sada dodajem linije

                                        SalesLine."Document No." := SalesHeaderAdvance."No.";
                                        SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                        SalesLine."Line No." := 1000;
                                        SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                        SalesLine.Validate("No.", CustTemp."Advance GK");
                                        //trebam dobiti 79,95 (finalni rezultat)


                                        SalesLine.validate("Unit Price", round((abs(abs(cjl."Customer Prepayment") - (round((CJLSum.Total + CJLSum."War Calculation (LVT)"), 0.01, '='))) / ((1 + SalesLine."VAT %" / 100))), 0.01, '='));
                                        //abs(CustLedgerEntry."Remaining Amount") / (1 + SalesLine."VAT %" / 100)
                                        SalesLine.Validate("Avans Amount", abs(cjl."Customer Prepayment") - round((CJLSum.Total + CJLSum."War Calculation (LVT)"), 0.01, '='));
                                        SalesLine.validate(Quantity, 1);
                                        SalesLine.Validate("Avans Amount", abs(cjl."Customer Prepayment") - round((CJLSum.Total + CJLSum."War Calculation (LVT)"), 0.01, '='));

                                        if SalesLine."Amount Including VAT" >= 0.01 then begin
                                            if LogsAvansiObrada.NewAdvance = False then begin
                                                SalesLine.Insert(false);
                                                Commit();

                                                SalesHeader.Copy(SalesHeaderAdvance);
                                                Code_SHPost(SalesHeader, false);
                                                cjl."Billing Created Memo" := true;
                                                //   cjl.Modify();

                                                LogsAvansiObrada.NewAdvance := true;
                                            end;
                                        end;



                                    end;
                                end;

                            end;
                            LogsAvansiObrada.insert;
                            Commit;
                        end;

                    until CJL.Next() = 0;

                //ovdje sam rekla kraj, one koji nemaju u obračunu
                CustF.Reset();
                CustF.setfilteR("Posting Date", '%1', LastDate1);
                CustF.setfilter("Date Filter", '<=%1', LastDate1);
                CustF.SetFilter("Remaining Amt. (LCY)", '<>%1', 0);
                CustF.setfilter("Billing Credit Memo", '%1', false);
                CustF.SetFilter("Customer Posting Group", '%1|%2|%3|%4|%5|%6', 'AVANS', 'AVANS.MP', 'AVANS.DOM', 'GAS-MP', 'GAS-DOM', 'GAS-PL');
                FiltersCust := GetFilter("Service Invoice Header"."Bill-to Customer No.");
                if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"KJKP Heating plant") or ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Special Customer") then
                    CustF.SetFilter("Customer Category", '%1|%2', "Service Invoice Header"."Customer Category"::"Large Economy", "Service Invoice Header"."Customer Category"::" ")
                else
                    CustF.SetFilter("Customer Category", '%1|%2', "Service Invoice Header"."Customer Category", "Service Invoice Header"."Customer Category"::" ");

                if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Large Economy") or
                ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"KJKP Heating plant") or ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Special Customer") then
                    CustF.SetFilter("Bill type", '%1|%2', '01', '1');

                if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::Household)
                                           then
                    CustF.SetFilter("Bill type", '%1|%2', '03', '3');

                if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Small Economy")
                                           then
                    CustF.SetFilter("Bill type", '%1|%2', '02', '2');

                if CustF.FindSet() then
                    repeat


                        LogsAvansiObrada.Reset();
                        LogsAvansiObrada.SetFilter(Code, '%1', CustF."Customer No.");
                        LogsAvansiObrada.SetFilter(Billing_Code, '%1', SifraNew);
                        LogsAvansiObrada.SetFilter(Purpose, '%1', 'Avansi');
                        if not LogsAvansiObrada.findfirst then begin
                            LogsAvansiObrada.init;
                            LogsAvansiObrada."Code" := CustF."Customer No.";
                            LogsAvansiObrada.Description := CustF."Document No." + '|' + format(CustF."Entry No.");
                            LogsAvansiObrada.Billing_Code := SifraNew;
                            LogsAvansiObrada.Purpose := 'Avansi';
                            LogsAvansiObrada.insert;
                            Commit;
                            //storno iste fakture
                            PostedSalesAdvance.Reset();
                            PostedSalesAdvance.SetFilter("Sell-to Customer No.", '%1', CustF."Customer No.");
                            PostedSalesAdvance.SetFilter("Billing Created", '%1', true);
                            PostedSalesAdvance.SetFilter("Billing Credit Memo", '%1', false);
                            //ĐK naknadno provjeriti datum 
                            PostedSalesAdvance.SetFilter("Posting Date", '%1..%2', FirstDate1, LastDate1);
                            if PostedSalesAdvance.FindFirst() then begin

                                PostinD := CurrentDate;
                                SalesSetup.Get();
                                SalesHeaderAdvance.init;
                                SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";


                                CustLedgerEntryI.Reset();
                                CustLedgerEntryI.SetFilter("Document Type", '%1', SalesHeaderAdvance."Document Type"::"Credit Memo");
                                CustLedgerEntryI.SetFilter("Customer No.", '%1', CustF."Customer No.");
                                CustLedgerEntryI.SetFilter("Posting Date", '%1', PostinD);
                                CustLedgerEntryI.SetFilter(Prepayment, '%1', true);
                                if not CustLedgerEntryI.FindFirst() then begin

                                    CustCateg.Reset();
                                    CustCateg.SetFilter("No.", '%1', CustF."Customer No.");
                                    if CustCateg.FindFirst() then
                                        CustTemp.Reset();
                                    CustTemp.SetFilter("Bill Category", '%1', CustCateg."Customer Category");
                                    if CustTemp.FindFirst() then
                                        SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);

                                    if SalesHeaderAdvance."Bill type" = '' then
                                        SalesHeaderAdvance.Validate("Bill type", "Service Invoice Header"."Bill type");
                                    SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(CustTemp."Corr. Advance No. Series Bill", PostinD, true);
                                    SalesHeaderAdvance.Prepayment := TRUE;




                                    SalesHeaderAdvance.validate("Sell-to Customer No.", CustF."Customer No.");
                                    SalesHeaderAdvance.validate("Order Date", PostinD);
                                    SalesHeaderAdvance.validate("Posting Date", PostinD);
                                    SalesHeaderAdvance.validate("Shipment Date", PostinD);
                                    SalesHeaderAdvance.validate("VAT Date", PostinD);
                                    SalesHeaderAdvance.validate("COrrection", true);
                                    SalesHeaderAdvance.validate("Bill Category", CustomerPrepayment."Customer Category");
                                    SalesHeaderAdvance.validate("Billing Credit Memo", true);


                                    OpenAdvance.Reset();
                                    OpenAdvance.SetFilter("Document Type", '%1', SalesHeaderAdvance."Document Type"::Invoice);
                                    OpenAdvance.SetFilter("Document No.", '%1', PostedSalesAdvance."No.");
                                    OpenAdvance.SetFilter(Open, '%1', true);
                                    if OpenAdvance.FindFirst() then begin

                                        SalesHeaderAdvance.Validate("Applies-to Doc. Type", SalesHeaderAdvance."Document Type"::Invoice);
                                        SalesHeaderAdvance.Validate("Applies-to Doc. No.", PostedSalesAdvance."No.");
                                    end;

                                    SalesHeaderAdvance."Posting Description" := 'Storno avansne fakture ' + SalesHeaderAdvance."No.";
                                    //poredati po kategorijama
                                    CustTemp.Reset();
                                    if CustomerPrepayment."Customer Category" = CustomerPrepayment."Customer Category"::" " then
                                        CustomerPrepayment."Customer Category" := "Service Invoice Header"."Customer Category";
                                    CustTemp.SetFilter("Bill Category", '%1', CustomerPrepayment."Customer Category");
                                    if CustTemp.FindFirst() then
                                        SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);

                                    SalesHeaderAdvance.validate("No. Series", CustTemp."Corr. Advance No. Series Bill");
                                    SalesHeaderAdvance.validate("Posting No. Series", CustTemp."Post. Advance No. Series Bill");

                                    SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";
                                    SalesHeaderAdvance.Insert();
                                    Commit();
                                    //sad i linije dodati

                                    PostedSalesInvoiceLIne.reset;
                                    PostedSalesInvoiceLIne.SetFilter("Document No.", '%1', PostedSalesAdvance."No.");
                                    PostedSalesInvoiceLIne.SetFilter("Sell-to Customer No.", '%1', PostedSalesAdvance."Sell-to Customer No.");

                                    if PostedSalesInvoiceLIne.FindSet() then
                                        repeat

                                            SalesLine.init;
                                            SalesLine."Document No." := SalesHeaderAdvance."No.";

                                            SalesLine."Line No." := 1000;
                                            SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                            SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                            SalesLine.Validate("No.", PostedSalesInvoiceLIne."No.");
                                            SalesLine.validate(Quantity, PostedSalesInvoiceLIne.Quantity);
                                            //."Balance (LCY)"

                                            SalesLine.validate("Unit Price", PostedSalesInvoiceLIne."Unit Price");
                                            SalesLine."Document Type" := SalesLine."Document Type"::"Credit Memo";
                                            SalesLine.validate("Unit Price", PostedSalesInvoiceLIne."Unit Price");
                                            // SalesLine.validate("Avans Amount", PostedSalesInvoiceLIne."Avans Amount");
                                            SalesLine.validate(Amount, PostedSalesInvoiceLIne.Amount);
                                            SalesLine.validate("Amount Including VAT", PostedSalesInvoiceLIne."Amount Including VAT");

                                            SalesLine.Insert(false);
                                            Commit();

                                        until PostedSalesInvoiceLIne.next = 0;


                                    //proknjižim avansno odobrenje
                                    //Đ PROBAJ  PostDocumentSales(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance."No.");
                                    SalesHeader.Copy(SalesHeaderAdvance);
                                    Code_SHPost(SalesHeader, false);
                                    // PostDocument(CODEUNIT::"Sales-Post (Yes/No)");

                                    //zavrseno - test
                                    CustF_2.get(CustF."Entry No.");
                                    CustF_2."Billing Credit Memo" := true;
                                    RecRef.GetTable(CustF_2);
                                    RecordRefExample.ModifyRecords(RecRef);
                                end;
                            end;

                            DetailedCust2."Amount (LCY)" := 0;
                            DetailedCust2.reset;
                            DetailedCust2.setfilter("Customer No.", '%1', SalesHeaderAdvance."Sell-to Customer No.");
                            DetailedCust2.setfilter("Prepayment", '%1', true);
                            DetailedCust2.SetFilter("Posting Date", '%1', LastDate1);
                            DetailedCust2.setfilter("Entry Type", '%1', DetailedCust2."Entry Type"::"Initial Entry");
                            if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Large Economy") or
   ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"KJKP Heating plant") or ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Special Customer") then
                                DetailedCust2.SetFilter("Bill type", '%1|%2', '01', '1');

                            if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::Household)
                                                       then
                                DetailedCust2.SetFilter("Bill type", '%1|%2', '03', '3');

                            if ("Service Invoice Header"."Customer Category" = "Service Invoice Header"."Customer Category"::"Small Economy")
                                                       then
                                DetailedCust2.SetFilter("Bill type", '%1|%2', '02', '2');
                            if DetailedCust2.findfirst then begin
                                DetailedCust2.calcsums("Amount (LCY)");
                            end;

                            //ovo su nove avansne fakture
                            if abs(DetailedCust2."Amount (LCY)") > 0 then begin

                                CustLedgerEntryI.Reset();
                                CustLedgerEntryI.SetFilter("Document Type", '%1', SalesHeaderAdvance."Document Type"::"Invoice");

                                CustLedgerEntryI.SetFilter("Customer No.", '%1', CustF."Customer No.");
                                CustLedgerEntryI.SetFilter("Posting Date", '%1', PostinD);
                                CustLedgerEntryI.SetFilter(Prepayment, '%1', true);
                                if not CustLedgerEntryI.FindFirst() then begin

                                    PostinD := today;
                                    SalesSetup.Get();
                                    SalesHeaderAdvance.init;
                                    SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::Invoice;
                                    CustTemp.reset;
                                    CustTemp.SetFilter("Bill Category", '%1', cjl."Category Customer");
                                    if (cjl."Category Customer" = cjl."Category Customer"::"KJKP Heating plant") or (cjl."Category Customer" = cjl."Category Customer"::"Special Customer") then
                                        CustTemp.SetFilter("Bill Category", '%1', CustTemp."Bill Category"::"Large Economy");
                                    if CustTemp.FindFirst() then begin
                                        SalesHeaderAdvance.Validate("No. Series", CustTemp."Advance No. Series Bill");
                                        SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(CustTemp."Advance No. Series Bill", PostinD, true);
                                        SalesHeaderAdvance.Validate("Posting No. Series", CustTemp."Post. Advance No. Series Bill");

                                    end
                                    else begin
                                        SalesHeaderAdvance."No. Series" := SalesSetup."Prepayment Invoice Nos.";
                                        SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                                        SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
                                    end;
                                    //SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                                    SalesHeaderAdvance.Prepayment := TRUE;


                                    SalesHeaderAdvance."Posting Description" := 'Avansna Faktura ' + SalesHeaderAdvance."No.";
                                    SalesHeaderAdvance.validate("Sell-to Customer No.", CustF."Customer No.");
                                    SalesHeaderAdvance.validate("Order Date", CurrentDate);
                                    SalesHeaderAdvance.validate("Posting Date", CurrentDate);
                                    SalesHeaderAdvance.validate("Shipment Date", CurrentDate);
                                    SalesHeaderAdvance.validate("VAT Date", CurrentDate);
                                    SalesHeaderAdvance.validate("Bill Category", CustF."Customer Category");
                                    SalesHeaderAdvance.validate("Billing Created", true);
                                    //poredati po kategorijama
                                    //poredati po kategorijama
                                    CustTemp.SetFilter("Bill Category", '%1', CustF."Customer Category");
                                    if CustTemp.FindFirst() then
                                        SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);

                                    if SalesHeaderAdvance."Bill type" = '' then
                                        SalesHeaderAdvance.Validate("Bill type", "Service Invoice Header"."Bill type");
                                    SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::Invoice;
                                    SalesHeaderAdvance."Posting Description" := 'Avansna Faktura ' + SalesHeaderAdvance."No.";
                                    SalesHeaderAdvance."Posting No. Series" := CustTemp."Post. Advance No. Series Bill";
                                    SalesHeaderAdvance."No. Series" := CustTemp."Advance No. Series Bill";
                                    SalesHeaderAdvance.Insert(false);

                                    commit;

                                    //sada dodajem linije

                                    SalesLine."Document No." := SalesHeaderAdvance."No.";
                                    SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                    SalesLine."Line No." := 1000;
                                    SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                    SalesLine.Validate("No.", CustTemp."Advance GK");
                                    //trebam dobiti 79,95 (finalni rezultat)



                                    //abs(CustLedgerEntry."Remaining Amount") / (1 + SalesLine."VAT %" / 100)
                                    SalesLine.validate(Quantity, 1);
                                    SalesLine.validate("Avans Amount", abs(DetailedCust2."Amount (LCY)"));
                                    //."Balance (LCY)"
                                    //."Balance (LCY)"


                                    SalesLine.Insert();
                                    Commit();

                                    //ĐK    Post_Send(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance);

                                    SalesHeader.Copy(SalesHeaderAdvance);
                                    Code_SHPost(SalesHeader, false);
                                end;

                            end;
                        end;
                    until CustF.next = 0;
                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    UserSetup.Advance := false;
                    UserSetup.Modify();
                end;
            end;






        }
    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin


    end;

    trigger OnPostReport()
    var

    begin







    end;

    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin




    end;

    local procedure Code_SHPost(var SalesHeader: Record "Sales Header"; PostAndSend: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        HideDialog: Boolean;
        IsHandled: Boolean;
        DefaultOption: Integer;
    begin
        HideDialog := false;
        IsHandled := false;
        DefaultOption := 3;


        SalesSetup.Get();
        if SalesSetup."Post with Job Queue" and not PostAndSend then
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        else
            CODEUNIT.Run(CODEUNIT::"Sales-Post", SalesHeader);

    end;



    var
        CustomerPrepayment: Record Customer;
        CustLedger: Record "Cust. Ledger Entry";

        SalesHeaderAdvance: Record "Sales Header";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        PostinD: date;
        Date2: date;

        CustTemp: Record "Customer Templ.";
        SalesLine: Record "Sales Line";
        SalesAdvance: page "Sales Advance Invoice";
        PostedSalesAdvance: record "Sales Invoice Header";
        PostedSalesInvoiceLIne: record "Sales Invoice Line";
        cjlGt: Record "Calculation Journal Line";
        AbsFill: Codeunit "Absence Fill";
        FirstDate: Date;
        FirstDate1: date;
        LastDate: date;
        LastDate1: date;
        CurrentDate: date;
        SalesHeader: Record "Sales Header";
        CustmerPrep: Record Customer;
        CJL: Record "Calculation Journal Line";
        CurrentDateCredit: Date;
        SifraNew: code[20];
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DetailedCust: Record "Detailed Cust. Ledg. Entry";
        RecRef: RecordRef;
        RecordRefExample: Codeunit "Modiy Permissions";
        EntryLast: Integer;
        GetFiltersCOde: Record "Calcuation Header";
        TempCust: Record "Calcuation Header" temporary;
        DetailedCust2: Record "Detailed Cust. Ledg. Entry";
        CustLedgC: Record "Cust. Ledger Entry";
        CustF: Record "Cust. Ledger Entry";
        CustF_2: Record "Cust. Ledger Entry";
        CustCateg: Record Customer;
        FiltersCust: text;
        CJLBIll: Record "Cust. Ledger Entry";
        CJLSum: Record "Calculation Journal Line";
        LogsAvansiObrada: Record "CJL Logs";
        UserSetup: Record "User Setup";
        OpenAdvance: Record "Cust. Ledger Entry";


}

