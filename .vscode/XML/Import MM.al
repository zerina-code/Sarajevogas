xmlport 50025 "MM Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'MM Import';





    schema
    {
        textelement(Root)
        {
            tableelement("Service Item"; "Service Item")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Service_Item';
                UseTemporary = false;
                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }
                textelement(Naziv)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraKupca)
                {
                    MinOccurs = Zero;
                }
                textelement(HodogramS)
                {
                    MinOccurs = Zero;
                }

                textelement(SifraUliceMM)
                {
                    MinOccurs = Zero;
                }
                textelement(BrojUliceMM)
                {
                    MinOccurs = Zero;
                }

                textelement(BrojUliceSlovimaMM)
                {
                    MinOccurs = Zero;
                }
                textelement(BrojStanaMM)
                {
                    MinOccurs = Zero;
                }
                textelement(SpratMM)
                {
                    MinOccurs = Zero;
                }

                textelement(GIS)
                {
                    MinOccurs = Zero;
                }


                textelement(RezimZima)
                {
                    MinOccurs = Zero;

                }
                textelement(RezimLjeto)
                {
                    MinOccurs = Zero;
                }
                textelement(RezimPrelaz)
                {
                    MinOccurs = Zero;
                }

                textelement(OcitackaZonaZima)
                {
                    MinOccurs = Zero;
                }

                textelement(OcitackaZonaljeto)
                {
                    MinOccurs = Zero;
                }

                textelement(NamjenaPotrosnje)
                {
                    MinOccurs = Zero;
                }

                textelement(NacinOcitanja)
                {
                    MinOccurs = Zero;
                }

                textelement(AlternativnoGorivo)
                {
                    MinOccurs = Zero;
                }

                textelement(PodeseniPritisak)
                {
                    MinOccurs = Zero;
                }

                textelement(MinPtr)
                {
                    MinOccurs = Zero;
                }



                textelement(NadmorskaVisina)
                {
                    MinOccurs = Zero;
                }

                textelement(KategorijaMM)
                {
                    MinOccurs = Zero;
                }

                textelement(Projektovano)
                {
                    MinOccurs = Zero;
                }

                textelement(StartPotrosnje)
                {
                    MinOccurs = zero;

                }
                textelement(Instalisano)
                {
                    MinOccurs = Zero;
                }

                textelement(Djelatnost)
                {
                    MinOccurs = Zero;
                }
                textelement(DjelatnostEU)
                {
                    MinOccurs = zero;
                }
                textelement(DjelatnostEF)
                {
                    MinOccurs = Zero;
                }
                textelement(Status)
                {
                    MinOccurs = Zero;
                }
                textelement(napomena)
                {
                    MinOccurs = Zero;
                }


                textelement(Kategorija)
                {
                    MinOccurs = Zero;
                }
                textelement(VlasnikIstoKaoKupac)
                {
                    MinOccurs = Zero;
                }
                textelement(OdgovornoLice)
                {
                    MinOccurs = Zero;
                }
                textelement(TelefonMM)
                {
                    MinOccurs = Zero;
                }
                textelement(Opaska)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                var
                    MMActivity: Record "MM Activity";
                    HodogramI: Integer;
                    CU: Record Customer;
                begin
                    "Service Item".Reset();
                    "Service Item".SetFilter("No.", '%1', Sifra);
                    if "Service Item".FindFirst() then begin




                        if HodogramS <> '' then begin
                            HodogramS := ReplaceString(HodogramS, 'ĐĐĐ', '');
                            if Evaluate(HodogramI, HodogramS) then
                                "Service Item".Validate(Hodogram, HodogramI);
                        end;

                        if Naziv <> '' then begin
                            Naziv := ReplaceString(Naziv, 'ĐĐĐ', '');

                            if strlen(naziv) > 100 then begin
                                "Service Item".Validate(description, copystr(Naziv, 1, 100))
                            end
                            else begin
                                "Service Item".Validate(description, Naziv)
                                ;
                            end;

                        end;


                        if Djelatnost <> '' then begin

                            Djelatnost := ReplaceString(Djelatnost, 'ĐĐĐ', '');
                            MMActivity.Reset();
                            MMActivity.SetFilter(Code, '%1', Djelatnost);
                            MMActivity.setfilter(Type, '%1', MMActivity.Type::Basic);
                            if MMActivity.FindFirst() then begin
                                "Service Item".Validate(Activity, MMActivity.Description);
                            end;
                        end;

                        if DjelatnostEU <> '' then begin
                            DjelatnostEU := ReplaceString(DjelatnostEU, 'ĐĐĐ', '');
                            MMActivity.Reset();
                            MMActivity.SetFilter(Code, '%1', DjelatnostEU);
                            MMActivity.setfilter(Type, '%1', MMActivity.Type::EU);
                            if MMActivity.FindFirst() then begin
                                "Service Item".Validate("EU Activity", MMActivity.Description);
                            end;
                        end;

                        if DjelatnostEF <> '' then begin
                            DjelatnostEF := ReplaceString(DjelatnostEF, 'ĐĐĐ', '');
                            MMActivity.Reset();
                            MMActivity.SetFilter(Code, '%1', DjelatnostEF);
                            MMActivity.setfilter(Type, '%1', MMActivity.Type::Ef);
                            if MMActivity.FindFirst() then begin
                                "Service Item".Validate("EF Activity", MMActivity.Description);
                            end;
                        end;


                        if Naziv <> '' then begin
                            Naziv := ReplaceString(Naziv, 'ĐĐĐ', '');
                            "Service Item".Validate("Search Description", "Service Item".Description);

                        end;

                        if SifraKupca <> '' then begin
                            SifraKupca := ReplaceString(SifraKupca, 'ĐĐĐ', '');
                            "Service Item".Validate("Customer No.", SifraKupca);
                        end;

                        if SifraUliceMM <> '' then begin
                            SifraUliceMM := ReplaceString(SifraUliceMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Street", SifraUliceMM);
                        end;

                        if BrojUliceMM <> '' then begin
                            BrojUliceMM := ReplaceString(BrojUliceMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Street No.", BrojUliceMM);
                        end;

                        if BrojUliceSlovimaMM <> '' then begin
                            BrojUliceSlovimaMM := ReplaceString(BrojUliceSlovimaMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Street No. Text", BrojUliceSlovimaMM);
                        end;




                        if SpratMM <> '' then begin
                            SpratMM := ReplaceString(SpratMM, 'ĐĐĐ', '');
                            "Service Item".Validate(Floor, SpratMM);
                        end;
                        if BrojStanaMM <> '' then begin
                            BrojStanaMM := ReplaceString(BrojStanaMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Apartment No.", BrojStanaMM);
                        end;

                        if gis <> '' then begin
                            gis := ReplaceString(gis, 'ĐĐĐ', '');
                            if Evaluate(GISInt, GIS) then
                                "Service Item".Validate(GIS, GISInt)
                            else
                                "Service Item".Validate(GIS, 0);

                        end;


                        if RezimLjeto <> '' then begin
                            RezimLjeto := ReplaceString(RezimLjeto, 'ĐĐĐ', '');
                            if Evaluate(RezimLjetoInt, RezimLjeto) then
                                "Service Item".Validate("Summer Zone", RezimLjetoInt)
                            else
                                "Service Item".Validate("Summer Zone", 0);
                        end;

                        if RezimZima <> '' then begin
                            RezimZima := ReplaceString(RezimZima, 'ĐĐĐ', '');
                            if Evaluate(RezimZimaInt, RezimZima) then
                                "Service Item".Validate("Winter Zone", RezimZimaInt)
                            else
                                "Service Item".Validate("Winter Zone", 0);
                        end;

                        if RezimPrelaz <> '' then begin
                            RezimPrelaz := ReplaceString(RezimPrelaz, 'ĐĐĐ', '');
                            if Evaluate(RezimPrelazInt, RezimPrelaz) then
                                "Service Item".Validate("Transit Zone", RezimPrelazInt)
                            else
                                "Service Item".Validate("Transit Zone", 0);
                        end;

                        if NacinOcitanja <> '' then begin
                            NacinOcitanja := ReplaceString(NacinOcitanja, 'ĐĐĐ', '');

                            if NacinOcitanja = '0' then
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::"Reading List")
                            else
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::Digital);

                        end;
                        if PodeseniPritisak <> '' then begin
                            PodeseniPritisak := ReplaceString(PodeseniPritisak, 'ĐĐĐ', '');

                            if Evaluate(PodeseniPritisakDecimal, PodeseniPritisak) then
                                "Service Item".Validate("Adjusted Pressure", PodeseniPritisakDecimal)
                            else
                                "Service Item".Validate("Adjusted Pressure", 0);
                        end;



                        if NadmorskaVisina <> '' then begin

                            NadmorskaVisina := ReplaceString(NadmorskaVisina, 'ĐĐĐ', '');
                            if Evaluate(NadmorskaVisinaDecimal, NadmorskaVisina) then
                                "Service Item".Validate(Elevation, NadmorskaVisinaDecimal)
                            else
                                "Service Item".Validate(Elevation, 0);

                        end;

                        if AlternativnoGorivo <> '' then begin
                            AlternativnoGorivo := ReplaceString(AlternativnoGorivo, 'ĐĐĐ', '');
                            if AlternativnoGorivo = '0' then
                                "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::No)
                            else
                                "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::Yes);


                        end;

                        if Projektovano <> '' then begin
                            Projektovano := ReplaceString(Projektovano, 'ĐĐĐ', '');
                            if Evaluate(ProjektovanoDecimal, Projektovano) then
                                "Service Item".Validate("Designed KW", ProjektovanoDecimal)
                            else
                                "Service Item".Validate("Designed KW", 0);

                        end;
                        if Instalisano <> '' then begin
                            Instalisano := ReplaceString(Instalisano, 'ĐĐĐ', '');
                            if Evaluate(InstalisanoDecimal, Instalisano) then
                                "Service Item".Validate("Installed KW", InstalisanoDecimal)
                            else
                                "Service Item".Validate("Installed KW", 0);

                        end;
                        if StartPotrosnje <> '' then begin
                            StartPotrosnje := ReplaceString(StartPotrosnje, 'ĐĐĐ', '');
                            if Evaluate(StartPotrosnjeDate, StartPotrosnje) then
                                "Service Item".Validate("Starting Measuring", StartPotrosnjeDate)
                            else
                                "Service Item".Validate("Starting Measuring", 0D);

                        end;

                        if MinPtr <> '' then begin
                            MinPtr := ReplaceString(MinPtr, 'ĐĐĐ', '');
                            "Service Item".Validate("Minimal Consumption", MinPtr);
                        end;

                        if OcitackaZonaljeto <> '' then begin

                            OcitackaZonaljeto := ReplaceString(OcitackaZonaljeto, 'ĐĐĐ', '');
                            if Evaluate(OcitackaZonaljetoDecimal, OcitackaZonaljeto) then
                                "Service Item".Validate("Measuring Zone - summer", OcitackaZonaljetoDecimal)
                            else
                                "Service Item".Validate("Measuring Zone - summer", 0);

                        end;

                        if OcitackaZonaZima <> '' then begin

                            OcitackaZonaZima := ReplaceString(OcitackaZonaZima, 'ĐĐĐ', '');
                            if Evaluate(OcitackaZonaZenoDecimal, OcitackaZonaZima) then
                                "Service Item".Validate("Measuring Zone - winter", OcitackaZonaZenoDecimal)
                            else
                                "Service Item".Validate("Measuring Zone - winter", 0);

                        end;

                        if NamjenaPotrosnje <> '' then begin
                            NamjenaPotrosnje := ReplaceString(NamjenaPotrosnje, 'ĐĐĐ', '');
                            PurposeValidate.Reset();
                            PurposeValidate.SetFilter(Code, '%1', NamjenaPotrosnje);
                            if PurposeValidate.FindFirst() then begin
                                "Service Item".Validate(Purpose, PurposeValidate.Description)
                            end
                            else begin
                                "Service Item".Validate(Purpose, '');
                            end;

                        end;

                        if NacinOcitanja <> '' then begin
                            NacinOcitanja := ReplaceString(NacinOcitanja, 'ĐĐĐ', '');

                            if NacinOcitanja = '0' then
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::"Reading List")
                            else
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::Digital);

                        end;



                        if KategorijaMM <> '' then begin
                            KategorijaMM := ReplaceString(KategorijaMM, 'ĐĐĐ', '');
                            if KategorijaMM = '1' then
                                "Service Item"."MM Category" := "Service Item"."MM Category"::"Large Economy";
                            if KategorijaMM = '2' then
                                "Service Item"."MM Category" := "Service Item"."MM Category"::"Small Economy";
                            if KategorijaMM = '3' then
                                "Service Item"."MM Category" := "Service Item"."MM Category"::Household;

                        end;

                        if status <> '' then begin
                            status := ReplaceString(status, 'ĐĐĐ', ';');
                            CHistory2.Reset();
                            CHistory2.SetFilter("Measuring Point", '%1', sifra);
                            if status = 'AKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Active);

                            if status = 'NEAKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Terminated);

                            if status = 'TRAJNO NEAKTIVAN' then
                                CHistory2.SetFilter("Information of processing", '%1', CHistory2."Information of processing"::"Permanently inactive");
                            CHistory2.SetFilter(Active, '%1', true);
                            CHistory2.setfilter("Source Table", '%1', 5940);

                            if not CHistory2.FindFirst() then begin
                                CHistory.Init();
                                CHistory.Validate("Measuring Point", sifra);

                                if status = 'AKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Active;
                                if status = 'NEAKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Terminated;

                                if status = 'TRAJNO NEAKTIVAN' then
                                    CHistory.SetFilter("Information of processing", '%1', CHistory."Information of processing"::"Permanently inactive");

                                CHistory."Request Type" := 7;
                                CHistory."Source Table" := 5940;
                                CHistory.Validate(Active, true);

                                CHistory.Insert();
                                Commit();

                                CHistory3.Reset();
                                CHistory3.SetFilter("Measuring Point", '%1', sifra);
                                CHistory3.SetFilter(Integer, '<>%1', CHistory.Integer);
                                CHistory3.SetFilter("Source Table", '%1', 5940);

                                if CHistory3.FindSet then
                                    repeat
                                        CHistory3.Active := false;
                                        CHistory3.Modify();
                                    until CHistory3.Next() = 0;

                            end;

                        end;

                        //     "Service Item".validate("Applied address", true);


                        /*   "Service Item".Validate("Street Customer", SifraUliceS);
                           "Service Item".Validate("Street No.", BrojUliceS);
                           "Service Item".Validate("Activity Code", Djelatnost);
                           if Status = '1' then
                               "Service Item"."Customer Status" := "Service Item"."Customer Status"::Active;
                           if Status = '2' then
                               "Service Item"."Customer Status" := "Service Item"."Customer Status"::Terminated;
                           if Status = '3' then
                               "Service Item"."Customer Status" := "Service Item"."Customer Status"::"Permanently inactive";*/

                        //ĐK   "Service Item".Comment:=napomena;


                        if napomena <> '' then begin


                            RecordLink.Init();
                            RecordLink."Link ID" := LastLinkID;
                            RecordLink.Insert();
                            RecordLink.Company := CompanyName;
                            RecordLink.Type := RecordLink.Type::Note;
                            RecordLink.Created := CurrentDateTime;
                            RecordLink."User ID" := UserId;
                            RecordLink."Record ID" := "Service Item".RecordId;
                            RecordLinkMgt.WriteNote(RecordLink, napomena);
                            RecordLink.Modify();
                            LastLinkID += 1;

                        end;

                        if Opaska <> '' then begin


                            RecordLink.Init();
                            RecordLink."Link ID" := LastLinkID;
                            RecordLink.Insert();
                            RecordLink.Company := CompanyName;
                            RecordLink.Type := RecordLink.Type::Note;
                            RecordLink.Created := CurrentDateTime;
                            RecordLink."User ID" := UserId;
                            RecordLink."Record ID" := "Service Item".RecordId;
                            RecordLinkMgt.WriteNote(RecordLink, Opaska);
                            RecordLink.Modify();
                            LastLinkID += 1;

                        end;


                        if VlasnikIstoKaoKupac <> '' then begin

                            if VlasnikIstoKaoKupac = 'DA' then begin
                                //   "Service Item".validate("Applied Customer inf", true);


                                ContactV."No." := ContactCode;
                                ContactCode := IncStr(ContactCode);

                                ContactV.validate(Name, OdgovornoLice);
                                ContactV.validate(Type, ContactV.Type::Person);
                                ContactV.Validate("Type Relation", ContactV."Type Relation"::Owner);
                                ContactV.Validate(Street, "Service Item".Street);
                                ContactV.Validate("Street No.", "Service Item"."Street No.");
                                ContactV.validate("Mobile Phone No.", TelefonMM);

                                //    ContactV.validate("E-Mail", cu."E-Mail");

                                CU.Reset();
                                CU.SetFilter("No.", '%1', "Service Item"."Customer No.");
                                if cu.FindFirst() then
                                    ContactV.Validate("Phone No.", cu."Customer Phone No.");

                                ContactV.insert;
                                Commit();
                                "Service Item"."Contact MM" := ContactV."No.";

                                "Service Item"."Owner E-Mail" := ContactV."E-Mail";
                                "Service Item"."Owner Mobile Phone No." := ContactV."Mobile Phone No.";
                                "Service Item"."Owner Name" := ContactV.Name;
                                "Service Item"."Owner Phone No." := TelefonMM;
                                "Service Item"."Phone No. MM" := TelefonMM;

                            end;
                            if VlasnikIstoKaoKupac = 'NE' then
                                ContactV.init;
                            ContactV."No." := ContactCode;
                            ContactCode := IncStr(ContactCode);

                            ContactV.validate(Name, OdgovornoLice);
                            ContactV.validate(Type, ContactV.Type::Person);
                            ContactV.Validate("Type Relation", ContactV."Type Relation"::Owner);
                            ContactV.Validate(Street, "Service Item".Street);
                            ContactV.Validate("Street No.", "Service Item"."Street No.");
                            ContactV.validate("Mobile Phone No.", TelefonMM);
                            ContactV.validate("E-Mail", cu."E-Mail");

                            CU.Reset();
                            CU.SetFilter("No.", '%1', "Service Item"."Customer No.");
                            if cu.FindFirst() then
                                ContactV.Validate("Phone No.", cu."Customer Phone No.");

                            ContactV.insert;
                            Commit();
                            "Service Item"."Contact MM" := ContactV."No.";

                            "Service Item"."Owner E-Mail" := ContactV."E-Mail";
                            "Service Item"."Owner Mobile Phone No." := ContactV."Mobile Phone No.";
                            "Service Item"."Owner Name" := ContactV.Name;
                            "Service Item"."Owner Phone No." := TelefonMM;
                            "Service Item"."Phone No. MM" := TelefonMM;

                        end;

                        "Service Item".Modify();


                    end
                    else begin

                        "Service Item".Init();
                        "Service Item"."No." := sifra;

                        if HodogramS <> '' then begin
                            HodogramS := ReplaceString(HodogramS, 'ĐĐĐ', '');
                            if Evaluate(HodogramI, HodogramS) then
                                "Service Item".Validate(Hodogram, HodogramI);
                        end;

                        if Naziv <> '' then begin
                            Naziv := ReplaceString(Naziv, 'ĐĐĐ', '');

                            if strlen(naziv) > 100 then begin
                                "Service Item".Validate(description, copystr(Naziv, 1, 100))
                            end
                            else begin
                                "Service Item".Validate(description, Naziv)
                                ;
                            end;

                        end;


                        if Djelatnost <> '' then begin

                            Djelatnost := ReplaceString(Djelatnost, 'ĐĐĐ', '');
                            MMActivity.Reset();
                            MMActivity.SetFilter(Code, '%1', Djelatnost);
                            MMActivity.setfilter(Type, '%1', MMActivity.Type::Basic);
                            if MMActivity.FindFirst() then begin
                                "Service Item".Validate(Activity, MMActivity.Description);
                            end;
                        end;

                        if DjelatnostEU <> '' then begin
                            DjelatnostEU := ReplaceString(DjelatnostEU, 'ĐĐĐ', '');
                            MMActivity.Reset();
                            MMActivity.SetFilter(Code, '%1', DjelatnostEU);
                            MMActivity.setfilter(Type, '%1', MMActivity.Type::EU);
                            if MMActivity.FindFirst() then begin
                                "Service Item".Validate("EU Activity", MMActivity.Description);
                            end;
                        end;

                        if DjelatnostEF <> '' then begin
                            DjelatnostEF := ReplaceString(DjelatnostEF, 'ĐĐĐ', '');
                            MMActivity.Reset();
                            MMActivity.SetFilter(Code, '%1', DjelatnostEF);
                            MMActivity.setfilter(Type, '%1', MMActivity.Type::Ef);
                            if MMActivity.FindFirst() then begin
                                "Service Item".Validate("EF Activity", MMActivity.Description);
                            end;
                        end;


                        if Naziv <> '' then begin
                            Naziv := ReplaceString(Naziv, 'ĐĐĐ', '');
                            "Service Item".Validate("Search Description", "Service Item".Description);

                        end;

                        if SifraKupca <> '' then begin
                            SifraKupca := ReplaceString(SifraKupca, 'ĐĐĐ', '');
                            "Service Item".Validate("Customer No.", SifraKupca);
                        end;

                        if SifraUliceMM <> '' then begin
                            SifraUliceMM := ReplaceString(SifraUliceMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Street", SifraUliceMM);
                        end;

                        if BrojUliceMM <> '' then begin
                            BrojUliceMM := ReplaceString(BrojUliceMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Street No.", BrojUliceMM);
                        end;

                        if BrojUliceSlovimaMM <> '' then begin
                            BrojUliceSlovimaMM := ReplaceString(BrojUliceSlovimaMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Street No. Text", BrojUliceSlovimaMM);
                        end;




                        if SpratMM <> '' then begin
                            SpratMM := ReplaceString(SpratMM, 'ĐĐĐ', '');
                            "Service Item".Validate(Floor, SpratMM);
                        end;
                        if BrojStanaMM <> '' then begin
                            BrojStanaMM := ReplaceString(BrojStanaMM, 'ĐĐĐ', '');
                            "Service Item".Validate("Apartment No.", BrojStanaMM);
                        end;

                        if gis <> '' then begin
                            gis := ReplaceString(gis, 'ĐĐĐ', '');
                            if Evaluate(GISInt, GIS) then
                                "Service Item".Validate(GIS, GISInt)
                            else
                                "Service Item".Validate(GIS, 0);

                        end;


                        if RezimLjeto <> '' then begin
                            RezimLjeto := ReplaceString(RezimLjeto, 'ĐĐĐ', '');
                            if Evaluate(RezimLjetoInt, RezimLjeto) then
                                "Service Item".Validate("Summer Zone", RezimLjetoInt)
                            else
                                "Service Item".Validate("Summer Zone", 0);
                        end;

                        if RezimZima <> '' then begin
                            RezimZima := ReplaceString(RezimZima, 'ĐĐĐ', '');
                            if Evaluate(RezimZimaInt, RezimZima) then
                                "Service Item".Validate("Winter Zone", RezimZimaInt)
                            else
                                "Service Item".Validate("Winter Zone", 0);
                        end;

                        if RezimPrelaz <> '' then begin
                            RezimPrelaz := ReplaceString(RezimPrelaz, 'ĐĐĐ', '');
                            if Evaluate(RezimPrelazInt, RezimPrelaz) then
                                "Service Item".Validate("Transit Zone", RezimPrelazInt)
                            else
                                "Service Item".Validate("Transit Zone", 0);
                        end;

                        if NacinOcitanja <> '' then begin
                            NacinOcitanja := ReplaceString(NacinOcitanja, 'ĐĐĐ', '');

                            if NacinOcitanja = '0' then
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::"Reading List")
                            else
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::Digital);

                        end;
                        if PodeseniPritisak <> '' then begin
                            PodeseniPritisak := ReplaceString(PodeseniPritisak, 'ĐĐĐ', '');

                            if Evaluate(PodeseniPritisakDecimal, PodeseniPritisak) then
                                "Service Item".Validate("Adjusted Pressure", PodeseniPritisakDecimal)
                            else
                                "Service Item".Validate("Adjusted Pressure", 0);
                        end;



                        if NadmorskaVisina <> '' then begin

                            NadmorskaVisina := ReplaceString(NadmorskaVisina, 'ĐĐĐ', '');
                            if Evaluate(NadmorskaVisinaDecimal, NadmorskaVisina) then
                                "Service Item".Validate(Elevation, NadmorskaVisinaDecimal)
                            else
                                "Service Item".Validate(Elevation, 0);

                        end;

                        if AlternativnoGorivo <> '' then begin
                            AlternativnoGorivo := ReplaceString(AlternativnoGorivo, 'ĐĐĐ', '');
                            if AlternativnoGorivo = '0' then
                                "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::No)
                            else
                                "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::Yes);


                        end;

                        if Projektovano <> '' then begin
                            Projektovano := ReplaceString(Projektovano, 'ĐĐĐ', '');
                            if Evaluate(ProjektovanoDecimal, Projektovano) then
                                "Service Item".Validate("Designed KW", ProjektovanoDecimal)
                            else
                                "Service Item".Validate("Designed KW", 0);

                        end;
                        if Instalisano <> '' then begin
                            Instalisano := ReplaceString(Instalisano, 'ĐĐĐ', '');
                            if Evaluate(InstalisanoDecimal, Instalisano) then
                                "Service Item".Validate("Installed KW", InstalisanoDecimal)
                            else
                                "Service Item".Validate("Installed KW", 0);

                        end;
                        if StartPotrosnje <> '' then begin
                            StartPotrosnje := ReplaceString(StartPotrosnje, 'ĐĐĐ', '');
                            if Evaluate(StartPotrosnjeDate, StartPotrosnje) then
                                "Service Item".Validate("Starting Measuring", StartPotrosnjeDate)
                            else
                                "Service Item".Validate("Starting Measuring", 0D);

                        end;

                        if MinPtr <> '' then begin
                            MinPtr := ReplaceString(MinPtr, 'ĐĐĐ', '');
                            "Service Item".Validate("Minimal Consumption", MinPtr);
                        end;

                        if OcitackaZonaljeto <> '' then begin

                            OcitackaZonaljeto := ReplaceString(OcitackaZonaljeto, 'ĐĐĐ', '');
                            if Evaluate(OcitackaZonaljetoDecimal, OcitackaZonaljeto) then
                                "Service Item".Validate("Measuring Zone - summer", OcitackaZonaljetoDecimal)
                            else
                                "Service Item".Validate("Measuring Zone - summer", 0);

                        end;

                        if OcitackaZonaZima <> '' then begin

                            OcitackaZonaZima := ReplaceString(OcitackaZonaZima, 'ĐĐĐ', '');
                            if Evaluate(OcitackaZonaZenoDecimal, OcitackaZonaZima) then
                                "Service Item".Validate("Measuring Zone - winter", OcitackaZonaZenoDecimal)
                            else
                                "Service Item".Validate("Measuring Zone - winter", 0);

                        end;

                        if NamjenaPotrosnje <> '' then begin
                            NamjenaPotrosnje := ReplaceString(NamjenaPotrosnje, 'ĐĐĐ', '');
                            PurposeValidate.Reset();
                            PurposeValidate.SetFilter(Code, '%1', NamjenaPotrosnje);
                            if PurposeValidate.FindFirst() then begin
                                "Service Item".Validate(Purpose, PurposeValidate.Description)
                            end
                            else begin
                                "Service Item".Validate(Purpose, '');
                            end;

                        end;

                        if NacinOcitanja <> '' then begin
                            NacinOcitanja := ReplaceString(NacinOcitanja, 'ĐĐĐ', '');

                            if NacinOcitanja = '0' then
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::"Reading List")
                            else
                                "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::Digital);

                        end;



                        if KategorijaMM <> '' then begin
                            KategorijaMM := ReplaceString(KategorijaMM, 'ĐĐĐ', '');
                            if KategorijaMM = '1' then
                                "Service Item"."MM Category" := "Service Item"."MM Category"::"Large Economy";
                            if KategorijaMM = '2' then
                                "Service Item"."MM Category" := "Service Item"."MM Category"::"Small Economy";
                            if KategorijaMM = '3' then
                                "Service Item"."MM Category" := "Service Item"."MM Category"::Household;

                        end;

                        if status <> '' then begin
                            status := ReplaceString(status, 'ĐĐĐ', ';');
                            CHistory2.Reset();
                            CHistory2.SetFilter("Measuring Point", '%1', sifra);
                            if status = 'AKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Active);

                            if status = 'NEAKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Terminated);

                            if status = 'TRAJNO NEAKTIVAN' then
                                CHistory2.SetFilter("Information of processing", '%1', CHistory2."Information of processing"::"Permanently inactive");
                            CHistory2.SetFilter(Active, '%1', true);
                            CHistory2.setfilter("Source Table", '%1', 5940);

                            if not CHistory2.FindFirst() then begin
                                CHistory.Init();
                                CHistory.Validate("Measuring Point", sifra);

                                if status = 'AKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Active;
                                if status = 'NEAKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Terminated;

                                if status = 'TRAJNO NEAKTIVAN' then
                                    CHistory.SetFilter("Information of processing", '%1', CHistory."Information of processing"::"Permanently inactive");

                                CHistory."Request Type" := 7;
                                CHistory."Source Table" := 5940;
                                CHistory.Validate(Active, true);

                                CHistory.Insert();
                                Commit();

                                CHistory3.Reset();
                                CHistory3.SetFilter("Measuring Point", '%1', sifra);
                                CHistory3.SetFilter(Integer, '<>%1', CHistory.Integer);
                                CHistory3.SetFilter("Source Table", '%1', 5940);

                                if CHistory3.FindSet then
                                    repeat
                                        CHistory3.Active := false;
                                        CHistory3.Modify();
                                    until CHistory3.Next() = 0;

                            end;

                        end;

                        //     "Service Item".validate("Applied address", true);


                        /*   "Service Item".Validate("Street Customer", SifraUliceS);
                           "Service Item".Validate("Street No.", BrojUliceS);
                           "Service Item".Validate("Activity Code", Djelatnost);
                           if Status = '1' then
                               "Service Item"."Customer Status" := "Service Item"."Customer Status"::Active;
                           if Status = '2' then
                               "Service Item"."Customer Status" := "Service Item"."Customer Status"::Terminated;
                           if Status = '3' then
                               "Service Item"."Customer Status" := "Service Item"."Customer Status"::"Permanently inactive";*/

                        //ĐK   "Service Item".Comment:=napomena;


                        if napomena <> '' then begin


                            RecordLink.Init();
                            RecordLink."Link ID" := LastLinkID;
                            RecordLink.Insert();
                            RecordLink.Company := CompanyName;
                            RecordLink.Type := RecordLink.Type::Note;
                            RecordLink.Created := CurrentDateTime;
                            RecordLink."User ID" := UserId;
                            RecordLink."Record ID" := "Service Item".RecordId;
                            RecordLinkMgt.WriteNote(RecordLink, napomena);
                            RecordLink.Modify();
                            LastLinkID += 1;

                        end;

                        if Opaska <> '' then begin


                            RecordLink.Init();
                            RecordLink."Link ID" := LastLinkID;
                            RecordLink.Insert();
                            RecordLink.Company := CompanyName;
                            RecordLink.Type := RecordLink.Type::Note;
                            RecordLink.Created := CurrentDateTime;
                            RecordLink."User ID" := UserId;
                            RecordLink."Record ID" := "Service Item".RecordId;
                            RecordLinkMgt.WriteNote(RecordLink, Opaska);
                            RecordLink.Modify();
                            LastLinkID += 1;

                        end;


                        if VlasnikIstoKaoKupac <> '' then begin

                            if VlasnikIstoKaoKupac = 'DA' then begin
                                //   "Service Item".validate("Applied Customer inf", true);


                                ContactV."No." := ContactCode;
                                ContactCode := IncStr(ContactCode);
                                ContactV.validate(Name, OdgovornoLice);
                                ContactV.validate(Type, ContactV.Type::Person);
                                ContactV.Validate("Type Relation", ContactV."Type Relation"::Owner);
                                ContactV.Validate(Street, "Service Item".Street);
                                ContactV.Validate("Street No.", "Service Item"."Street No.");
                                ContactV.validate("Mobile Phone No.", TelefonMM);
                                //    ContactV.validate("E-Mail", cu."E-Mail");

                                CU.Reset();
                                CU.SetFilter("No.", '%1', "Service Item"."Customer No.");
                                if cu.FindFirst() then
                                    ContactV.Validate("Phone No.", cu."Customer Phone No.");

                                ContactV.insert;
                                Commit();
                                "Service Item"."Contact MM" := ContactV."No.";

                                "Service Item"."Owner E-Mail" := ContactV."E-Mail";
                                "Service Item"."Owner Mobile Phone No." := ContactV."Mobile Phone No.";
                                "Service Item"."Owner Name" := ContactV.Name;
                                "Service Item"."Owner Phone No." := TelefonMM;
                                "Service Item"."Phone No. MM" := TelefonMM;

                            end;
                            if VlasnikIstoKaoKupac = 'NE' then
                                ContactV.init;
                            ContactV."No." := ContactCode;
                            ContactCode := IncStr(ContactCode);

                            ContactV.validate(Name, OdgovornoLice);
                            ContactV.validate(Type, ContactV.Type::Person);
                            ContactV.Validate("Type Relation", ContactV."Type Relation"::Owner);
                            ContactV.Validate(Street, "Service Item".Street);
                            ContactV.Validate("Street No.", "Service Item"."Street No.");
                            ContactV.validate("Mobile Phone No.", TelefonMM);
                            ContactV.validate("E-Mail", cu."E-Mail");

                            CU.Reset();
                            CU.SetFilter("No.", '%1', "Service Item"."Customer No.");
                            if cu.FindFirst() then
                                ContactV.Validate("Phone No.", cu."Customer Phone No.");

                            ContactV.insert;
                            Commit();
                            "Service Item"."Contact MM" := ContactV."No.";

                            "Service Item"."Owner E-Mail" := ContactV."E-Mail";
                            "Service Item"."Owner Mobile Phone No." := ContactV."Mobile Phone No.";
                            "Service Item"."Owner Name" := ContactV.Name;
                            "Service Item"."Owner Phone No." := TelefonMM;
                            "Service Item"."Phone No. MM" := TelefonMM;

                        end;


                        "Service Item".Insert();
                    end;


                end;
            }
        }
    }
    trigger OnPreXmlPort()
    var
    begin
        RecordLinkTest.Reset();
        if RecordLinkTest.FindLast() then begin
            LastLinkID := RecordLinkTest."Link ID" + 1;
        end;

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'VLASNICI');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            ContactCode := NoSeriesLine."Last No. Used";
        end;
        ContactCode := IncStr(ContactCode);

    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'VLASNICI');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := ContactCode;
        end;


    end;

    procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250]
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;


    var
        Datum: Date;
        EmpVec: Record Employee;
        PurposeValidate: Record Purpose;

        OcitackaZonaljetoDecimal: Decimal;
        OcitackaZonaZenoDecimal: Decimal;

        StartPotrosnjeDate: Date;
        ProjektovanoDecimal: Decimal;
        InstalisanoDecimal: Decimal;
        AlternativnoGorivoBoolean: Boolean;
        NadmorskaVisinaDecimal: Decimal;
        GISInt: Integer;
        PodeseniPritisakDecimal: Decimal;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        EG: Record Employee;
        CHistory2: Record "Status History MM";
        CHistory: Record "Status History MM";
        CHistory3: Record "Status History MM";
        NoSe: Record "No. Series";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        NoSeriesLine: Record "No. Series Line";
        ER: Record Employee;
        ContactCode: code[20];
        Redoslijed: Integer;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
        AlternativeAddress: Record "Alternative Address";
        ContactV: Record Contact;
        RezimLjetoInt: Integer;
        RezimZimaInt: Integer;
        RezimPrelazInt: Integer;

        Department: Record Department;
        RecordLink: Record "Record Link";
        RecordLinkTest: Record "Record Link";
        LastLinkID: Integer;
        Slozen: Decimal;
        EmployeeU: Record Employee;
        Code2: Code[20];
        Code3: Code[20];
        HumanResSetup: Record "Human Resources Setup";
        Uslov: Decimal;

        Odgovor: Decimal;
        RecordLinkMgt: Codeunit "Record Link Management";
}