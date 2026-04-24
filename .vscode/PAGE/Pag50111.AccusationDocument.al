page 50111 "Accusation Document"
{
    Caption = 'Accusation Document';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Accusation Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Bill Category"; "Bill Category") { ApplicationArea = All; }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                    //   Editable = false;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Document No."; "Document No.")
                {
                    Caption = 'Document No.';
                    // Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    Caption = 'Document Date';
                    //Editable = false;
                    ApplicationArea = All;
                }
                field("Balance (LCY)"; "Balance (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customer''s balance.';

                    trigger OnDrillDown()
                    begin
                        OpenCustomerLedgerEntries(false);
                    end;
                }
                field(Description; Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field(Debt; Debt)
                {
                    Caption = 'Debt';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Interest; Interest)
                {
                    Caption = 'Interest';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field("Reminder sent"; "Reminder sent")
                {
                    Caption = 'Send reminder';
                    Visible = post;
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        customer: Record Customer;
                    begin
                        if "Reminder sent" = true then begin
                            "Date of sent reminder" := Today();
                        end;
                        customer.SetFilter("No.", '%1', Rec."Customer No.");
                        if customer.FindFirst() then begin
                            if customer."Way of Sending Reminder" = AccusationDelivery::"Via Email" then begin
                                "Delivered via Email" := true;
                            end else
                                if customer."Way of Sending Reminder" = AccusationDelivery::"Via Post Office" then begin
                                    "Delivered via Post" := true;
                                end;
                        end;
                    end;
                }

                field("Date of sent reminder"; "Date of sent reminder")
                {
                    Caption = 'Date of sent reminder';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Way of Delivery"; "Way of Delivery") { ApplicationArea = All; Editable = false; }
                field("Delivered via Email"; "Delivered via Email")
                {
                    Caption = 'Delivered via Email';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = mail;

                }
                field("Delivered via Post"; "Delivered via Post")
                {
                    Caption = 'Delivered via Post';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = post;
                }
                field(Reminder; Reminder) { Caption = 'Reminder'; ApplicationArea = All; Editable = false; }
                field("Reminder No."; "Reminder No.") { Caption = 'Reminder No.'; ApplicationArea = All; Editable = false; }

                field("Reprogrammed Debt"; "Reprogrammed Debt")
                {
                    ApplicationArea = All;
                }
                field("Reprogrammed Debt Date"; "Reprogrammed Debt Date") { }
                field("Debt paid under 10 days"; "Debt paid under 10 days")
                {
                    ApplicationArea = All;
                }
                field("Statue of Limitation Date"; "Statue of Limitation Date")
                {
                    Caption = 'Statue of Limitiation Date';
                    ApplicationArea = All;
                }
                field(Created; Created)
                {
                    Caption = 'Created';
                    ApplicationArea = All;
                    Editable = false;
                }


                field("Accusation Type"; "Accusation Type")
                {
                    Caption = 'Accusation Type';
                    ApplicationArea = All;
                    Lookup = true;
                    DrillDown = true;


                    /*                  trigger OnDrillDown()
                                      var
                                          us: Record "User Setup";
                                          entries: Page Territories;
                                      begin
                                          us.reset();
                                          us.SetFilter("User ID", '%1', UserId);

                                          if us.FindFirst() then begin
                                              us."Accusation No." := "No.";
                                              us."Accusation Record" := AccusationRecordType::"Accusation Type";
                                              us.Modify();
                                          end;
                                          accRecords.Reset();
                                          accRecords.SetFilter(Accusation, '%1', "No.");
                                          accRecords.SetFilter(Type, '%1', AccusationRecordType::"Accusation Type");
                                          entries.SETTABLEVIEW(accRecords);
                                          entries.RUN;
                                          CurrPage.UPDATE(true);


                                      end;
                  */
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        us: Record "User Setup";
                        entries: Page "Territories";
                        entry: Record Territory;
                    begin


                        us.reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Accusation No." := "No.";
                            us."Accusation Record" := AccusationRecordType::"Accusation Type";
                            us."Accusation Type" := rec."Current Accusation Type";
                            us.Modify();
                        end;
                        accRecords.Reset();
                        accRecords.SetFilter(Accusation, '%1', "No.");
                        accRecords.SetFilter(Type, '%1', AccusationRecordType::"Accusation Type");
                        entries.SetTableView(accRecords);
                        Commit();
                        entries.LOOKUPMODE(TRUE);
                        IF entries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            entries.GETRECORD(entry);
                            "Accusation Type" := entry.Code;
                            "Current Accusation Type" := entry."Accusation Type";
                            us.reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                us."Accusation No." := "No.";
                                us."Accusation Record" := AccusationRecordType::"Accusation Type";
                                us."Accusation Type" := rec."Current Accusation Type";
                                us.Modify();
                            end;
                        end;
                        Commit();
                        CurrPage.UPDATE;


                    end;
                }
                field("Current Accusation Type"; "Current Accusation Type")
                {
                    Caption = 'Current Accusation Type';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field("Accusation Status"; "Accusation Status")
                {
                    Caption = 'Accusation Status';
                    ApplicationArea = All;
                    Lookup = true;
                    DrillDown = true;
                    /*                    trigger OnDrillDown()
                                        var
                                            us: Record "User Setup";
                                            entries: Page "Territories";

                                        begin
                                            us.reset();
                                            us.SetFilter("User ID", '%1', UserId);
                                            if us.FindFirst() then begin
                                                us."Accusation No." := "No.";
                                                us."Accusation Record" := AccusationRecordType::"Accusation Status";
                                                us.Modify();
                                            end;
                                            accRecords.Reset();
                                            accRecords.SetFilter(Accusation, '%1', "No.");
                                            accRecords.SetFilter(Type, '%1', AccusationRecordType::"Accusation Status");

                                            entries.SETTABLEVIEW(accRecords);
                                            entries.RUN;
                                            CurrPage.UPDATE(true);

                                        end;
                    */
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        us: Record "User Setup";
                        entries: Page "Territories";
                        entry: Record Territory;
                    begin
                        us.reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Accusation No." := "No.";
                            us."Accusation Record" := AccusationRecordType::"Accusation Status";
                            us.Modify();
                        end;
                        accRecords.Reset();
                        accRecords.SetFilter(Accusation, '%1', "No.");
                        accRecords.SetFilter(Type, '%1', AccusationRecordType::"Accusation Status");
                        entries.SetTableView(accRecords);
                        Commit();
                        entries.LOOKUPMODE(TRUE);
                        IF entries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            entries.GETRECORD(entry);
                            "Accusation Status" := entry.Code;
                            "Status" := entry.Status;
                        end;
                        Commit();
                        CurrPage.UPDATE;
                    end;
                }
                field(Status; Status)
                {
                    Caption = 'Current Accusation Status';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }



                field("Court number"; Rec."Court number")
                {
                    Caption = 'Court Number';
                    ApplicationArea = All;

                    Lookup = true;
                    DrillDown = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        us: Record "User Setup";
                        entries: Page Territories;
                        entry: Record Territory;
                    begin
                        us.reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Accusation No." := "No.";
                            us."Accusation Record" := AccusationRecordType::MALS;
                            us.Modify();
                        end;
                        accRecords.Reset();
                        accRecords.SetFilter(Accusation, '%1', "No.");
                        accRecords.SetFilter(Type, '%1', AccusationRecordType::"MALS");
                        entries.SetTableView(accRecords);
                        Commit();
                        entries.LOOKUPMODE(TRUE);
                        IF entries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            entries.GETRECORD(entry);
                            "Court Number" := entry.Code;
                            "Actual Court Number" := entry.MALS;
                        end;
                        Commit();
                        CurrPage.UPDATE;

                    end;
                    /*
                                        trigger OnDrillDown()
                                        var
                                            us: Record "User Setup";

                                            entries: Page "Territories";
                                            entry: Record Territory;
                                        begin
                                            us.reset();
                                            us.SetFilter("User ID", '%1', UserId);
                                            if us.FindFirst() then begin
                                                us."Accusation No." := "No.";
                                                us."Accusation Record" := AccusationRecordType::MALS;
                                                us.Modify();
                                            end;
                                            accRecords.Reset();
                                            accRecords.SetFilter(Accusation, '%1', "No.");
                                            accRecords.SetFilter(Type, '%1', AccusationRecordType::"Trial");
                                            entries.SetTableView(accRecords);
                                            Commit();
                                            entries.LOOKUPMODE(TRUE);
                                            IF entries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                                entries.GETRECORD(entry);
                                                "Hearing" := entry.Code;

                                            end;
                                            Commit();
                                            CurrPage.UPDATE;
                                            //  end;

                                        end;
                    */

                }
                field("Actual Court Number"; "Actual Court Number")
                {
                    Editable = false;
                }
                field("Hearing"; Hearing)
                {
                    Caption = 'Hearing';
                    ApplicationArea = All;
                    Lookup = true;
                    DrillDown = true;
                    /*                    trigger OnDrillDown()
                                        var
                                            us: Record "User Setup";
                                            entries: Page Territories;
                                        begin
                                            us.reset();
                                            us.SetFilter("User ID", '%1', UserId);
                                            if us.FindFirst() then begin
                                                us."Accusation No." := "No.";
                                                us."Accusation Record" := AccusationRecordType::Trial;
                                                us.Modify();
                                            end;
                                            accRecords.Reset();
                                            accRecords.SetFilter(Accusation, '%1', "No.");
                                            accRecords.SetFilter(Type, '%1', AccusationRecordType::"Trial");

                                            entries.SETTABLEVIEW(accRecords);
                                            entries.RUN;
                                            CurrPage.UPDATE(true);


                                        end;
                    */
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        us: Record "User Setup";
                        entries: Page "Territories";
                        entry: Record Territory;

                    begin
                        us.reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Accusation No." := "No.";
                            us."Accusation Record" := AccusationRecordType::"Trial";
                            us.Modify();
                        end;

                        accRecords.SetFilter(Accusation, '%1', "No.");
                        accRecords.SetFilter(Type, '%1', AccusationRecordType::"Trial");
                        entries.SetTableView(accRecords);
                        Commit();
                        entries.LOOKUPMODE(TRUE);
                        IF entries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            entries.GETRECORD(entry);
                            "Hearing" := entry.Code;
                            "Actual Hearing" := entry.Code;

                        end;
                        Commit();
                        CurrPage.UPDATE;

                    end;
                }
                field("Actual Hearing"; "Actual Hearing")
                {
                    Caption = 'Actual Hearing';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;

                }
                field("IP"; "IP")
                {
                    Caption = 'IP';
                    ApplicationArea = All;
                    Lookup = true;
                    DrillDown = true;


                    /*        trigger OnDrillDown()
                            var
                                us: Record "User Setup";
                                entries: Page Territories;
                            begin
                                us.reset();
                                us.SetFilter("User ID", '%1', UserId);

                                if us.FindFirst() then begin
                                    us."Accusation No." := "No.";
                                    us."Accusation Record" := AccusationRecordType::"IP";
                                    us.Modify();
                                end;
                                accRecords.Reset();
                                accRecords.SetFilter(Accusation, '%1', "No.");
                                accRecords.SetFilter(Type, '%1', AccusationRecordType::"IP");
                                entries.SETTABLEVIEW(accRecords);
                                entries.RUN;
                                CurrPage.UPDATE(true);


                            end;
        */
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        us: Record "User Setup";
                        entries: Page "Territories";
                        entry: Record Territory;

                    begin
                        us.reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Accusation No." := "No.";
                            us."Accusation Record" := AccusationRecordType::"IP";
                            us.Modify();
                        end;
                        accRecords.SetFilter(Accusation, '%1', "No.");
                        accRecords.SetFilter(Type, '%1', AccusationRecordType::"IP");
                        entries.SetTableView(accRecords);
                        Commit();
                        entries.LOOKUPMODE(TRUE);
                        IF entries.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            entries.GETRECORD(entry);
                            "IP" := entry.Code;
                            "Current IP" := entry.IP;
                        end;
                        Commit();
                        CurrPage.UPDATE;


                    end;
                }
                field("Current IP"; "Current IP")
                {
                    Caption = 'Current IP';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field("Date of Accusation"; "Date of Accusation")
                {
                    Caption = 'Datum tužbe';
                    ApplicationArea = All;
                }


                // field("Interest given by Court Order"; "Interest given by Court Order") { Caption = 'Interest given by Court Order'; ApplicationArea = All; }
                field("Date of Interest Payment"; "Date of Interest Payment") { Caption = 'Date of Interest Payment'; }
                field("Court Number Record"; "Court Number Record") { }

                field("Court Expenses Payment Date"; "Court Expenses Payment Date") { }
                field("Court Expenses Amount"; "Court Expenses Amount") { Caption = 'Court Expenses Amount'; }
                field("Court Expenses Amt - Transfer"; Rec."Court Expenses Amt - Transfer") { ApplicationArea = All; }
                field("Court Expenses Amount Paid"; "Court Expenses Amount Paid") { }
                field("Court Expenses Amt Paid - Tr"; Rec."Court Expenses Amt Paid - Tr") { ApplicationArea = All; }
                field("Interest paid amount"; "Interest amount paid") { ApplicationArea = All; }
                field("Ineterst amount paid - Transfer"; "Interest amount paid-Transfer") { ApplicationArea = All; }
                field("Only debt paid"; "Only debt paid")
                {
                    Caption = 'Only debt paid';
                }
                field("Debt and court expenses paid"; "Debt and court expenses paid")
                {
                    Caption = 'Debt and court expenses paid';
                }
                field("Appealed for interest withdrawal"; "Appealed for interest withdrawal")
                {
                    Caption = 'Appealed for interest withdrawal';
                    trigger OnValidate()
                    begin
                        "Date of Appeal for withdrawal" := Today;
                    end;
                }
                field("Date of Appeal for withdrawal"; "Date of Appeal for withdrawal")
                {
                    Caption = 'Date of Appeal for withdrawal';
                }
                field(Withdrawn; Withdrawn) { Caption = 'Withdrawn'; ApplicationArea = All; }
                field("Date of Withdrawal"; "Date of Withdrawal")
                {
                    Caption = 'Date of Withdrawal';
                    ApplicationArea = All;
                }
                field("Archived status"; "Archive")
                {
                    Caption = 'Archived status';
                    Editable = true;
                    trigger OnValidate()
                    begin
                        "Archive date" := Today;
                    end;
                }
                field("Archive date"; "Archive date")
                {
                    Caption = 'Archive date';
                    ApplicationArea = All;
                }
                field("Accusation Referal Person"; "Accusation Referal Person")
                {
                    Caption = 'Accusation Referal Person';
                    ApplicationArea = All;
                    Editable = False;
                }

                field(Note; Rec.Note)
                {
                    Caption = 'Note';
                    ApplicationArea = All;
                }
            }

            part("Accusation Line"; "Accusation Line")
            {

                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }

        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Att. Det. FactBox")
            {
                Visible = true;
                ApplicationArea = All;

                Caption = 'Attachments';
                Editable = True;

                SubPageLink = "Table ID" = CONST(50068),
                              "No." = FIELD("Document No."),
                               Information = filter(false);

            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {

        area(Navigation)
        {
            action("Accusation Rewiew")
            {
                Caption = 'Accusation Rewiew';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var
                    AccusationRe: Report "Accusation Report";
                    AccH: Record "Accusation Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                begin

                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50090);
                    crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        AccH.Reset();
                        AccH.SetFilter("No.", '%1', rec."No.");
                        Report.Run(Report::"Accusation Report", true, true, AccH);


                    end;
                end;
            }

            action("Accusation Reminder")
            {
                Caption = 'Accusation Reminder';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var
                    reminder: Report IssuedAccusationReminder;
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";

                begin
                    //  reminder.SetAccusation(Rec."Reminder No.");
                    //reminder.Run();

                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50155);
                    crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        reminder.SetAccusation(Rec."Reminder No.");
                        reminder.Run();

                    end;
                end;
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
            action("Interest Rates")
            {
                Caption = 'Interest Rates';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var
                    aiReport: Report AccusationInterestReport;
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";

                begin
                    // aiReport.SetAccusation(Rec."No.");
                    //   aiReport.Run();

                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50146);
                    crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        aiReport.SetAccusation(Rec."No.");
                        aiReport.Run();
                        //  Report.Run(Report::UnpaidInvoices, true, false, cust);

                    end;
                end;


            }



            action("Calculate Interest Rates")
            {
                Caption = 'Calculate Interest Rates';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var
                    aiReport: Report "Calculate Report";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";

                begin
                    // aiReport.SetAccusation(Rec."No.");
                    //   aiReport.Run();

                    aiReport.Setparam(rec."Document No.");
                    aiReport.Run();
                    //  Report.Run(Report::UnpaidInvoices, true, false, cust);

                end;



            }


            action("Archive")
            {
                Caption = 'Archive';

                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Archive;
                trigger OnAction()
                var
                    accStatus: Record Territory;
                    gls: Record "General Ledger Setup";
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    AccLine: Record "Accusation Line";

                begin
                    Rec.Archive := true;
                    Rec."Archive date" := Today;
                    Rec.Modify();
                    AccLine.Reset();
                    AccLine.SetFilter("Document No.", '%1', rec."No.");
                    if AccLine.FindSet() then
                        repeat
                            AccLine.Archived := true;
                            AccLine.Modify();
                        until AccLine.Next() = 0;

                    gls.Get();
                    if gls.FindFirst() then begin
                        accStatus."Archived Date" := Today();
                        accStatus.Status := AccusationStatus::"Archived";
                        accStatus.Code := NoSeriesMgt.GetNextNo(gls."Status Entry Series", TODAY, true);
                        accStatus.Insert();
                        //   end

                    end
                end;
            }



            action("Withdraw Accusation")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Cancel;
                trigger OnAction()
                var
                    accStatus: Record Territory;
                    gls: Record "General Ledger Setup";
                    NoSeriesMgt: Codeunit NoSeriesExtented;

                begin
                    Rec.Withdrawn := true;
                    Rec."Date of Withdrawal" := Today;
                    Rec.Modify();
                    gls.Get();
                    if gls.FindFirst() then begin
                        //   if countRecordsForAutoInsert(Rec."No.", AccusationRecordType::"Accusation Status") = 0 then begin
                        accStatus.Accusation := Rec."No.";
                        accStatus.Type := AccusationRecordType::"Accusation Status";
                        accStatus.Date := Today();
                        accStatus.Status := AccusationStatus::"End Accusation";
                        accStatus.Code := NoSeriesMgt.GetNextNo(gls."Status Entry Series", TODAY, true);
                        accStatus."Document No." := accStatus.Code;
                        accStatus.Insert();
                        //   end

                    end
                end;
            }

            action("Accusation Print")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                var
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Cust: Record "Cust. Ledger Entry";
                    unpaidInvoices: Report UnpaidInvoices;
                    AccLine: Record "Accusation Line";
                    TotalAmtPaid: Decimal; //"Amount Paid - Transfer"
                    TotalAmtDebt: Decimal; //Debt Amount - Transfer
                    TotalInterestAmt: Decimal; //Interest Amount - Transfer
                    OldSalesInvNo: Code[20];
                    OldDate: Date;
                begin
                    TotalAmtPaid := 0;
                    TotalAmtDebt := 0;
                    TotalInterestAmt := 0;
                    AccLine.Reset();
                    AccLine.SetFilter("Document No.", '%1', Rec."No.");
                    if AccLine.FindSet() then
                        repeat
                            TotalAmtPaid += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                            TotalAmtDebt += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                            TotalInterestAmt += AccLine."Interest Amount" + AccLine."Interest Amount - Transfer";
                            OldSalesInvNo := AccLine."Sales Invoice No. - Transfer";
                            OldDate := AccLine."Date - Transfer";
                        until AccLine.Next() = 0;

                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50153);
                    crl.SetFilter(Description, '%1', 'Tužbe');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        cust.Reset();
                        cust.SetFilter(Open, '%1', true);
                        cust.SetFilter("Document Type", '%1', cust."Document Type"::Invoice);
                        unpaidInvoices.setPostingDate(Rec."Document Date");
                        unpaidInvoices.setCustomer(Rec."Customer No.");
                        unpaidInvoices.setTotalAmt(TotalAmtPaid, TotalAmtDebt, TotalInterestAmt, OldSalesInvNo, OldDate);
                        unpaidInvoices.SetAccusation(Rec."No.");
                        unpaidInvoices.setVisible(true);
                        unpaidInvoices.Run();
                        //  Report.Run(Report::UnpaidInvoices, true, false, cust);

                    end;


                end;
            }

            action("Submission to the Court")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Report;
                trigger OnAction()
                var
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    AccH: Record "Accusation Header";
                begin
                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50090);
                    crl.SetFilter(Description, '%1', 'Podnesak tužitelju');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        AccH.Reset();
                        AccH.SetFilter("No.", '%1', rec."No.");
                        Report.Run(Report::"Accusation Report", true, false, AccH);

                    end;


                end;
            }

            action("Azuriraj kupca")
            {

                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var

                    Cust: Record "Customer";
                    AH: Record "Accusation Header";
                    MAL: Record Territory;
                    AL: Record "Accusation Line";

                begin
                    // aiReport.SetAccusation(Rec."No.");
                    //   aiReport.Run();

                    AH.Reset();
                    AH.SetFilter("No.", '<>%1', '');
                    if AH.FindFirst() then
                        repeat
                            AH.validate("Accusation Status", AH."No.");
                            Cust.SetFilter("No.", '%1', AH."Customer No.");
                            if cust.FindFirst() then begin
                                AH."Customer Name" := Cust.Name;
                                MAL.SETFILTER(Code, '%1', AH."No.");
                                MAL.SETFILTER(Type, '%1', MAL.Type::MALS);
                                IF MAL.Findfirst then
                                    AH.validate("Court number", AH."No.")
                                ELSE
                                    AH."Court Number" := '';

                                AL.Reset;
                                AL.SETFILTER("Document No.", '%1', AH."No.");
                                IF AL.FINDfirst then
                                    repeat
                                        AL.VALIDATE("Bill Category", Cust."Customer Category");
                                        AL.MODIFY;
                                    until al.next = 0;



                                AH.Modify();
                            end;
                        until ah.next = 0;

                end;


            }


            action("History")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Calls;
                trigger OnAction()
                var
                    us: Record "User Setup";
                    entries: Page Territories;
                begin
                    us.reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us."Accusation No." := Rec."No.";
                        us."Accusation Record" := AccusationRecordType::History;
                        us.Modify();
                    end;
                    accRecords.Reset();
                    accRecords.SetFilter(Accusation, '%1', "No.");
                    accRecords.SetFilter(Type, '%1', AccusationRecordType::"History");
                    entries.SETTABLEVIEW(accRecords);
                    entries.RUN;
                end;
            }

            action(ImportAccusationDocumentEE)
            {
                ApplicationArea = all;
                Caption = 'Import Accusation Document EE';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportServiceItem: XmlPort "ImportTuzbeSaGas";

                begin
                    ImportServiceItem.RUN;
                end;
            }
            action(ImportAccusationDocumentEE2)
            {
                ApplicationArea = all;
                Caption = 'Import Accusation Document EE2';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportServiceItem: XmlPort "SudskiTroškovi";

                begin
                    ImportServiceItem.RUN;
                end;
            }

        }
    }
    trigger OnOpenPage()
    var
        lastHearing: Record Territory;
        lastStatus: Record Territory;
        lastType: Record Territory;
        lastCourtNumber: Record Territory;
        lastIP: Record Territory;
        customer: Record Customer;
    begin
        lastHearing.SetFilter(Accusation, '%1', "No.");
        lastHearing.SetFilter(Type, '%1', lastHearing.Type::Trial);
        if lastHearing.FindLast() then begin
            Rec."Actual Hearing" := lastHearing.Code;
            // Rec.Modify();
        end;
        lastCourtNumber.SetFilter(Accusation, '%1', "No.");
        lastCourtNumber.SetFilter(Type, '%1', lastCourtNumber.Type::MALS);
        if lastCourtNumber.FindLast() then begin
            Rec."Court number" := lastCourtNumber.Code;
            Rec."Actual Court Number" := lastCourtNumber."MALS";
            //Rec.Modify();
        end;
        lastStatus.SetFilter(Accusation, '%1', "No.");
        lastStatus.SetFilter(Type, '%1', lastStatus.Type::"Accusation Status");
        if lastStatus.FindLast() then begin
            Rec.Status := lastStatus.Status;
            Rec."Accusation Status" := lastStatus.Code;
            //Rec.Modify();
        end;
        lastType.SetFilter(Accusation, '%1', "No.");
        lastType.SetFilter(Type, '%1', lastType.Type::"Accusation Type");
        if lastType.FindLast() then begin
            Rec."Current Accusation Type" := lastType."Accusation Type";
            Rec."Accusation Type" := lastType.Code;
            // Rec.Modify();
        end;
        if lastIP.FindLast() then begin
            Rec."Current IP" := lastIP.IP;
            Rec.IP := lastIP.Code;
            //  Rec.Modify();
        end;
        customer.SetFilter("No.", '%1', Rec."Customer No.");
        if customer.FindFirst() then begin
            if customer."Way of Sending Reminder" = AccusationDelivery::"Via Email" then begin
                post := false;
                mail := true;
            end else
                if customer."Way of Sending Reminder" = AccusationDelivery::"Via Post Office" then begin
                    post := true;
                    mail := false;
                end;
        end else begin
            post := false;
            mail := false;
        end;

    end;

    var
        accRecords: Record Territory;
        post: Boolean;
        mail: Boolean;

    procedure countRecordsForAutoInsert(accusation: Code[20]; recordType: Enum AccusationRecordType): Integer;
    var
        acc: Record "Accusation Header";
        cnt: Integer;
        acRecord: Record Territory;
    begin
        acRecord.SetFilter(Accusation, '%1', accusation);
        acRecord.SetFilter(Type, '%1', recordType);
        if acc.FindSet() then repeat cnt += 1; until acc.next = 0;
        exit(cnt);
    end;

    procedure OpenCustomerLedgerEntries(FilterOnDueEntries: Boolean)
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        cust: Record Customer;
    begin
        cust.get(Rec."Customer No.");
        DetailedCustLedgEntry.SetRange("Customer No.", "Customer No.");
        CopyFilter("Global Dimension 1 Filter", DetailedCustLedgEntry."Initial Entry Global Dim. 1");
        CopyFilter("Global Dimension 2 Filter", DetailedCustLedgEntry."Initial Entry Global Dim. 2");
        if FilterOnDueEntries and (GetFilter("Date Filter") <> '') then begin
            CopyFilter("Date Filter", DetailedCustLedgEntry."Initial Entry Due Date");
            DetailedCustLedgEntry.SetFilter("Posting Date", '<=%1', Rec."Document Date");
        end;
        CopyFilter("Currency Filter", DetailedCustLedgEntry."Currency Code");
        CustLedgerEntry.DrillDownOnEntries(DetailedCustLedgEntry);
    end;

    procedure DrillDownOnEntries(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        DrillDownPageID: Integer;
    begin
        CustLedgEntry.Reset();
        DtldCustLedgEntry.CopyFilter("Customer No.", CustLedgEntry."Customer No.");
        DtldCustLedgEntry.CopyFilter("Currency Code", CustLedgEntry."Currency Code");
        DtldCustLedgEntry.CopyFilter("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
        DtldCustLedgEntry.CopyFilter("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
        DtldCustLedgEntry.CopyFilter("Initial Entry Due Date", CustLedgEntry."Due Date");
        CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
        CustLedgEntry.SetRange(Open, true);
        //OnBeforeDrillDownEntries(CustLedgEntry, DtldCustLedgEntry, DrillDownPageID);
        PAGE.Run(DrillDownPageID, CustLedgEntry);
    end;
}