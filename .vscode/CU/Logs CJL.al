table 50069 "CJL Logs"
{
    Caption = 'CJL Logs';//DZ

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Purpose; Text[250])
        {
            Caption = 'Purpose';
            DataClassification = CustomerContent;
        }

        field(4; Billing_Code; Code[20])
        {
            Caption = 'Billing_Code';
            DataClassification = CustomerContent;
        }
        field(5; CreditMemo; Boolean)
        {
            Caption = 'CreditMemo';
            DataClassification = CustomerContent;
        }
        field(6; NewAdvance; Boolean)
        {
            Caption = 'NewAdvance';
            DataClassification = CustomerContent;
        }
        field(7; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }

    }
    keys
    {
        key(PK; Code, Description, Purpose)
        {
            Clustered = true;
        }
        key(Description; Description)
        {
            Unique = true;
        }
    }
}