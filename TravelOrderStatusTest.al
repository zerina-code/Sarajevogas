/*codeunit 50030 "Travel Order Status Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure Test_ValidTransition_Open_To_Approved()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open);
        SetupUserRole("Travel Order User Role SG"::Manager);

        StatusMgt.ApproveOrder(TravelOrderHeader);

        TravelOrderHeader.Get(TravelOrderHeader."No.");
        Assert.AreEqual(
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
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Approved);
        SetupUserRole("Travel Order User Role SG"::Accountant);

        StatusMgt.PostOrder(TravelOrderHeader);

        TravelOrderHeader.Get(TravelOrderHeader."No.");
        Assert.AreEqual(
            "Travel Order Status"::ClosedPosted,
            TravelOrderHeader.Status,
            'Status mora biti Zatvoreno knjiženo.');
        PostedHeader.SetRange("Travel Order No.", TravelOrderHeader."No.");
        Assert.IsTrue(PostedHeader.FindFirst(), 'Proknjiženi nalog mora biti kreiran.');
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
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open);
        SetupUserRole("Travel Order User Role SG"::Manager);

        StatusMgt.CancelOrder(TravelOrderHeader);

        TravelOrderHeader.Get(TravelOrderHeader."No.");
        Assert.AreEqual(
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
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open);
        SetupUserRole("Travel Order User Role SG"::Accountant);

        asserterror StatusMgt.PostOrder(TravelOrderHeader);
        Assert.ExpectedError('Nevažeći prijelaz statusa');
    end;

    [Test]
    procedure Test_InvalidTransition_ClosedPosted_ToAny()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::ClosedPosted);
        SetupUserRole("Travel Order User Role SG"::Accountant);

        asserterror StatusMgt.CancelOrder(TravelOrderHeader);
        Assert.ExpectedError('zaključan');
    end;

    [Test]
    procedure Test_InvalidTransition_ClosedCancelled_ToAny()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::ClosedCancelled);
        SetupUserRole("Travel Order User Role SG"::Manager);

        asserterror StatusMgt.ApproveOrder(TravelOrderHeader);
        Assert.ExpectedError('zaključan');
    end;

    [Test]
    procedure Test_Role_EmployeeCannotApprove()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open);
        SetupUserRole("Travel Order User Role SG"::Employee);

        asserterror StatusMgt.ApproveOrder(TravelOrderHeader);
        Assert.ExpectedError('Samo korisnik s ulogom Menadžer');
    end;

    [Test]
    procedure Test_Role_ManagerCannotPost()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Approved);
        SetupUserRole("Travel Order User Role SG"::Manager);

        asserterror StatusMgt.PostOrder(TravelOrderHeader);
        Assert.ExpectedError('Samo korisnik s ulogom Računovodstvo');
    end;

    [Test]
    procedure Test_Role_EmployeeCannotCancel()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open);
        SetupUserRole("Travel Order User Role SG"::Employee);

        asserterror StatusMgt.CancelOrder(TravelOrderHeader);
        Assert.ExpectedError('Zaposlenik ne može otkazati');
    end;

    [Test]
    procedure Test_AuditLog_RecordedOnStatusChange()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
        StatusLog: Record "Travel Status Log";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open);
        SetupUserRole("Travel Order User Role SG"::Manager);

        StatusMgt.ApproveOrder(TravelOrderHeader);

        StatusLog.SetRange("Travel Order Status number", TravelOrderHeader."No.");
        Assert.IsTrue(StatusLog.FindFirst(), 'Status log mora biti kreiran.');
        Assert.AreEqual(
            "Travel Order Status"::Open,
            StatusLog."Previous Status",
            'Prethodni status mora biti Open.');
        Assert.AreEqual(
            "Travel Order Status"::Approved,
            StatusLog."New Status",
            'Novi status mora biti Approved.');
    end;

    [Test]
    procedure Test_HeaderNotEditable_WhenClosedPosted()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::ClosedPosted);

        asserterror TravelOrderHeader.Validate(Destination, 'Novi grad');
        Assert.ExpectedError('Izmjene nisu dozvoljene');
    end;

    [Test]
    procedure Test_HeaderEditable_WhenApproved()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Approved);

        TravelOrderHeader.Validate(Destination, 'Berlin, Njemačka');
        Assert.AreEqual(
            'Berlin, Njemačka',
            TravelOrderHeader.Destination,
            'Polje mora biti izmijenjeno.');
    end;

    // ── Helpers ────────────────────────────────────────────────────────────────

    local procedure CreateTestOrder(
        var TravelOrderHeader: Record "Travel Order Header SG";
        Status: Enum "Travel Order Status")
    begin
        TravelOrderHeader.Init();
        TravelOrderHeader."No." := 'TEST-' + CopyStr(Format(CreateGuid()), 2, 8);
        TravelOrderHeader."Employee No." := 'EMP001';
        TravelOrderHeader."Departure Date" := Today();
        TravelOrderHeader."Return Date" := Today() + 3;
        TravelOrderHeader.Destination := 'Beč, Austrija';
        TravelOrderHeader.Purpose := 'Poslovna konferencija 2026';
        //TravelOrderHeader.Status := Status;
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
        Assert.IsTrue(StatusLog.FindFirst(), 'Status log zapis mora postojati.');
    end;

    var
        Assert: Codeunit Assert;
}*/