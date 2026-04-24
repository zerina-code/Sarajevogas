tableextension 50092 General_Posting_Setup extends "General Posting Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Retail Account No."; code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Retail Account No.';

        }
        field(50001; "Retail Receipt Account No."; code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Retail Receipt Account No.';

        }
        field(50002; "Retail Receipt Account No. MP"; code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Retail Receipt Account No.';

        }
        field(50003; "Update General Posting Group"; Boolean)
        {
            Caption = 'Update General Posting Group';

        }
        field(50005; "HTZ Account"; code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'HTZ Account';

        }
        field(50006; "HTZ Account 2"; code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'HTZ Account 2';

        }
        field(50007; "Previous HTZ Account"; code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Previous HTZ Account';

        }
        field(50008; "Previous HTZ Account 2"; code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Previous HTZ Account 2';

        }
    }

    var
        myInt: Integer;
}