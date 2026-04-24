/*table 50186 "Wage Addition IB"
{
    // //NK

    Caption = 'Wage addition';
    DrillDownPageID = "Wage Addition";
    LookupPageID = "Wage Addition";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF emp.GET("Employee No.") THEN BEGIN
                    "First Name" := emp."First Name";
                    "Last Name" := emp."Last Name";
                    "Contribution Category Code" := emp."Contribution Category Code";
                END;
            end;
        }
        field(4; "Wage Addition Type"; Code[10])
        {
            Caption = 'Wage Addition Type';
            TableRelation = "Wage Addition Type" WHERE("Incentive/Bonus" = FILTER(TRUE));

            trigger OnValidate()
            var
                WAT: Record "Wage Addition Type";
            begin
                WAT.GET("Wage Addition Type");
                Description := WAT.Description;
                IF WAT."Default Amount" <> 0 THEN
                    VALIDATE(Amount, WAT."Default Amount");


                IF ((WAT."Calculated on Brutto") AND (WAT."Calculation Type" = 0)) THEN BEGIN
                    WAmounts.SETFILTER("Employee No.", "Employee No.");
                    IF WAmounts.FINDLAST THEN BEGIN

                        ConCat.SETFILTER(Code, '%1', Rec."Contribution Category Code");
                        IF ConCat.FINDSET THEN BEGIN
                            ConCat.CALCFIELDS("From Brutto");
                            VALIDATE(Amount, (WAmounts."Wage Amount" * (WAT."Default Amount" / 100)) * (1 - ConCat."From Brutto" / 100));
                        END;
                    END;
                END;
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
        field(8; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(9; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(10; n; Integer)
        {
        }
        field(100; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(109; "Contribution Category Code"; Code[10])
        {
        }
        field(110; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(111; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(112; "Month of Wage"; Integer)
        {
            Caption = 'Month of Wage';
        }
        field(113; "Year of Wage"; Integer)
        {
            Caption = 'Year of Wage';
        }
        field(114; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(115; "Payment Date"; Date)
        {
            Caption = 'Payment Date';

            trigger OnValidate()
            begin

                IF "Payment Date" <> 0D THEN BEGIN
                    "Year of Wage" := DATE2DMY("Payment Date", 3);
                    "Month of Wage" := DATE2DMY("Payment Date", 2);
                END;
            end;
        }
        field(116; Evaluation; Text[30])
        {
            Caption = 'Evaluation';
        }
        field(117; "Calculate By Days"; Boolean)
        {
            Caption = 'Calculate By Days';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Employee No.")
        {
            SumIndexFields = Amount;
        }
        key(Key2; "Employee No.", "Wage Addition Type")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Wage Addition Type", "Employee No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        NextEntryNo := 0;
        IF WA.FIND('+') THEN
            NextEntryNo := WA."Entry No.";

        NextEntryNo += 1;
        "Entry No." := NextEntryNo;
    end;

    var
        Txt001: Label '<Ne smijete mijenjati zakljucani red>';
        Txt002: Label '<Morate navesti tip dodatka>';
        WA: Record "Wage Addition IB";
        NextEntryNo: Integer;
        emp: Record "Employee";
        ConCat: Record "Contribution Category";
        ATCCon: Record "Contribution Category Conn.";
        ATCConRS: Record "Contribution Category Conn.";
        AddTaxes: Record "Contribution";
        AddTaxesRS: Record "Contribution";
        ATPercentRS: Decimal;
        ATPercent: Decimal;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        //     SegmentationGroup: Record "Segmentation Data";
        wb: Record "Work Booklet";
        WAT: Record "Wage Addition";
        WageAdditionType: Record "Wage Addition Type";
        Class: Record "Tax Class";
        CompInfo: Record "Company Information";
        WageSetup: Record "Wage Setup";
        Response: Boolean;
        WAM: Record "Wage Addition";
        WAMOld: Record "Wage Addition";
        WAM2: Record "Wage Addition";
        WAmounts: Record "Wage Amounts";
}

*/