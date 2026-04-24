report 50030 "TS_knjizenja 2"
{
    // // NK01 01.02.2018. - Excel export
    DefaultLayout = RDLC;
    RDLCLayout = './TS_knjizenja 2_real.rdl';
    UseRequestPage = true;
    ProcessingOnly = false;
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem(DataItem2; "Wage/Reduction Bank Accounts")
        {
            RequestFilterFields = "Bank Code";
            UseTemporary = true;
            column(BankAccount; DataItem2."Account No")
            { }
            column(TodayDate; TodayDate)
            { }
            column(Picture; Comp.Picture)
            {

            }
            column(NazivBanke; NazivBanke)
            {

            }
            column(SlikaVisible; SlikaVisible) { }

            column(IznosU; IznosU) { }
            column(Naslov; Naslov) { }
            column(VrstaUplate; VrstaUplate) { }
            column(SvrhaDOz; SvrhaDOz) { }
            column(Racun; Racun) { }
            column(KontaktMail; KontaktMail) { }
            column(KontaktMail2; KontaktMail2) { }
            column(BoldSluzba; BoldSluzba) { }
            column(FaxV; FaxV) { }
            column(PhoneV; PhoneV) { }
            column(FaxV2; FaxV2) { }
            column(PhoneV2; PhoneV2) { }
            column(Emal; Emal) { }
            column(Tel; Tel) { }
            column(Sektor; Sektor) { }
            column(Sluzba; Sluzba) { }
            column(ImeZ; ImeZ) { }
            column(Center; Center) { }
            column(GodinaVisible; GodinaVisible) { }
            column(TotalShow; TotalShow) { }
            column(IznosUplateTextBold; IznosUplateTextBold) { }
            column(BrRedniTextBold; BrRedniTextBold) { }
            column(ImeTextBold; ImeTextBold) { }
            column(TOtalText; TOtalText) { }
            column(Nedef; Nedef) { }
            column(Boja; Boja) { }
            column(SamoNaslov; SamoNaslov) { }
            column(DatumSVisible; DatumSVisible) { }
            column(MjesecVisible; MjesecVisible) { }
            column(Tabela2; Tabela2) { }
            column(Tabela3; Tabela3) { }
            column(Tabela4; Tabela4) { }
            column(Tabela5; Tabela5) { }
            column(Tabela6; Tabela6) { }
            column(Tabela7; Tabela7) { }
            column(SifraORGVisible; SifraORGVisible) { }
            column(JIBVisible; JIBVisible) { }
            column(RedniBRVisible; RedniBRVisible) { }
            column(RedniBrojText; RedniBrojText) { }
            column(Redoslijed; Redoslijed) { }
            column(Spar; Spar) { }
            column(PartijaVisible; PartijaVisible) { }
            column(JMBVisible; JMBVisible) { }
            column(BrojRacunaVisible; BrojRacunaVisible) { }
            column(ImeIPrezimeVisible; ImeIPrezimeVisible) { }
            column(RacunBold; RacunBold) { }
            column(ImeBold; ImeBold) { }
            column(UplataBold; UplataBold) { }

            column(IznosUpateVisible; IznosUpateVisible)
            { }
            dataitem(DataItem1; "Payment Order")
            {

                column(Uplatio1; Uplatio1)
                {
                }
                column(IsplataDatum; format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>'))
                {

                }
                column(Uplatio2; Uplatio2)
                {
                }
                column(Uplatio3; Uplatio3)
                {

                }
                column(JIB; JIB) { }
                //napravila neku kroekciju
                column(SvrhaDoznake1; SvrhaDoznake1)
                {
                }
                column(SvrhaDoznake2; SvrhaDoznake2)
                {
                }
                column(SvrhaDoznake3; SvrhaDoznake3)
                {
                }
                column(Primalac1; Primalac1)
                {
                }
                column(Primalac2; Primalac2)
                {
                }
                column(Primalac3; Primalac3)
                {
                }
                column(TotalBank; TotalBank)
                {


                }


                column(MjestoUplate; MjestoUplate)
                {
                }
                column(RacunPosiljaoca; RacunPosiljaoca)
                {
                }
                column(RacunPrimaoca; SvrhaDoznake1)
                {
                }
                column(Iznos; Iznos)
                {
                }
                column(BrojPoreznogObaveznika; BrojPoreznogObaveznika)
                {
                }
                column(VrstaPrihoda; VrstaPrihoda)
                {
                }
                column(PorezniPeriodOd; PorezniPeriodOd)
                {
                }
                column(PorezniPeriodDo; PorezniPeriodDo)
                {
                }
                column(Opstina; Opstina)
                {
                }
                column(PozivNaBroj; PozivNaBroj)
                {
                }
                column(LastName; LastName)
                {
                }
                column(FirstName; FirstName)
                {
                }
                column(EmployeeID; EmployeeID)
                {
                }
                column(RedniBr; RedniBr)
                {

                }
                column(RecutionDesc; RecutionDesc)
                {

                }

                column(Year; Year)
                {

                }
                column(Month; Month) { }
                column(Org; Org) { }


                trigger OnAfterGetRecord()
                begin
                    Boja := 'No Color';
                    Tabela2 := false;
                    Tabela3 := false;
                    Tabela4 := false;
                    Tabela5 := false;
                    Tabela6 := false;
                    Tabela7 := false;
                    FaxV := '';
                    PhoneV := '';
                    FaxV2 := '';
                    PhoneV2 := '';
                    Spar := false;


                    Comp.get();
                    RacunBold := false;
                    Comp.CalcFields(Picture);
                    if Employee.Get(DataItem1.SvrhaDoznake3) then
                        JMBG := Employee."Employee ID"
                    else
                        JMBG := '';


                    WH.Reset();
                    wh.SetFilter("No.", '%1', DataItem1."Wage Header No.");
                    WH.FindFirst();
                    UserS.Reset();
                    UserS.SetFilter("User ID", '%1', USERID);
                    if UserS.FindFirst() then begin
                        ECL.Reset();
                        ECL.SetFilter("Starting Date", '<=%1', WH."Payment Date");
                        ECL.SetFilter("Employee No.", '%1', UserS."Employee No. for Wage");
                        ECL.SetCurrentKey("Starting Date");
                        ecl.Ascending;
                        if ECL.FindLast() then begin
                            Sektor := ECL."Sector Description";
                            Sluzba := ECL."Department Cat. Description";
                            Emal := UserS."E-Mail";
                            Tel := UserS."Phone No.";

                        end
                        else begin
                            Sektor := '';
                            Sluzba := '';
                            Emal := '';
                            Tel := '';

                        end;


                    end
                    else begin
                        Sektor := '';
                        Sluzba := '';
                        Emal := '';
                        Tel := '';

                    end;

                    //Đk


                    if strpos(DataItem2."Bank Code", 'SBER') <> 0 then begin
                        GodinaVisible := False;
                        TotalShow := true;
                        Tabela3 := true;

                        Boja := '#ccffff';
                        MjesecVisible := false;
                        UplataBold := true;
                        SifraORGVisible := false;
                        IznosU := 'Iznos';

                        ImeTextBold := false;
                        IznosUplateTextBold := false;
                        BrRedniTextBold := false;
                        TOtalText := 'UKUPNO';

                        ImeBold := true;
                        JIBVisible := false;
                        Nedef := false;
                        SamoNaslov := false;
                        RedniBRVisible := true;
                        Redoslijed := false;
                        RedniBrojText := 'Redni broj';
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        DatumSVisible := false;
                        PartijaVisible := true;
                        ImeIPrezimeVisible := true;
                        ImeZ := 'Ime i prezime';
                        Racun := 'Broj računa';
                        JMBVisible := true;
                        BrojRacunaVisible := false;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Sektor := '';
                        Sluzba := '';
                        Emal := '';
                        Tel := '';
                        Center := false;
                        Naslov := 'Spisak uposlenih za isplatu  plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                    end;

                    if strpos(DataItem2."Bank Code", 'BBI') <> 0 then begin
                        GodinaVisible := false;
                        TotalShow := true;
                        Tabela4 := true;
                        MjesecVisible := false;
                        Boja := 'Silver';

                        ImeTextBold := false;
                        IznosUplateTextBold := true;
                        BrRedniTextBold := false;
                        TOtalText := '';

                        SifraORGVisible := false;
                        RacunBold := false;
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        Nedef := false;
                        SamoNaslov := true;
                        IznosU := 'Iznos';
                        DatumSVisible := false;
                        JIBVisible := false;
                        Racun := 'Broj računa';
                        ImeZ := 'Prezime i ime';
                        RedniBRVisible := true;
                        Redoslijed := true;
                        RedniBrojText := 'R. Broj';
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := false;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Center := false;
                        ImeBold := true;
                        UplataBold := true;
                        KontaktMail2 := KontaktMail;
                        KontaktMail := '';
                        Email := '';
                        Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                    end;


                    if strpos(DataItem2."Bank Code", 'ADDIKO') <> 0 then begin
                        GodinaVisible := false;
                        MjesecVisible := false;
                        BoldSluzba := false;
                        Boja := 'Silver';
                        TotalShow := true;

                        ImeTextBold := false;
                        IznosUplateTextBold := true;
                        BrRedniTextBold := false;
                        TOtalText := '';

                        SifraORGVisible := false;
                        RacunBold := false;
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        Nedef := false;
                        SamoNaslov := true;
                        IznosU := 'Iznos';
                        DatumSVisible := false;
                        JIBVisible := false;
                        Racun := 'Broj računa';
                        ImeZ := 'Prezime i ime';
                        RedniBRVisible := true;
                        Redoslijed := true;
                        RedniBrojText := 'R. Broj';
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := false;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Center := false;
                        ImeBold := true;
                        UplataBold := true;
                        //ĐK   KontaktMail2 := KontaktMail;
                        //  KontaktMail := '';
                        Email := '';
                        Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                    end;
                    if strpos(DataItem2."Bank Code", 'NLB') <> 0 then begin
                        GodinaVisible := false;
                        TotalShow := true;
                        Tabela6 := true;
                        BoldSluzba := true;
                        MjesecVisible := false;
                        Boja := 'Silver';

                        PhoneV2 := '';
                        FaxV2 := '';


                        ImeTextBold := false;
                        IznosUplateTextBold := true;
                        BrRedniTextBold := false;
                        TOtalText := '';

                        SifraORGVisible := false;
                        RacunBold := false;
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        Nedef := false;
                        SamoNaslov := true;
                        IznosU := 'IZNOS';
                        DatumSVisible := false;
                        JIBVisible := false;
                        Racun := 'BROJ RAČUNA';
                        ImeZ := 'PREZIME I IME';
                        RedniBRVisible := true;
                        Redoslijed := true;
                        RedniBrojText := 'R. BROJ';
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := false;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Center := false;
                        ImeBold := true;
                        UplataBold := true;
                        KontaktMail2 := KontaktMail;
                        KontaktMail := '';
                        Email := '';
                        Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                    end;

                    if strpos(DataItem2."Bank Code", 'SPARKASSE') <> 0 then begin
                        GodinaVisible := false;
                        MjesecVisible := false;
                        TotalShow := true;
                        Tabela7 := true;
                        Boja := '#ccffff';
                        PhoneV2 := '';
                        FaxV2 := '';
                        Spar := true;


                        ImeTextBold := false;
                        IznosUplateTextBold := true;
                        BrRedniTextBold := false;
                        TOtalText := '';

                        SifraORGVisible := false;
                        RacunBold := false;
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        Nedef := false;
                        SamoNaslov := true;
                        IznosU := 'Iznos uplate';
                        DatumSVisible := false;
                        JIBVisible := false;
                        Racun := 'Broj računa';
                        ImeZ := 'Ime i prezime';
                        RedniBRVisible := false;
                        Redoslijed := false;
                        RedniBrojText := 'Redni broj';
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := true;
                        BrojRacunaVisible := true;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Center := false;
                        ImeBold := true;
                        UplataBold := true;
                        KontaktMail2 := KontaktMail;
                        KontaktMail := '';
                        Email := '';
                        Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                    end;

                    if strpos(DataItem2."Bank Code", 'ASA') <> 0 then begin
                        GodinaVisible := true;
                        MjesecVisible := true;
                        Tabela2 := true;
                        BoldSluzba := true;
                        TotalShow := false;

                        ImeTextBold := false;
                        IznosUplateTextBold := false;
                        BrRedniTextBold := false;
                        TOtalText := '';

                        SifraORGVisible := true;
                        RacunBold := true;
                        VrstaUplate := '';
                        SvrhaDOz := '';
                        Nedef := false;
                        SamoNaslov := false;
                        IznosU := 'Iznos';
                        DatumSVisible := true;
                        JIBVisible := false;
                        Racun := 'TRN ASA';
                        ImeZ := 'Ime';
                        RedniBRVisible := false;
                        Redoslijed := false;
                        RedniBrojText := 'Redni broj';
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := true;
                        IznosUpateVisible := true;
                        SlikaVisible := true;
                        Center := false;
                        Naslov := '';
                    end;


                    if strpos(DataItem2."Bank Code", 'UNICRED') <> 0 then begin
                        GodinaVisible := false;
                        MjesecVisible := false;

                        TotalShow := false;
                        Nedef := true;
                        TotalShow := false;
                        SamoNaslov := false;
                        ImeTextBold := false;
                        IznosUplateTextBold := false;
                        BrRedniTextBold := false;
                        TOtalText := '';

                        SifraORGVisible := false;
                        Sektor := '';
                        IznosU := 'Iznos u KM';
                        DatumSVisible := false;
                        JIBVisible := true;
                        Racun := 'broj računa zaposlenika';
                        ImeZ := 'Ime i prezime zaposlenika';
                        RedniBRVisible := false;
                        Redoslijed := false;
                        RedniBrojText := 'Redni broj';
                        PartijaVisible := false;
                        ImeIPrezimeVisible := true;
                        JMBVisible := false;
                        BrojRacunaVisible := true;
                        IznosUpateVisible := true;
                        SlikaVisible := false;
                        Center := false;
                        Naslov := '';

                        Sluzba := '';
                        Sektor := '';
                        Emal := '';
                        Tel := '';
                        if DataItem1."Wage Calculation Type" = DataItem1."Wage Calculation Type"::Regular then
                            VrstaUplate := 'Redovno'
                        else
                            VrstaUplate := Format(DataItem1."Wage Calculation Type");
                        if DataItem1.PorezniPeriodDo = 0D then
                            DataItem1.PorezniPeriodDo := WH."Payment Date";

                        SvrhaDOz := 'Plaća za ' + format(Date2DMY(DataItem1.PorezniPeriodDo, 2)) + '/' + format(Date2DMY(DataItem1.PorezniPeriodDo, 3));
                    end;

                    //15.03.2022. godine
                    Primalac1 := DataItem1.SvrhaDoznake1;




                    //Org





                    ReductionType.Reset();
                    ReductionType.SetFilter(Code, '%1', DataItem1."Reduction Type");
                    if ReductionType.FindFirst() then
                        RecutionDesc := ReductionType.Description
                    else
                        RecutionDesc := '';

                    NazivBanke := '';
                    //Wage/Reduction Bank Accounts
                    WageReductionBank.Reset();
                    WageReductionBank.SetFilter("Account No", '%1', DataItem1.RacunPrimaoca);
                    if WageReductionBank.FindFirst() then begin
                        WageBank.Reset();
                        WageBank.SetFilter(Code, '%1', WageReductionBank."Bank Code");
                        if WageBank.FindFirst() then NazivBanke := WageBank.Name;
                        KontaktMail := WageBank."Contact E-mail";
                        FaxV := WageBank.Fax;
                        PhoneV := WageBank."Phone No.";
                        FaxV2 := FaxV;
                        PhoneV2 := PhoneV;

                        if strpos(DataItem2."Bank Code", 'BBI') <> 0 then begin
                            KontaktMail2 := KontaktMail;
                            KontaktMail := '';
                        end;

                        if strpos(DataItem2."Bank Code", 'NLB') <> 0 then begin
                            //ĐK  KontaktMail2 := KontaktMail;
                            //ĐK  KontaktMail := '';
                            FaxV2 := '';
                            PhoneV2 := '';

                        end;


                        if strpos(DataItem2."Bank Code", 'INTESA') <> 0 then begin
                            GodinaVisible := False;
                            TotalShow := true;
                            Tabela5 := true;
                            Boja := '#ccffff';
                            RacunBold := true;
                            DatumSVisible := false;
                            ImeTextBold := true;
                            IznosUplateTextBold := true;
                            BrRedniTextBold := true;
                            TOtalText := '';

                            MjesecVisible := false;
                            SifraORGVisible := false;
                            ImeBold := true;
                            UplataBold := true;
                            Nedef := false;
                            SamoNaslov := false;
                            ImeZ := 'Ime i prezime';
                            JIBVisible := false;
                            RedniBRVisible := true;
                            Redoslijed := false;
                            RedniBrojText := 'Redni broj';
                            PartijaVisible := false;
                            ImeIPrezimeVisible := true;
                            JMBVisible := false;
                            BrojRacunaVisible := true;
                            Center := true;
                            IznosUpateVisible := true;
                            IznosU := 'Iznos uplate';
                            SlikaVisible := true;
                            Sektor := '';
                            Sluzba := '';
                            Emal := '';
                            Tel := '';
                            Racun := 'Broj računa';
                            VrstaUplate := '';
                            SvrhaDOz := '';
                            Naslov := 'Spisak radnika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                        end;


                        //ĐK





                    end
                    ;



                    RacunPrimaoca2 := DataItem1.SvrhaDoznake1;
                    if RacunPrimaoca2 = 'Neto na račun' then
                        RacunPrimaoca2 := '';

                    Year := WH."Year Of Wage";
                    Month := WH."Month Of Wage";


                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', DataItem1.SvrhaDoznake3);
                    ECL.SetFilter("Starting Date", '<=%1', WH."Closing Date");
                    ECL.SetCurrentKey("Starting Date");
                    ECL.Ascending;
                    if ECL.FindLast() then begin

                        OrgDijelovi.Reset();
                        OrgDijelovi.SetFilter(Description, '%1', ECL."Org Unit Name");
                        OrgDijelovi.SetFilter(Active, '%1', true);
                        if OrgDijelovi.FindFirst() then
                            JIB := OrgDijelovi."JIB Contributes"
                        else
                            JIB := '';
                        Org := OrgDijelovi.Code;
                    end

                    else begin
                        Org := '';

                        JIB := '';

                    end;




                    WBTemp.Reset();
                    WBTemp.SetFilter(Code, '%1', WageReductionBank."Bank Code");
                    if WBTemp.FindFirst() then begin
                        if Iznos <> 0 then begin
                            RedniBr := RedniBr + 1;
                            TotalBank := TotalBank + DataItem1.Iznos;

                        end;


                    end
                    else begin
                        WBTemp.Init();
                        WBTemp.Code := WageReductionBank."Bank Code";
                        WBTemp.Insert();
                        RedniBr := 1;
                        TotalBank := 0;

                    end;






                    Employee.SETFILTER("No.", '%1', SvrhaDoznake3);
                    IF Employee.FINDFIRST THEN BEGIN
                        FirstName := Employee."First Name";
                        LastName := Employee."Last Name";
                        EmployeeID := Employee."Employee ID";
                    END
                    ELSE BEGIN
                        FirstName := '';
                        LastName := '';
                        EmployeeID := '';
                    END;


                end;



                trigger OnPreDataItem()
                begin
                    FirstName := '';
                    TodayDate := Today;
                    Comp.get();
                    Comp.CalcFields(Picture);
                    LastName := '';
                    EmployeeID := '';
                    SETFILTER("Wage Header No.", '%1', Document);

                    // DataItemTableView = WHERE(Contributon = FILTER('Obustava'));
                    SETFILTER(Contributon, '%1', 'PLAĆA');
                    SETFILTER(RacunPrimaoca, '%1', DataItem2."Account No");

                end;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
                SIfraB: Code[20];
                PO: Record "Payment Order";
                WR: Record "Wage/Reduction Bank Accounts";
                WHC: page "Wage Header Card";
            begin
                Tabela2 := false;
                Tabela3 := false;
                Tabela4 := false;
                Tabela5 := false;
                Tabela6 := false;
                Tabela7 := false;
                SIfraB := DataItem2.GetFilter("Bank Code");
                WHC.SetParam(SIfraB);
                if Document = '' then begin
                    WHO.Reset();
                    WHO.SetFilter(Status, '%1', WHO.Status::Open);
                    WHO.FindFirst();
                    Document := WHO."No.";
                end;
                WR.Reset();
                WR.CopyFilters(DataItem2);
                if WR.FindSet() then
                    repeat

                        po.Reset();
                        po.CopyFilters(DataItem1);
                        po.SETFILTER("Wage Header No.", '%1', Document);

                        // DataItemTableView = WHERE(Contributon = FILTER('Obustava'));
                        po.SETFILTER(Contributon, '%1', 'PLAĆA');
                        po.SETFILTER(RacunPrimaoca, '%1', WR."Account No");
                        if Po.FindFirst() then begin
                            DataItem2.Init();
                            DataItem2.TransferFields(WR);
                            DataItem2.Insert();
                        end;



                    until WR.Next() = 0;



                if strpos(SIfraB, 'INTESA') <> 0 then begin
                    GodinaVisible := False;
                    TotalShow := true;
                    Tabela5 := true;
                    Boja := '#ccffff';

                    DatumSVisible := false;
                    UplataBold := True;
                    MjesecVisible := false;

                    ImeTextBold := true;
                    IznosUplateTextBold := true;
                    BrRedniTextBold := true;
                    TOtalText := '';


                    ImeBold := true;
                    Nedef := false;
                    SamoNaslov := false;
                    RacunBold := true;
                    SifraORGVisible := false;
                    ImeZ := 'Ime i prezime';
                    JIBVisible := false;
                    RedniBrojText := 'Redni broj';
                    Redoslijed := false;
                    RedniBRVisible := true;
                    PartijaVisible := false;
                    ImeIPrezimeVisible := true;
                    JMBVisible := false;
                    BrojRacunaVisible := true;
                    Center := true;
                    IznosUpateVisible := true;
                    IznosU := 'Iznos uplate';
                    SlikaVisible := true;
                    Sektor := '';
                    Sluzba := '';
                    Emal := '';
                    Tel := '';
                    Racun := 'Broj računa';
                    VrstaUplate := '';
                    SvrhaDOz := '';
                    Naslov := 'Spisak radnika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                end;

                //ĐK

                if strpos(SIfraB, 'SBER') <> 0 then begin
                    GodinaVisible := False;
                    Boja := '#ccffff';
                    Tabela3 := true;
                    MjesecVisible := false;
                    TotalShow := true;
                    Nedef := false;
                    SamoNaslov := false;
                    ImeBold := true;

                    ImeTextBold := false;
                    IznosUplateTextBold := false;
                    BrRedniTextBold := false;
                    TOtalText := 'UKUPNO';


                    SifraORGVisible := false;
                    UplataBold := true;
                    IznosU := 'Iznos';
                    JIBVisible := false;
                    RedniBRVisible := true;
                    Redoslijed := false;
                    RedniBrojText := 'Redni broj';
                    VrstaUplate := '';
                    SvrhaDOz := '';
                    DatumSVisible := false;
                    PartijaVisible := true;
                    ImeIPrezimeVisible := true;
                    ImeZ := 'Ime i prezime';
                    Racun := 'Broj računa';
                    JMBVisible := true;
                    BrojRacunaVisible := false;
                    IznosUpateVisible := true;
                    SlikaVisible := true;
                    Sektor := '';
                    Sluzba := '';
                    Emal := '';
                    Tel := '';
                    Center := false;
                    Naslov := 'Spisak uposlenih za isplatu  plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                end;

                if strpos(SIfraB, 'ASA') <> 0 then begin
                    GodinaVisible := true;
                    RacunBold := true;
                    Tabela2 := true;

                    TotalShow := false;
                    BoldSluzba := true;
                    ImeTextBold := false;
                    TotalShow := true;
                    IznosUplateTextBold := false;
                    BrRedniTextBold := false;
                    TOtalText := '';

                    Nedef := false;
                    SamoNaslov := false;
                    MjesecVisible := true;
                    SifraORGVisible := true;
                    VrstaUplate := '';
                    SvrhaDOz := '';
                    IznosU := 'Iznos';
                    DatumSVisible := true;
                    JIBVisible := false;
                    Racun := 'TRN ASA';
                    ImeZ := 'Ime';
                    RedniBRVisible := false;
                    Redoslijed := false;
                    RedniBrojText := 'Redni broj';
                    PartijaVisible := false;
                    ImeIPrezimeVisible := true;
                    JMBVisible := false;
                    BrojRacunaVisible := true;
                    IznosUpateVisible := true;
                    SlikaVisible := true;
                    Center := false;
                    Naslov := '';
                end;

                if strpos(SIfraB, 'BBI') <> 0 then begin
                    GodinaVisible := false;
                    Boja := 'Silver';
                    Tabela4 := true;
                    TotalShow := true;
                    Email := '';
                    TotalShow := true;
                    RacunBold := false;
                    ImeTextBold := false;
                    IznosUplateTextBold := true;
                    BrRedniTextBold := false;
                    TOtalText := '';
                    KontaktMail2 := KontaktMail;
                    KontaktMail := '';


                    Nedef := false;
                    SamoNaslov := true;
                    MjesecVisible := false;
                    SifraORGVisible := false;
                    VrstaUplate := '';
                    SvrhaDOz := '';
                    IznosU := 'Iznos';
                    DatumSVisible := false;
                    JIBVisible := false;
                    Racun := 'Broj računa';
                    ImeZ := 'Prezime i ime';
                    RedniBRVisible := true;
                    Redoslijed := true;
                    RedniBrojText := 'R. Broj';
                    PartijaVisible := false;
                    ImeIPrezimeVisible := true;
                    JMBVisible := false;
                    BrojRacunaVisible := false;
                    IznosUpateVisible := true;
                    SlikaVisible := true;
                    Center := false;
                    ImeBold := true;
                    UplataBold := true;
                    Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                end;

                if strpos(SIfraB, 'ADDIKO') <> 0 then begin
                    GodinaVisible := false;
                    Boja := 'Silver';
                    BoldSluzba := false;
                    Email := '';
                    TotalShow := true;
                    TotalShow := true;
                    RacunBold := false;
                    ImeTextBold := false;
                    IznosUplateTextBold := true;
                    BrRedniTextBold := false;
                    TOtalText := '';
                    //  KontaktMail2 := KontaktMail;
                    // KontaktMail := '';


                    Nedef := false;
                    SamoNaslov := true;
                    MjesecVisible := false;
                    SifraORGVisible := false;
                    VrstaUplate := '';
                    SvrhaDOz := '';
                    IznosU := 'Iznos';
                    DatumSVisible := false;
                    JIBVisible := false;
                    Racun := 'Broj računa';
                    ImeZ := 'Prezime i ime';
                    RedniBRVisible := true;
                    Redoslijed := true;
                    RedniBrojText := 'R. Broj';
                    PartijaVisible := false;
                    ImeIPrezimeVisible := true;
                    JMBVisible := false;
                    BrojRacunaVisible := false;
                    IznosUpateVisible := true;
                    SlikaVisible := true;
                    Center := false;
                    ImeBold := true;
                    UplataBold := true;
                    Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                end;

                //

                if strpos(SIfraB, 'NLB') <> 0 then begin
                    GodinaVisible := false;
                    Email := '';
                    Tabela6 := true;
                    Boja := 'Silver';
                    RacunBold := false;
                    BoldSluzba := true;
                    PhoneV2 := '';
                    FaxV2 := '';


                    TotalShow := true;

                    ImeTextBold := false;
                    IznosUplateTextBold := true;
                    BrRedniTextBold := false;
                    TOtalText := '';
                    KontaktMail2 := KontaktMail;
                    KontaktMail := '';


                    Nedef := false;
                    SamoNaslov := true;
                    MjesecVisible := false;
                    SifraORGVisible := false;
                    VrstaUplate := '';
                    SvrhaDOz := '';
                    IznosU := 'Iznos';
                    DatumSVisible := false;
                    JIBVisible := false;
                    Racun := 'Broj računa';
                    ImeZ := 'Prezime i ime';
                    RedniBRVisible := true;
                    Redoslijed := true;
                    RedniBrojText := 'R. BROJ';
                    PartijaVisible := false;
                    ImeIPrezimeVisible := true;
                    JMBVisible := false;
                    BrojRacunaVisible := false;
                    IznosUpateVisible := true;
                    SlikaVisible := true;
                    Center := false;
                    ImeBold := true;
                    UplataBold := true;
                    Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                end;

                if strpos(SIfraB, 'SPARKASSE') <> 0 then begin
                    GodinaVisible := false;
                    TotalShow := true;
                    Boja := '#ccffff';
                    Tabela7 := true;
                    PhoneV2 := '';
                    Spar := true;
                    FaxV2 := '';
                    Email := '';
                    TotalShow := true;
                    RacunBold := false;
                    ImeTextBold := false;
                    IznosUplateTextBold := true;
                    BrRedniTextBold := false;
                    TOtalText := '';
                    KontaktMail2 := KontaktMail;
                    KontaktMail := '';


                    Nedef := false;
                    SamoNaslov := true;
                    MjesecVisible := false;
                    SifraORGVisible := false;
                    VrstaUplate := '';
                    SvrhaDOz := '';
                    IznosU := 'Iznos uplate';
                    DatumSVisible := false;
                    JIBVisible := false;
                    Racun := 'Broj računa';
                    ImeZ := 'Ime i prezime';
                    RedniBRVisible := false;
                    Redoslijed := false;
                    RedniBrojText := 'Redni broj';
                    PartijaVisible := false;
                    ImeIPrezimeVisible := true;
                    JMBVisible := true;
                    BrojRacunaVisible := true;
                    IznosUpateVisible := true;
                    SlikaVisible := true;
                    Center := false;
                    ImeBold := true;
                    UplataBold := true;
                    Naslov := 'Spisak uposlenika za isplatu plaće i ostalih primanja na dan ' + format(WH."Payment Date", 0, '<day,2>.<month,2>.<year4>') + ' godine';
                end;

                //


                if strpos(SIfraB, 'UNICRED') <> 0 then begin
                    GodinaVisible := false;
                    ImeTextBold := false;
                    TotalShow := false;

                    IznosUplateTextBold := false;
                    BrRedniTextBold := false;
                    TOtalText := '';
                    MjesecVisible := false;
                    SifraORGVisible := false;
                    Nedef := true;
                    SamoNaslov := false;
                    IznosU := 'Iznos u KM';
                    Sektor := '';
                    DatumSVisible := false;
                    JIBVisible := true;
                    Racun := 'broj računa zaposlenika';
                    ImeZ := 'Ime i prezime zaposlenika';
                    RedniBRVisible := false;
                    Redoslijed := false;
                    RedniBrojText := 'Redni broj';
                    PartijaVisible := false;
                    ImeIPrezimeVisible := true;
                    JMBVisible := false;
                    BrojRacunaVisible := true;
                    IznosUpateVisible := true;
                    SlikaVisible := false;
                    Center := false;
                    Naslov := '';

                    Sluzba := '';
                    Emal := '';
                    TotalShow := false;
                    Tel := '';

                end;
            end;
        }
    }

    requestpage

    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnInitReport()
    begin
        WBTemp.deleteall;
        RedniBr := 0;
    end;


    var

        //ĐK     i: Integer;
        IznosU: Text[250];
        Boja: Text[250];
        FaxV: Text[250];
        PhoneV: text[250];

        FaxV2: Text[250];
        PhoneV2: text[250];
        TotalShow: Boolean;
        SvrhaDOz: Text[250];
        VrstaUplate: Text[250];

        KontaktMail: Text[250];
        KontaktMail2: text[250];
        Sektor: Text[250];
        Sluzba: Text[250];
        Tel: Text[250];
        Emal: Text[250];
        UserS: Record "User Setup";
        DatumSVisible: Boolean;
        GodinaVisible: Boolean;

        ImeTextBold: Boolean;
        TOtalText: Text;
        BrRedniTextBold: Boolean;

        IznosUplateTextBold: Boolean;
        ImeZ: Text[250];
        Center: Boolean;
        SlikaVisible: Boolean;
        RacunBold: Boolean;
        Naslov: Text[250];
        WHO: Record "Wage Header";
        BoldSluzba: Boolean;
        RacunPrimaoca2: Text[250];
        Spar: Boolean;
        MjesecVisible: Boolean;
        SifraORGVisible: Boolean;
        JIBVisible: Boolean;
        RedniBRVisible: Boolean;
        PartijaVisible: Boolean;

        ImeIPrezimeVisible: Boolean;
        JMBVisible: Boolean;
        BrojRacunaVisible: Boolean;
        IznosUpateVisible: Boolean;
        JIB: Text[30];
        OrgDijelovi: Record "ORG Dijelovi";
        Org: Code[20];
        ECL: Record "Employee Contract Ledger";
        Year: Integer;
        Month: Integer;
        JMBG: Code[13];
        TodayDate: Date;
        WH: Record "Wage Header";
        a: Integer;
        NazivBanke: Text[2000];
        RecutionDesc: Text[1000];
        ReductionType: Record "Reduction Types";

        WSetup: Record "Wage Setup";
        WageReductionBank: Record "Wage/Reduction Bank Accounts";
        WVe: Record "Wage Value Entry";
        WBTemp: Record "Wage/Reduction Bank" temporary;
        Comp: Record "Company Information";
        RedniBr: Integer;

        WageBank: Record "Wage/Reduction Bank";
        TotalBank: Decimal;


        aRacunPosiljaoca: Text[250];
        Nedef: Boolean;
        RedniBrojText: Text[250];
        Redoslijed: Boolean;
        aRacunPrimaoca: Text[250];
        Email: Text[250];
        SamoNaslov: Boolean;
        Racun: Text[250];
        avrstaPrihoda: Text[30];
        aOpstina: Text[30];
        aBrojPoreznogObaveznika: Text[100];
        aPozivNaBroj: Text[100];
        LastName: Text[100];
        FirstName: Text[100];
        EmployeeID: Text[100];
        Employee: Record "Employee";
        ExcelBuffer: Record "Excel Buffer";
        Document: Code[20];
        UplataBold: Boolean;
        ImeBold: Boolean;
        Tabela2: Boolean;
        Tabela3: Boolean;
        Tabela4: Boolean;
        Tabela5: Boolean;
        Tabela6: Boolean;
        Tabela7: Boolean;


    procedure SetParam(DocumentNo: Code[20])

    begin


        Document := DocumentNo;

    end;
}

