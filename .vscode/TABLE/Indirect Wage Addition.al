/*ĐK table 50239 "Indirect Wage Addition"
{
    Caption = 'Indirect wage addition';

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; "Month of Wage"; Integer)
        {
            Caption = 'Month of Wage';
        }
        field(3; "Year of Wage"; Integer)
        {
            Caption = 'Year of Wage';
        }
        field(4; "Indirect Wage Addition Type"; Code[10])
        {
            Caption = 'Indirect Wage Addition Type';
            TableRelation = "Indirect Wage Addition Type";

            trigger OnValidate()
            var
                IWAT: Record "Indirect Wage Addition Type";
            begin
                IWAT.GET("Indirect Wage Addition Type");
                Description := IWAT.Description;
            end;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(100; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(101; Locked; Boolean)
        {
            Caption = 'Locked';
        }
        field(102; "Wage Header No."; Code[10])
        {
            Caption = 'Wage Header No.';
        }
        field(103; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Employee No.", "Year of Wage", "Month of Wage", "Indirect Wage Addition Type")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Indirect Wage Addition Type", "Year of Wage", "Month of Wage", "Employee No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF xRec.Locked THEN ERROR(Txt001);
    end;

    trigger OnInsert()
    begin
        NextEntryNo := 0;
        IF IWA.FIND('+') THEN
            NextEntryNo := IWA."Entry No.";

        NextEntryNo += 1;
        "Entry No." := NextEntryNo;
    end;

    trigger OnModify()
    begin
        IF xRec.Locked THEN ERROR(Txt001);
    end;

    trigger OnRename()
    begin
        IF xRec.Locked THEN ERROR(Txt001);
    end;

    var
        IWA: Record "Indirect Wage Addition";
        NextEntryNo: Integer;
        Txt001: Label '<Ne smijete mijenjati zakljucani red>';
        Txt002: Label '<Morate navesti tip dodatka>';
}

*/