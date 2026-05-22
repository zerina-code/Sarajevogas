codeunit 50027 "Travel Status Management"
{
    procedure ChangeStatus(var TravelOrderHeader: Record "Travel Order Header SG"; NewStatus: Enum "Travel Order Status SG")
    var
        OldStatus: Enum "Travel Order Status SG";
    begin
        OldStatus := TravelOrderHeader.Status;

        ValidateTransition(OldStatus, NewStatus);
        ValidateUserRole(NewStatus);

        TravelOrderHeader.Status := NewStatus;
        TravelOrderHeader.Modify(false);  // false = ne triggera OnModify provjeru za editability

        // LogStatusChange(TravelOrderHeader."No.", OldStatus, NewStatus, '');

        // Ako je knjiženo → prebaci podatke u Posted tabele
        if NewStatus = "Travel Order Status SG"::ClosedPosted then
            TransferToPosted(TravelOrderHeader);
    end;

    procedure ApproveOrder(var TravelOrderHeader: Record "Travel Order Header SG")
    begin
        ChangeStatus(TravelOrderHeader, "Travel Order Status SG"::Approved);
    end;

    /// Knjiži nalog (Odobreno → Zatvoreno knjiženo). Samo računovodstvo.
    procedure PostOrder(var TravelOrderHeader: Record "Travel Order Header SG")
    begin
        ChangeStatus(TravelOrderHeader, "Travel Order Status SG"::ClosedPosted);
    end;

    /// Otkaže nalog (Otvoreno ili Odobreno → Zatvoreno otkazano).
    procedure CancelOrder(var TravelOrderHeader: Record "Travel Order Header SG")
    begin
        ChangeStatus(TravelOrderHeader, "Travel Order Status SG"::ClosedCancelled);
    end;

    local procedure ValidateTransition(OldStatus: Enum "Travel Order Status SG"; NewStatus: Enum "Travel Order Status SG")
    begin
        // Iz zaključanih statusa ne može ništa
        if OldStatus in ["Travel Order Status SG"::ClosedPosted, "Travel Order Status SG"::ClosedCancelled] then
            Error('Status "%1" je zaključan. Promjena statusa nije dozvoljena.', OldStatus);

        case OldStatus of
            "Travel Order Status SG"::Open:
                // Iz Otvoreno može ići samo u Odobreno ili Zatvoreno otkazano
                if not (NewStatus in ["Travel Order Status SG"::Approved, "Travel Order Status SG"::ClosedCancelled]) then
                    Error('Nevažeći prijelaz statusa: %1 → %2. Dozvoljeno: Odobreno ili Zatvoreno otkazano.', OldStatus, NewStatus);

            "Travel Order Status SG"::Approved:
                // Iz Odobreno može ići u Zatvoreno knjiženo ili Zatvoreno otkazano
                if not (NewStatus in ["Travel Order Status SG"::ClosedPosted, "Travel Order Status SG"::ClosedCancelled]) then
                    Error('Nevažeći prijelaz statusa: %1 → %2. Dozvoljeno: Zatvoreno knjiženo ili Zatvoreno otkazano.', OldStatus, NewStatus);
        end;
    end;

    local procedure ValidateUserRole(NewStatus: Enum "Travel Order Status SG")
    var
        UserRole: Enum "Travel Order User Role SG";
    begin
        UserRole := GetCurrentUserRole();

        case NewStatus of
            "Travel Order Status SG"::Approved:
                if UserRole <> "Travel Order User Role SG"::Manager then
                    Error('Samo korisnik s ulogom Menadžer može odobriti putni nalog.');

            "Travel Order Status SG"::ClosedPosted:
                if UserRole <> "Travel Order User Role SG"::Accountant then
                    Error('Samo korisnik s ulogom Računovodstvo može knjižiti putni nalog.');

            "Travel Order Status SG"::ClosedCancelled:
                // Otkazivanje može Manager ili Accountant (zaposlenik ne može sam)
                if UserRole = "Travel Order User Role SG"::Employee then
                    Error('Zaposlenik ne može otkazati putni nalog. Kontaktirajte menadžera.');
        end;
    end;

    local procedure GetCurrentUserRole(): Enum "Travel Order User Role SG"
    var
        TravelUserSetup: Record "User Setup";
    begin
        if not TravelUserSetup.Get(UserId()) then
            Error('Korisnik "%1" nema definisanu rolu u sistemu putnih naloga.', UserId());
        exit(TravelUserSetup."User Role");
    end;

    /// Audit log — obavezan za svaku promjenu statusa bez izuzetaka (FR-13)
    local procedure LogStatusChange(TravelOrderNo: Code[20]; OldStatus: Enum "Travel Order Status SG"; NewStatus: Enum "Travel Order Status SG"; Comment: Text[250])
    var
        StatusLog: Record "Travel Status Audit Log";
    begin
        /*  StatusLog.Init();
          StatusLog."Travel Order No." := TravelOrderNo;
          StatusLog."Old Status" := OldStatus;
          StatusLog."New Status" := NewStatus;
          StatusLog."Changed By" := UserId();
          StatusLog."Changed At" := CurrentDateTime();
          /*StatusLog.Comment := Comment;
          StatusLog.Insert(true);*/
    end;

    local procedure TransferToPosted(TravelOrderHeader: Record "Travel Order Header SG")
    var
        PostedHeader: Record "Posted Travel Order Header";
        TravelOrderLine: Record "Posted Travel Order Line";
        PostedLine: Record "Posted Travel Order Line";
        PostedNo: Code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        PostedNo := NoSeriesMgt.GetNextNo('PUTNALOGPROK', Today(), true);
        PostedHeader.Init();
        PostedHeader."No." := PostedNo;
        PostedHeader."Travel Order No." := Format(TravelOrderHeader."No.");
        PostedHeader."Employee No." := TravelOrderHeader."Employee No.";
        PostedHeader."Departure Date" := TravelOrderHeader."Departure Date";
        PostedHeader."Return Date" := TravelOrderHeader."Return Date";
        PostedHeader.Destination := TravelOrderHeader.Destination;
        PostedHeader.Purpose := TravelOrderHeader.Purpose;
        PostedHeader."Advance Amount" := TravelOrderHeader."Advance Amount";
        PostedHeader."Posted By" := UserId();
        PostedHeader."Posted At" := CurrentDateTime();
        PostedHeader.Insert(true);
        /*TravelOrderLine.SetRange("Posted Travel Order Line", TravelOrderHeader."No.");*/
        if TravelOrderLine.FindSet() then
            repeat
                PostedLine.Init();
                PostedLine."Posted Order No." := PostedNo;
                PostedLine."Line No." := TravelOrderLine."Line No.";
                PostedLine."Country Code" := TravelOrderLine."Country Code";
                PostedLine."Entry DateTime" := TravelOrderLine."Entry DateTime";
                PostedLine."Exit DateTime" := TravelOrderLine."Exit DateTime";
                PostedLine."Duration Hours" := TravelOrderLine."Duration Hours";
                PostedLine."Per Diem Amount" := TravelOrderLine."Per Diem Amount";
                PostedLine."Per Diem Amount BAM" := TravelOrderLine."Per Diem Amount BAM";
                PostedLine."Correction Type" := TravelOrderLine."Correction Type";
                PostedLine.Insert(true);
            until TravelOrderLine.Next() = 0;
    end;
}