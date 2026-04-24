tableextension 50006 PurchaseandpayableSetup extends "Purchases & Payables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Prepayment Invoice Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            Caption = 'Prepayment Invoice Nos.';
        }
        field(50001; "Corr. Prepayment Invoice Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            Caption = 'Corr. Prepayment Invoice Nos.';
        }
        /*field(50002; "Notification Email"; Text[80])
        {
            Caption = 'Notification Email';
        }
        field(50003; "Notification Name"; Text[100])
        {
            Caption = 'Notification Name';
        }*/
        field(50004; "Notification Path"; Text[100])
        {
            Caption = 'Notification Path';
        }
        field(50005; "Advance No. Series"; code[20])
        {

            Caption = 'Advance No. Series';
            TableRelation = "No. Series".Code;
        }
    }

    var
        myInt: Integer;
}