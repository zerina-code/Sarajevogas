table 50018 "Travel Stay By Country"
{
    Caption = 'Boravak po Državama';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Broj Naloga"; Code[20])
        {
            Caption = 'Broj Naloga';
            //TableRelation = "Travel Order Card SG".No;
            NotBlank = true;
        }
        field(2; "Broj Linije"; Integer)
        {
            Caption = 'Broj Linije';
            MinValue = 1;
        }
        field(3; "ISO Kod Drzave"; Code[2])
        {
            Caption = 'Država';
            TableRelation = "Country/Region".Code;
            NotBlank = true;

            trigger OnValidate()
            begin
                ValidateDrzava();
            end;
        }
        field(4; "Naziv Drzave"; Text[50])
        {
            Caption = 'Naziv Države';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region".Name where(Code = field("ISO Kod Drzave")));
        }
        field(5; "Datum Vrijeme Ulaska"; DateTime)
        {
            Caption = 'Datum/Vrijeme Ulaska';

            trigger OnValidate()
            begin
                ValidateVrijemeUlaska();
                IzracunajTrajanje();
            end;
        }
        field(6; "Datum Vrijeme Izlaska"; DateTime)
        {
            Caption = 'Datum/Vrijeme Izlaska';

            trigger OnValidate()
            begin
                ValidateVrijemeIzlaska();
                IzracunajTrajanje();
            end;
        }
        field(7; "Trajanje Minuta"; Integer)
        {
            Caption = 'Trajanje (min)';
            Editable = false;
        }
        field(8; "Trajanje Tekst"; Text[20])
        {
            Caption = 'Trajanje';
            Editable = false;
        }
        field(9; "Tip Boravka"; Enum "Travel Stay Type")
        {
            Caption = 'Tip Boravka';
        }
        field(10; Status; Enum "Travel Stay Status")
        {
            Caption = 'Status';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Broj Naloga", "Broj Linije")
        {
            Clustered = true;
        }
        key(VrijemeUlaska; "Broj Naloga", "Datum Vrijeme Ulaska")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Broj Linije" = 0 then
            "Broj Linije" := GenerirajBrojLinije();
    end;

    trigger OnModify()
    begin
        IzracunajTrajanje();
    end;

    // ─────────────────────────────────────────────
    //  Lokalne procedure
    // ─────────────────────────────────────────────

    local procedure GenerirajBrojLinije(): Integer
    var
        BoravakRec: Record "Travel Stay By Country";
        SljedeciRed: Integer;
    begin
        BoravakRec.SetRange("Broj Naloga", "Broj Naloga");
        if BoravakRec.FindLast() then
            SljedeciRed := BoravakRec."Broj Linije" + 10000
        else
            SljedeciRed := 10000;
        exit(SljedeciRed);
    end;

    local procedure ValidateDrzava()
    var
        Drzava: Record "Country/Region";
    begin
        if "ISO Kod Drzave" = '' then
            Error('Država je obavezno polje.');
        if not Drzava.Get("ISO Kod Drzave") then
            Error('Država sa ISO kodom "%1" ne postoji u šifarniku.', "ISO Kod Drzave");
    end;

    local procedure ValidateVrijemeUlaska()
    begin
        if "Datum Vrijeme Ulaska" = 0DT then
            Error('Datum/vrijeme ulaska mora biti unijeto.');
        if ("Datum Vrijeme Izlaska" <> 0DT) and ("Datum Vrijeme Ulaska" >= "Datum Vrijeme Izlaska") then
            Error('Vrijeme ulaska mora biti prije vremena izlaska.');
    end;

    local procedure ValidateVrijemeIzlaska()
    begin
        if "Datum Vrijeme Izlaska" = 0DT then
            Error('Datum/vrijeme izlaska mora biti unijeto.');
        if ("Datum Vrijeme Ulaska" <> 0DT) and ("Datum Vrijeme Izlaska" <= "Datum Vrijeme Ulaska") then
            Error('Vrijeme izlaska mora biti striktno veće od vremena ulaska.');
    end;

    procedure IzracunajTrajanje()
    var
        UkupnoMinuta: Integer;
        Sati: Integer;
        Minute: Integer;
    begin
        if ("Datum Vrijeme Ulaska" <> 0DT) and ("Datum Vrijeme Izlaska" <> 0DT) then begin
            UkupnoMinuta := Round(
                (CreateDateTime(DT2Date("Datum Vrijeme Izlaska"), DT2Time("Datum Vrijeme Izlaska")) -
                 CreateDateTime(DT2Date("Datum Vrijeme Ulaska"), DT2Time("Datum Vrijeme Ulaska"))) / 60000,
                1, '>');
            if UkupnoMinuta < 0 then
                UkupnoMinuta := 0;
            "Trajanje Minuta" := UkupnoMinuta;
            Sati := UkupnoMinuta div 60;
            Minute := UkupnoMinuta mod 60;
            "Trajanje Tekst" := Format(Sati) + 'h ' + Format(Minute) + 'min';
        end else begin
            "Trajanje Minuta" := 0;
            "Trajanje Tekst" := '';
        end;
    end;
}