/*codeunit 50029 "Travel Order Tests SG"
{
    Subtype = Test;
    TestPermissions = Disabled;

    // ============================================================
    // UNIT TESTOVI - Validacije
    // ============================================================

    [Test]
    procedure TestCreateTravelOrder_Success()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
        EmployeeNo: Code[20];
    begin
        // [GIVEN] Postoji zaposlenik u sistemu
        EmployeeNo := CreateTestEmployee();

        // [WHEN] Kreiramo nalog sa ispravnim podacimat
        TravelOrderMgt.CreateTravelOrder(
            EmployeeNo,
            CalcDate('<+1D>', Today()),
            CalcDate('<+5D>', Today()),
            'Sarajevo',
            'Poslovna posjeta',
            100,
            'Automobil',
            TravelOrderHeader
        );

        // [THEN] Nalog je kreiran sa statusom Open
        Assert.AreEqual(
            TravelOrderHeader.Status::Open,
            TravelOrderHeader.Status,
            'Novokreirani nalog mora imati status Otvoren'
        );

        // [THEN] Broj naloga je popunjen (auto-generated)
        Assert.IsTrue(TravelOrderHeader."No." <> '', 'Broj naloga mora biti auto-generisan');

        // Cleanup
        TravelOrderHeader.Delete(true);
        DeleteTestEmployee(EmployeeNo);
    end;

    [Test]
    procedure TestCreateTravelOrder_InvalidEmployee()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
    begin
        // [GIVEN/WHEN/THEN] Kreiranje naloga sa nepostojećim zaposlenikom baca grešku
        asserterror TravelOrderMgt.CreateTravelOrder(
            'NEPOSTOJI999',
            CalcDate('<+1D>', Today()),
            CalcDate('<+5D>', Today()),
            'Sarajevo',
            'Poslovna posjeta',
            0,
            '',
            TravelOrderHeader
        );

        Assert.ExpectedError('Zaposlenik sa šifrom NEPOSTOJI999 ne postoji u sistemu.');
    end;

    [Test]
    procedure TestValidation_DepartureDateAfterReturnDate()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
        EmployeeNo: Code[20];
    begin
        // [GIVEN] Postoji zaposlenik
        EmployeeNo := CreateTestEmployee();

        // [WHEN/THEN] Datum polaska je POSLIJE datuma dolaska - mora baciti grešku
        asserterror TravelOrderMgt.CreateTravelOrder(
            EmployeeNo,
            CalcDate('<+10D>', Today()),  // polazak nakon dolaska!
            CalcDate('<+5D>', Today()),
            'Sarajevo',
            'Test',
            0,
            '',
            TravelOrderHeader
        );

        Assert.ExpectedError('Datum polaska mora biti prije datuma dolaska.');
        DeleteTestEmployee(EmployeeNo);
    end;

    [Test]
    procedure TestValidation_NegativeAdvanceAmount()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
        EmployeeNo: Code[20];
    begin
        // [GIVEN] Postoji zaposlenik
        EmployeeNo := CreateTestEmployee();

        // [WHEN/THEN] Negativna akontacija mora baciti grešku
        asserterror TravelOrderMgt.CreateTravelOrder(
            EmployeeNo,
            CalcDate('<+1D>', Today()),
            CalcDate('<+5D>', Today()),
            'Sarajevo',
            'Test',
            -50,  // negativna akontacija!
            '',
            TravelOrderHeader
        );

        Assert.ExpectedError('Akontacija ne može biti negativna.');
        DeleteTestEmployee(EmployeeNo);
    end;

    [Test]
    procedure TestValidation_MissingMandatoryFields()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
        EmployeeNo: Code[20];
    begin
        // [GIVEN] Postoji zaposlenik
        EmployeeNo := CreateTestEmployee();

        // [WHEN/THEN] Prazno odredište mora baciti grešku
        asserterror TravelOrderMgt.CreateTravelOrder(
            EmployeeNo,
            CalcDate('<+1D>', Today()),
            CalcDate('<+5D>', Today()),
            '',   // prazno odredište!
            'Test',
            0,
            '',
            TravelOrderHeader
        );

        Assert.ExpectedError('Odredište je obavezno polje.');
        DeleteTestEmployee(EmployeeNo);
    end;

    [Test]
    procedure TestEditBlocked_ClosedPostedStatus()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
        EmployeeNo: Code[20];
    begin
        // [GIVEN] Kreiran i zatvoren/knjižen nalog
        EmployeeNo := CreateTestEmployee();
        TravelOrderMgt.CreateTravelOrder(
            EmployeeNo,
            CalcDate('<+1D>', Today()),
            CalcDate('<+5D>', Today()),
            'Sarajevo',
            'Poslovna posjeta',
            100,
            '',
            TravelOrderHeader
        );

        // Simuliramo status Closed Posted
        TravelOrderHeader.Status := TravelOrderHeader.Status::"ClosedPosted";
        TravelOrderHeader.Modify();

        // [WHEN/THEN] Pokušaj izmjene mora biti blokiran
        asserterror TravelOrderMgt.UpdateTravelOrder(
            TravelOrderHeader."No.",
            CalcDate('<+2D>', Today()),
            CalcDate('<+6D>', Today()),
            'Mostar',
            'Izmjena',
            200,
            'Vlak'
        );

        Assert.IsTrue(StrPos(GetLastErrorText(), 'ne može mijenjati') > 0,
            'Izmjena zatvorenog/knjiženog naloga mora biti blokirana');

        // Cleanup
        TravelOrderHeader.Delete();
        DeleteTestEmployee(EmployeeNo);
    end;

    [Test]
    procedure TestStatusTransition_OpenToApproved()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
        EmployeeNo: Code[20];
    begin
        // [GIVEN] Otvoren nalog
        EmployeeNo := CreateTestEmployee();
        TravelOrderMgt.CreateTravelOrder(
            EmployeeNo,
            CalcDate('<+1D>', Today()),
            CalcDate('<+5D>', Today()),
            'Sarajevo',
            'Poslovna posjeta',
            100,
            'Automobil',
            TravelOrderHeader
        );

        // [WHEN] Odobrimo nalog
        TravelOrderMgt.ApproveTravelOrder(TravelOrderHeader."No.");

        // [THEN] Status je Approved
        TravelOrderHeader.Get(TravelOrderHeader."No.");
        Assert.AreEqual(
            TravelOrderHeader.Status::Approved,
            TravelOrderHeader.Status,
            'Nakon odobravanja status mora biti Odobreno'
        );
        Assert.IsTrue(TravelOrderHeader."Approved By" <> '', 'Approved By mora biti popunjen');
        Assert.IsTrue(TravelOrderHeader."Approved Date" <> 0D, 'Approved Date mora biti popunjen');

        // Cleanup
        TravelOrderHeader.Delete();
        DeleteTestEmployee(EmployeeNo);
    end;

    // ============================================================
    // INTEGRACIONI TEST - Kreiranje naloga end-to-end
    // ============================================================

    [Test]
    procedure IntegrationTest_CreateAndProcessTravelOrder()
    var
        TravelOrderHeader: Record "Travel Order Header SG";
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
        EmployeeNo: Code[20];
        TravelOrderNo: Code[20];
    begin
        // ============================================================
        // Integracioni test: Kreiranje naloga i praćenje kroz statuse
        // ============================================================

        // [GIVEN] Postoji zaposlenik u sistemu
        EmployeeNo := CreateTestEmployee();

        // [STEP 1] Kreiranje naloga
        TravelOrderMgt.CreateTravelOrder(
            EmployeeNo,
            CalcDate('<+3D>', Today()),
            CalcDate('<+7D>', Today()),
            'Banja Luka',
            'Godišnji sastanak',
            250,
            'Automobil',
            TravelOrderHeader
        );

        TravelOrderNo := TravelOrderHeader."No.";

        // Provjera kreiranog naloga
        Assert.IsTrue(TravelOrderNo <> '', 'Broj naloga mora biti generisan');
        Assert.AreEqual(TravelOrderHeader.Status::Open, TravelOrderHeader.Status, 'Status mora biti Otvoren');
        Assert.IsTrue(TravelOrderHeader."Created By" <> '', 'Created By mora biti popunjen');
        Assert.IsTrue(TravelOrderHeader."Created Date" <> 0D, 'Created Date mora biti popunjen');

        // Nalog je vidljiv u sistemu
        Assert.IsTrue(TravelOrderHeader.Get(TravelOrderNo), 'Nalog mora biti vidljiv u bazi');

        // [STEP 2] Izmjena u statusu Open - mora raditi
        TravelOrderMgt.UpdateTravelOrder(
            TravelOrderNo,
            CalcDate('<+3D>', Today()),
            CalcDate('<+8D>', Today()),
            'Banja Luka - izmijenjeno',
            'Godišnji sastanak - ažurirano',
            300,
            'Kombibus'
        );

        TravelOrderHeader.Get(TravelOrderNo);
        Assert.AreEqual('Banja Luka - izmijenjeno', TravelOrderHeader.Destination,
            'Izmjena odredišta u Open statusu mora biti moguća');

        // [STEP 3] Odobravanje naloga
        TravelOrderMgt.ApproveTravelOrder(TravelOrderNo);

        TravelOrderHeader.Get(TravelOrderNo);
        Assert.AreEqual(TravelOrderHeader.Status::Approved, TravelOrderHeader.Status,
            'Status mora biti Odobreno');

        // [STEP 4] Izmjena u statusu Approved - mora raditi
        TravelOrderMgt.UpdateTravelOrder(
            TravelOrderNo,
            CalcDate('<+3D>', Today()),
            CalcDate('<+8D>', Today()),
            'Banja Luka',
            'Godišnji sastanak',
            300,
            'Automobil'
        );

        // [STEP 5] Zatvaranje naloga
        TravelOrderMgt.CloseTravelOrder(TravelOrderNo, true); // AsPosted = true

        TravelOrderHeader.Get(TravelOrderNo);
        Assert.AreEqual(TravelOrderHeader.Status::"ClosedPosted", TravelOrderHeader.Status,
            'Status mora biti Zatvoreno knjiženo');

        // [STEP 6] Izmjena zatvorenog naloga - mora biti blokirana
        asserterror TravelOrderMgt.UpdateTravelOrder(
            TravelOrderNo,
            CalcDate('<+3D>', Today()),
            CalcDate('<+8D>', Today()),
            'Mostar',
            'Nova svrha',
            500,
            'Vlak'
        );

        Assert.IsTrue(StrPos(GetLastErrorText(), 'ne može mijenjati') > 0,
            'Izmjena zatvorenog naloga mora biti blokirana');

        // Cleanup
        TravelOrderHeader.Delete();
        DeleteTestEmployee(EmployeeNo);

        Message('✓ Integracioni test uspješno završen!');
    end;

    // ============================================================
    // HELPER METODE
    // ============================================================

    local procedure CreateTestEmployee(): Code[20]
    var
        Employee: Record Employee;
    begin
        Employee.Init();
        Employee."No." := 'TEST-EMP-001';
        Employee."First Name" := 'Test';
        Employee."Last Name" := 'Zaposlenik';
        Employee."Job Title" := 'Tester';
        if not Employee.Get('TEST-EMP-001') then
            Employee.Insert(true);
        exit('TEST-EMP-001');
    end;

    local procedure DeleteTestEmployee(EmployeeNo: Code[20])
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmployeeNo) then
            Employee.Delete(true);
    end;

    var
        Assert: Codeunit Assert;
}*/