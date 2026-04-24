tableextension 50114 "Standard Text" extends "Standard Text"
{
    fields
    {
        // Add changes to table fields here
        field(5000; "Plan"; integer)
        {
            Caption = 'Plan';
            FieldClass = FlowField;
            CalcFormula = count("Plan RN" where("Activity Code" = field(Code), Year = field("Year Filter")));
        }
        field(50001; "Year Filter"; Integer)
        {
            Caption = 'Year Filter';
            FieldClass = FlowFilter;
        }
    }

    var
        myInt: Integer;
}