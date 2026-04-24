
pageextension 50255 SalesInvoiceSubformEx extends "Sales Invoice Subform"

{


    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("Posting Group"; "Posting Group")
            {
                Editable = true;
                Visible = true;

            }
            field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                Editable = true;
                Visible = true;
            }

            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                Editable = true;
                Visible = true;

            }
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                Editable = true;
                Visible = true;

            }
        }



        addafter("Line Amount")
        {
            field(VATAMOUNT; "VAT Prod. Posting Group")
            {
                Editable = true;
                Visible = true;
            }
        }


        addafter("Unit Price")
        {
            field("Avans Amount"; "Avans Amount")
            {
                Visible = true;
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    DeltaUpdateTotals();
                end;

            }
        }
    }



    var
        myInt: Integer;
}