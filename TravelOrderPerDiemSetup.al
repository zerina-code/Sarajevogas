table 50990 "Travel Order Per Diem Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Putni nalog - Dnevnice po zemlji';

    fields
    {
        field(1; "Country Code"; Code[10])
        {
            Caption = 'Kod zemlje';
            NotBlank = true;
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            var
                CountryRegion: Record "Country/Region";
            begin
                if CountryRegion.Get("Country Code") then
                    "Country Name" := CountryRegion.Name;
            end;
        }

        field(2; "Country Name"; Text[100])
        {
            Caption = 'Naziv zemlje';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(3; "Full Day Per Diem Amount"; Decimal)
        {
            Caption = 'Dnevnica za puni dan (BAM)';
            DataClassification = ToBeClassified;
            MinValue = 0;
            DecimalPlaces = 2 : 2;
        }

        field(4; "Currency Code"; Code[10])
        {
            Caption = 'Valuta';
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;
        }
    }

    keys
    {
        key(PK; "Country Code")
        {
            Clustered = true;
        }
    }
}