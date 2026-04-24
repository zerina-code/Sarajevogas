query 50000 "Payment Orders Summarry"
{

    elements
    {
        dataitem(QueryElement1; "Payment Order")
        {
            column(Wage_Payment_Type; Contributon)
            {
            }
            column(Sum_Iznos; Iznos)
            {
                Method = Sum;
            }
            filter(Wage_Calculation_Type; "Wage Calculation Type")
            {
            }
            filter(Wage_Header_No; "Wage Header No.")
            {
            }
            filter(DatumUplate; DatumUplate)
            {
            }
        }
    }
}

