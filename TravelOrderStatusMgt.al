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
        Assert.AreEqual("Travel Order Status"::Approved, TravelOrderHeader.Status, 'Status mora biti Odobreno.');
        VerifyAuditLogExists(TravelOrderHeader."No.", "Travel Order Status SG"::Open, "Travel Order Status SG"::Approved);
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
        Assert.AreEqual("Travel Order Status"::ClosedPosted, TravelOrderHeader.Status, 'Status mora biti Zatvoreno knjiženo.');
        PostedHeader.SetRange("Travel Order No.", TravelOrderHeader."No.");
        Assert.IsTrue(PostedHeader.FindFirst(), 'Proknjiženi nalog mora biti kreiran.');
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
        Assert.AreEqual("Travel Order Status"::ClosedCancelled, TravelOrderHeader.Status, 'Status mora biti Zatvoreno otkazano.');
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
    procedure Test_AuditLog_RecordedOnEveryChange()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        StatusMgt: Codeunit "Travel Status Management";
        StatusLog: Record "Travel Status Audit Log";
    begin
        CreateTestOrder(TravelOrderHeader, "Travel Order Status"::Open);
        SetupUserRole("Travel Order User Role SG"::Manager);

        StatusMgt.ApproveOrder(TravelOrderHeader);

        StatusLog.SetRange("Travel Order No.", TravelOrderHeader."No.");
        Assert.IsTrue(StatusLog.FindFirst(), 'Audit log mora biti kreiran.');
        Assert.AreEqual(UserId(), StatusLog."Changed By", 'Log mora sadržavati korisnika.');
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
        Assert.AreEqual('Berlin, Njemačka', TravelOrderHeader.Destination, 'Polje mora biti izmijenjeno.');
    end;


    local procedure CreateTestOrder(var TravelOrderHeader: Record "Travel Order Header SG"; Status: Enum "Travel Order Status")
    begin
        TravelOrderHeader.Init();
        TravelOrderHeader."No." := 'TEST-' + Format(CreateGuid()).Substring(1, 8);
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
        UserSetup: Record "Travel Order User Setup";
    begin
        if UserSetup.Get(UserId()) then
            UserSetup.Delete();
        UserSetup.Init();
        UserSetup."User ID" := UserId();
        UserSetup."User Role" := Role;
        UserSetup.Insert();
    end;

    local procedure VerifyAuditLogExists(OrderNo: Code[20]; OldStatus: Enum "Travel Order Status SG"; NewStatus: Enum "Travel Order Status SG")
    var
        StatusLog: Record "Travel Status Audit Log";
    begin
        StatusLog.SetRange("Travel Order No.", OrderNo);
        StatusLog.SetRange("Old Status", OldStatus);
        StatusLog.SetRange("New Status", NewStatus);
        Assert.IsTrue(StatusLog.FindFirst(), 'Audit log zapis mora postojati.');
    end;

    var
        Assert: Codeunit Assert;
}*/