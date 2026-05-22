codeunit 50031 "Stay Validation Mgt."
{

    procedure ValidirajBoravak(var Boravak: Record "Travel Stay By Country")
    begin
        ValidirajObaveznaPolia(Boravak);
        ValidirajVrijemenskiInterval(Boravak);
        ValidirajDrzavu(Boravak."ISO Kod Drzave");
    end;

    procedure ValidirajKontinuitetBoravaka(BrojNaloga: Code[20])
    var
        PutniNalog: Record "Travel Order Header SG";
        Boravak: Record "Travel Stay By Country";
        PrethodniIzlaz: DateTime;
        BrojRedova: Integer;
    begin
        if not PutniNalog.Get(BrojNaloga) then
            Error('Putni nalog "%1" ne postoji.', BrojNaloga);

        Boravak.SetRange("Broj Naloga", BrojNaloga);
        Boravak.SetCurrentKey("Broj Naloga", "Datum Vrijeme Ulaska");
        Boravak.SetAscending("Datum Vrijeme Ulaska", true);

        if not Boravak.FindSet() then
            exit;
        BrojRedova := 0;
        PrethodniIzlaz := 0DT;

        repeat
            BrojRedova += 1;
            ValidirajVrijemenskiInterval(Boravak);

            if BrojRedova = 1 then begin

                if PutniNalog."Departure Date" <> 0D then
                    if DT2Date(Boravak."Datum Vrijeme Ulaska") <> PutniNalog."Departure Date" then
                        Error(
                            'Prva stavka boravka mora početi u trenutku polaska (%1).\nPronađeno: %2',
                            PutniNalog."Departure Date",
                            Boravak."Datum Vrijeme Ulaska");
            end else begin
                if Boravak."Datum Vrijeme Ulaska" <> PrethodniIzlaz then
                    if Boravak."Datum Vrijeme Ulaska" > PrethodniIzlaz then
                        Error(
                            'Postoji vremenska praznina između stavke koja završava u %1 i stavke koja počinje u %2.',
                            PrethodniIzlaz,
                            Boravak."Datum Vrijeme Ulaska")
                    else
                        Error(
                            'Postoji vremensko preklapanje: stavka počinje u %1, a prethodna završava u %2.',
                            Boravak."Datum Vrijeme Ulaska",
                            PrethodniIzlaz);
            end;

            PrethodniIzlaz := Boravak."Datum Vrijeme Izlaska";
        until Boravak.Next() = 0;

        if PutniNalog."Return Date" <> 0D then
            if DT2Date(PrethodniIzlaz) <> PutniNalog."Return Date" then
                Error(
                    'Zadnja stavka boravka mora završiti u trenutku povratka (%1).\nPronađeno: %2',
                    PutniNalog."Return Date",
                    PrethodniIzlaz);
    end;

    procedure PreklapaIzmedjuStavki(
        BrojNaloga: Code[20];
        Ulaz: DateTime;
        Izlaz: DateTime;
        IzuzmiLiniju: Integer): Boolean
    var
        Boravak: Record "Travel Stay By Country";
    begin
        Boravak.SetRange("Broj Naloga", BrojNaloga);
        if IzuzmiLiniju > 0 then
            Boravak.SetFilter("Broj Linije", '<>%1', IzuzmiLiniju);

        if Boravak.FindSet() then
            repeat

                if (Ulaz < Boravak."Datum Vrijeme Izlaska") and
                   (Izlaz > Boravak."Datum Vrijeme Ulaska")
                then
                    exit(true);
            until Boravak.Next() = 0;

        exit(false);
    end;


    procedure DozvolioBrisanje(var Boravak: Record "Travel Stay By Country"): Boolean
    var
        PutniNalog: Record "Travel Order Header SG";
    begin
        if not PutniNalog.Get(Boravak."Broj Naloga") then
            exit(false);
        exit(PutniNalog.Status in [PutniNalog.Status::Open, PutniNalog.Status::Approved]);
    end;

    local procedure ValidirajObaveznaPolia(Boravak: Record "Travel Stay By Country")
    begin
        if Boravak."ISO Kod Drzave" = '' then
            Error('Polje "Država" je obavezno.');
        if Boravak."Datum Vrijeme Ulaska" = 0DT then
            Error('Polje "Datum/Vrijeme Ulaska" je obavezno.');
        if Boravak."Datum Vrijeme Izlaska" = 0DT then
            Error('Polje "Datum/Vrijeme Izlaska" je obavezno.');
    end;

    local procedure ValidirajVrijemenskiInterval(Boravak: Record "Travel Stay By Country")
    begin
        if (Boravak."Datum Vrijeme Ulaska" <> 0DT) and
           (Boravak."Datum Vrijeme Izlaska" <> 0DT) then
            if Boravak."Datum Vrijeme Izlaska" <= Boravak."Datum Vrijeme Ulaska" then
                Error(
                    'Vrijeme izlaska (%1) mora biti striktno veće od vremena ulaska (%2).',
                    Boravak."Datum Vrijeme Izlaska",
                    Boravak."Datum Vrijeme Ulaska");
    end;

    local procedure ValidirajDrzavu(ISOKod: Code[2])
    var
        Drzava: Record "Country/Region";
    begin
        if ISOKod = '' then
            Error('ISO kod države ne može biti prazan.');
        if not Drzava.Get(ISOKod) then
            Error('Država sa ISO kodom "%1" ne postoji u šifarniku.', ISOKod);
    end;
}