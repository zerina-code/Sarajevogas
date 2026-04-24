query 50003 MaxNewValueQuery
{
    QueryType = Normal;

    elements
    {
        dataitem(CalcLine; "Calculation Journal Line")
        {
            column(NewValue; Difference) { Method = Max; }
            column(Code; Code) { }
            column(Measuring_Point_Code; "Measuring Point Code") { }
        }
    }
}