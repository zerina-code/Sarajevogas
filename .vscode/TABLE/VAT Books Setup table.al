table 50003 "VAT Books Setup"
{
    // BH1.00, VAT Books

    Caption = 'VAT books setup';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry no.';
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Sale,Purchase';
            OptionMembers = Sale,Purchase;
        }
        field(3; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(4; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(5; "Column Name"; Option)
        {
            Caption = 'Column Name';
            OptionCaption = 'Column 1,Column 2,Column 3,Column 4,Column 5,Column 6';
            OptionMembers = Column1,Column2,Column3,Column4,Column5,Column6;
        }
        field(6; Operator1; Option)
        {
            Caption = 'Operator1';
            OptionCaption = ' ,+,-';
            OptionMembers = " ","+","-";
        }
        field(7; Value1; Option)
        {
            Caption = 'Value1';
            OptionCaption = ' ,Base,Amount,VAT Base (retro),VAT Amount (retro)';
            OptionMembers = " ",Base,Amount,"VAT Base (retro)","VAT Amount (retro)";
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(8; Operator2; Option)
        {
            Caption = 'Operator2';
            OptionCaption = ' ,+,-';
            OptionMembers = " ","+","-";
        }
        field(9; Value2; Option)
        {
            Caption = 'Value2';
            OptionCaption = ' ,Base,Amount,VAT Base (retro),VAT Amount (retro)';
            OptionMembers = " ",Base,Amount,"VAT Base (retro)","VAT Amount (retro)";
        }
        field(10; Operator3; Option)
        {
            Caption = 'Operator2';
            OptionCaption = ' ,+,-';
            OptionMembers = " ","+","-";
        }
        field(11; Value3; Option)
        {
            Caption = 'Value2';
            OptionCaption = ' ,Base,Amount,VAT Base (retro),VAT Amount (retro)';
            OptionMembers = " ",Base,Amount,"VAT Base (retro)","VAT Amount (retro)";
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        CheckEntry;
    end;

    trigger OnModify()
    begin
        CheckEntry;
    end;

    procedure CheckEntry()
    var
        VATBooksSetup: Record "VAT Books Setup";
        Err01: Label 'Row %1, %2, %3, %4 already exists!';
        Err02: Label 'Fields combination %1, %2 is not valid!';
    begin
        VATBooksSetup.SETRANGE(Type, Type);
        VATBooksSetup.SETRANGE("VAT Bus. Posting Group", "VAT Bus. Posting Group");
        VATBooksSetup.SETRANGE("VAT Prod. Posting Group", "VAT Prod. Posting Group");
        VATBooksSetup.SETRANGE("Column Name", "Column Name");
        VATBooksSetup.SETFILTER("Entry No.", '<>%1', "Entry No.");
        IF NOT VATBooksSetup.ISEMPTY THEN
            ERROR(Err01, Type, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Column Name");

        IF ((Value1 <> Value1::" ") AND (Operator1 = Operator1::" "))
           OR
           ((Value1 = Value1::" ") AND (Operator1 <> Operator1::" "))
        THEN
            ERROR(Err02, FIELDCAPTION(Operator1), FIELDCAPTION(Value1));

        IF ((Value2 <> Value2::" ") AND (Operator2 = Operator2::" "))
           OR
           ((Value2 = Value2::" ") AND (Operator2 <> Operator2::" "))
        THEN
            ERROR(Err02, FIELDCAPTION(Operator2), FIELDCAPTION(Value2));
    end;
}

