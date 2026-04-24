tableextension 50090 Purch_Rcpt_Line extends "Purch. Rcpt. Line"

{

    fields
    {
        // Add changes to table fields here
        field(5716; "Print Quantity"; Integer) //ED za ispis kartica malog formata
        {
            Caption = 'Print Quantity';
            Editable = true;
        }


        //d test

    }

    var
        myInt: Integer;
}