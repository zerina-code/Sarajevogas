tableextension 50027 "FAPostingBuffer" extends "FA G/L Posting Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Donation"; Boolean)
        {
            Caption = 'Donation';
        }
        field(50002; "OS No."; Code[20])
        {
            Caption = 'Fixed Asset No.';
        }
    }

    var
        myInt: Integer;
}