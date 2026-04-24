pageextension 50123 "Resource List" extends "Resource List"
{
    layout
    {
        addafter("No.")
        {
            field(Order; "Order")
            {
                ApplicationArea = All;
            }
        }
    }
}