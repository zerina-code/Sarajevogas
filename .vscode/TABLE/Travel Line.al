/*table 50081 "Travel Line"
{
    // //


    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Travel Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'Line No.';

            trigger OnValidate()
            var
                lineorderno: Integer;
                Travellinetable: Record "Travel Line";
            begin
            end;
        }
        field(3; "Cost Type"; Option)
        {
            Caption = 'Cost Type';
            OptionCaption = 'Advance Payment,Daily Allowance,Fuel,Accomodation,Meal,Aditional Car Costs,Other Costs';
            OptionMembers = "Advance Payment","Daily Allowance",Fuel,Accomodation,Meal,"Aditional Car Costs","Other Costs";

            trigger OnValidate()
            var
                lineorderno: Integer;
                Travellinetable: Record "Travel Line";
            begin
            end;
        }
        field(4; Currency; Code[10])
        {
            Caption = 'Currency';
            TableRelation = Currency;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * Amount;

                IF Currency = '' THEN BEGIN
                    "Amount (LCY)" := Amount;
                    "Line Amount (LCY)" := Quantity * "Amount (LCY)";
                END
                ELSE BEGIN
                    CER.SETFILTER("Currency Code", '%1', Currency);
                    IF CER.FIND('+') THEN BEGIN
                        "Amount (LCY)" := Amount * CER."Relational Exch. Rate Amount";
                        "Line Amount (LCY)" := Quantity * "Amount (LCY)";
                    END;
                END;
            end;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            begin
                "Line Amount" := Quantity * Amount;

                IF Currency = '' THEN BEGIN
                    "Amount (LCY)" := Amount;
                    "Line Amount (LCY)" := Quantity * "Amount (LCY)";
                END
                ELSE BEGIN
                    CER.SETFILTER("Currency Code", '%1', Currency);
                    IF CER.FIND('+') THEN BEGIN
                        "Amount (LCY)" := Amount * CER."Relational Exch. Rate Amount";
                        "Line Amount (LCY)" := Quantity * "Amount (LCY)";
                    END;
                END;
            end;
        }
        field(7; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
        }
        field(8; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
        field(9; "Line Amount (LCY)"; Decimal)
        {
            Caption = 'Line Amount(LCY)';
        }
        field(10; "Commercialist No."; Code[10])
        {
            Caption = 'Commercialist No.';
            //  TableRelation = Table50096.Field50018 WHERE (Field1=FIELD("Document No."));
        }
        field(11; "Line Order"; Integer)
        {

            trigger OnValidate()
            var
                lineorderno: Integer;
                Travellinetable: Record "Travel Line";
            begin
            end;
        }
        field(12; "LR Quantity"; Decimal)
        {
            Caption = 'Legaly Recognized Quantity';

            trigger OnValidate()
            begin

                IF Currency = '' THEN BEGIN
                    "LR Amount (LCY)" := "LR Amount";
                    "LR Line Amount (LCY)" := Quantity * "LR Amount (LCY)";
                END
                ELSE BEGIN
                    CER.SETFILTER("Currency Code", '%1', Currency);
                    IF CER.FIND('+') THEN BEGIN
                        "LR Amount (LCY)" := "LR Amount" * CER."Relational Exch. Rate Amount";
                        "LR Line Amount (LCY)" := Quantity * "LR Amount (LCY)";
                    END;
                END;
            end;
        }
        field(13; "LR Amount"; Decimal)
        {
            Caption = 'Legally Recognized Amount';

            trigger OnValidate()
            begin
                //"LR Line Amount":= Quantity*"LR Amount";

                IF Currency = '' THEN BEGIN
                    "LR Amount (LCY)" := "LR Amount";
                    "LR Line Amount (LCY)" := Quantity * "LR Amount (LCY)";
                END
                ELSE BEGIN
                    CER.SETFILTER("Currency Code", '%1', Currency);
                    IF CER.FIND('+') THEN BEGIN
                        "LR Amount (LCY)" := "LR Amount" * CER."Relational Exch. Rate Amount";
                        "LR Line Amount (LCY)" := Quantity * "LR Amount (LCY)";
                    END;
                END;
            end;
        }
        field(14; "LR Amount (LCY)"; Decimal)
        {
            Caption = 'Legally Recognized Amount (LCY';
        }
        field(15; "LR Line Amount (LCY)"; Decimal)
        {
            Caption = 'Legally Recognized Line Amount (LCY)';
        }
        field(16; "Transfer to Cash Desk"; Boolean)
        {
            Caption = 'Transfer to Cash Desk';
        }
        field(17; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CER: Record "Currency Exchange Rate";
}

*/