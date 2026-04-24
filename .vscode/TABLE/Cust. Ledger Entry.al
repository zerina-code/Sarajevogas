tableextension 50017 CustLedgerEntryExtends extends "Cust. Ledger Entry"
{

    fields
    {
        //    VAT Base (retro.) new
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }


        field(50001; "G/L Account"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Customer Posting Group"."Receivables Account" where(Code = field("Customer Posting Group")));

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
        field(50021; "Cashier Employer"; Code[10])
        {
            Caption = 'Cashier Employer';
        }
        field(50051; "KUF_Entry"; Code[20])

        {
            Caption = 'KUF Entry';
        }
        field(50052; "KIF_Entry"; Code[20])

        {
            Caption = 'KIF Entry';
        }
        field(50053; "KUF_Type"; Option)
        {
            Caption = 'KUF Type';
            OptionCaption = 'DOMAĆI,INO,AVANSI';
            OptionMembers = "DOMAĆI",INO,AVANSI;
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
        field(50050; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";
        }
        field(50100; "MALS"; Text[200])
        {
            Caption = 'MALS';
        }
        field(50102; "Billing Credit Memo"; Boolean)
        {
            Caption = 'Billing Credit Memo';
        }


    }
    trigger OnInsert()
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        //  GenJnlPostPreview.

        //"Gen. Jnl.-Post Preview".SaveCustLedgEntry(Rec);
    end;

    var
        myInt: Integer;



    procedure DrillDownOnEntries2(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; Prep: boolean)
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
        DtldCustLedgEntry.setfilter(Prepayment, '%1', Prep);
        CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
        CustLedgEntry.SetRange(Open, true);

        PAGE.Run(DrillDownPageID, CustLedgEntry);
    end;


}