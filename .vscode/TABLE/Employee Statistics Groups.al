pageextension 50141 "Employee Statistics Groups" extends "Employee Statistics Groups"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Type of vehicle"; "Type of vehicle") { ApplicationArea = all; }
            field("Customer No. "; "Customer No.") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}