report 50123 "Reprogramming of debt"
{
    Caption = 'Reprogramming of debt';
    // Reprogram duga
    // Na kartici kupca i popisu kupaca, funkcija za prenos iznosa salda u opštu temeljnicu
    ProcessingOnly = true;
    ShowPrintStatus = false;
    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.") { }

            trigger OnPreDataItem()
            begin
                // Saznaj jel odabran samo jedan kupac ili više njih
                CustCount := 0;
                ProcessedCustomerIDs := '';
                NumberOfRowsCreated := 0;

                if Customer.FindSet() then
                    repeat
                        CustCount := CustCount + 1;
                    until Customer.Next() = 0;

                if CustCount = 1 then begin
                    Response := Confirm(Label001, false, "No.", "Name");
                end
                else
                    if CustCount > 1 then
                        Response := Confirm(Label002);
            end;

            trigger OnAfterGetRecord()
            var
                CalculatedDate: Date;
                TotalAmount: Decimal;
                AmountPerLine: Decimal;
                Remainder: Decimal;
                i: Integer;
                LineNo: Integer;
            begin
                // Prije svega, provjeri ima li vec postojećih zapisa u tabeli Opšteg naloga za knjiženje (Gen. Journal Line)
                GenJrnlLine.Reset();
                GenJrnlLine.SetRange("Journal Template Name", 'OPŠTE');
                GenJrnlLine.SetRange("Journal Batch Name", 'OPŠTE');
                GenJrnlLine.SetRange("Document No.", NumberOfDecision);
                GenJrnlLine.SetRange("Account No.", Customer."No.");
                if GenJrnlLine.FindFirst() then begin
                    if CustCount = 1 then
                        Error(Label004, Customer."No.", NumberOfDecision);
                    if UnprocessedCustomerIDs = '' then
                        UnprocessedCustomerIDs := Format(Customer."No.")
                    else
                        UnprocessedCustomerIDs += ', ' + Format(Customer."No.");
                end else begin
                    Customer.SetRange("Date Filter", WorkDate()); //ovo je za korektan izračun salda
                    Customer.CalcFields("Balance Due (LCY)", "Prepayment (LCY)");
                    TotalAmount := Customer."Balance Due (LCY)" - Customer."Prepayment (LCY)";
                    if TotalAmount > 0 then begin
                        AmountPerLine := Round(TotalAmount / NumberOfMonths, 1, '<');
                        Remainder := TotalAmount - (AmountPerLine * (NumberOfMonths - 1));

                        if Response then begin
                            if ProcessedCustomerIDs = '' then
                                ProcessedCustomerIDs := Format(Customer."No.")
                            else
                                ProcessedCustomerIDs += '|' + Format(Customer."No.");

                            // Pronađi najveći Line No u tabeli Gen Journal Line zato što je primarni ključ kombinacija: journal template name + journal batch name + line no
                            GenJrnlLine.Reset();
                            GenJrnlLine.SetRange("Journal Template Name", 'OPŠTE');
                            GenJrnlLine.SetRange("Journal Batch Name", 'OPŠTE');
                            if GenJrnlLine.FindLast() then
                                LineNo := GenJrnlLine."Line No." + 1
                            else
                                LineNo := 10000;

                            //Započni insertovanje za ovog kupca
                            for i := 1 to NumberOfMonths do begin
                                GenJrnlLine.Init();
                                GenJrnlLine.Validate("Journal Template Name", 'OPŠTE');
                                GenJrnlLine.Validate("Journal Batch Name", 'OPŠTE');
                                GenJrnlLine.Validate("Document No.", NumberOfDecision);
                                GenJrnlLine.Validate("Line No.", LineNo);
                                GenJrnlLine.Validate("Account Type", GenJrnlLine."Account Type"::Customer);
                                GenJrnlLine.Validate("Account No.", Customer."No.");
                                GenJrnlLine.Validate("Posting Date", Today());
                                if i = 1 then
                                    GenJrnlLine.Validate("Due Date", DateStartPayment)
                                else
                                    GenJrnlLine.Validate("Due Date", CalcDate(Period, DateStartPayment));

                                if i < NumberOfMonths then
                                    GenJrnlLine.Validate(Amount, AmountPerLine)
                                else
                                    GenJrnlLine.Validate(Amount, Remainder);

                                GenJrnlLine.Insert();

                                if i <> 1 then
                                    DateStartPayment := CalcDate(Period, DateStartPayment);
                                LineNo := LineNo + 1;
                                NumberOfRowsCreated += 1;
                            end;

                            // Insertuj sumarni redak na kraju:
                            GenJrnlLine.Init();
                            GenJrnlLine.Validate("Journal Template Name", 'OPŠTE');
                            GenJrnlLine.Validate("Journal Batch Name", 'OPŠTE');
                            GenJrnlLine.Validate("Document No.", NumberOfDecision);
                            GenJrnlLine.Validate("Line No.", LineNo);
                            GenJrnlLine.Validate("Account Type", GenJrnlLine."Account Type"::Customer);
                            GenJrnlLine.Validate("Account No.", Customer."No.");
                            GenJrnlLine.Validate("Posting Date", Today());
                            GenJrnlLine.Validate("Due Date", CalcDate(Period, DateStartPayment));
                            GenJrnlLine.Validate("Credit Amount", TotalAmount);
                            GenJrnlLine.Insert();
                            NumberOfRowsCreated += 1;

                        end;
                    end else begin
                        if UnprocessedCustomerIDs = '' then
                            UnprocessedCustomerIDs := Format(Customer."No.")
                        else
                            UnprocessedCustomerIDs += ', ' + Format(Customer."No.");
                    end;
                end;
            end;

            trigger OnPostDataItem()

            begin

                if CustCount = 1 then
                    OpenGenJnlLine := Confirm(Label005, false, NumberOfRowsCreated)
                else begin
                    Message('Neprocesirani kupci: ' + UnprocessedCustomerIDs);
                    OpenGenJnlLine := Confirm(Label005, false, NumberOfRowsCreated);
                end;

                if OpenGenJnlLine then begin
                    Clear(GenJrnlLine);
                    GenJrnlLine.SetRange("Document No.", NumberOfDecision);
                    GenJrnlLine.SetRange("Journal Template Name", 'OPŠTE');
                    GenJrnlLine.SetRange("Journal Batch Name", 'OPŠTE');
                    // Ukloni single quotes iz ProcessedCustomerIDs:
                    ProcessedCustomerIDs := STRSUBSTNO('%1', ProcessedCustomerIDs);
                    GenJrnlLine.SetFilter("Account No.", ProcessedCustomerIDs);
                    Page.Run(Page::"General Journal", GenJrnlLine);
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(ParametersGroup)
                {
                    Caption = 'Parameters';
                    field(NumberOfMonths; NumberOfMonths)
                    {
                        ApplicationArea = All;
                        Caption = 'Number of Months';
                        ToolTip = 'Enter the number of months.';
                    }
                    field(Period; Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        ToolTip = 'Enter the period in date format.';
                    }
                    field(NumberOfDecision; NumberOfDecision)
                    {
                        ApplicationArea = All;
                        Caption = 'Number of Decision';
                        Tooltip = 'Enter the number of decision.';
                    }
                    field(DateStartPayment; DateStartPayment)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Payment Date';
                        ToolTip = 'Enter the start date of the payment.';
                    }
                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean;
        var
            myInt: Integer;
        begin
            ProcessedCustomerIDs := Customer.GetFilter("No.");

            if CloseAction = Action::OK then begin
                if (NumberOfMonths = 0) OR (Format(Period) = '') OR (NumberOfDecision = '') OR (DateStartPayment = 0D) then
                    Error(Label003);

                if ProcessedCustomerIDs = '' then
                    Error(Label007);
            end;
        end;
    }

    var
        NumberOfMonths: Integer;
        Period: DateFormula;
        NumberOfDecision: Code[30];
        DateStartPayment: Date;
        GenJrnlLine: Record "Gen. Journal Line";
        Response: Boolean;
        OpenGenJnlLine: Boolean;
        CustCount: Integer;
        Label001: Label 'Are you sure you want to transfer the Balance of customer (%1) %2 to Gen. Journal Line and reprogram the debt?';
        Label002: Label 'Are you sure you want to transfer the Balance of multiple customers to Gen. Journal Line and reprogram the debt?';
        Label003: Label 'You must enter values in fields Number of Months, Period, Number of Decision and DateStartPayment.';
        Label004: Label 'The entry with Customer No: %1 and Document No: %2 already exists in Gen. Journal Line.';
        Label005: Label 'Transfer completed: %1 lines created. \Do you want to open the Item Journal Line page?';
        Label006: Label 'Transfer completed. \Do you want to open the Gen. Journal Line page?';
        Label007: Label 'You must select at least one Customer';
        ProcessedCustomerIDs: Text;
        UnprocessedCustomerIDs: Text;
        NumberOfRowsCreated: Integer;
}
