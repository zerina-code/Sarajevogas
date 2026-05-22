codeunit 50030 "Travel Order Status Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure Test_ValidTransition_Open_To_Approved()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open, 'TEST-001');
        SetupUserRole("Travel Order User Role SG"::Manager);

        StatusMgt.ApproveOrder(TravelOrderHeader);

        TravelOrderHeader.Get(TravelOrderHeader."No.");
        AssertAreEqual(
            "Travel Order Status"::Approved,
            TravelOrderHeader.Status,
            'Status mora biti Odobreno.');
        VerifyStatusLog(
            TravelOrderHeader."No.",
            "Travel Order Status"::Open,
            "Travel Order Status"::Approved);
    end;

    [Test]
    procedure Test_ValidTransition_Approved_To_ClosedPosted()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
        PostedHeader: Record "Posted Travel Order Header";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Approved, 'TEST-002');
        SetupUserRole("Travel Order User Role SG"::Accountant);

        StatusMgt.PostOrder(TravelOrderHeader);

        TravelOrderHeader.Get(TravelOrderHeader."No.");
        AssertAreEqual(
            "Travel Order Status"::ClosedPosted,
            TravelOrderHeader.Status,
            'Status mora biti Zatvoreno knjiženo.');
        PostedHeader.SetRange("Travel Order No.", TravelOrderHeader."No.");
        AssertIsTrue(PostedHeader.FindFirst(), 'Proknjiženi nalog mora biti kreiran.');
        VerifyStatusLog(
            TravelOrderHeader."No.",
            "Travel Order Status"::Approved,
            "Travel Order Status"::ClosedPosted);
    end;

    [Test]
    procedure Test_ValidTransition_Open_To_Cancelled()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open, 'TEST-003');

        StatusMgt.CancelOrder(TravelOrderHeader);

        TravelOrderHeader.Get(TravelOrderHeader."No.");
        AssertAreEqual(
            "Travel Order Status"::ClosedCancelled,
            TravelOrderHeader.Status,
            'Status mora biti Zatvoreno otkazano.');
        VerifyStatusLog(
            TravelOrderHeader."No.",
            "Travel Order Status"::Open,
            "Travel Order Status"::ClosedCancelled);
    end;

    [Test]
    procedure Test_InvalidTransition_Open_To_ClosedPosted()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open, 'TEST-004');
        SetupUserRole("Travel Order User Role SG"::Accountant);

        asserterror StatusMgt.PostOrder(TravelOrderHeader);
        AssertExpectedError('Nevažeći prijelaz statusa');
    end;

    [Test]
    procedure Test_InvalidTransition_ClosedPosted_ToAny()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::ClosedPosted, 'TEST-005');
        SetupUserRole("Travel Order User Role SG"::Accountant);

        asserterror StatusMgt.CancelOrder(TravelOrderHeader);
        AssertExpectedError('zaključan');
    end;

    [Test]
    procedure Test_InvalidTransition_ClosedCancelled_ToAny()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::ClosedCancelled, 'TEST-006');
        SetupUserRole("Travel Order User Role SG"::Manager);

        asserterror StatusMgt.ApproveOrder(TravelOrderHeader);
        AssertExpectedError('zaključan');
    end;

    [Test]
    procedure Test_Role_EmployeeCannotApprove()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open, 'TEST-007');
        SetupUserRole("Travel Order User Role SG"::Employee);

        asserterror StatusMgt.ApproveOrder(TravelOrderHeader);
        AssertExpectedError('Samo korisnik s ulogom Menadžer');
    end;

    [Test]
    procedure Test_Role_ManagerCannotPost()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Approved, 'TEST-008');
        SetupUserRole("Travel Order User Role SG"::Manager);

        asserterror StatusMgt.PostOrder(TravelOrderHeader);
        AssertExpectedError('Samo korisnik s ulogom Računovodstvo');
    end;

    [Test]
    procedure Test_Role_EmployeeCannotCancel()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open, 'TEST-009');
        SetupUserRole("Travel Order User Role SG"::Employee);

        asserterror StatusMgt.CancelOrder(TravelOrderHeader);
        AssertExpectedError('Zaposlenik ne može otkazati');
    end;

    [Test]
    procedure Test_AuditLog_RecordedOnStatusChange()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
        StatusLog: Record "Travel Status Log";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open, 'TEST-010');
        SetupUserRole("Travel Order User Role SG"::Manager);

        StatusMgt.ApproveOrder(TravelOrderHeader);

        StatusLog.SetRange("Travel Order Status number", TravelOrderHeader."No.");
        AssertIsTrue(StatusLog.FindFirst(), 'Status log mora biti kreiran.');
        AssertAreEqual(
            "Travel Order Status"::Open,
            StatusLog."Previous Status",
            'Prethodni status mora biti Open.');
        AssertAreEqual(
            "Travel Order Status"::Approved,
            StatusLog."New Status",
            'Novi status mora biti Approved.');
    end;

    [Test]
    procedure Test_HeaderNotEditable_WhenClosedPosted()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::ClosedPosted, 'TEST-011');

        asserterror TravelOrderHeader.Validate(Destination, 'Novi grad');
        AssertExpectedError('Izmjene nisu dozvoljene');
    end;

    [Test]
    procedure Test_HeaderEditable_WhenApproved()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Approved, 'TEST-012');

        TravelOrderHeader.Validate(Destination, 'Berlin, Njemačka');
        AssertAreEqual(
            'Berlin, Njemačka',
            TravelOrderHeader.Destination,
            'Polje mora biti izmijenjeno.');
    end;

    // ── Helpers ────────────────────────────────────────────────────────────────

    local procedure CreateTestOrder(
        var TravelOrderHeader: Record "Travel Order Header SG";
        Status: Enum "Travel Order Status";
        TestNo: Code[20])
    begin
        TravelOrderHeader.Init();
        TravelOrderHeader."No." := TestNo;
        TravelOrderHeader."Employee No." := 'EMP001';
        TravelOrderHeader."Departure Date" := Today();
        TravelOrderHeader."Return Date" := Today() + 3;
        TravelOrderHeader.Destination := 'Beč, Austrija';
        TravelOrderHeader.Purpose := 'Poslovna konferencija 2026';
        TravelOrderHeader.Status := Status;
        TravelOrderHeader.Insert(false);
    end;

    local procedure SetupUserRole(Role: Enum "Travel Order User Role SG")
    var
        UserSetup: Record "User Setup";
    begin
        if not UserSetup.Get(UserId()) then begin
            UserSetup.Init();
            UserSetup."User ID" := UserId();
            UserSetup.Insert();
        end;
        UserSetup."User Role" := Role;
        UserSetup.Modify();
    end;
    local procedure VerifyStatusLog(
        OrderNo: Code[20];
        ExpectedPrevious: Enum "Travel Order Status";
        ExpectedNew: Enum "Travel Order Status")
    var
    StatusLog: Record "Travel Status Log";
    begin
        StatusLog.SetRange("Travel Order Status number", OrderNo);
        StatusLog.SetRange("Previous Status", ExpectedPrevious);
        StatusLog.SetRange("New Status", ExpectedNew);
        AssertIsTrue(StatusLog.FindFirst(), 'Status log zapis mora postojati.');
    end;

    local procedure AssertAreEqual(Expected: Variant; Actual: Variant; Message: Text)
    begin
        if Format(Expected) <> Format(Actual) then
            Error('Expected: %1, Actual: %2. %3', Expected, Actual, Message);
    end;

    local procedure AssertIsTrue(Condition: Boolean; Message: Text)
    begin
        if not Condition then
            Error(Message);
    end;

    local procedure AssertExpectedError(ExpectedErrorText: Text)
    begin
        if StrPos(GetLastErrorText(), ExpectedErrorText) = 0 then
            Error('Expected error containing: "%1", but got: "%2"', ExpectedErrorText, GetLastErrorText());
    end;
}