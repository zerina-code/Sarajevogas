codeunit 50028 "Travel Order Mgt. SG"
{
    procedure CreateTravelOrder(
        EmployeeNo: Code[20];
        DepartureDate: Date;
        ReturnDate: Date;
        Destination: Text[250];
        Purpose: Text[500];
        AdvanceAmount: Decimal;
        TransportType: Text[100];
        var TravelOrderHeader: Record "Travel Order Header SG"
    )
    var
        Employee: Record Employee;
    begin
        if not Employee.Get(EmployeeNo) then
            Error('Zaposlenik sa šifrom %1 ne postoji u sistemu.', EmployeeNo);

        if DepartureDate = 0D then
            Error('Datum polaska je obavezan.');

        if ReturnDate = 0D then
            Error('Datum dolaska je obavezan.');

        if DepartureDate > ReturnDate then
            Error('Datum polaska mora biti prije datuma dolaska.');

        if Destination = '' then
            Error('Odredište je obavezno polje.');

        if Purpose = '' then
            Error('Svrha putovanja je obavezno polje.');

        if AdvanceAmount < 0 then
            Error('Akontacija ne može biti negativna.');

        TravelOrderHeader.Init();
        TravelOrderHeader."Employee No." := EmployeeNo;
        TravelOrderHeader."Departure Date" := DepartureDate;
        TravelOrderHeader."Return Date" := ReturnDate;
        TravelOrderHeader.Destination := Destination;
        TravelOrderHeader.Purpose := Purpose;
        TravelOrderHeader."Advance Amount" := AdvanceAmount;

        if LowerCase(TransportType) = 'službeno' then
            TravelOrderHeader."Transport Type" := TravelOrderHeader."Transport Type"::Sluzbeno
        else
            if LowerCase(TransportType) = 'privatno' then
                TravelOrderHeader."Transport Type" := TravelOrderHeader."Transport Type"::Privatno
            else
                Error('Nepoznata vrsta prijevoza: %1', TransportType);

        TravelOrderHeader.Insert(true);
    end;

    procedure UpdateTravelOrder(
        TravelOrderNo: Code[20];
        DepartureDate: Date;
        ReturnDate: Date;
        Destination: Text[250];
        Purpose: Text[500];
        AdvanceAmount: Decimal;
        TransportType: Text[100]
    )
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        if not TravelOrderHeader.Get(TravelOrderNo) then
            Error('Putni nalog %1 ne postoji.', TravelOrderNo);

        if not TravelOrderHeader.IsEditable() then
            Error('Putni nalog %1 se ne može mijenjati u statusu %2.',
                TravelOrderNo, Format(TravelOrderHeader.Status));

        if DepartureDate > ReturnDate then
            Error('Datum polaska mora biti prije datuma dolaska.');

        if AdvanceAmount < 0 then
            Error('Akontacija ne može biti negativna.');

        TravelOrderHeader."Departure Date" := DepartureDate;
        TravelOrderHeader."Return Date" := ReturnDate;
        TravelOrderHeader.Destination := Destination;
        TravelOrderHeader.Purpose := Purpose;
        TravelOrderHeader."Advance Amount" := AdvanceAmount;

        if LowerCase(TransportType) = 'službeno' then
            TravelOrderHeader."Transport Type" := TravelOrderHeader."Transport Type"::Sluzbeno
        else
            if LowerCase(TransportType) = 'privatno' then
                TravelOrderHeader."Transport Type" := TravelOrderHeader."Transport Type"::Privatno
            else
                Error('Nepoznata vrsta prijevoza: %1', TransportType);

        CalculatePerDiem(TravelOrderHeader);
        TravelOrderHeader.Modify(true);
    end;

    procedure ApproveTravelOrder(TravelOrderNo: Code[20])
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        if not TravelOrderHeader.Get(TravelOrderNo) then
            Error('Putni nalog %1 ne postoji.', TravelOrderNo);

        if TravelOrderHeader.Status <> TravelOrderHeader.Status::Open then
            Error('Samo nalozi u statusu Otvoren se mogu odobriti.');

        TravelOrderHeader.TestField("Employee No.");
        TravelOrderHeader.TestField("Departure Date");
        TravelOrderHeader.TestField("Return Date");
        TravelOrderHeader.TestField(Destination);
        TravelOrderHeader.TestField(Purpose);

        TravelOrderHeader.Status := TravelOrderHeader.Status::Approved;
        TravelOrderHeader."Approved By" := CopyStr(UserId(), 1, MaxStrLen(TravelOrderHeader."Approved By"));
        TravelOrderHeader."Approved Date" := Today();
        TravelOrderHeader.Modify(true);
    end;

    procedure CloseTravelOrder(TravelOrderNo: Code[20]; AsPosted: Boolean)
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        if not TravelOrderHeader.Get(TravelOrderNo) then
            Error('Putni nalog %1 ne postoji.', TravelOrderNo);

        if TravelOrderHeader.Status <> TravelOrderHeader.Status::Approved then
            Error('Samo odobreni nalozi se mogu zatvoriti.');

        if AsPosted then
            TravelOrderHeader.Status := TravelOrderHeader.Status::"ClosedPosted"
        else
            TravelOrderHeader.Status := TravelOrderHeader.Status::Closed;

        TravelOrderHeader.Modify(true);
    end;

    procedure CancelTravelOrder(TravelOrderNo: Code[20])
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        if not TravelOrderHeader.Get(TravelOrderNo) then
            Error('Putni nalog %1 ne postoji.', TravelOrderNo);

        if not (TravelOrderHeader.Status in [
            TravelOrderHeader.Status::Open,
            TravelOrderHeader.Status::Approved])
        then
            Error('Putni nalog %1 se ne može otkazati u statusu %2.',
                TravelOrderNo, Format(TravelOrderHeader.Status));

        TravelOrderHeader.Status := TravelOrderHeader.Status::Cancelled;
        TravelOrderHeader.Modify(true);
    end;

    procedure ValidateTravelOrderForPosting(TravelOrderHeader: Record "Travel Order Header SG")
    begin
        TravelOrderHeader.TestField("No.");
        TravelOrderHeader.TestField("Employee No.");
        TravelOrderHeader.TestField("Departure Date");
        TravelOrderHeader.TestField("Return Date");
        TravelOrderHeader.TestField(Destination);
        TravelOrderHeader.TestField(Purpose);

        if TravelOrderHeader."Departure Date" > TravelOrderHeader."Return Date" then
            Error('Datum polaska mora biti prije datuma dolaska.');

        if TravelOrderHeader."Advance Amount" < 0 then
            Error('Akontacija ne može biti negativna.');
    end;

    procedure CalculatePerDiem(var TravelOrderHeader: Record "Travel Order Header SG")
    var
        PerDiemSetup: Record "Travel Order Per Diem Setup";
        DepartureDateTime: DateTime;
        ReturnDateTime: DateTime;
        DurationMs: BigInteger;
        DurationMinutes: Integer;
        FullDays: Integer;
        RemainingMinutes: Integer;
        PerDiemMultiplier: Decimal;
    begin
        ClearPerDiemFields(TravelOrderHeader);

        if TravelOrderHeader."Departure Date" = 0D then
            exit;

        if TravelOrderHeader."Return Date" = 0D then
            exit;

        if TravelOrderHeader."Departure Time" = 0T then
            exit;

        if TravelOrderHeader."Return Time" = 0T then
            exit;

        if TravelOrderHeader."Country Code" = '' then
            exit;

        DepartureDateTime := CreateDateTime(TravelOrderHeader."Departure Date", TravelOrderHeader."Departure Time");
        ReturnDateTime := CreateDateTime(TravelOrderHeader."Return Date", TravelOrderHeader."Return Time");

        if ReturnDateTime <= DepartureDateTime then
            Error('Vrijeme povratka mora biti nakon vremena polaska.');

        DurationMs := ReturnDateTime - DepartureDateTime;
        DurationMinutes := DurationMs div 60000;

        TravelOrderHeader."Duration Minutes" := DurationMinutes;
        TravelOrderHeader."Duration Text" := FormatDurationText(DurationMinutes);

        // PRIVREMENO ZA TESTIRANJE:
        // Pošto nemaš permission za setup page, za NJEM koristimo testnu dnevnicu 100 BAM.
        // Za ostale države ostaje normalna logika preko setup tabele.
        if TravelOrderHeader."Country Code" = 'NJEM' then
            TravelOrderHeader."Per Diem Base Amount" := 100
        else begin
            if not PerDiemSetup.Get(TravelOrderHeader."Country Code") then
                Error('Nije podešena dnevnica za državu %1.', TravelOrderHeader."Country Code");

            TravelOrderHeader."Per Diem Base Amount" := PerDiemSetup."Full Day Per Diem Amount";
        end;

        FullDays := DurationMinutes div 1440;
        RemainingMinutes := DurationMinutes mod 1440;

        PerDiemMultiplier := FullDays;

        if RemainingMinutes < 240 then begin
            // manje od 4 sata = nema dodatne dnevnice
        end else
            if RemainingMinutes < 480 then
                PerDiemMultiplier += 0.5
            else
                PerDiemMultiplier += 1;

        if PerDiemMultiplier = 0 then
            TravelOrderHeader."Per Diem Type" := TravelOrderHeader."Per Diem Type"::None
        else
            if PerDiemMultiplier = 0.5 then
                TravelOrderHeader."Per Diem Type" := TravelOrderHeader."Per Diem Type"::Half
            else
                if PerDiemMultiplier = 1 then
                    TravelOrderHeader."Per Diem Type" := TravelOrderHeader."Per Diem Type"::Full
                else
                    TravelOrderHeader."Per Diem Type" := TravelOrderHeader."Per Diem Type"::"Multiple Full";

        TravelOrderHeader."Per Diem Amount" := TravelOrderHeader."Per Diem Base Amount" * PerDiemMultiplier;
    end;

    local procedure ClearPerDiemFields(var TravelOrderHeader: Record "Travel Order Header SG")
    begin
        TravelOrderHeader."Duration Minutes" := 0;
        TravelOrderHeader."Duration Text" := '';
        TravelOrderHeader."Per Diem Type" := TravelOrderHeader."Per Diem Type"::None;
        TravelOrderHeader."Per Diem Base Amount" := 0;
        TravelOrderHeader."Per Diem Amount" := 0;
    end;

    local procedure FormatDurationText(DurationMinutes: Integer): Text[100]
    var
        Days: Integer;
        Hours: Integer;
        Minutes: Integer;
    begin
        Days := DurationMinutes div 1440;
        Hours := (DurationMinutes mod 1440) div 60;
        Minutes := DurationMinutes mod 60;

        exit(StrSubstNo('%1 dana, %2 sati, %3 minuta', Days, Hours, Minutes));
    end;
}