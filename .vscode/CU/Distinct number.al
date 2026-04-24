query 50002 "My Query"
{
    Caption = 'My Query';
    QueryType = Normal;


    elements
    {
        dataitem(Calculation_Journal_Line; "Calculation Journal Line")

        {
            DataItemTableFilter = SM3 = filter(> 0), "Old Gauge" = filter(false);


            column(Code; Code) { }
            column(Customer_No_; "Customer No.") { }
            column(EF_Activity; "EF Activity") { }

            column(Totals)
            {
                Method = Count;
            }



        }

    }

}