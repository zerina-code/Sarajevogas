tableextension 50033 GenJournalBatch extends "Gen. Journal Batch"
{
    fields
    {

        field(50001; "Cashier Table"; Code[10])
        {
            Caption = 'Cashier Table';
            TableRelation = Cashier;

        }
        field(50002; "TAB"; Option)
        {
            Caption = 'TAB OR SPACE';
            OptionCaption = ' ,TAB,SPACE';
            OptionMembers = " ",TAB,SPACE;
        }
        field(50003; "Commissioning"; Boolean)
        {
            Caption = 'Commissioning';
        }
        field(50004; "Payment to Employees"; Boolean)
        {
            Caption = 'Payment to Employees';
        }

        field(50005; "Path for Cashier"; Text[250])
        {
            Caption = 'Path for Cashier';
        }
        field(600346; "No. series Payment Int"; Code[20])
        {
            Caption = 'No. series Payment';
            TableRelation = "No. Series".Code;

        }
        field(600347; "No. series Payment Int Card"; Code[20])
        {
            Caption = 'No. series Payment Card';
            TableRelation = "No. Series".Code;


        }

    }
}