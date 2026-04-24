tableextension 50019 DetailedCustLedgEntryExtends extends "Detailed Cust. Ledg. Entry"
{
    fields
    {
        //    VAT Base (retro.)


        field(50000; "Prepayment"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Cust. Ledger Entry".Prepayment where("Entry No." = field("Cust. Ledger Entry No.")));


        }

        field(50102; "Billing Credit Memo"; Boolean)
        {
            Caption = 'Billing Credit Memo';
        }
        field(50001; "MALS"; Text[020])
        {
            Caption = 'MALS';


        }
        field(50050; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";
        }
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }


    }

    var
        myInt: Integer;
}