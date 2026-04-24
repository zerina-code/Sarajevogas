tableextension 50011 "Sales Setup Additional Field" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Date When Reminder Was Sent"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'The Date When The Reminder Was Sent';
        }
        field(50002; "Prepayment Invoice Nos."; Code[20])
        {
            Caption = 'Prepayment Invocie Nos.';
            TableRelation = "No. Series";
        }
        field(50001; "Corr. Prepayment Invoice Nos."; Code[20])
        {
            Caption = 'Corr. Prepayment Invocie Nos.';
            TableRelation = "No. Series";
        }

        field(50003; "NN Customer Code"; code[20])
        {
            Caption = 'NN Customer Code';
            TableRelation = Customer."No.";
        }
        field(50004; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50005; "Reminder Date"; DateFormula)
        {
            Caption = 'Reminder Date';
        }
    }

}