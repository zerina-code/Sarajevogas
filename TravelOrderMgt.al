codeunit 50028 "Travel Order Mgt. SG"
{
    // ============================================================
    // Travel Order Management Codeunit
    // Sadrži svu poslovnu logiku za putne naloge
    // ============================================================

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
        // Validacija zaposlenika
        if not Employee.Get(EmployeeNo) then
            Error('Zaposlenik sa šifrom %1 ne postoji u sistemu.', EmployeeNo);

        // Validacija datuma
        if DepartureDate = 0D then
            Error('Datum polaska je obavezan.');
        if ReturnDate = 0D then
            Error('Datum dolaska je obavezan.');
        if DepartureDate > ReturnDate then
            Error('Datum polaska mora biti prije datuma dolaska.');

        // Validacija odredišta i svrhe
        if Destination = '' then
            Error('Odredište je obavezno polje.');
        if Purpose = '' then
            Error('Svrha putovanja je obavezno polje.');

        // Validacija akontacije
        if AdvanceAmount < 0 then
            Error('Akontacija ne može biti negativna.');

        // Kreiranje naloga
        TravelOrderHeader.Init();
        TravelOrderHeader."Employee No." := EmployeeNo;
        TravelOrderHeader."Departure Date" := DepartureDate;
        TravelOrderHeader."Return Date" := ReturnDate;
        TravelOrderHeader.Destination := Destination;
        TravelOrderHeader.Purpose := Purpose;
        TravelOrderHeader."Advance Amount" := AdvanceAmount;
        TravelOrderHeader."Transport Type" := TransportType;
        // Status se postavlja na Open u OnInsert triggeru tabele
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

        // Provjera da li je nalog u statusu koji dozvoljava izmjenu
        if not TravelOrderHeader.IsEditable() then
            Error('Putni nalog %1 se ne može mijenjati u statusu %2.',
                TravelOrderNo, Format(TravelOrderHeader.Status));

        // Validacija datuma
        if DepartureDate > ReturnDate then
            Error('Datum polaska mora biti prije datuma dolaska.');

        if AdvanceAmount < 0 then
            Error('Akontacija ne može biti negativna.');

        TravelOrderHeader."Departure Date" := DepartureDate;
        TravelOrderHeader."Return Date" := ReturnDate;
        TravelOrderHeader.Destination := Destination;
        TravelOrderHeader.Purpose := Purpose;
        TravelOrderHeader."Advance Amount" := AdvanceAmount;
        TravelOrderHeader."Transport Type" := TransportType;
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
}