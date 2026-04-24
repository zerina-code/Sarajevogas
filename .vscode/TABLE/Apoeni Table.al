table 50188 "Apoeni"
{
    //ED

    Caption = 'Apoeni';
    DrillDownPageID = "Apoeni Page";
    LookupPageID = "Apoeni Page";


    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; Apoeni; Enum "Apoeni Enum")
        {
            Caption = 'Apoeni';

            trigger OnValidate()
            begin
                if Rec.Apoeni.AsInteger() < 9 then begin
                    //ApoeniText := FORMAT(Rec.Apoeni); //probati bez ovoga   
                    //Evaluate(ApoeniDecimal, ApoeniText);
                    if Evaluate(ApoeniDecimal, Format(Rec.Apoeni))
                    then
                        Evaluate(ApoeniDecimal, Format(Rec.Apoeni))
                    else
                        ApoeniDecimal := 0

                end
                else
                    if Rec.Apoeni.AsInteger() = 9 then
                        ApoeniDecimal := 0.5
                    else
                        if Rec.Apoeni.AsInteger() = 10 then
                            ApoeniDecimal := 0.2
                        else
                            if Rec.Apoeni.AsInteger() = 11 then
                                ApoeniDecimal := 0.1
                            else
                                if Rec.Apoeni.AsInteger() = 12 then ApoeniDecimal := 0.05;

                if (ApoeniDecimal <> 0) AND (Rec.Quantity <> 0) then
                    Rec.Amount := ApoeniDecimal * Rec.Quantity;


            end;
        }
        field(3; Quantity; Integer)
        {
            Caption = 'Quantity';

            trigger OnValidate()
            begin
                Validate(Apoeni, Rec.Apoeni);

                if (ApoeniDecimal <> 0) AND (Rec.Quantity <> 0) then
                    Rec.Amount := ApoeniDecimal * Rec.Quantity;


            end;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(6; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }

    }



    keys
    {
        key(Key1; "Bal. Account No.", "Posting Date", Apoeni)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ApoeniDecimal: Decimal;
        ApoeniText: Text[10];


}

