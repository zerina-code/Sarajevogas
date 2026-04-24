report 50189 "Doubtful receivables"
{
    Caption = 'Doubtful receivables';
    ProcessingOnly = true;
    dataset
    {
        dataitem(CustLedgerEntry; "Cust. Ledger Entry")
        {


            trigger OnPreDataItem()
            begin
                EndDate := RequestedDate;
                StartDate := CalcDate('-1G', RequestedDate);
                SETFILTER("Document Date", '..%1', StartDate);
                SETFILTER("Prepayment", '%1', false);
                SETFILTER(Open, '%1', TRUE);
                SETFILTER("G/L Account", '<>%1', '2119*');

            end;

            trigger OnAfterGetRecord()

            begin
                Cust.GET("Customer No.");
                IF Cust."Exclude from repost" = FALSE then begin
                    InsertLine := false;

                    GLSetup.GET;
                    T_GJL.SETFILTER("Journal Template Name", '%1', GLSetup."Repost Journal Template");
                    T_GJL.SETFILTER("Journal Batch Name", '%1', GLSetup."Repost Batch Name");
                    IF T_GJL.FIND('+') THEN
                        LineNo := T_GJL."Line No." + 100
                    ELSE
                        LineNo := 100;
                    T_GJL."Journal Template Name" := GLSetup."Repost Journal Template";
                    T_GJL."Journal Batch Name" := GLSetup."Repost Batch Name";
                    T_GJL."Account Type" := T_GJL."Account Type"::"Customer";
                    T_GJL."Account No." := "Customer No.";
                    T_GJL."Line No." := LineNo;
                    T_GJL."Posting Date" := TODAY;
                    T_GJL."Document Date" := TODAY;
                    Docno := NoSeriesMgt.GetNextNo(GLSetup."Doubtful rec. No. series", TODAY, false);
                    T_GJL."Document No." := Docno;
                    T_GJL.Description := '';
                    CALCFIELDS("Remaining Amt. (LCY)");
                    T_GJL.VALIDATE("Credit Amount", "Remaining Amt. (LCY)");
                    T_GJL."VAT Bus. Posting Group" := '';
                    T_GJL."VAT Prod. Posting Group" := '';
                    T_GJL.VALIDATE("Posting Group", "Customer Posting Group");
                    T_GJL.INSERT(TRUE);
                    LineNo += 100;


                    T_GJL."Journal Template Name" := GLSetup."Repost Journal Template";
                    T_GJL."Journal Batch Name" := GLSetup."Repost Batch Name";
                    T_GJL."Account Type" := T_GJL."Account Type"::"Customer";
                    T_GJL."Account No." := "Customer No.";
                    T_GJL."Line No." := LineNo;
                    T_GJL."Posting Date" := TODAY;
                    T_GJL."Document Date" := TODAY;
                    T_GJL."Document No." := Docno;
                    T_GJL.Description := 'S';
                    IF "Bill Type" = '01' then
                        T_GJL."Posting Group" := 'SUM.I.SP-PL'
                    ELSE
                        IF "Bill Type" = '02' then
                            T_GJL."Posting Group" := 'SUM.I.SP-MP'

                        ELSE
                            IF "Bill Type" = '03' then
                                T_GJL."Posting Group" := 'SUM.I.SPOR'
                            ELSE
                                T_GJL."Posting Group" := 'SUM.I.SP-USL';
                    CALCFIELDS("Remaining Amt. (LCY)");
                    T_GJL.VALIDATE("Debit Amount", "Remaining Amt. (LCY)");
                    T_GJL."VAT Bus. Posting Group" := '';
                    T_GJL."VAT Prod. Posting Group" := '';
                    T_GJL.INSERT(TRUE);
                    InsertLine := true;

                    LineNo += 100;
                    T_GJL."Journal Template Name" := GLSetup."Repost Journal Template";
                    T_GJL."Journal Batch Name" := GLSetup."Repost Batch Name";
                    T_GJL."Account Type" := T_GJL."Account Type"::"Customer";
                    T_GJL."Account No." := "Customer No.";
                    T_GJL."Line No." := LineNo;
                    T_GJL."Posting Date" := TODAY;
                    T_GJL."Document Date" := TODAY;
                    T_GJL."Document No." := Docno;
                    T_GJL.Description := 'S';
                    IF "Bill Type" = '01' then
                        T_GJL."Posting Group" := 'SUM.I.SP-PL_KOR'
                    ELSE
                        IF "Bill Type" = '02' then
                            T_GJL."Posting Group" := 'SUM.I.SP-MP_KOR'

                        ELSE
                            IF "Bill Type" = '03' then
                                T_GJL."Posting Group" := 'SUM.I.SP.DOM_KOR'
                            ELSE
                                T_GJL."Posting Group" := 'SUM.I.SP-USL_KOR';
                    CALCFIELDS("Remaining Amt. (LCY)");
                    T_GJL.VALIDATE("Credit Amount", "Remaining Amt. (LCY)");
                    T_GJL."VAT Bus. Posting Group" := '';
                    T_GJL."VAT Prod. Posting Group" := '';
                    T_GJL.INSERT(TRUE);
                    InsertLine := true;
                    LineNo += 100;

                    T_GJL."Journal Template Name" := GLSetup."Repost Journal Template";
                    T_GJL."Journal Batch Name" := GLSetup."Repost Batch Name";
                    T_GJL."Account Type" := T_GJL."Account Type"::"G/L Account";
                    IF "Bill Type" = '01' then begin
                        cpg.reset();
                        cpg.GET('SUM.I.SP-PL');
                        T_GJL."Account No." := cpg."Expense G/L Account";
                    end;
                    IF "Bill Type" = '02' then begin
                        cpg.reset();
                        cpg.GET('SUM.I.SP-MP');
                        T_GJL."Account No." := cpg."Expense G/L Account";
                    end;
                    IF "Bill Type" = '06' then begin
                        cpg.reset();
                        cpg.GET('SUM.I.SP-USL');
                        T_GJL."Account No." := cpg."Expense G/L Account";
                    end;


                    T_GJL."Line No." := LineNo;
                    T_GJL."Posting Date" := TODAY;
                    T_GJL."Document Date" := TODAY;
                    T_GJL."Document No." := Docno;
                    T_GJL.Description := '';
                    CALCFIELDS("Remaining Amt. (LCY)");
                    T_GJL.VALIDATE("Debit Amount", "Remaining Amt. (LCY)");
                    T_GJL."VAT Bus. Posting Group" := '';
                    T_GJL."VAT Prod. Posting Group" := '';
                    T_GJL.INSERT(TRUE);
                    LineNo += 100;


                end;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Calculation Date")
                {
                    Caption = 'Izaberi datum izračuna';
                    Field(RequestedDate; RequestedDate)
                    {
                        Caption = 'Datum izračuna:';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }


    }

    trigger OnInitReport()
    begin
        RequestedDate := TODAY;
    end;

    trigger OnPostReport()
    begin
        MESSAGE(Txt000);
        GJL.RUN;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        T_GJL: Record "Gen. Journal Line";
        LineNo: Integer;
        Docno: Code[30];
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Txt000: Label 'Done.';
        InsertLine: Boolean;
        Cust: Record customer;
        RequestedDate: Date;
        GJL: Page "General Journal";
        StartDate: Date;
        EndDate: Date;
        cpg: Record "Customer Posting Group";

}
