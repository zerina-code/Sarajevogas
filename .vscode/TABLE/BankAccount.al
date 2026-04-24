tableextension 50010 BankAccount extends "Bank Account"
{

    //ED

    fields
    {
        field(50000; "No Report"; Boolean)
        {
            Caption = 'No Report';
        }
        field(50001; "Transit G/L account"; Code[10])
        {
            Caption = 'Transit G/L account';
            TableRelation = "G/L Account";
        }
        field(50002; "No. series for Payment"; Code[20])
        {
            Caption = 'Brojčana serija za uplate';
            TableRelation = "No. Series".Code;
        }
        field(50003; Showondocument; boolean)
        {
            Caption = 'Show on document';
        }
        field(50004; CZK; boolean)
        {
            Caption = 'CZK';
        }
        field(50005; "No. series for Payment Card"; Code[20])
        {
            Caption = 'Brojčana serija za uplate kartično';
            TableRelation = "No. Series".Code;
        }
        field(5006; "Path for fiscal printer"; text[250])
        {
            Caption = 'Path for fiscal printer';
        }
        field(5007; "No. series FIscal No."; Code[20])
        {
            Caption = 'No. series Fiscal No.';
            TableRelation = "No. Series".Code;
        }
        field(5008; "No. series R. FIscal No."; Code[20])
        {
            Caption = 'No. series R. Fiscal No.';
            TableRelation = "No. Series".Code;
        }


    }

    var
        myInt: Integer;
}