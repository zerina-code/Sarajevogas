pageextension 50291 "ReminderPageExtends" extends Reminder
{
    layout
    {



        addafter("Customer No.")
        {
            field(Category; "CustomerCategory") { }
            field("Delivered via email"; "Delivered via email") { Visible = mail; }
            field("Delivered via Post"; "Delivered via Post") { Visible = post; }
            field("Reminder sent"; "Reminder sent") { }
            field("Date of sending Reminder"; "Date of Sent Reminder") { }
            field("Type of Report"; "Reminder Report Type") { }
            field("Reminder Type"; "Reminder Type") { }
            field("Customer Posting Group"; "Customer Posting Group") { }
        }


    }

    actions
    {

        modify(SuggestReminderLines)
        {
            Visible = false;
        }
        modify(Issue)
        {
            Visible = true;
        }
        modify(CreateReminders)
        {
            Visible = false;
        }
        modify("Customer - Payment Receipt")
        {
            Visible = false;
        }
        modify("Customer - Trial Balance")
        {
            Visible = false;
        }
        modify("Aged Accounts Receivable")
        {
            Visible = false;
        }
        modify("Report Statement")
        {
            Visible = false;
        }


        modify("&Issuing")
        {
            Visible = false;
        }
        modify("&Reminder")
        {
            Visible = false;
        }
        modify("Co&mments")
        {
            Visible = false;
        }
        modify("C&ustomer")
        {
            Visible = false;
        }
        modify("Dimensions")
        {
            Visible = false;

        }
        modify("F&unctions")
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify(TestReport)
        {
            Visible = false;
        }
        modify(Customer)
        {
            Visible = false;
        }


        addafter("&Reminder")
        {
            action("Reminder Print")
            {
                ApplicationArea = All;
                Caption = 'Reminder Print';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ReminderTest: Report "30DReminder";
                    IssuedAccusationReminder: Report IssuedAccusationReminder;
                    RealReminder: Report RealReminder;
                    CRL: Record "Custom Report Layout";
                    ReportL: Record "Report Layout Selection";
                    CustomerSummaryAging: Report CustomerSummaryAging;

                begin
                    /*    if Rec."Reminder sent" = true then begin
                            if Rec."Reminder Report Type" = "Reminder Report Type"::Custom then begin
                                IssuedAccusationReminder.SetAccusation(Rec."No.");
                                IssuedAccusationReminder.Run();
                                Rec."Reminder Printed" := true;
                                Rec.Modify();
                            end else begin
                                RealReminder.SetParam(Rec."No.");
                                RealReminder.Run();
                                Rec."Reminder Printed" := true;
                                Rec.Modify();
                            end;
                        end else begin*/
                    if Rec."Reminder Report Type" = "Reminder Report Type"::Custom then begin

                        if rec."Reminder Type" = rec."Reminder Type"::"Accusation Reminder" then begin
                            // AccusationReminder.SetAccusation(Rec."No.");
                            //AccusationReminder.Run();

                            crl.Reset();
                            crl.SetFilter("Report ID", '%1', 50155);
                            crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
                            if crl.FindFirst() then begin
                                ReportL.SetTempLayoutSelected(format(CRL.Code));
                                AccusationReminder.SetAccusation(Rec."No.");
                                AccusationReminder.Run();

                            end;


                        end
                        else begin

                            crl.Reset();
                            crl.SetFilter("Report ID", '%1', 50144);
                            crl.SetFilter(Description, '%1', 'Opomena za prekid gasa');
                            if crl.FindFirst() then begin
                                ReportL.SetTempLayoutSelected(format(CRL.Code));
                                AccusationReminder.SetAccusation(Rec."No.");
                                AccusationReminder.Run();

                            end;

                            //ĐK DODAJ WORD
                            //   AccusationReminder.SetAccusation(Rec."No.");
                            //    AccusationReminder.setp
                            //AccusationReminder.Run();

                        end;
                        Rec."Reminder Printed" := true;
                        Rec.Modify();
                    end else begin
                        ReminderTest.SetParam(Rec."No.");
                        ReminderTest.Run();
                        Rec."Reminder Printed" := true;
                        Rec.Modify();
                    end;
                end;
                //     end;
            }
            action("Send Reminder Via Post")
            {
                ApplicationArea = all;
                Caption = 'Send Reminder via Post';
                Visible = post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reminder;
                trigger OnAction()
                var
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    ReminderTest: Report "30DReminder";
                    IssuedReminder: Record "Issued Reminder Header";
                    IssuedReminderLines: Record "Issued Reminder Line";
                    lines: Record "Reminder Line";
                    gls: Record "General Ledger Setup";
                begin
                    //      if Rec."Reminder sent" = false then begin
                    Rec."Date of Sent Reminder" := Today;
                    Rec."Reminder sent" := true;
                    Rec."Delivered via Post" := true;

                    //      issueReminder(Rec);
                    // if Rec."Reminder Report Type" = "Reminder Report Type"::Custom then begin
                    //    AccusationReminder.SetAccusation(Rec."No.");
                    //     AccusationReminder.Run();
                    //  end else begin
                    //       ReminderTest.SetParam(Rec."No.");
                    //         ReminderTest.Run();
                    //       end;
                    CurrPage.Update();
                end;
                //    else
                //          Message('Opomena je već izdana');

                //    end;
            }
            action("Reminder Send")
            {

                ApplicationArea = all;
                Caption = 'Send Reminder via e-mail';
                Visible = mail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Reminder;
                trigger OnAction()
                var
                    Year: Integer;
                    Month: Integer;
                    Recipients: List of [Text];
                    Reminder: Report "AccusationReminder";
                    SMTPMail: Codeunit "SMTP Mail";
                    SMTPSetup: Record "SMTP Mail Setup";
                    Mail: Codeunit Mail;
                    WH: Record "Wage Header";
                    Calc: Record "Wage Calculation";
                    FileManagement: Codeunit "File Management";
                    gls: Record "General Ledger Setup";
                    Customer: Record "Customer";
                    filename: Text;
                    Text001: Label 'Reminder sent.';
                    PathDoc: Text[1000];
                    Encription: Codeunit EncryptPDF;
                    IssuedReminder: Record "Issued Reminder Header";
                    IssuedReminderLine: Record "Issued Reminder Line";
                begin
                    gls.get();

                    //if Rec."Reminder sent" = false then begin
                    if Rec."Reminder Report Type" = "Reminder Report Type"::Custom then begin

                        Reminder.SetAccusation(Rec."No.");
                        Reminder.SetTableView(Rec);
                        Customer.GET(Rec."Customer No.");
                        Clear(Recipients);
                        CLEAR(FileManagement);
                        filename := gls."Export Report Path" + '\' + Customer."Name" + '.pdf';
                        Month := Date2DMY(Today, 2);
                        Year := Date2DMY(Today, 3);
                        Reminder.SAVEASPDF(filename);
                        PathDoc := Encription.EncryptPdfForAccusation(filename, Month, Year, Rec, "Reminder Report Type"::Custom);
                        FileManagement.DownloadToFile(filename, filename);
                        SMTPSetup.GET;
                        Recipients.Add(Customer."E-Mail");
                        SMTPMail.CreateMessage(gls."Send Name e-mail", gls."Send email", Recipients, 'Opomena pred tužbu ' + FORMAT(Month) + '.' + FORMAT(Year), '', TRUE);
                        SMTPMail.AddAttachment(PathDoc, Customer."Name" + '.pdf');
                        // SMTPMail.TrySend();
                        SMTPMail.Send();
                        Rec."Reminder sent" := true;
                        Rec."Delivered via Email" := true;
                        Rec."Date of sent reminder" := Today;
                        Rec."Reminder Printed" := true;
                        Rec.MODIFY;
                        ERASE(filename);
                        CurrPage.Update();

                        //issueReminder(Rec);

                    end
                    else begin
                        Reminder.SetAccusation(Rec."No.");
                        Reminder.SetTableView(Rec);
                        Customer.GET(Rec."Customer No.");
                        Clear(Recipients);
                        CLEAR(FileManagement);
                        filename := gls."Export Report Path" + Customer."Name" + '.pdf';
                        Month := Date2DMY(Today, 2);
                        Year := Date2DMY(Today, 3);
                        Reminder.SAVEASPDF(filename);
                        PathDoc := Encription.EncryptPdfForAccusation(filename, Month, Year, Rec, "Reminder Report Type"::Native);
                        FileManagement.DownloadToFile(filename, filename);
                        SMTPSetup.GET;
                        Recipients.Add(Customer."E-Mail");
                        gls.get();
                        SMTPMail.CreateMessage(gls."Send Name e-mail", gls."Send email", Recipients, 'Opomena pred tužbu ' + FORMAT(Month) + '.' + FORMAT(Year), '', TRUE);
                        filename := gls."Export Report Path" + Customer."Name" + '.pdf';
                        SMTPMail.AddAttachment(PathDoc, Customer."Name" + '.pdf');
                        // SMTPMail.TrySend();
                        SMTPMail.Send();
                        Rec."Reminder sent" := true;
                        Rec."Delivered via Email" := true;
                        Rec."Date of sent reminder" := Today;
                        Rec."Reminder Printed" := true;

                        // issueReminder(Rec);
                        Rec.MODIFY;
                        ERASE(filename);
                        CurrPage.Update();
                    end;
                end; //else begin
                     // Message('Opomena je već poslana');
                     //end;
                     // end;

            }
            action("Unpaid Invoices")
            {
                Caption = 'Unpaid Invoices';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var
                    unpaidInvoices: Report UnpaidInvoices;
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                //
                begin
                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50153);
                    crl.SetFilter(Description, '<>%1', 'Tužbe');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        unpaidInvoices.setPostingDate(Rec."Document Date");
                        unpaidInvoices.setCustomer(Rec."Customer No.");
                        unpaidInvoices.setVisible(true);
                        unpaidInvoices.Run();
                        //  Report.Run(Report::UnpaidInvoices, true, false, cust);

                    end;
                end;

            }
            action(CreateAccusation)
            {
                ApplicationArea = all;
                Caption = 'Create Accusation';
                Visible = true;
                Image = Reminder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    accusation: Record "Accusation Header";
                    accLine: Record "Accusation Line";
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    gls: Record "General Ledger Setup";
                    AD: page "Accusation Document";
                    AH: Record "Accusation Header";
                    lines: Record "Reminder Line";
                    cust: Record Customer;
                    tempLine: Record "Accusation Line";
                    amt: Decimal;
                    interest: Decimal;
                    day: Integer;
                    month: Integer;
                    year: Integer;
                    dateDifference: Integer;
                    firstPart: Decimal;
                    poweredPart: Decimal;
                    finalPart: Decimal;
                    tempAmount: Decimal;
                begin
                    //    if Rec."Created From Reminder" = false then begin
                    gls.get();
                    day := Date2DMY(Today, 1);
                    month := Date2DMY(Today, 2);
                    year := Date2DMY(Today, 3);
                    accusation."No." := NoSeriesMgt.GetNextNo(gls."Accusation Entry Series", TODAY, true);
                    accusation."Customer No." := Rec."Customer No.";
                    cust.get(Rec."Customer No.");
                    accusation."Customer Name" := cust.Name;
                    accusation.Interest := Rec."Interest Amount";
                    // accusation."Date of Accusation" := Today;
                    accusation."Delivered via Email" := Rec."Delivered via email";
                    accusation."Delivered via Post" := Rec."Delivered via Post";
                    accusation.Reminder := ReminderType::"Before the Accusation";
                    accusation."Document Date" := Today;
                    accusation."Document No." := accusation."No.";
                    accusation."Reminder sent" := Rec."Reminder sent";
                    accusation."Reminder No." := Rec."No.";
                    accusation."Date of sent reminder" := Rec."Date of Sent Reminder";
                    accusation.Created := true;
                    accusation."Accusation Referal Person" := UserId;
                    accusation."Way of Delivery" := cust."Way of Sending Reminder";
                    if cust."Customer Category" = Category::Household then begin
                        accusation."Statue of Limitation Date" := DMY2Date(Day, Month, Year + 1);
                    end
                    else begin
                        accusation."Statue of Limitation Date" := DMY2Date(Day, Month, Year + 3);
                    end;
                    accusation.Insert();
                    lines.SetFilter("Reminder No.", '%1', Rec."No.");
                    if lines.FindSet() then
                        repeat
                            tempLine.SetFilter("Document No.", '%1', accusation."No.");
                            if tempLine.FindLast then begin
                                accLine."Line No." := accLine."Line No." + 1
                            end
                            else begin
                                accLine."Line No." := 1;
                            end;
                            accLine."Document No." := accusation."No.";
                            accLine."Accusation Line Type" := AccusationLineType::Debt;
                            accLine."Sales Invoice No." := lines."Document No.";
                            accLine."Date of Debt" := lines."Document Date";
                            accLine."Bill Category" := lines."Bill Category";
                            accLine."Bill type" := lines."Bill type";
                            accLine."Customer Category" := lines."Customer Category";
                            accLine."Due Date" := lines."Due Date";
                            accLine.Description := lines.Description;
                            accLine."Line Amount" := lines."Remaining Amount";
                            accLine."Cust. Ledger Entry No." := lines."Entry No.";
                            amt += lines."Remaining Amount";
                            accLine."Interest Coefficient" := lines."Interest Rate";
                            accLine."Interest Yearly Rate" := 12;
                            if lines."Due Date" > DMY2Date(day, month, year + 1) then begin
                                accLine."Interest Calculation Type" := InterestCalculationType::Standard;
                            end else begin
                                accLine."Interest Calculation Type" := InterestCalculationType::Comfort;
                            end;
                            dateDifference := Today - (lines."Due Date" + 15);
                            accLine."Interest Amount" := CalculateInterest(accLine);
                            interest += accLine."Interest Amount";
                            accLine."Cust. Ledger Entry No." := lines."Entry No.";
                            accLine.Insert();
                        until lines.next = 0;
                    Rec."Created From Reminder" := true;
                    Rec."Reminder sent" := true;
                    //  Rec."Remaining Amount" := amt;
                    Rec.Modify();
                    accusation.Debt := amt;
                    accusation.Interest := interest;
                    accusation.Modify();
                    Message('Tužba je kreirana');
                    Commit();
                    Clear(AD);
                    ah.Reset();
                    ah.SetFilter("No.", '%1', accusation."No.");
                    ad.SetTableView(ah);
                    ad.Run();

                    Commit();
                    //    end

                end;

            }
            action(CustomerBalancetoDate)
            {
                ApplicationArea = all;
                Caption = 'CustomerBalancetoDate';
                Visible = true;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //  RunObject = Report CustomerBalancetoDate;

                trigger OnAction()
                var
                    myInt: Integer;
                    Cust: Record Customer;
                begin
                    cust.Reset();
                    cust.SetFilter("No.", '%1', rec."Customer No.");
                    Report.Run(Report::CustomerBalancetoDate, true, true, cust);

                end;
            }
            action(CustomerDetalTrailBal)
            {
                ApplicationArea = all;
                Caption = 'CustomerDetalTrailBal';
                Visible = true;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //   RunObject = Report CustomerDetalTrailBal;
                trigger OnAction()
                var
                    myInt: Integer;
                    cust: Record Customer;
                begin
                    cust.Reset();
                    cust.SetFilter("No.", '%1', rec."Customer No.");
                    Report.Run(Report::CustomerDetalTrailBal, true, true, cust);

                end;
            }

        }
    }

    trigger OnOpenPage()
    var
        Customer: Record Customer;
    begin
        Customer.GET(Rec."Customer No.");
        if Customer."Way of Sending Reminder" = AccusationDelivery::"Via Email" then begin
            mail := true;
            post := false;
        end
        else
            if Customer."Way of Sending Reminder" = AccusationDelivery::"Via Post Office" then begin
                mail := false;
                post := true;
            end;
    end;

    var
        myInt: Integer;
        ReminderNative: Report "Reminder";
        AccusationReminder: Report AccusationReminder;
        AccusationReminder_Issued: Report AccusationReminder;
        mail: Boolean;
        post: Boolean;

    procedure issueReminder(Reminder: Record "Reminder Header")
    var
        NoSeriesMgt: Codeunit NoSeriesExtented;
        ReminderTest: Report "30DReminder";
        IssuedReminder: Record "Issued Reminder Header";
        IssuedReminderLines: Record "Issued Reminder Line";
        lines: Record "Reminder Line";
        gls: Record "General Ledger Setup";
    begin
        gls.get();
        IssuedReminder."No." := NoSeriesMgt.GetNextNo(gls."Issued Reminder Entry Series", TODAY, true);
        IssuedReminder."Customer No." := Reminder."Customer No.";
        IssuedReminder."Interest Amount" := Reminder."Interest Amount";
        IssuedReminder."Remaining Amount" := Reminder."Remaining Amount";
        IssuedReminder."Reminder Level" := Reminder."Reminder Level";
        IssuedReminder.Address := Reminder.Address;
        IssuedReminder."Address 2" := Reminder."Address 2";
        IssuedReminder."Post Code" := Reminder."Post Code";
        IssuedReminder."Posting Date" := Today;
        IssuedReminder."City" := Reminder.City;
        IssuedReminder."Document Date" := Reminder."Document Date";
        IssuedReminder.Insert();
        Reminder."Issued Reminder No." := IssuedReminder."No.";
        Reminder.Modify();
        lines.SetFilter("Document No.", '%1', Reminder."No.");
        if lines.FindSet() then
            repeat
                IssuedReminderLines.Reset();
                IssuedReminderLines."No." := NoSeriesMgt.GetNextNo(gls."Issued Reminder Line Entry Series", TODAY, true);
                IssuedReminderLines."Document Date" := IssuedReminder."Posting Date";
                IssuedReminderLines.Amount := lines.Amount;
                IssuedReminderLines."Original Amount" := lines."Original Amount";
                IssuedReminderLines."Document No." := lines."Document No.";
                IssuedReminderLines.Description := lines.Description;
                IssuedReminderLines."Document Type" := lines."Document Type";
                IssuedReminderLines."Interest Rate" := lines."Interest Rate";
                IssuedReminderLines."Due Date" := lines."Due Date";
                IssuedReminderLines."No. of Reminders" := lines."No. of Reminders";
                IssuedReminderLines.Type := lines.Type;
                IssuedReminderLines.insert();
            until lines.next = 0;
    end;


    local procedure CalculateInterest(accLine: Record "Accusation Line"): Decimal;
    var
        amount: Decimal;
        saleInvoice: Record "Sales Invoice Header";
        dateDifference: Integer;
        firstPart: Decimal;
        poweredPart: Decimal;
        gls: Record "General Ledger Setup";
        finalPart: Decimal;
    begin
        gls.get();
        dateDifference := Today - (accLine."Due Date" + gls."Number of Days Necessary before Interest Calculation");
        if dateDifference > 0 then begin
            if accLine."Interest Calculation Type" = InterestCalculationType::Standard then begin
                amount := gls."Interest Yearly Rate" * accLine."Line Amount" * dateDifference / 36500;
            end else
                if accLine."Interest Calculation Type" = InterestCalculationType::Comfort then begin
                    firstPart := 1 + (gls."Interest Yearly Rate" / 100);
                    poweredPart := Power(firstPart, (dateDifference / 365));
                    finalPart := poweredPart - 1;
                    amount := finalPart * accLine."Line Amount";
                end;
        end;
        exit(amount);
    end;


}