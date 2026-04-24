tableextension 50097 DetailedVendorLedgEntryExtends extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        //    VAT Base (retro.)


        field(50000; "Prepayment"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Ledger Entry".Prepayment where("Entry No." = field("Vendor Ledger Entry No.")));


        }
        field(50001; "Vendor Posting Group"; code[20])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";

        }


    }

    var
        myInt: Integer;
}