pageextension 50097 VendorBankAccountList extends "Vendor Bank Account List"
{

    layout
    {
        // Add changes to page layout here
        addbefore(Name)
        {
            field("Vendor No."; "Vendor No.")
            {
            }
        }
        modify("Bank Account No.")
        {
            Visible = true;
        }
        moveafter("Vendor No."; "Bank Account No.")
    }

    var
}