query 50004 MaxNewValueQueryLast
{
    QueryType = Normal;

    elements
    {
        dataitem(CalcLine; "Calculation Journal Line")
        {
            column(NewValue; SM3) { Method = Sum; }
            column(Code; Code) { }
            column(Measuring_Point_Code; "Measuring Point Code") { }
            column(Calculation_Date_To; "Calculation Date To") { }
        }
    }
}