report 50211 "CustomerSummaryAging Billing"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './CustAgingBilling.rdl';
    ApplicationArea = all;
    Caption = 'Customer - Summary Aging Simp.';
    ShowPrintStatus = false;
    UsageCategory = ReportsAndAnalysis;
    EnableExternalAssemblies = true;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {
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

            column(Customer__No__; "Customer No.")
            {
            }
            column(Customer_Name; "CUstomer Name")
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
            column(Customer__No__Caption; FieldCaption("Customer No."))
            {
            }
            column(Customer_NameCaption; FieldCaption("CUstomer Name"))
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
                RLine: Record "Reminder Line";
                RLineLine: Record "Reminder Line";
                us: Record "User Setup";

            begin


                SveOpomene := true;
                CalHeader := "Calculation Journal Line".Code;
                CUstF.get("Calculation Journal Line"."Customer No.");
                Show := 1;
                CalHeader := "Calculation Journal Line".Code;
                CodeI := 'I';

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
                    CalcHe.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                    if CalcHe.findfirst then begin
                        ShowData := true;
                    end
                    else begin
                        ShowData := false;
                    end;


                end;


                PrintCust := false;


                DtldCustLedgEntry.Reset();

                DtldCustLedgEntry.SetRange("Customer No.", "Calculation Journal Line"."Customer No.");
                DtldCustLedgEntry.SetRange("Posting Date", 0D, StartDate);

                if CalHeader <> '' then
                    DtldCustLedgEntry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');

                CustBalanceDueLCY[7] := 0;

                DtldCustLedgEntry.setfilter("Posting Date", '<=%1', StartDate);
                DtldCustLedgEntry.setfilter("Date Filter", '<=%1', StartDate);
                DtldCustLedgEntry.SetFilter("Due Date", '<=%1', StartDate);

                DtldCustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
                if DtldCustLedgEntry.FindSet() then
                    repeat
                        DtldCustLedgEntry.CalcFields("Remaining Amt. (LCY)");
                        CustBalanceDueLCY[7] += DtldCustLedgEntry."Remaining Amt. (LCY)";
                    until DtldCustLedgEntry.next = 0;
                if CustBalanceDueLCY[7] <> 0 then
                    PrintCust := true;

                custLedgEntry.Reset();

                custLedgEntry.SetRange("Customer No.", "Calculation Journal Line"."Customer No.");
                custLedgEntry.SetRange("Posting Date", 0D, StartDate);
                custLedgEntry.SetRange("Initial Entry Due Date", PeriodStartDate[1], PeriodStartDate[3] - 1);
                custLedgEntry.SetCurrentKey("Customer No.", "Initial Entry Due Date", "Posting Date");
                if custLedgEntry.FindSet() then
                    repeat
                        counterForAccusation += 1;
                    until custLedgEntry.next = 0;

                if not PrintCust then
                    CurrReport.Skip();
                gls.get();







                if CustBalanceDueLCY[7] > 0 then begin

                    RCheck.Reset();
                    RCheck.SetFilter("WH", '%1', CalHeader);
                    RCheck.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");

                    if not RCheck.FindFirst() then begin
                        reminder.Reset();

                        reminder.Init();
                        ///  reminder.SetReminderNo();
                        reminder.Validate(CustomerCategory, "Calculation Journal Line"."Category Customer");
                        reminder."Posting Date" := today;
                        reminder."No." := NoSeriesMgt.GetNextNo(reminder.GetNoSeriesCode(), TODAY, true);
                        reminder.validate("Customer No.", "Calculation Journal Line"."Customer No.");
                        reminder."Document Date" := Today;
                        reminder.CustomerCategory := "Calculation Journal Line"."Category Customer";
                        reminder.Name := copystr("Calculation Journal Line"."Customer Name", 1, 100);
                        reminder."E-mail" := "Calculation Journal Line"."E-mail Delivery";
                        reminder."E-mail delivery" := "Calculation Journal Line"."E-Mail 2";
                        reminder."Currency Code" := '';
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

                        reminder.City := "Calculation Journal Line"."City Customer";
                        reminder.Address := "Calculation Journal Line"."Address Customer";
                        reminder."Address 2" := "Calculation Journal Line"."Address 2";
                        reminder."Reminder Level" := 1;
                        reminder."Post Code" := "calculation journal line"."Post Code Customer";
                        reminder."Country/Region Code" := CUstF."Country/Region Code";
                        reminder."Reminder Report Type" := ReminderReportType::Custom;
                        reminder."Currency Code" := "Calculation Journal Line"."Currency Code";

                        if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::Household then
                            ReminderV := CalcSetup."Reminder amount";
                        if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Large Economy" then
                            ReminderV := CalcSetup."Reminder amount VP";
                        if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Small Economy" then
                            ReminderV := CalcSetup."Reminder amount MP";
                        if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"KJKP Heating plant" then
                            ReminderV := CalcSetup."Reminder amount KJKP";
                        if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Special Customer" then
                            ReminderV := CalcSetup."Reminder amount SP";
                        if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::CNG then
                            ReminderV := CalcSetup."Reminder amount CNG";

                        us.reset;
                        us.setfilter("User ID", '%1', userid);
                        if us.findfirst then begin
                            CalHeader := us."Calculation V";
                            if CalHeader <> '' then begin
                                CalcSetup.get;
                                CalcJLine.Reset();
                                CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                CalcJLine.SetFilter("Customer Balance", '>=%1', ReminderV);
                                CalcJLine.SetFilter("Measuring point off", '%1', false);
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

                    end;


                    lentry.Reset();
                    lentry.SetRange("Customer No.", "Calculation Journal Line"."Customer No.");
                    lentry.SetRange("Posting Date", 0D, StartDate);
                    lentry.SetFilter("Document Type", '%1|%2', lentry."Document Type"::Invoice, lentry."Document Type"::" ");





                    if CalHeader <> '' then
                        lentry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');




                    lentry.setfilter("Date Filter", '<=%1', StartDate);
                    lentry.SetFilter("Due Date", '<=%1', StartDate);

                    lentry.SetCurrentKey("Customer No.", "Due Date", "Posting Date");

                    if lentry.FindSet() then
                        repeat
                            reminderLine.Reset();
                            clentry.Reset();


                            reminderLine.Init();
                            RCheck.Reset();
                            RCheck.SetFilter("WH", '%1', CalHeader);
                            RCheck.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                            if RCheck.FindFirst() then
                                reminderLine."No." := RCheck."No."
                            else
                                reminderLine."No." := reminder."No.";
                            reminderLine."Reminder No." := reminder."No.";
                            //reminderLine."No." := NoSeriesMgt.GetNextNo(gls."Reminder Line Entry Series", TODAY, true);
                            reminderLine2.SETFILTER("Reminder No.", '%1', reminderLine."Reminder No.");
                            reminderLine."Line No." := LineNo + 10000;
                            LineNo += 10000;
                            clentry.SetFilter("Entry No.", '%1', lentry."Entry No.");

                            if CalHeader <> '' then
                                clentry.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');




                            clentry.setfilter("Date Filter", '<=%1', StartDate);
                            clentry.SetFilter("Due Date", '<=%1', StartDate);

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
                            clentry."Calculate Interest" := false;
                            if clentry."Calculate Interest" = false then begin
                                reminderLine."Interest Rate" := 0;
                            end else
                                if clentry."Calculate Interest" = true then begin
                                    if DMY2Date(Date2DMY(clentry."Due Date", 1), Date2DMY(clentry."Due Date", 2), Date2DMY(clentry."Due Date", 3) + 1) > Today then begin
                                        reminderLine."Interest Rate" := gls."Interest Normal Coefficient";
                                    end else
                                        reminderLine."Interest Rate" := gls."Interest Comfort Coefficient";
                                end;
                            if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::Household then
                                ReminderV := CalcSetup."Reminder amount";
                            if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Large Economy" then
                                ReminderV := CalcSetup."Reminder amount VP";
                            if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Small Economy" then
                                ReminderV := CalcSetup."Reminder amount MP";
                            if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"KJKP Heating plant" then
                                ReminderV := CalcSetup."Reminder amount KJKP";
                            if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Special Customer" then
                                ReminderV := CalcSetup."Reminder amount SP";
                            if "Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::CNG then
                                ReminderV := CalcSetup."Reminder amount CNG";

                            us.reset;
                            us.setfilter("User ID", '%1', userid);
                            if us.findfirst then begin
                                CalHeader := us."Calculation V";
                                if CalHeader <> '' then begin
                                    CalcSetup.get;
                                    CalcJLine.Reset();
                                    CalcJLine.SetFilter("Customer No.", '%1', reminder."Customer No.");
                                    CalcJLine.SetFilter("Customer Balance", '>=%1', ReminderV);
                                    CalcJLine.SetFilter("Measuring point off", '%1', false);
                                    if CalcJLine.FindFirst() then begin
                                        Commit();
                                        ReminderLineExsist.Reset();
                                        ReminderLineExsist.SetFilter("No.", '%1', reminderLine."No.");
                                        ReminderLineExsist.SetFilter("Entry No.", '%1', reminderLine."Entry No.");
                                        ReminderLineExsist.SetFilter(Description, '%1', reminderLine.Description);
                                        if not ReminderLineExsist.FindFirst() then begin
                                            RLine.Reset();
                                            RLine.SetFilter("Reminder No.", '%1', reminderLine."Reminder No.");
                                            RLine.SetFilter("Line No.", '%1', reminderLine."Line No.");
                                            if not RLine.FindFirst() then begin
                                                reminderLine.Insert();
                                            end
                                            else begin
                                                RLineLine.Reset();
                                                RLineLine.SetFilter("Reminder No.", '%1', reminderLine."Reminder No.");
                                                RLineLine.SetCurrentKey("Line No.");
                                                RLineLine.Ascending;
                                                if RLineLine.FindLast() then begin
                                                    reminderLine."Line No." := RLineLine."Line No." + 1000;
                                                    reminderLine.Insert();
                                                end;

                                            end;
                                        end;

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


            trigger OnPreDataItem()
            var
                us: Record "User Setup";
                WHF: Record "Calcuation Header";

            begin
                Clear(CustBalanceDueLCY);
                CompInfo.CALCFIELDS(Picture);

                // SetFilter("Reminder Terms Code", '<>%1', '');








            end;

            trigger OnPostDataItem()
            var
                myInt: Integer;
                RHDelete: Record "Reminder Header";
            begin
                RHDelete.Reset();
                RHDelete.SetFilter("Remaining Amount", '%1', 0);
                RHDelete.SetFilter(WH, '%1', CalHeader);
                if RHDelete.FindSet() then
                    repeat

                        RHDelete.Delete();
                    until RHDelete.Next() = 0;
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
                        Visible = false;
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
        //  crl.SetFilter(Description, '%1', 'Opomena za prekid gasa');
        IF CRL.FindFirst() THEN
            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));


        CustFilter := FormatDocument.GetRecordFiltersWithCaptions("Calculation Journal Line");

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







    var
        Text001: Label 'As of %1';
        CodeI: code[20];
        CalHeader: code[20];

        SveOpomene: Boolean;
        Show: Integer;
        ReminderV: Decimal;
        CompInfo: Record "Company Information";
        DtldCustLedgEntry: Record "Cust. Ledger Entry";
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
        CUstF: Record Customer;

        counterForAccusation: Integer;

        Selected: Option "","30D","60D","90D","300D","330D","Preko 330D";
        CalcHe: Record "Calculation Journal Line";
        CalcJLine: Record "Calculation Journal Line";
        RCheck: Record "Reminder Header";
        RLineCheck: Record "Reminder Line";

        selecetdText: Text;
        crl: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        ReminderLineExsist: Record "Reminder Line";

    procedure InitializeRequest(StartingDate: Date)
    begin
        StartDate := StartingDate;
    end;



}

