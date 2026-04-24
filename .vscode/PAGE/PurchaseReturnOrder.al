pageextension 50179 PurchaseReturnOrder extends "Purchase Return Order"
{

    layout
    {


        addafter(Status)
        {
            field("Correction"; "Correction")
            {
                ApplicationArea = All;
            }

        }


    }
}

