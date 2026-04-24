table 50004 "Detailed VAT Entry"
{
    Caption = 'Detailed VAT Entry';



    fields
    {
        field(1; "VAT Entry No."; Integer)
        {
            Caption = 'VAT Entry No.';
            DataClassification = ToBeClassified;
        }

        field(2; Column1; Decimal)
        {
            Caption = 'Column1';
            DataClassification = ToBeClassified;
        }
        field(3; Column2; Decimal)
        {
            Caption = 'Column2';
            DataClassification = ToBeClassified;
        }
        field(4; Column3; Decimal)
        {
            Caption = 'Column3';
            DataClassification = ToBeClassified;
        }
        field(5; Column4; Decimal)
        {
            Caption = 'Column4';
            DataClassification = ToBeClassified;
        }
        field(6; Column5; Decimal)
        {
            Caption = 'Column5';
            DataClassification = ToBeClassified;
        }
        field(7; Column6; Decimal)
        {
            Caption = 'Column6';
            DataClassification = ToBeClassified;
        }
        field(8; Column7; Decimal)
        {
            Caption = 'Column7';
            DataClassification = ToBeClassified;
        }
        field(9; Column8; Decimal)
        {
            Caption = 'Column8';
            DataClassification = ToBeClassified;
        }
        field(10; Column9; Decimal)
        {
            Caption = 'Column9';
            DataClassification = ToBeClassified;
        }
        field(11; Column10; Decimal)
        {
            Caption = 'Column10';
            DataClassification = ToBeClassified;
        }
        field(100; Type; Enum "Type Detailed VAT Entry")
        {
            Caption = 'Type';

        }
        field(50000; "VAT retro"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("VAT Entry"."VAT Base (retro.)" WHERE("Entry No." = FIELD("VAT Entry No.")));


        }
        field(50001; "Amount retro"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("VAT Entry"."VAT Amount (retro.)" WHERE("Entry No." = FIELD("VAT Entry No.")));

        }
        field(50002; "Document No."; Code[20])
        {

            Caption = 'Document No.';
        }
        field(50003; "External Document No."; Code[35])
        {

            Caption = 'External Document No.';
        }
        field(50004; "Document Type"; Enum "Gen. Journal Document Type")
        {

            Caption = 'Document Type';
        }
        field(50005; "VAT Date"; Date)
        {

            Caption = 'VAT Date';
        }
    }

    keys
    {
        key(Key1; "VAT Entry No.", Type)
        {
        }
    }
    var
        VATEntry: Record "VAT Entry";


}


