codeunit 50032 "Boravak po Drzavama Tests"
{
    Subtype = Test;

    var
        BoravakMgt: Codeunit "Stay Validation Mgt.";
        LibraryAssert: Codeunit "Library Assert";
        BrojNalogaTest: Code[20];


    procedure Setup()
    begin
        BrojNalogaTest := 'TEST-001';
        OcistiTestPodatke();
    end;

    procedure Teardown()
    begin
        OcistiTestPodatke();
    end;

    // ─────────────────────────────────────────────────────────────────
    //  UNIT TESTOVI
    // ─────────────────────────────────────────────────────────────────

    [Test]
    procedure Test_ValidanInterval_ProlaziValidaciju()
    // Acceptance: korisnik može dodati stavku sa validnim intervalom
    var
        Boravak: Record "Travel Stay By Country";
    begin
        // Arrange
        KreirajBoravakRec(Boravak, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 200000T));

        // Act & Assert — ne smije baciti grešku
        BoravakMgt.ValidirajBoravak(Boravak);
    end;

    [Test]
    procedure Test_IzlazakPrijeUlaska_BacaError()
    // Acceptance: sistem sprječava čuvanje nevalidnog vremenskog raspona
    var
        Boravak: Record "Travel Stay By Country";
        ErrorPoruka: Text;
    begin
        // Arrange
        KreirajBoravakRec(Boravak, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 200000T),   // Ulaz: 20h
            CreateDateTime(20260501D, 080000T));  // Izlaz: 08h — NEVALIDAN

        // Act
        asserterror BoravakMgt.ValidirajBoravak(Boravak);

        // Assert
        ErrorPoruka := GetLastErrorText();
        LibraryAssert.IsTrue(
            ErrorPoruka.Contains('striktno veće'),
            'Greška mora objasniti da izlaz mora biti veći od ulaska.');
    end;

    [Test]
    procedure Test_PreklapanieIntervala_BacaError()
    // Acceptance: nije moguće kreirati preklapanje
    var
        Boravak1: Record "Travel Stay By Country";
        Boravak2: Record "Travel Stay By Country";
        Preklapa: Boolean;
    begin
        // Arrange — insert prve stavke direktno u tabelu
        KreirajBoravakRec(Boravak1, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 180000T));
        Boravak1.Insert();

        // Act — drugi interval preklapa prvog
        Preklapa := BoravakMgt.PreklapaIzmedjuStavki(
            BrojNalogaTest,
            CreateDateTime(20260501D, 120000T),  // unutar prvog intervala
            CreateDateTime(20260501D, 200000T),
            0);

        // Assert
        LibraryAssert.IsTrue(Preklapa, 'Sistem mora detektovati preklapanje intervala.');
    end;

    [Test]
    procedure Test_BezPreklapanja_VracaFalse()
    var
        Boravak1: Record "Travel Stay By Country";
        Preklapa: Boolean;
    begin
        // Arrange
        KreirajBoravakRec(Boravak1, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 120000T));
        Boravak1.Insert();

        // Act — sukcesivni interval, bez preklapanja
        Preklapa := BoravakMgt.PreklapaIzmedjuStavki(
            BrojNalogaTest,
            CreateDateTime(20260501D, 120000T),  // počinje tačno gdje prethodni završava
            CreateDateTime(20260501D, 200000T),
            0);

        // Assert
        LibraryAssert.IsFalse(Preklapa, 'Sukcesivni intervali ne smiju biti označeni kao preklapanje.');
    end;

    [Test]
    procedure Test_PrazninaIzmedjuStavki_BacaError()
    // Acceptance: sistem validira da nema praznina
    var
        Boravak1: Record "Travel Stay By Country";
        Boravak2: Record "Travel Stay By Country";
    begin
        // Arrange: praznina od 2h između stavki
        KreirajBoravakRec(Boravak1, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 120000T));
        Boravak1.Insert();

        KreirajBoravakRec(Boravak2, BrojNalogaTest, 20000, 'AT',
            CreateDateTime(20260501D, 140000T),  // praznina: 12h → 14h
            CreateDateTime(20260501D, 200000T));
        Boravak2.Insert();

        // Act & Assert
        asserterror BoravakMgt.ValidirajKontinuitetBoravaka(BrojNalogaTest);
        LibraryAssert.IsTrue(
            GetLastErrorText().Contains('praznina'),
            'Greška mora ukazivati na vremensku prazninu.');
    end;

    [Test]
    procedure Test_ViseZemalja_ValidanKontinuitet()
    // Acceptance: sistem podržava više država u jednom putovanju
    var
        B1: Record "Travel Stay By Country";
        B2: Record "Travel Stay By Country";
        B3: Record "Travel Stay By Country";
    begin
        // Arrange: BiH → DE → AT, bez praznina
        KreirajBoravakRec(B1, BrojNalogaTest, 10000, 'BA',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 120000T));
        B1.Insert();

        KreirajBoravakRec(B2, BrojNalogaTest, 20000, 'DE',
            CreateDateTime(20260501D, 120000T),
            CreateDateTime(20260501D, 200000T));
        B2.Insert();

        KreirajBoravakRec(B3, BrojNalogaTest, 30000, 'AT',
            CreateDateTime(20260501D, 200000T),
            CreateDateTime(20260502D, 080000T));
        B3.Insert();

        // Act & Assert — ne smije baciti grešku
        BoravakMgt.ValidirajKontinuitetBoravaka(BrojNalogaTest);
    end;

    [Test]
    procedure Test_Tranzit_ObracunavanKaoStandard()
    // Acceptance: tranzit se tretira kao standardna stavka
    var
        Boravak: Record "Travel Stay By Country";
    begin
        // Arrange
        KreirajBoravakRec(Boravak, BrojNalogaTest, 10000, 'HR',
            CreateDateTime(20260501D, 100000T),
            CreateDateTime(20260501D, 110000T));
        Boravak."Tip Boravka" := Boravak."Tip Boravka"::Tranzit;

        // Act & Assert — validacija prolazi isti kao za Standard
        BoravakMgt.ValidirajBoravak(Boravak);
    end;

    [Test]
    procedure Test_IzracunTrajanja_TacnostNaMinute()
    // Acceptance: trajanje se računa precizno na minute
    var
        Boravak: Record "Travel Stay By Country";
    begin
        // Arrange: 2 sata 35 minuta = 155 minuta
        KreirajBoravakRec(Boravak, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 103500T));

        // Act
        Boravak.IzracunajTrajanje();

        // Assert
        LibraryAssert.AreEqual(155, Boravak."Trajanje Minuta",
            'Trajanje mora biti 155 minuta (2h 35min).');
        LibraryAssert.AreEqual('2h 35min', Boravak."Trajanje Tekst",
            'Trajanje tekst mora biti "2h 35min".');
    end;

    [Test]
    procedure Test_PraznaStateDrzave_BacaError()
    // Acceptance: nije dozvoljeno čuvanje prazne države
    var
        Boravak: Record "Travel Stay By Country";
    begin
        KreirajBoravakRec(Boravak, BrojNalogaTest, 10000, '',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 200000T));

        asserterror BoravakMgt.ValidirajBoravak(Boravak);
        LibraryAssert.IsTrue(
            GetLastErrorText().Contains('obavezno'),
            'Greška mora ukazivati na praznu državu.');
    end;

    // ─────────────────────────────────────────────────────────────────
    //  INTEGRACIJSKI TESTOVI
    // ─────────────────────────────────────────────────────────────────

    [Test]
    procedure IntTest_KompletanFlowUnosaViseDrzava()
    // Acceptance: kompletan flow unosa više država
    var
        Boravak: Record "Travel Stay By Country";
        B1: Record "Travel Stay By Country";
        B2: Record "Travel Stay By Country";
        B3: Record "Travel Stay By Country";
    begin
        // Simuliramo unos: BA → DE → AT, svaki validan

        // Stavka 1
        KreirajBoravakRec(B1, BrojNalogaTest, 10000, 'BA',
            CreateDateTime(20260501D, 060000T),
            CreateDateTime(20260501D, 100000T));
        BoravakMgt.ValidirajBoravak(B1);
        B1.Insert(true);

        // Stavka 2
        KreirajBoravakRec(B2, BrojNalogaTest, 20000, 'DE',
            CreateDateTime(20260501D, 100000T),
            CreateDateTime(20260502D, 060000T));
        BoravakMgt.ValidirajBoravak(B2);
        B2.Insert(true);

        // Stavka 3
        KreirajBoravakRec(B3, BrojNalogaTest, 30000, 'AT',
            CreateDateTime(20260502D, 060000T),
            CreateDateTime(20260502D, 200000T));
        BoravakMgt.ValidirajBoravak(B3);
        B3.Insert(true);

        // Provjeri ukupan broj stavki
        Boravak.SetRange("Broj Naloga", BrojNalogaTest);
        LibraryAssert.AreEqual(3, Boravak.Count(), 'Moraju postojati 3 stavke boravka.');

        // Validiraj kontinuitet
        BoravakMgt.ValidirajKontinuitetBoravaka(BrojNalogaTest);
    end;

    [Test]
    procedure IntTest_EditPostojecegIntervala()
    // Acceptance: edit postojećih intervala
    var
        Boravak: Record "Travel Stay By Country";
    begin
        // Insert
        KreirajBoravakRec(Boravak, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 180000T));
        Boravak.Insert(true);

        // Modify
        Boravak.Get(BrojNalogaTest, 10000);
        Boravak."Datum Vrijeme Izlaska" := CreateDateTime(20260501D, 200000T);
        BoravakMgt.ValidirajBoravak(Boravak);
        Boravak.Modify(true);

        // Assert
        Boravak.Get(BrojNalogaTest, 10000);
        LibraryAssert.AreEqual(
            CreateDateTime(20260501D, 200000T),
            Boravak."Datum Vrijeme Izlaska",
            'Izlazak mora biti ažuriran na 20:00.');
    end;

    [Test]
    procedure IntTest_BrisanjeIntervala()
    // Acceptance: korisnik može obrisati stavku
    var
        Boravak: Record "Travel Stay By Country";
        B1: Record "Travel Stay By Country";
        B2: Record "Travel Stay By Country";
    begin
        // Insert 2 stavke
        KreirajBoravakRec(B1, BrojNalogaTest, 10000, 'DE',
            CreateDateTime(20260501D, 080000T),
            CreateDateTime(20260501D, 140000T));
        B1.Insert(true);

        KreirajBoravakRec(B2, BrojNalogaTest, 20000, 'AT',
            CreateDateTime(20260501D, 140000T),
            CreateDateTime(20260501D, 200000T));
        B2.Insert(true);

        // Delete prvu
        Boravak.Get(BrojNalogaTest, 10000);
        Boravak.Delete(true);

        // Assert
        Boravak.SetRange("Broj Naloga", BrojNalogaTest);
        LibraryAssert.AreEqual(1, Boravak.Count(), 'Nakon brisanja mora ostati samo 1 stavka.');
    end;

    // ─────────────────────────────────────────────────────────────────
    //  Pomocne procedure
    // ─────────────────────────────────────────────────────────────────

    local procedure KreirajBoravakRec(
        var Boravak: Record "Travel Stay By Country";
        BrojNaloga: Code[20];
        BrojLinije: Integer;
        ISOKod: Code[2];
        Ulaz: DateTime;
        Izlaz: DateTime)
    begin
        Clear(Boravak);
        Boravak."Broj Naloga" := BrojNaloga;
        Boravak."Broj Linije" := BrojLinije;
        Boravak."ISO Kod Drzave" := ISOKod;
        Boravak."Datum Vrijeme Ulaska" := Ulaz;
        Boravak."Datum Vrijeme Izlaska" := Izlaz;
        Boravak."Tip Boravka" := Boravak."Tip Boravka"::Standard;
        Boravak.IzracunajTrajanje();
    end;

    local procedure OcistiTestPodatke()
    var
        Boravak: Record "Travel Stay By Country";
    begin
        Boravak.SetRange("Broj Naloga", BrojNalogaTest);
        Boravak.DeleteAll();
    end;
}