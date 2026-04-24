tableextension 50031 FASetup extends "Fa setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Activation Nos."; Code[20])
        {
            Caption = 'Activation Nos.';
        }
        field(50001; "A. Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name for Activation OS';
        }
        field(50002; "A. Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name for Activation OS';
        }


    }

    var
        myInt: Integer;
}