tableextension 50000 FADepreciationBook extends "FA Depreciation Book"
{
    fields
    {
        // Add changes to table fields here
        field(50004; "Unactivated"; Decimal)
        {
            Caption = 'Unactivated';
            FieldClass = FlowField;
            CalcFormula = Sum("FA Ledger Entry".Amount WHERE("FA No." = FIELD("FA No."), "FA Posting Type" = FILTER("Acquisition Cost"), Activation = FILTER(false)));
        }
    }

    var
        myInt: Integer;
}