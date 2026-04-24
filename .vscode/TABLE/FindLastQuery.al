query 50005 MaxNewValueQueryLast2
{
    QueryType = Normal;

    elements
    {
        dataitem(CalcLine; "Calculation Journal Line")
        {
            column(NewValue; "New Value") { }
            column(Code; Code) { }
            column(Measuring_Point_Code; Gauge) { }

        }
    }
}