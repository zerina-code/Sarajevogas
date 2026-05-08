table 50017 "Travel Order Setup SG"
{
    DataClassification = ToBeClassified;
    Caption = 'Postavke putnih naloga';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primarni ključ';
            DataClassification = ToBeClassified;
        }
        field(2; "Travel Order Nos."; Code[20])
        {
            Caption = 'Serija brojeva putnih naloga';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
