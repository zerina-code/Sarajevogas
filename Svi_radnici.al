report 50095 "Svi radnici"
{
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Svi radnici.rdl';

    dataset
    {
        dataitem(DataItem1; "Employee Contract Ledger")
        {
            RequestFilterFields = "Starting Date", "Reason for Change";

            column(Adresa; CompInfo.Address)
            {
            }
            column(Grad; CompInfo.City)
            {
            }
            column(Slika; CompInfo.Picture)
            {
            }
            column(Tel; CompInfo."Phone No.")
            {
            }
            column(Kod; CompInfo."Country/Region Code")
            {
            }
            column(OJJ; "Department Code")
            {
            }
            column(Sluzba; "Department Category")
            {
            }
            column(Odjel; "Group Description")
            {
            }
            column(NazivRadnogMjesta; "Position Description")
            {
            }
            column(KrajDatum; FORMAT("Ending Date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(Spol; Spol)
            {

            }
            column(Show; Show)
            { }

            column(Sektor; "Sector Description")
            {
            }
            column(Ime; Ime)
            {
            }
            column(Prezime; Prezime)
            {
            }
            column(EmploymentDate; EmploymentDate)
            {
            }
            column(Zvanje; Zvanje)
            {
            }
            column(Titula; Titula)
            {
            }
            column(EL; EL)
            {
            }
            column(Pozicija; Pozicija)
            {
            }
            column(StartingDate; StartingDate)
            {
            }
            column(VrstaUgovora; VrstaUgovora)
            {
            }
            column(Koeficijent; Koeficijent)
            {
            }
            column(Select; Select)
            {
            }
            column(Sifra; "Employee No.")
            {
            }
            column(ImeRoditelja; ImeRoditelja)
            {
            }
            column(NazivOrgana; NazivOrgana)
            {
            }
            column(DatumRodjenja; DatumRodjenja)
            {
            }
            column(RazlogPrekida; "Grounds for Term. Description")
            {
            }
            column(Pomocna; Pomocna)
            {

            }

            trigger OnAfterGetRecord()
            begin
                Show := true;
                if (Select = Select::"Spisak po spolu") or (Select = Select::"Spisak svih radnika") or (Select = Select::"Po stvarnoj/potrebnoj stručnoj spremi")
               then begin
                    EClShow.Reset();
                    EClShow.CopyFilters(DataItem1);
                    EClShow.SetFilter("Employee No.", '%1', DataItem1."Employee No.");
                    if DataItem1.GetFilter("Starting Date") = '' then begin
                        EClShow.SetFilter(Active, '%1', true);
                    end;
                    EClShow.SetCurrentKey("Starting Date");
                    EClShow.Ascending;
                    if EClShow.FindLast() then begin
                        BrStavke := EClShow."No.";

                    end;

                end;
                if BrStavke <> 0 then begin
                    if BrStavke <> DataItem1."No." then
                        Show := false;

                end;
                CompInfo.RESET;
                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
                NazivOrgana := CompInfo.Name;


                //Prikazi:=FALSE Entry No. je polje
                //Prikazi:=TRUE;


                DataItem1.CALCFIELDS("Minimal Education Level");

                //lookup(Position."Minimal Education Level" WHERE(Code = FIELD("Position Code")));
                Pozicija := '';

                PosM.Reset();
                PosM.SetFilter("Position Name", '%1', DataItem1."Position Description");
                PosM.SetFilter("Position Code", '%1', DataItem1."Position Code");
                PosM.SetFilter("Org Shema", '%1', DataItem1."Org. Structure");
                if PosM.FindSet() then
                    repeat
                        Pozicija += format(PosM."Minimal Education Level") + '/;';
                    until PosM.Next() = 0;
                if StrLen(Pozicija) > 1 then
                    Pozicija := CopyStr(Pozicija, 1, StrLen(Pozicija) - 1);

                //
                //Pisanje kolone Sluzba\Odjel
                /*     Pomocna := '';
                     if DataItem1."Department Category" <> '' then
                         if DataItem1."Group Description" <> '' then
                             Pomocna := DataItem1."Department Category" + '\' + DataItem1."Group Description";

                     if DataItem1."Department Category" = '' then Pomocna := DataItem1."Group Description";
                     if DataItem1."Group Description" = '' then Pomocna := DataItem1."Department Category";*/
                Pomocna := '';

                if DataItem1."Department Cat. Description" <> '' then
                    Pomocna := DataItem1."Department Cat. Description";
                if DataItem1."Group Description" <> '' then
                    Pomocna := Pomocna + '\' + DataItem1."Group Description";
                /*if DataItem1."Department Category"<>'' then
                   if DataItem1."Group Description"<>'' then
                   Pomocna:= DataItem1."Department Category"+'\'+DataItem1."Group Description";*/

                VrstaUgovora := DataItem1."Contract Type Name";
                Koeficijent := DataItem1."Position Coefficient for Wage";

                //STRUCNA SPREMA POZICIJE
                EL := DataItem1."Minimal Education Level";
                /*  P.RESET;
                  P.SETFILTER("Position ID", '%1', "Employee No.");
                  IF P.FINDFIRST THEN BEGIN

                      Pozicija := FORMAT(P."Minimal Education Level");
                  END ELSE BEGIN
                      Pozicija := '';
                  END;*/
                //UZIMANJE IMENA I PREZIMENA RADNIKA, te imena jednog roditelja
                E.RESET;
                E.SETFILTER("No.", '%1', "Employee No.");
                E.SETFILTER(StatusExt, '%1', 0);
                IF E.FINDFIRST THEN BEGIN
                    Ime := E."First Name";
                    Prezime := E."Last Name";
                    ImeRoditelja := E."Father Name";
                    Spol := '';
                    if E.Gender = E.Gender::Female then
                        Spol := 'Žensko';

                    if E.Gender = E.Gender::Male then
                        Spol := 'Muško';


                    EmploymentDate := FORMAT(E."Employment Date", 0, '<day,2>.<month,2>.<year4>.'); //ovo ne koristim kao employment date
                    DatumRodjenja := FORMAT(E."Birth Date", 0, '<day,2>.<month,2>.<year4>.');
                END ELSE BEGIN
                    Ime := '';
                    Prezime := '';
                    EmploymentDate := '';
                    ImeRoditelja := '';
                    Spol := '';
                END;
                // TITULA I ZVANJE RADNIKA
                AE.RESET;
                AE.SETFILTER("Employee No.", '%1', "Employee No.");

                AE.SetFilter("From Date", '<=%1', DataItem1."Starting Date");
                AE.SetCurrentKey("From Date");
                AE.Ascending;
                IF AE.FindLast() THEN BEGIN
                    Titula := FORMAT(AE."Education Level");
                    Zvanje := FORMAT(AE."Title Description");
                END ELSE BEGIN
                    Titula := '';
                    Zvanje := '';
                END;
                //WORK BOOKLET STARTING DATE ovo ok
                WB.RESET;
                WB.SETFILTER("Employee No.", '%1', "Employee No.");
                WB.SETFILTER("Current Company", '%1', TRUE);
                WB.SETFILTER("Starting Date", '<=%1', DataItem1."Starting Date");
                WB.SETCURRENTKEY("Starting Date");
                WB.ASCENDING;
                IF WB.FINDLAST THEN BEGIN
                    StartingDate := FORMAT(WB."Starting Date", 0, '<day,2>.<month,2>.<year4>.'); //ovo koristim kao employment date
                END ELSE BEGIN
                    StartingDate := '';
                END;
            end;

            trigger OnPreDataItem()
            begin

                NazivOrgana := '';
                IF Select = Select::"Otišli u zadanom intervalu" THEN
                    DataItem1.SETFILTER("Grounds for Term. Description", '<>%1', '');
                IF Select = Select::"Došli u zadanom intervalu" THEN
                    DataItem1.SETFILTER("Reason for Change", '%1', DataItem1."Reason for Change"::"New Contract");

                DataItem1.SETFILTER("Show Record", '%1', TRUE);
                DataItem1.SETCURRENTKEY("Starting Date");
                DataItem1.ASCENDING;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(Select; Select)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = ' ,Otišli u zadanom intervalu,Po stvarnoj/potrebnoj stručnoj spremi,Spisak po radnim mjestima,Spisak po sektorima,Spisak po spolu,Spisak svih radnika,Došli u zadanom intervalu';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        EClShow: Record "Employee Contract Ledger";
        BrStavke: Integer;
        Show: Boolean;
        ECL: Record "Employee Contract Ledger";
        EndingDate: Text;
        EmploymentDate: Text;
        E: Record "Employee";
        EH: Page "Education History";
        Titula: Text;
        AE: Record "Additional Education";
        Zvanje: Text;
        Odjel: Text;
        Sektor: Text;
        EL: Option;
        MinPos: Text;
        Position: Record "Position";
        VrstaUgovora: Text;
        Koeficijent: Decimal;
        Selected: Option ,"4","5","6","7","8","9","17";
        DepartmentCode: Text;
        Spol: Text;
        Sluzba: Text;
        Ime: Text;
        Prezime: Text;
        P: Record "Position";
        PosM: Record "Position Minimal Education";
        Pozicija: Text;
        WB: Record "Work booklet";
        StartingDate: Text;
        Select: Option ,"Otišli u zadanom intervalu","Po stvarnoj/potrebnoj stručnoj spremi","Spisak po radnim mjestima","Spisak po sektorima","Spisak po spolu","Spisak svih radnika","Došli u zadanom intervalu";
        ImeRoditelja: Text;
        NazivOrgana: Text;
        DatumRodjenja: Text;
        Pomocna: Text;
        Sluzba1: Text;
        Odjel1: Text;
        Prikazi: Boolean;
}

