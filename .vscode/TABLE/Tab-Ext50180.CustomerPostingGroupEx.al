tableextension 50180 "Customer Posting Group Ex" extends "Customer Posting Group"
{
    fields
    {
        field(50000; "Expense G/L Account"; Code[20])
        {
            Caption = 'Expense G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50001; "Correction G/L Account"; Code[20])
        {
            Caption = 'Correction G/L Account';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
    }
}
