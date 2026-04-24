query 50001 "Accusation Count"
{
    Caption = 'Accusation Count';


    elements
    {
        dataitem(Accusation_Line; "Accusation Line")
        {
            filter(Archived; Archived) { }
            filter(Bill_Category; "Bill Category") { }
            column(Document_No_; "Document No.") { }
            column(count)
            {
                Method = Count;
            }


        }
    }
}

