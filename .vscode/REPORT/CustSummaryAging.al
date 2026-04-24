report 50152 "CustomerSummaryAging"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustAging.rdl';
    AdditionalSearchTerms = 'customer balance simplify,payment due simplify';
    ApplicationArea = Suite;
    Caption = 'Customer - Summary Aging Simp.';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Statistics Group", "Payment Terms Code";
            column(STRSUBSTNO_Text001_FORMAT_StartDate__; StrSubstNo(Text001, Format(StartDate)))
            {
            }
            column(Picture; CompInfo.Picture) { }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName)
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; TableCaption + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(CustBalanceDueLCY_6_; CustBalanceDueLCY[8])
            {
                AutoFormatType = 1;
                //nije dospjelo - datum od danas - 30.12.9999
            }
            column
            (ShowData; ShowData)
            { }
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[7])
            {
                AutoFormatType = 1;
                //30 dana
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
                //30 - 60
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
                //60 - 90
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;

                //90 - 300
            }
            column(CustBalanceDueLCY_1_300; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
                //300- 330D
            }
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_7_; CustBalanceDueLCY[7])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_8_; CustBalanceDueLCY[8])
            {
                AutoFormatType = 1;
            }

            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustBalanceDueLCY_5__Control25; CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control26; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control27; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control28; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control29; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control30; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control37; CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control38; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control39; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control40; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control41; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control42; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(Customer___Summary_Aging_Simp_Caption; Customer___Summary_Aging_Simp_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Customer__No__Caption; FieldCaption("No."))
            {
            }
            column(Customer_NameCaption; FieldCaption(Name))
            {
            }
            column(CustBalanceDueLCY_5__Control25Caption; CustBalanceDueLCY_5__Control25CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_4__Control26Caption; CustBalanceDueLCY_4__Control26CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_3__Control27Caption; CustBalanceDueLCY_3__Control27CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_2__Control28Caption; CustBalanceDueLCY_2__Control28CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control29Caption; CustBalanceDueLCY_1__Control29CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control30Caption; CustBalanceDueLCY_1__Control30CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_1__Control30CaptionLbl_300; CustBalanceDueLCY_1__Control30CaptionLbl_300) { }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            var
                acc: Record "Accusation Header";
                custLedgEntry: Record "Detailed Cust. Ledg. Entry";

                lentry: Record "Cust. Ledger Entry";
                clentry: Record "Cust. Ledger Entry";
                accReminder: Report AccusationReminder;
                nativeReminder: Report Reminder;
                NoSeriesMgt: Codeunit NoSeriesExtented;
                gls: Record "General Ledger Setup";
                LineNo: Integer;
                SS: record "Sales & Receivables Setup";
                CH: Record "Calcuation Header";
                us: Record "User Setup";

            begin

                us.reset;
                us.setfilter("User ID", '%1', userid);
                if us.findfirst then begin
                    CalHeader := us."Calculation V";
                    if CalHeader <> '' then
                        Show := 1
                    else
                        Show := 2;
                    CalHeader := CalHeader;
                    CodeI := 'I';
                    if CalHeader <> '' then begin
                        SveOpomene := true;
                    end
                    else begin
                        SveOpomene := false;
                    end;


                end;



                SS.get;
                CH.Reset();
                CH.SetFilter("Calculation Date To", '<=%1', StartDate);
                ch.SetCurrentKey("Calculation Date To");
                ch.Ascending;
                if ch.FindFirst() then
                    ShowData := true;

                if (Show = 1) or (Show = 2) then begin
                    CalcHe.Reset();
                    CalcHe.SetFilter(Code, '%1', CalHeader);
                    CalcHe.SetFilter("Customer No.", '%1', Customer."No.");
                    if CalcHe.findfirst then begin
                        ShowData := true;
                    end
                    else begin
                        ShowData := false;
                    end;


                end;


                PrintCust := false;

                for i := 1 to 8 do begin
                    DtldCustLedgEntry.SetCurrentKey("Customer No.", "Initial Entry Due Date", "Posting Date");
                    DtldCustLedgEntry.SetRange("Customer No.", "No.");
                    DtldCustLedgEntry.SetRange("Posting Date", 0D, StartDate);
                    if i = 2 then
                        DtldCustLedgEntry.SetFilter("Initial Entry Due Date", '<=%1', PeriodStartDate[i + 1] - 1)
                    else
                        DtldCustLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.CalcSums("Amount (LCY)");
                    CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)";
                    if CustBalanceDueLCY[i] <> 0 then
                        PrintCust := true;
                end;
                custLedgEntry.SetCurrentKey("Customer No.", "Initial Entry Due Date", "Posting Date");
                custLedgEntry.SetRange("Customer No.", "No.");
                custLedgEntry.SetRange("Posting Date", 0D, StartDate);
                custLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[1], PeriodStartDate[3] - 1);
                if custLedgEntry.FindSet() then
                    repeat
                        counterForAccusation += 1;
                    until custLedgEntry.next = 0;

                if not PrintCust then
                    CurrReport.Skip();
                gls.get();


                LineNo := 0;
                if (selecetdText = '60D') or (SveOpomene = true) then begin

                    //od 30 - 60
                    if CustBalanceDueLCY[6] > 0 then begin
                        reminder.Init();

                        //   reminder.SetReminderNo();
                        //  NoSeriesMgt.InitSeries(reminder.GetNoSeriesCode(), '', 0D, reminder."No.", reminder."No. Series");
                        reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                        reminder.validate("Customer No.", Customer."No.");
                        reminder.CustomerCategory := Customer."Customer Category";
                        reminder.Name := customer.Name;
                        reminder."Customer Posting Group" := Customer."Customer Posting Group";
                        reminder."Document Date" := Today;
                        reminder."Reminder Report Type" := reminder."Reminder Report Type"::Custom;
                        reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";

                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";


                        if CodeI = 'I' then
                            reminder.validate("Document Date", StartDate);

                        reminder.WH := CalHeader;
                        reminder."Due Date" := calcdate(ss."Reminder Date", reminder."Document Date");
                        reminder.City := Customer.City;
                        reminder.Address := Customer.Address;
                        reminder."Address 2" := Customer."Address 2";
                        reminder."Reminder Level" := 1;
                        reminder."Post Code" := customer."Post Code";
                        reminder."Country/Region Code" := Customer."Country/Region Code";
                        reminder."Reminder Report Type" := ReminderReportType::Custom;
                        reminder."Currency Code" := Customer."Currency Code";
                        reminder."Posting Date" := today;
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";


                        us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            CalHeader := us."Calculation V";
                            if CalHeader <> '' then begin
                                CalcSetup.get;
                                CalcJLine.Reset();
                                CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                if CalcJLine.FindFirst() then begin
                                    Commit();
                                    reminder.Insert();
                                    Commit();
                                end;



                            end;
                        end;
                        Commit();
                        if CalHeader = '' then
                            reminder.Insert();
                        Commit();
                        lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");
                        lentry.SetRange("Customer No.", "No.");

                        lentry.SetRange("Posting Date", 0D, StartDate);
                        lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");
                        lentry.SetRange("Due Date", PeriodStartDate[6], PeriodStartDate[7] - 1);
                        if CalHeader <> '' then
                            lentry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');
                        if lentry.FindSet() then
                            repeat
                                reminderLine.Reset();
                                reminderLine2.Reset();
                                clentry.Reset();
                                reminderLine.Init();
                                reminderLine."No." := reminder."No.";
                                reminderLine."Reminder No." := reminder."No.";
                                //NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                                //    reminderLine2.SETFILTER("Reminder No.", '%1', reminderLine."Reminder No.");
                                //  if reminderLine2.FINDLAST then
                                reminderLine."Line No." := LineNo + 10000;
                                LineNo += 10000;
                                //   else
                                //   reminderLine."Line No." := 10000;
                                clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");
                                if clentry.FindFirst() then
                                    clentry.CalcFields(Amount, "Remaining Amount");
                                reminderLine."Original Amount" := clentry.Amount;
                                reminderLine."Remaining Amount" := clentry."Remaining Amount";
                                reminderLine.Amount := clentry.Amount;
                                reminderLine."Due Date" := clentry."Due Date";
                                reminderLine."Entry No." := clentry."Entry No.";
                                reminderLine."Document Date" := clentry."Document Date";
                                reminderLine.Description := clentry.Description;
                                reminderLine."Document Type" := clentry."Document Type";
                                reminderLine."Bill Category" := clentry."Bill Category";
                                reminderLine."Bill type" := clentry."Bill type";
                                reminderLine."Customer Category" := clentry."Customer Category";
                                reminderLine."Document No." := lentry."Document No.";
                                reminderLine."Type" := "Reminder Source Type"::"Customer Ledger Entry";
                                reminderLine."No. of Reminders" := 1;
                                if clentry."Calculate Interest" = false then begin
                                    reminderLine."Interest Rate" := 0;
                                end else
                                    if clentry."Calculate Interest" = true then begin
                                        if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                            reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                        end else
                                            reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                    end;

                                us.reset;
                                us.setfilter("User ID", '%1', userid);
                                if us.findfirst then begin
                                    CalHeader := us."Calculation V";
                                    if CalHeader <> '' then begin
                                        CalcSetup.get;
                                        CalcJLine.Reset();
                                        CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                        CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                        if CalcJLine.FindFirst() then begin
                                            Commit();
                                            reminderLine.Insert();
                                            Commit();
                                        end;
                                    end;
                                end;
                                Commit();
                                if CalHeader = '' then
                                    reminderLine.Insert();
                                Commit();
                            until lentry.next = 0;
                    end;

                end;

                //300

                if (selecetdText = '300D') or (SveOpomene = true) then begin


                    if CustBalanceDueLCY[4] > 0 then begin
                        reminder.Init();
                        //   reminder.SetReminderNo();
                        //  NoSeriesMgt.InitSeries(reminder.GetNoSeriesCode(), '', 0D, reminder."No.", reminder."No. Series");
                        reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                        reminder.validate("Customer No.", Customer."No.");
                        reminder."Posting Date" := today;
                        reminder.CustomerCategory := Customer."Customer Category";

                        reminder."Customer Posting Group" := Customer."Customer Posting Group";
                        reminder."Document Date" := Today;
                        reminder.Name := customer.Name;
                        reminder."Reminder Report Type" := reminder."Reminder Report Type"::Custom;
                        reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";


                        if CodeI = 'I' then
                            reminder.validate("Document Date", StartDate);

                        reminder.WH := CalHeader;
                        reminder."Due Date" := calcdate(ss."Reminder Date", reminder."Document Date");
                        reminder.City := Customer.City;
                        reminder.Address := Customer.Address;
                        reminder."Address 2" := Customer."Address 2";
                        reminder."Reminder Level" := 1;
                        reminder."Post Code" := customer."Post Code";
                        reminder."Country/Region Code" := Customer."Country/Region Code";
                        reminder."Reminder Report Type" := ReminderReportType::Custom;
                        reminder."Currency Code" := Customer."Currency Code";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";

                        us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            CalHeader := us."Calculation V";
                            if CalHeader <> '' then begin
                                CalcSetup.get;
                                CalcJLine.Reset();
                                CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                if CalcJLine.FindFirst() then begin
                                    Commit();
                                    reminder.Insert();
                                    Commit();
                                end;
                            end;
                        end;
                        Commit();
                        if CalHeader = '' then
                            reminder.Insert();
                        Commit();
                        lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");
                        lentry.SetRange("Customer No.", "No.");
                        lentry.SetRange("Posting Date", 0D, StartDate);
                        lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");
                        lentry.SetRange("Due Date", PeriodStartDate[4], PeriodStartDate[5] - 1);
                        if CalHeader <> '' then
                            lentry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');
                        if lentry.FindSet() then
                            repeat
                                reminderLine.Reset();
                                reminderLine2.Reset();
                                clentry.Reset();
                                reminderLine.Init();
                                reminderLine."No." := reminder."No.";
                                reminderLine."Reminder No." := reminder."No.";
                                //NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                                //    reminderLine2.SETFILTER("Reminder No.", '%1', reminderLine."Reminder No.");
                                //  if reminderLine2.FINDLAST then
                                reminderLine."Line No." := LineNo + 10000;
                                LineNo += 10000;
                                //   else
                                //   reminderLine."Line No." := 10000;
                                clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");
                                if clentry.FindFirst() then
                                    clentry.CalcFields(Amount, "Remaining Amount");
                                reminderLine."Original Amount" := clentry.Amount;
                                reminderLine."Remaining Amount" := clentry."Remaining Amount";
                                reminderLine.Amount := clentry.Amount;
                                reminderLine."Due Date" := clentry."Due Date";
                                reminderLine."Entry No." := clentry."Entry No.";
                                reminderLine."Document Date" := clentry."Document Date";
                                reminderLine."Bill Category" := clentry."Bill Category";
                                reminderLine."Bill type" := clentry."Bill type";
                                reminderLine."Customer Category" := clentry."Customer Category";
                                reminderLine.Description := clentry.Description;
                                reminderLine."Document Type" := clentry."Document Type";
                                reminderLine."Document No." := lentry."Document No.";
                                reminderLine."Type" := "Reminder Source Type"::"Customer Ledger Entry";
                                reminderLine."No. of Reminders" := 1;
                                if clentry."Calculate Interest" = false then begin
                                    reminderLine."Interest Rate" := 0;
                                end else
                                    if clentry."Calculate Interest" = true then begin
                                        if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                            reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                        end else
                                            reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                    end;

                                us.reset;
                                us.setfilter("User ID", '%1', userid);
                                if us.findfirst then begin
                                    CalHeader := us."Calculation V";
                                    if CalHeader <> '' then begin
                                        CalcSetup.get;
                                        CalcJLine.Reset();
                                        CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                        CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                        if CalcJLine.FindFirst() then begin
                                            Commit();
                                            reminderLine.Insert();
                                            Commit();
                                        end;
                                    end;
                                end;
                                Commit();
                                if CalHeader = '' then
                                    reminderLine.Insert();
                                Commit();
                            until lentry.next = 0;
                    end;

                end;

                //300

                if (selecetdText = '330D') or (SveOpomene = true) then begin


                    if CustBalanceDueLCY[3] > 0 then begin
                        reminder.Init();
                        //   reminder.SetReminderNo();
                        //  NoSeriesMgt.InitSeries(reminder.GetNoSeriesCode(), '', 0D, reminder."No.", reminder."No. Series");
                        reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                        reminder.validate("Customer No.", Customer."No.");
                        reminder."Posting Date" := today;
                        reminder.CustomerCategory := Customer."Customer Category";
                        reminder."Customer Posting Group" := Customer."Customer Posting Group";
                        reminder.Name := customer.Name;
                        reminder."Document Date" := Today;
                        reminder."Reminder Report Type" := reminder."Reminder Report Type"::Custom;
                        reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";


                        if CodeI = 'I' then
                            reminder.validate("Document Date", StartDate);

                        reminder.WH := CalHeader;
                        reminder."Due Date" := calcdate(ss."Reminder Date", reminder."Document Date");
                        reminder.City := Customer.City;
                        reminder.Address := Customer.Address;
                        reminder."Address 2" := Customer."Address 2";
                        reminder."Reminder Level" := 1;
                        reminder."Post Code" := customer."Post Code";
                        reminder."Country/Region Code" := Customer."Country/Region Code";
                        reminder."Reminder Report Type" := ReminderReportType::Custom;
                        reminder."Currency Code" := Customer."Currency Code";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";

                        us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            CalHeader := us."Calculation V";
                            if CalHeader <> '' then begin
                                CalcSetup.get;
                                CalcJLine.Reset();
                                CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                if CalcJLine.FindFirst() then begin
                                    Commit();
                                    reminder.Insert();
                                    Commit();
                                end;
                            end;
                        end;
                        Commit();
                        if CalHeader = '' then
                            reminder.Insert();
                        Commit();
                        lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");
                        lentry.SetRange("Customer No.", "No.");
                        lentry.SetRange("Posting Date", 0D, StartDate);
                        lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");
                        lentry.SetRange("Due Date", PeriodStartDate[3], PeriodStartDate[4] - 1);
                        if CalHeader <> '' then
                            lentry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');
                        if lentry.FindSet() then
                            repeat
                                reminderLine.Reset();
                                reminderLine2.Reset();
                                clentry.Reset();
                                reminderLine.Init();
                                reminderLine."No." := reminder."No.";
                                reminderLine."Reminder No." := reminder."No.";
                                //NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                                //    reminderLine2.SETFILTER("Reminder No.", '%1', reminderLine."Reminder No.");
                                //  if reminderLine2.FINDLAST then
                                reminderLine."Line No." := LineNo + 10000;
                                LineNo += 10000;
                                //   else
                                //   reminderLine."Line No." := 10000;
                                clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");
                                if clentry.FindFirst() then
                                    clentry.CalcFields(Amount, "Remaining Amount");
                                reminderLine."Original Amount" := clentry.Amount;
                                reminderLine."Remaining Amount" := clentry."Remaining Amount";
                                reminderLine.Amount := clentry.Amount;
                                reminderLine."Due Date" := clentry."Due Date";
                                reminderLine."Entry No." := clentry."Entry No.";
                                reminderLine."Document Date" := clentry."Document Date";
                                reminderLine.Description := clentry.Description;
                                reminderLine."Document Type" := clentry."Document Type";
                                reminderLine."Bill Category" := clentry."Bill Category";
                                reminderLine."Bill type" := clentry."Bill type";
                                reminderLine."Customer Category" := clentry."Customer Category";
                                reminderLine."Document No." := lentry."Document No.";
                                reminderLine."Type" := "Reminder Source Type"::"Customer Ledger Entry";
                                reminderLine."No. of Reminders" := 1;
                                if clentry."Calculate Interest" = false then begin
                                    reminderLine."Interest Rate" := 0;
                                end else
                                    if clentry."Calculate Interest" = true then begin
                                        if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                            reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                        end else
                                            reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                    end;

                                us.reset;
                                us.setfilter("User ID", '%1', userid);
                                if us.findfirst then begin
                                    CalHeader := us."Calculation V";
                                    if CalHeader <> '' then begin
                                        CalcSetup.get;
                                        CalcJLine.Reset();
                                        CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                        CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                        if CalcJLine.FindFirst() then begin
                                            Commit();
                                            reminderLine.Insert();
                                            Commit();
                                        end;
                                    end;
                                end;
                                Commit();
                                if CalHeader = '' then
                                    reminderLine.Insert();
                                Commit();
                            until lentry.next = 0;
                    end;

                end;

                //preko 330 D

                if (selecetdText = 'Preko 330D') or (SveOpomene = true) then begin


                    if CustBalanceDueLCY[2] > 0 then begin
                        reminder.Init();
                        //   reminder.SetReminderNo();
                        //  NoSeriesMgt.InitSeries(reminder.GetNoSeriesCode(), '', 0D, reminder."No.", reminder."No. Series");
                        reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                        reminder.validate("Customer No.", Customer."No.");
                        reminder."Posting Date" := today;
                        reminder.CustomerCategory := Customer."Customer Category";
                        reminder."Customer Posting Group" := Customer."Customer Posting Group";
                        reminder.Name := customer.Name;
                        reminder."Document Date" := Today;
                        reminder."Reminder Report Type" := reminder."Reminder Report Type"::Custom;
                        reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";


                        if CodeI = 'I' then
                            reminder.validate("Document Date", StartDate);

                        reminder.WH := CalHeader;
                        reminder."Due Date" := calcdate(ss."Reminder Date", reminder."Document Date");
                        reminder.City := Customer.City;
                        reminder.Address := Customer.Address;
                        reminder."Address 2" := Customer."Address 2";
                        reminder."Reminder Level" := 1;
                        reminder."Post Code" := customer."Post Code";
                        reminder."Country/Region Code" := Customer."Country/Region Code";
                        reminder."Reminder Report Type" := ReminderReportType::Custom;
                        reminder."Currency Code" := Customer."Currency Code";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";

                        us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            CalHeader := us."Calculation V";
                            if CalHeader <> '' then begin
                                CalcSetup.get;
                                CalcJLine.Reset();
                                CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                if CalcJLine.FindFirst() then begin
                                    Commit();
                                    reminder.Insert();
                                    Commit();
                                end;
                            end;
                        end;
                        Commit();

                        if CalHeader = '' then
                            reminder.Insert();
                        Commit();
                        lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");
                        lentry.SetRange("Customer No.", "No.");
                        lentry.SetRange("Posting Date", 0D, StartDate);
                        lentry.setfilter("Due Date", '<=%1', PeriodStartDate[2 + 1] - 1);
                        lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");
                        if lentry.FindSet() then
                            repeat
                                reminderLine.Reset();
                                reminderLine2.Reset();
                                clentry.Reset();
                                reminderLine.Init();
                                reminderLine."No." := reminder."No.";
                                reminderLine."Reminder No." := reminder."No.";
                                //NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                                //    reminderLine2.SETFILTER("Reminder No.", '%1', reminderLine."Reminder No.");
                                //  if reminderLine2.FINDLAST then
                                reminderLine."Line No." := LineNo + 10000;
                                LineNo += 10000;
                                //   else
                                //   reminderLine."Line No." := 10000;
                                clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");
                                if clentry.FindFirst() then
                                    clentry.CalcFields(Amount, "Remaining Amount");
                                reminderLine."Original Amount" := clentry.Amount;
                                reminderLine."Remaining Amount" := clentry."Remaining Amount";
                                reminderLine.Amount := clentry.Amount;
                                reminderLine."Due Date" := clentry."Due Date";
                                reminderLine."Entry No." := clentry."Entry No.";
                                reminderLine."Document Date" := clentry."Document Date";
                                reminderLine.Description := clentry.Description;
                                reminderLine."Document Type" := clentry."Document Type";
                                reminderLine."Bill Category" := clentry."Bill Category";
                                reminderLine."Bill type" := clentry."Bill type";
                                reminderLine."Customer Category" := clentry."Customer Category";
                                reminderLine."Document No." := lentry."Document No.";
                                reminderLine."Type" := "Reminder Source Type"::"Customer Ledger Entry";
                                reminderLine."No. of Reminders" := 1;
                                if clentry."Calculate Interest" = false then begin
                                    reminderLine."Interest Rate" := 0;
                                end else
                                    if clentry."Calculate Interest" = true then begin
                                        if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                            reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                        end else
                                            reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                    end;

                                us.reset;
                                us.setfilter("User ID", '%1', userid);
                                if us.findfirst then begin
                                    CalHeader := us."Calculation V";
                                    if CalHeader <> '' then begin
                                        CalcSetup.get;
                                        CalcJLine.Reset();
                                        CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                        CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                        if CalcJLine.FindFirst() then begin
                                            Commit();
                                            reminderLine.Insert();
                                            Commit();
                                        end;
                                    end;
                                end;
                                Commit();
                                if CalHeader = '' then
                                    reminderLine.Insert();
                                Commit();
                            until lentry.next = 0;
                    end;

                end;

                //330

                if (selecetdText = '90D') or (SveOpomene = true) then begin

                    if CustBalanceDueLCY[5] > 0 then begin
                        reminder.Init();
                        // reminder.SetReminderNo();
                        //  NoSeriesMgt.InitSeries(reminder.GetNoSeriesCode(), '', 0D, reminder."No.", reminder."No. Series");
                        reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                        reminder.validate("Customer No.", Customer."No.");
                        reminder."Posting Date" := today;
                        reminder."Document Date" := Today;
                        reminder.Name := Customer.name;
                        reminder.CustomerCategory := Customer."Customer Category";
                        reminder.WH := CalHeader;
                        reminder."Reminder Report Type" := reminder."Reminder Report Type"::Custom;
                        reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";


                        if CodeI = 'I' then
                            reminder.validate("Document Date", StartDate);

                        reminder."Due Date" := calcdate(ss."Reminder Date", reminder."Document Date");
                        reminder.City := Customer.City;
                        reminder.Address := Customer.Address;
                        reminder."Address 2" := Customer."Address 2";
                        reminder."Reminder Level" := 1;
                        reminder."Post Code" := customer."Post Code";
                        reminder."Country/Region Code" := Customer."Country/Region Code";
                        reminder."Reminder Report Type" := ReminderReportType::Custom;
                        reminder."Currency Code" := Customer."Currency Code";

                        us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            CalHeader := us."Calculation V";
                            if CalHeader <> '' then begin
                                CalcSetup.get;
                                CalcJLine.Reset();
                                CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                if CalcJLine.FindFirst() then begin
                                    Commit();
                                    reminder.Insert();
                                    Commit();
                                end;
                            end;
                        end;
                        Commit();
                        if CalHeader = '' then
                            reminder.Insert(TRUE);
                        Commit();
                        lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");
                        lentry.SetRange("Customer No.", "No.");
                        lentry.SetRange("Posting Date", 0D, StartDate);
                        lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");
                        lentry.SetRange("Due Date", PeriodStartDate[5], PeriodStartDate[6] - 1);
                        if lentry.FindSet() then
                            repeat
                                reminderLine.Reset();
                                clentry.Reset();
                                reminderLine.Init();
                                reminderLine."No." := reminder."No.";
                                reminderLine."Reminder No." := reminder."No.";
                                //reminderLine."No." := NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                                reminderLine."Line No." := LineNo + 10000;
                                LineNo += 10000;
                                clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");
                                if clentry.FindFirst() then
                                    clentry.CalcFields(Amount, "Remaining Amount");
                                reminderLine."Original Amount" := clentry.Amount;
                                reminderLine."Remaining Amount" := clentry."Remaining Amount";
                                reminderLine.Amount := clentry.Amount;
                                reminderLine."Due Date" := clentry."Due Date";
                                reminderLine."Document Date" := clentry."Document Date";
                                reminderLine.Description := clentry.Description;
                                reminderLine."Document Type" := lentry."Document Type";
                                reminderLine."Bill Category" := clentry."Bill Category";
                                reminderLine."Bill type" := clentry."Bill type";
                                reminderLine."Customer Category" := clentry."Customer Category";
                                reminderLine."Document No." := lentry."Document No.";
                                reminderLine."No. of Reminders" := 3;
                                reminderLine."Entry No." := clentry."Entry No.";
                                reminderLine."Type" := "Reminder Source Type"::"Customer Ledger Entry";

                                if clentry."Calculate Interest" = false then begin
                                    reminderLine."Interest Rate" := 0;
                                end else
                                    if clentry."Calculate Interest" = true then begin
                                        if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                            reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                        end else
                                            reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                    end;

                                us.reset;
                                us.setfilter("User ID", '%1', userid);
                                if us.findfirst then begin
                                    CalHeader := us."Calculation V";
                                    if CalHeader <> '' then begin
                                        CalcSetup.get;
                                        CalcJLine.Reset();
                                        CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                        CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                        if CalcJLine.FindFirst() then begin
                                            Commit();
                                            reminderLine.Insert();
                                            Commit();
                                        end;
                                    end;
                                end;

                                Commit();
                                if CalHeader = '' then
                                    reminderLine.Insert();
                                Commit();
                            until lentry.next = 0;
                    end
                end;

                /* if (SveOpomene = True) then begin

                     if (CustBalanceDueLCY[7] > 0)
                     or (CustBalanceDueLCY[6] > 0)
                     or (CustBalanceDueLCY[5] > 0)
                     or (CustBalanceDueLCY[4] > 0)
                     or (CustBalanceDueLCY[3] > 0)
                     or (CustBalanceDueLCY[2] > 0)
                     then begin
                         reminder.Reset();
                         reminder.Init();
                         ///  reminder.SetReminderNo();
                         reminder.Validate(CustomerCategory, Customer."Customer Category");
                         reminder."Posting Date" := today;
                         reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                         reminder.validate("Customer No.", Customer."No.");
                         reminder."Document Date" := StartDate;
                         reminder.CustomerCategory := Customer."Customer Category";
                         reminder.Name := customer.Name;
                         reminder."Due Date" := calcdate(ss."Reminder Date", Today);
                         reminder.WH := CalHeader;
                         reminder."Reminder Report Type" := reminder."Reminder Report Type"::Custom;
                         reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply";
                          if CodeI = 'I' then
                             reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                         else
                             reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";
                         reminder.City := Customer.City;
                         reminder.Address := Customer.Address;
                         reminder."Address 2" := Customer."Address 2";
                         reminder."Reminder Level" := 1;
                         reminder."Post Code" := customer."Post Code";
                         reminder."Country/Region Code" := Customer."Country/Region Code";
                         reminder."Reminder Report Type" := ReminderReportType::Custom;
                         reminder."Currency Code" := Customer."Currency Code";

                         us.reset;
                         us.setfilter("User ID", '%1', userid);
                         if us.findfirst then begin
                             CalHeader := us."Calculation V";
                             if CalHeader <> '' then begin
                                 CalcSetup.get;
                                 CalcJLine.Reset();
                                 CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                 CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                 if CalcJLine.FindFirst() then begin
                                     Commit();
                                     reminder.Insert();
                                     Commit();
                                 end;
                             end;
                         end;
                         Commit();
                         if CalHeader = '' then
                             reminder.Insert(TRUE);
                         Commit();                       lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");
                         lentry.SetRange("Customer No.", "No.");
                         lentry.SetRange("Posting Date", 0D, StartDate);
                         lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");
                         lentry.setfilter("Due Date", '<%1', calcdate('<-0D>', StartDate));
                         lentry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');
                         if CalHeader <> '' then
                             lentry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');
                         //   lentry.SetRange("Due Date", PeriodStartDate[7], PeriodStartDate[8] - 1);
                         if lentry.FindSet() then
                             repeat
                                 reminderLine.Reset();
                                 clentry.Reset();
                                 ;
                                 reminderLine.Init();
                                 reminderLine."No." := reminder."No.";
                                 reminderLine."Reminder No." := reminder."No.";
                                 //reminderLine."No." := NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                                 reminderLine2.SETFILTER("Reminder No.", '%1', reminderLine."Reminder No.");
                                 reminderLine."Line No." := LineNo + 10000;
                                 LineNo += 10000;
                                 clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");
                                 if clentry.FindFirst() then
                                     clentry.CalcFields(Amount, "Remaining Amount");
                                 reminderLine."Original Amount" := clentry.Amount;
                                 reminderLine."Remaining Amount" := clentry."Remaining Amount";
                                 reminderLine.Amount := clentry.Amount;
                                 reminderLine."Due Date" := clentry."Due Date";
                                 reminderLine."Document Date" := clentry."Document Date";
                                 reminderLine.Description := clentry.Description;
                                 reminderLine."Bill Category" := clentry."Bill Category";
                                 reminderLine."Bill type" := clentry."Bill type";
                                 reminderLine."Customer Category" := clentry."Customer Category";
                                 reminderLine."Document Type" := lentry."Document Type";
                                 reminderLine."Document No." := lentry."Document No.";
                                 reminderLine."No. of Reminders" := 1;
                                 reminderLine."Entry No." := clentry."Entry No.";
                                 reminderLine."Type" := "Reminder Source Type"::"Customer Ledger Entry";

                                 if clentry."Calculate Interest" = false then begin
                                     reminderLine."Interest Rate" := 0;
                                 end else
                                     if clentry."Calculate Interest" = true then begin
                                         if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                             reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                         end else
                                             reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                     end;
                                 us.reset;
                                 us.setfilter("User ID", '%1', userid);
                                 if us.findfirst then begin
                                     CalHeader := us."Calculation V";
                                     if CalHeader <> '' then begin
                                         CalcSetup.get;
                                         CalcJLine.Reset();
                                         CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                         CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                         if CalcJLine.FindFirst() then begin
                                             Commit();
                                             reminderLine.Insert();
                                             Commit();
                                         end;
                                     end;
                                 end;
                                 Commit();
                                 if CalHeader = '' then
                                     reminderLine.Insert();
                                 Commit();
                             until lentry.next = 0;
                     end;
                 end;*/


                if (selecetdText = '30D') or (SveOpomene = true) then begin

                    if CustBalanceDueLCY[7] > 0 then begin
                        reminder.Reset();
                        reminder.Init();
                        ///  reminder.SetReminderNo();
                        reminder.Validate(CustomerCategory, Customer."Customer Category");
                        reminder."Posting Date" := today;
                        reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                        reminder.validate("Customer No.", Customer."No.");
                        reminder."Document Date" := Today;
                        reminder.CustomerCategory := Customer."Customer Category";
                        reminder.Name := customer.Name;
                        reminder."Due Date" := calcdate(ss."Reminder Date", reminder."Document Date");
                        reminder.WH := CalHeader;
                        reminder."Reminder Report Type" := reminder."Reminder Report Type"::Custom;
                        reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";
                        if CodeI = 'I' then
                            reminder."Reminder Type" := reminder."Reminder Type"::"Reminder for interruption of gas supply"
                        else
                            reminder."Reminder Type" := reminder."Reminder Type"::"Accusation Reminder";

                        if CodeI = 'I' then
                            reminder.validate("Document Date", StartDate);

                        reminder.City := Customer.City;
                        reminder.Address := Customer.Address;
                        reminder."Address 2" := Customer."Address 2";
                        reminder."Reminder Level" := 1;
                        reminder."Post Code" := customer."Post Code";
                        reminder."Country/Region Code" := Customer."Country/Region Code";
                        reminder."Reminder Report Type" := ReminderReportType::Custom;
                        reminder."Currency Code" := Customer."Currency Code";

                        us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            CalHeader := us."Calculation V";
                            if CalHeader <> '' then begin
                                CalcSetup.get;
                                CalcJLine.Reset();
                                CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                if CalcJLine.FindFirst() then begin
                                    Commit();
                                    reminder.Insert();
                                    Commit();
                                end;
                            end;
                        end;
                        Commit();
                        if CalHeader = '' then
                            reminder.Insert(TRUE);
                        Commit();
                        lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");
                        lentry.SetRange("Customer No.", "No.");
                        lentry.SetRange("Posting Date", 0D, StartDate);
                        lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");
                        lentry.SetRange("Due Date", PeriodStartDate[7], PeriodStartDate[8] - 1);
                        if lentry.FindSet() then
                            repeat
                                reminderLine.Reset();
                                clentry.Reset();
                                ;
                                reminderLine.Init();
                                reminderLine."No." := reminder."No.";
                                reminderLine."Reminder No." := reminder."No.";
                                //reminderLine."No." := NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                                reminderLine2.SETFILTER("Reminder No.", '%1', reminderLine."Reminder No.");
                                reminderLine."Line No." := LineNo + 10000;
                                LineNo += 10000;
                                clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");
                                if clentry.FindFirst() then
                                    clentry.CalcFields(Amount, "Remaining Amount");
                                reminderLine."Original Amount" := clentry.Amount;
                                reminderLine."Remaining Amount" := clentry."Remaining Amount";
                                reminderLine.Amount := clentry.Amount;
                                reminderLine."Due Date" := clentry."Due Date";
                                reminderLine."Document Date" := clentry."Document Date";
                                reminderLine.Description := clentry.Description;
                                reminderLine."Bill Category" := clentry."Bill Category";
                                reminderLine."Bill type" := clentry."Bill type";
                                reminderLine."Customer Category" := clentry."Customer Category";
                                reminderLine."Document Type" := lentry."Document Type";
                                reminderLine."Document No." := lentry."Document No.";
                                reminderLine."No. of Reminders" := 1;
                                reminderLine."Entry No." := clentry."Entry No.";
                                reminderLine."Type" := "Reminder Source Type"::"Customer Ledger Entry";

                                if clentry."Calculate Interest" = false then begin
                                    reminderLine."Interest Rate" := 0;
                                end else
                                    if clentry."Calculate Interest" = true then begin
                                        if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                            reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                        end else
                                            reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                    end;
                                us.reset;
                                us.setfilter("User ID", '%1', userid);
                                if us.findfirst then begin
                                    CalHeader := us."Calculation V";
                                    if CalHeader <> '' then begin
                                        CalcSetup.get;
                                        CalcJLine.Reset();
                                        CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                        CalcJLine.SetFilter("Customer Balance", '>%1', CalcSetup."Reminder amount");
                                        if CalcJLine.FindFirst() then begin
                                            Commit();
                                            reminderLine.Insert();
                                            Commit();
                                        end;
                                    end;
                                end;
                                Commit();
                                if CalHeader = '' then
                                    reminderLine.Insert();
                                Commit();
                            until lentry.next = 0;
                    end;
                end;
            end;


            trigger OnPreDataItem()
            var
                us: Record "User Setup";
            begin
                Clear(CustBalanceDueLCY);
                CompInfo.CALCFIELDS(Picture);
                SetFilter("Customer Status", '%1', "Customer Status"::Active);
                //  SetFilter("Reminder Terms Code", '<>%1', '');





                reminder.Reset();
                reminder.SetFilter(WH, '%1', '');
                if reminder.FindFirst() then
                    reminder.DeleteAll();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; StartDate)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                }
                group("Izaberi opomenu")
                {
                    Caption = 'Izaberi opomenu';
                    field(ReminderSelection; Selected)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = ',Kreirati opomene za kupce koji imaju dospijeće 30D, Kreirati opomene za kupce koji imaju dospijeće 60D, Kreirati opomene za kupce koji imaju dospijeće 90D, Kreirati opomene za kupce koji imaju dospijeće 300D, Kreirati opomene za kupce koji imaju dospijeće 330D,Kreirati opomene za kupce koji imaju dospijeće preko 330D';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if StartDate = 0D then
                StartDate := WorkDate;
            CompInfo.Get();
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        FormatDocument: Codeunit "Format Document";
    begin

        crl.Reset();
        crl.SetFilter("Report ID", '%1', 50152);
        IF CRL.FindFirst() THEN
            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));


        CustFilter := FormatDocument.GetRecordFiltersWithCaptions(Customer);

        PeriodStartDate[8] := StartDate;
        PeriodStartDate[9] := DMY2Date(31, 12, 9999);
        for i := 7 downto 2 do begin
            if i > 4 then
                PeriodStartDate[i] := CalcDate('<-30D>', PeriodStartDate[i + 1]);
            if i = 4 then
                PeriodStartDate[i] := CalcDate('<-300D>', PeriodStartDate[8]);
            if i = 3 then
                PeriodStartDate[i] := CalcDate('<-330D>', PeriodStartDate[8]);

            if i = 2 then
                PeriodStartDate[i] := CalcDate('<-30D>', PeriodStartDate[i + 1]);



        end;
        PeriodStartDate[1] := CalcDate('<-30D>', PeriodStartDate[2]);
        selecetdText := Format(Selected);
    end;

    procedure SetParam(Exist: Boolean; WH_2: code[20]; I: Code[20])

    var

    begin
        if Exist = true then
            Show := 1
        else
            Show := 2;

        CalHeader := Wh_2;
        CodeI := i;
        if CalHeader <> '' then begin
            SveOpomene := true;
        end
        else begin
            SveOpomene := false;
        end;


    end;

    var
        Text001: Label 'As of %1';
        CodeI: code[20];
        CalHeader: code[20];

        SveOpomene: Boolean;
        Show: Integer;
        CompInfo: Record "Company Information";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        StartDate: Date;
        CustFilter: Text;

        PeriodStartDate: array[10] of Date;
        ShowData: Boolean;
        CustBalanceDueLCY: array[10] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        fileName: Text;
        FileManagement: Codeunit "File Management";


        Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY';
        CustBalanceDueLCY_5__Control25CaptionLbl: Label 'Not Due';
        CustBalanceDueLCY_4__Control26CaptionLbl: Label '0-30 days';
        CustBalanceDueLCY_3__Control27CaptionLbl: Label '31-60 days';
        CustBalanceDueLCY_2__Control28CaptionLbl: Label '61-90 days';
        CustBalanceDueLCY_1__Control29CaptionLbl: Label '91 - 300 days';

        CustBalanceDueLCY_1__Control30CaptionLbl_300: Label '300 - 330 days';
        CustBalanceDueLCY_1__Control30CaptionLbl: Label 'Over 330 days';

        TotalCaptionLbl: Label 'Total';
        NoSeriesMgt: Codeunit NoSeriesExtented;
        CalcSetup: Record "Calculation Setup";
        reminder: Record "Reminder Header";
        reminderLine: Record "Reminder Line";
        reminderLine2: Record "Reminder Line";

        counterForAccusation: Integer;
        Selected: Option "","30D","60D","90D","300D","330D","Preko 330D";
        CalcHe: Record "Calculation Journal Line";
        CalcJLine: Record "Calculation Journal Line";


        selecetdText: Text;
        crl: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";

    procedure InitializeRequest(StartingDate: Date)
    begin
        StartDate := StartingDate;
    end;



}

