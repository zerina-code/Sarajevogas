tableextension 50028 FaPostingGroup extends "FA Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(5000; "Investment Account"; Code[20])
        {
            TableRelation = "G/L Account";
            Caption = 'Investment Account';

            trigger OnValidate()
            begin
                CheckGLAcc("Acquisition Cost Account", false);
            end;

        }

        field(50001; "Depreciation Expense Acc. D."; Code[20])
        {
            Caption = 'Depreciation Expense Acc. Donation';
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                CheckGLAcc("Depreciation Expense Acc.", true);
            end;
        }



        field(5003; Description; Text[250])
        {

            Caption = 'Description';
        }
    }

    var
        myInt: Integer;
        GLAcc: Record "G/L Account";

    procedure CheckGLAcc(Accno: Code[20]; DirectPosting: Boolean)
    begin
        IF AccNo = '' THEN
            EXIT;
        GLAcc.GET(AccNo);
        GLAcc.CheckGLAcc;
        IF DirectPosting THEN
            GLAcc.TESTFIELD("Direct Posting");

    end;
}