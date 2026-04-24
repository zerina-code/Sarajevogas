pageextension 50155 Customer_Bank_Account_Card extends "Customer Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Transit No.")
        {
            field("Bank Prefix"; "Bank Prefix") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}