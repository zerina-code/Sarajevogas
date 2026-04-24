xmlport 50053 ImportGID
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ImportGID';
    schema
    {
        textelement(Root)
        {
            tableelement(GasInstallationData; "Gas Installation Data")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'UGI';
                UseTemporary = false;

                textelement(Id)
                {
                    MinOccurs = Zero;

                }

                textelement(pregledUgi)
                {
                    MinOccurs = Zero;
                }
                textelement(Datum)
                {
                    MinOccurs = Zero;
                }
                textelement(MM)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraKupca)
                {
                    MinOccurs = Zero;
                }
                textelement(Kategorija)
                {
                    MinOccurs = Zero;
                }
                textelement(KupacNaziv)
                {
                    MinOccurs = Zero;
                }
                textelement(KupacAdresa)
                {
                    MinOccurs = Zero;
                }
                textelement(Opstine)
                {
                    MinOccurs = Zero;
                }
                textelement(RMS_u_objektu)
                {
                    MinOccurs = Zero;
                }
                textelement(Spojni_elementi_plombirani)
                {
                    MinOccurs = Zero;
                }
                textelement(Pristupačan_za_očitanje)
                {
                    MinOccurs = Zero;
                }
                textelement(Ugi_ostala_u_pogonu)
                {
                    MinOccurs = Zero;
                }
                textelement(Ugi_puštena_u_pogon)
                {
                    MinOccurs = Zero;
                }
                textelement(Ugi_stavljena_van_pogona)
                {
                    MinOccurs = Zero;
                }
                textelement(Isključen_IV_ispred_gasnog_trošila)
                {
                    MinOccurs = Zero;
                }
                textelement(Ugi_ostala_van_pogona)
                {
                    MinOccurs = Zero;
                }
                textelement(Serviser)
                {
                    MinOccurs = Zero;
                }
                textelement(Elektro_atest)
                {
                    MinOccurs = Zero;
                }
                textelement(Dimnjačar_atest)
                {
                    MinOccurs = Zero;
                }
                textelement(Glavna_Saglasnost)
                {
                    MinOccurs = Zero;
                }
                textelement(Naziv_izvođača_Ispit_UGI_na_Čvstoću)
                {
                    MinOccurs = Zero;
                }
                textelement(Čvrstoća_Datum)
                {
                    MinOccurs = Zero;
                }
                textelement(Naziv_izvođača_Ispit_UGI_na_nepropusnost)
                {
                    MinOccurs = Zero;
                }
                textelement(Nepropusnost_Datum)
                {
                    MinOccurs = Zero;
                }

                textelement(Naziv_izvođača_Ispit_UGI_na_upotrebljivost)
                {
                    MinOccurs = Zero;
                }
                textelement(Upotrebljivost_Datum)
                {
                    MinOccurs = Zero;
                }

                textelement(Naziv_izvođača_Ispit_UGI_radnim_pritiskom)
                {
                    MinOccurs = Zero;
                }
                textelement(Radni_Pritisak_Datum)
                {
                    MinOccurs = Zero;
                }
                textelement(Izvrsena_Detekcija_ppm)
                {
                    MinOccurs = Zero;
                }
                textelement(Izvrsena_Kontrola_CO_ppm)
                {
                    MinOccurs = Zero;
                }
                textelement(Bakar)
                {
                    MinOccurs = Zero;
                }
                textelement(Spoj_pres_fiting)
                {
                    MinOccurs = Zero;
                }
                textelement(Tvrdi_lem)
                {
                    MinOccurs = Zero;
                }
                textelement(Mehki__lem)
                {
                    MinOccurs = Zero;
                }
                textelement(Čelik)
                {
                    MinOccurs = Zero;
                }
                textelement(Spoj_varenjem)
                {
                    MinOccurs = Zero;
                }
                textelement(Navojni_spoj)
                {
                    MinOccurs = Zero;
                }
                textelement(Napomena)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                begin

                    GasInstallationData.Reset();
                    Evaluate(IdInteger, Id);
                    GasInstallationData.SetFilter("Entry No.", '%1', IdInteger);

                    if GasInstallationData.FindFirst() then begin

                        if pregledUgi <> '' then begin
                            if pregledUgi = 'DA' then
                                GasInstallationData."Visual inspection of the gas" := GasInstallationData."Visual inspection of the gas"::Yes;
                            if pregledUgi = 'NE' then
                                GasInstallationData."Visual inspection of the gas" := GasInstallationData."Visual inspection of the gas"::No;

                        end;

                        if Datum <> '' then begin
                            if Evaluate(DateD, Datum) then
                                GasInstallationData.Validate(Date, DateD);
                        end;


                        if SifraKupca <> '' then begin
                            Customer.Reset();
                            Customer.SetFilter("No.", '%1', SifraKupca);
                            if Customer.FindFirst() then begin
                                GasInstallationData."Customer No." := Customer."No.";
                                if StrLen(KupacNaziv) > 100 then
                                    KupacNaziv := CopyStr(KupacNaziv, 1, 100);
                                //  if UpperCase(KupacNaziv) = UpperCase(Customer."Name") then
                                //  GasInstallationData."Customer Name" := Customer."Name";
                                //  GasInstallationData."Customer Name" := Customer.Name;
                                GasInstallationData.Validate("Customer Name", KupacNaziv);
                            end;
                            //  GasInstallationData.Validate("Customer No.", SifraKupca);
                            // GasInstallationData.Validate("Customer Name", KupacNaziv);
                        end;

                        if Kategorija <> '' then begin
                            if Kategorija = 'Domaćinstva' then begin
                                if MM = '0' then
                                    GasInstallationData.Validate("Measure Point No.", SifraKupca)
                                //  GasInstallationData."Measure Point No." := SifraKupca
                                else begin
                                    MMT.Reset();
                                    MMT.SetFilter("MM Category", Kategorija);
                                    MMT.SetFilter("No.", '%1', MM);
                                    if MMT.FindFirst() then
                                        GasInstallationData.Validate("Measure Point No.", MM);
                                end;
                            end else begin
                                MMT.Reset();
                                MMT.SetFilter("MM Category", Kategorija);
                                MMT.SetFilter("No.", '%1', MM);
                                if MMT.FindFirst() then
                                    GasInstallationData.Validate("Measure Point No.", MM);
                            end;
                        end;

                        if KupacAdresa <> '' then begin
                            Street.Reset();
                            Street.SetFilter(Description, '%1', KupacAdresa);
                            if Street.FindFirst() then begin
                                GasInstallationData."Street Name" := Street.Description;
                                GasInstallationData.Street := Street.Code;
                            end;

                        end;

                        if Opstine <> '' then begin
                            Municipality.Reset();
                            Municipality.setfilter(Name, '%1', Opstine);
                            If Municipality.FindFirst() then begin
                                GasInstallationData."Municipality Name" := Municipality.Name;
                                GasInstallationData."Municipality Code" := Municipality.Code;
                            end;
                        end;


                        if RMS_u_objektu <> '' then begin
                            if RMS_u_objektu = 'DA' then
                                GasInstallationData."Gas Station Placement" := GasInstallationData."Gas Station Placement"::"In Object";
                            if RMS_u_objektu = 'NE' then
                                GasInstallationData."Gas Station Placement" := GasInstallationData."Gas Station Placement"::"Out of Object";
                        end;

                        if Spojni_elementi_plombirani <> '' then begin
                            if Spojni_elementi_plombirani = 'DA' then
                                GasInstallationData."Connection Elements Locked" := GasInstallationData."Connection Elements Locked"::Yes;
                            if Spojni_elementi_plombirani = 'NE' then
                                GasInstallationData."Connection Elements Locked" := GasInstallationData."Connection Elements Locked"::No;
                        end;

                        if Pristupačan_za_očitanje <> '' then begin
                            if "Pristupačan_za_očitanje" = 'DA' then
                                GasInstallationData."Accessible for Reading" := GasInstallationData."Accessible for Reading"::Yes;
                            if "Pristupačan_za_očitanje" = 'NE' then
                                GasInstallationData."Accessible for Reading" := GasInstallationData."Accessible for Reading"::No;

                        end;

                        if Ugi_ostala_u_pogonu <> '' then begin
                            if Ugi_ostala_u_pogonu = 'DA' then
                                GasInstallationData."UGI remained in operation" := GasInstallationData."UGI remained in operation"::Yes;
                            if Ugi_ostala_u_pogonu = 'NE' then
                                GasInstallationData."UGI remained in operation" := GasInstallationData."UGI remained in operation"::No;
                        end;

                        if Ugi_puštena_u_pogon <> '' then begin
                            if Ugi_puštena_u_pogon = 'DA' then
                                GasInstallationData."UGI put into operation" := GasInstallationData."UGI put into operation"::Yes;
                            if Ugi_puštena_u_pogon = 'NE' then
                                GasInstallationData."UGI put into operation" := GasInstallationData."UGI put into operation"::No;
                        end;

                        if Ugi_stavljena_van_pogona <> '' then begin
                            if Ugi_stavljena_van_pogona = 'DA' then
                                GasInstallationData."UGI out of operation" := GasInstallationData."UGI out of operation"::Yes;
                            if Ugi_stavljena_van_pogona = 'NE' then
                                GasInstallationData."UGI out of operation" := GasInstallationData."UGI out of operation"::No;
                        end;

                        if Isključen_IV_ispred_gasnog_trošila <> '' then begin
                            if Isključen_IV_ispred_gasnog_trošila = 'DA' then
                                GasInstallationData."Shutdown gas consumer" := GasInstallationData."Shutdown gas consumer"::Yes;
                            if Isključen_IV_ispred_gasnog_trošila = 'NE' then
                                GasInstallationData."Shutdown gas consumer" := GasInstallationData."Shutdown gas consumer"::No;
                        end;

                        if Ugi_ostala_van_pogona <> '' then begin
                            if Ugi_ostala_van_pogona = 'DA' then
                                GasInstallationData."UGI remained out of order" := GasInstallationData."UGI remained out of order"::Yes;
                            if Ugi_ostala_van_pogona = 'NE' then
                                GasInstallationData."UGI remained out of order" := GasInstallationData."UGI remained out of order"::No;
                        end;

                        if Serviser <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Serviser);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Serviceman := Contact."No.";
                                GasInstallationData."Serviceman Text" := Contact.Name;
                            end;
                        end;

                        if Elektro_atest <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Elektro_atest);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Attest := Contact."No.";
                                GasInstallationData."Attest Text" := Contact.Name;
                            end;
                        end;

                        if "Dimnjačar_atest" <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', "Dimnjačar_atest");
                            if Contact.FindFirst() then begin
                                GasInstallationData.Chimney := Contact.Name;
                            end;
                        end;

                        if Glavna_Saglasnost <> '' then begin
                            Glavna_Saglasnost := ReplaceString(Glavna_Saglasnost, 'EE', ';');
                            GasInstallationData.Validate("Consent ID", Glavna_Saglasnost);
                        end;

                        if Naziv_izvođača_Ispit_UGI_na_Čvstoću <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_na_Čvstoću);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Hardness := Contact.Name;
                            end;
                        end;

                        if Čvrstoća_Datum <> '' then begin
                            if Evaluate(Čvrstoća_DatumD, Čvrstoća_Datum) then
                                GasInstallationData.Validate("Hardness Date", Čvrstoća_DatumD);
                        end;

                        if Naziv_izvođača_Ispit_UGI_na_nepropusnost <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_na_nepropusnost);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Impermeability := Contact.Name;
                            end;
                        end;

                        if Nepropusnost_Datum <> '' then begin
                            if Evaluate(Nepropusnost_DatumD, Nepropusnost_Datum) then
                                GasInstallationData.Validate("Impermeability Date", Nepropusnost_DatumD);
                        end;

                        if Naziv_izvođača_Ispit_UGI_na_upotrebljivost <> '' then begin
                            Contact.reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_na_upotrebljivost);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Usability := Contact.Name;
                            end;
                        end;

                        if Upotrebljivost_Datum <> '' then begin
                            if Evaluate(Upotrebljivost_DatumD, Upotrebljivost_Datum) then
                                GasInstallationData.Validate("Usability Date", Upotrebljivost_DatumD);
                        end;

                        if Naziv_izvođača_Ispit_UGI_radnim_pritiskom <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_radnim_pritiskom);
                            if Contact.FindFirst() then begin
                                GasInstallationData."Working pressure test" := Contact.Name;
                            end;
                        end;

                        if Radni_Pritisak_Datum <> '' then begin
                            if Evaluate(Radni_Pritisak_DatumD, Radni_Pritisak_Datum) then
                                GasInstallationData.Validate("Working pressure Date test", Radni_Pritisak_DatumD);
                        end;

                        if Izvrsena_Detekcija_ppm <> '' then begin
                            if Evaluate(Izvrsena_Detekcija_ppmD, Izvrsena_Detekcija_ppm) then
                                GasInstallationData.Validate(ppm1, Izvrsena_Detekcija_ppmD);
                        end;

                        if Izvrsena_Kontrola_CO_ppm <> '' then begin
                            if Evaluate(Izvrsena_Kontrola_CO_ppmD, Izvrsena_Kontrola_CO_ppm) then
                                GasInstallationData.Validate(ppm2, Izvrsena_Kontrola_CO_ppmD);
                        end;

                        if Bakar <> '' then begin
                            if Bakar = 'DA' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::Copper;
                            if Bakar = 'NE' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::" ";
                        end;

                        if Čelik <> '' then begin
                            if Čelik = 'DA' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::Steel;
                            if Čelik = 'NE' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::" ";
                        end;

                        if Spoj_pres_fiting <> '' then begin
                            if Spoj_pres_fiting = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Press fitting";

                        end;

                        if Tvrdi_lem <> '' then begin
                            if Tvrdi_lem = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Hard solder";

                        end;

                        if Mehki__lem <> '' then begin
                            if Mehki__lem = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Soft solder";
                        end;

                        if Spoj_varenjem <> '' then begin
                            if Spoj_varenjem = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Welded joint";
                        end;

                        if Navojni_spoj <> '' then begin
                            if Navojni_spoj = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Threaded connection";
                        end;
                        /*  if Napomena <> '' then begin
                              Napomena := ReplaceString(Napomena, 'EE', ';');

                              if StrLen(Napomena) > 20 then
                                  Napomena := CopyStr(Napomena, 1, 20);
                              // GasInstallationData.Validate(Remark, Napomena);
                              GasInstallationData.Remark := Napomena;
                          end;*/


                        GasInstallationData.Modify();



                    end else begin


                        GasInstallationData.Init();

                        if Id <> '' then begin
                            if Evaluate(IdInteger, Id) then
                                GasInstallationData.Validate("Entry No.", IdInteger);
                        end;

                        if pregledUgi <> '' then begin
                            if pregledUgi = 'DA' then
                                GasInstallationData."Visual inspection of the gas" := GasInstallationData."Visual inspection of the gas"::Yes;
                            if pregledUgi = 'NE' then
                                GasInstallationData."Visual inspection of the gas" := GasInstallationData."Visual inspection of the gas"::No;

                        end;

                        if Datum <> '' then begin
                            if Evaluate(DateD, Datum) then
                                GasInstallationData.Validate(Date, DateD);
                        end;


                        if SifraKupca <> '' then begin
                            Customer.Reset();
                            Customer.SetFilter("No.", '%1', SifraKupca);
                            if Customer.FindFirst() then begin
                                GasInstallationData."Customer No." := Customer."No.";
                                if StrLen(KupacNaziv) > 100 then
                                    KupacNaziv := CopyStr(KupacNaziv, 1, 100);
                                //  if UpperCase(KupacNaziv) = UpperCase(Customer."Name") then
                                //  GasInstallationData."Customer Name" := Customer."Name";
                                //  GasInstallationData."Customer Name" := Customer.Name;
                                GasInstallationData.Validate("Customer Name", KupacNaziv);
                            end;
                            //  GasInstallationData.Validate("Customer No.", SifraKupca);
                            // GasInstallationData.Validate("Customer Name", KupacNaziv);
                        end;

                        if Kategorija <> '' then begin
                            if Kategorija = 'Domaćinstva' then begin
                                if MM = '0' then
                                    GasInstallationData.Validate("Measure Point No.", SifraKupca)
                                //GasInstallationData."Measure Point No." := SifraKupca
                                else begin
                                    MMT.Reset();
                                    MMT.SetFilter("MM Category", Kategorija);
                                    MMT.SetFilter("No.", '%1', MM);
                                    if MMT.FindFirst() then
                                        GasInstallationData.Validate("Measure Point No.", MM);
                                end;
                            end else begin
                                MMT.Reset();
                                MMT.SetFilter("MM Category", Kategorija);
                                MMT.SetFilter("No.", '%1', MM);
                                if MMT.FindFirst() then
                                    GasInstallationData.Validate("Measure Point No.", MM);
                            end;
                        end;

                        if KupacAdresa <> '' then begin
                            Street.Reset();
                            Street.SetFilter(Description, '%1', KupacAdresa);
                            if Street.FindFirst() then begin
                                GasInstallationData."Street Name" := Street.Description;
                                GasInstallationData.Street := Street.Code;
                            end;

                        end;

                        if Opstine <> '' then begin
                            Municipality.Reset();
                            Municipality.setfilter(Name, '%1', Opstine);
                            If Municipality.FindFirst() then begin
                                GasInstallationData."Municipality Name" := Municipality.Name;
                                GasInstallationData."Municipality Code" := Municipality.Code;
                            end;
                        end;

                        if RMS_u_objektu <> '' then begin
                            if RMS_u_objektu = 'DA' then
                                GasInstallationData."Gas Station Placement" := GasInstallationData."Gas Station Placement"::"In Object";
                            if RMS_u_objektu = 'NE' then
                                GasInstallationData."Gas Station Placement" := GasInstallationData."Gas Station Placement"::"Out of Object";
                        end;

                        if Spojni_elementi_plombirani <> '' then begin
                            if Spojni_elementi_plombirani = 'DA' then
                                GasInstallationData."Connection Elements Locked" := GasInstallationData."Connection Elements Locked"::Yes;
                            if Spojni_elementi_plombirani = 'NE' then
                                GasInstallationData."Connection Elements Locked" := GasInstallationData."Connection Elements Locked"::No;
                        end;

                        if Pristupačan_za_očitanje <> '' then begin
                            if "Pristupačan_za_očitanje" = 'DA' then
                                GasInstallationData."Accessible for Reading" := GasInstallationData."Accessible for Reading"::Yes;
                            if "Pristupačan_za_očitanje" = 'NE' then
                                GasInstallationData."Accessible for Reading" := GasInstallationData."Accessible for Reading"::No;

                        end;

                        if Ugi_ostala_u_pogonu <> '' then begin
                            if Ugi_ostala_u_pogonu = 'DA' then
                                GasInstallationData."UGI remained in operation" := GasInstallationData."UGI remained in operation"::Yes;
                            if Ugi_ostala_u_pogonu = 'NE' then
                                GasInstallationData."UGI remained in operation" := GasInstallationData."UGI remained in operation"::No;
                        end;

                        if Ugi_puštena_u_pogon <> '' then begin
                            if Ugi_puštena_u_pogon = 'DA' then
                                GasInstallationData."UGI put into operation" := GasInstallationData."UGI put into operation"::Yes;
                            if Ugi_puštena_u_pogon = 'NE' then
                                GasInstallationData."UGI put into operation" := GasInstallationData."UGI put into operation"::No;
                        end;

                        if Ugi_stavljena_van_pogona <> '' then begin
                            if Ugi_stavljena_van_pogona = 'DA' then
                                GasInstallationData."UGI out of operation" := GasInstallationData."UGI out of operation"::Yes;
                            if Ugi_stavljena_van_pogona = 'NE' then
                                GasInstallationData."UGI out of operation" := GasInstallationData."UGI out of operation"::No;
                        end;

                        if Isključen_IV_ispred_gasnog_trošila <> '' then begin
                            if Isključen_IV_ispred_gasnog_trošila = 'DA' then
                                GasInstallationData."Shutdown gas consumer" := GasInstallationData."Shutdown gas consumer"::Yes;
                            if Isključen_IV_ispred_gasnog_trošila = 'NE' then
                                GasInstallationData."Shutdown gas consumer" := GasInstallationData."Shutdown gas consumer"::No;
                        end;

                        if Ugi_ostala_van_pogona <> '' then begin
                            if Ugi_ostala_van_pogona = 'DA' then
                                GasInstallationData."UGI remained out of order" := GasInstallationData."UGI remained out of order"::Yes;
                            if Ugi_ostala_van_pogona = 'NE' then
                                GasInstallationData."UGI remained out of order" := GasInstallationData."UGI remained out of order"::No;
                        end;

                        if Serviser <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Serviser);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Serviceman := Contact."No.";
                                GasInstallationData."Serviceman Text" := Contact.Name;
                            end;
                        end;

                        if Elektro_atest <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Elektro_atest);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Attest := Contact."No.";
                                GasInstallationData."Attest Text" := Contact.Name;
                            end;
                        end;

                        if "Dimnjačar_atest" <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', "Dimnjačar_atest");
                            if Contact.FindFirst() then begin
                                GasInstallationData.Chimney := Contact.Name;
                            end;
                        end;

                        if Glavna_Saglasnost <> '' then begin
                            Glavna_Saglasnost := ReplaceString(Glavna_Saglasnost, 'EE', ';');
                            GasInstallationData.Validate("Consent ID", Glavna_Saglasnost);
                        end;

                        if Naziv_izvođača_Ispit_UGI_na_Čvstoću <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_na_Čvstoću);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Hardness := Contact.Name;
                            end;
                        end;

                        if Čvrstoća_Datum <> '' then begin
                            if Evaluate(Čvrstoća_DatumD, Čvrstoća_Datum) then
                                GasInstallationData.Validate("Hardness Date", Čvrstoća_DatumD);
                        end;

                        if Naziv_izvođača_Ispit_UGI_na_nepropusnost <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_na_nepropusnost);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Impermeability := Contact.Name;
                            end;
                        end;

                        if Nepropusnost_Datum <> '' then begin
                            if Evaluate(Nepropusnost_DatumD, Nepropusnost_Datum) then
                                GasInstallationData.Validate("Impermeability Date", Nepropusnost_DatumD);
                        end;

                        if Naziv_izvođača_Ispit_UGI_na_upotrebljivost <> '' then begin
                            Contact.reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_na_upotrebljivost);
                            if Contact.FindFirst() then begin
                                GasInstallationData.Usability := Contact.Name;
                            end;
                        end;

                        if Upotrebljivost_Datum <> '' then begin
                            if Evaluate(Upotrebljivost_DatumD, Upotrebljivost_Datum) then
                                GasInstallationData.Validate("Usability Date", Upotrebljivost_DatumD);
                        end;

                        if Naziv_izvođača_Ispit_UGI_radnim_pritiskom <> '' then begin
                            Contact.Reset();
                            Contact.SetFilter(Name, '%1', Naziv_izvođača_Ispit_UGI_radnim_pritiskom);
                            if Contact.FindFirst() then begin
                                GasInstallationData."Working pressure test" := Contact.Name;
                            end;
                        end;

                        if Radni_Pritisak_Datum <> '' then begin
                            if Evaluate(Radni_Pritisak_DatumD, Radni_Pritisak_Datum) then
                                GasInstallationData.Validate("Working pressure Date test", Radni_Pritisak_DatumD);
                        end;

                        if Izvrsena_Detekcija_ppm <> '' then begin
                            if Evaluate(Izvrsena_Detekcija_ppmD, Izvrsena_Detekcija_ppm) then
                                GasInstallationData.Validate(ppm1, Izvrsena_Detekcija_ppmD);
                        end;

                        if Izvrsena_Kontrola_CO_ppm <> '' then begin
                            if Evaluate(Izvrsena_Kontrola_CO_ppmD, Izvrsena_Kontrola_CO_ppm) then
                                GasInstallationData.Validate(ppm2, Izvrsena_Kontrola_CO_ppmD);
                        end;

                        if Bakar <> '' then begin
                            if Bakar = 'DA' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::Copper;
                            if Bakar = 'NE' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::" ";
                        end;

                        if Čelik <> '' then begin
                            if Čelik = 'DA' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::Steel;
                            if Čelik = 'NE' then
                                GasInstallationData."Pipe/Connection Type" := GasInstallationData."Pipe/Connection Type"::" ";
                        end;

                        if Spoj_pres_fiting <> '' then begin
                            if Spoj_pres_fiting = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Press fitting";

                        end;

                        if Tvrdi_lem <> '' then begin
                            if Tvrdi_lem = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Hard solder";

                        end;

                        if Mehki__lem <> '' then begin
                            if Mehki__lem = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Soft solder";
                        end;

                        if Spoj_varenjem <> '' then begin
                            if Spoj_varenjem = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Welded joint";
                        end;

                        if Navojni_spoj <> '' then begin
                            if Navojni_spoj = 'DA' then
                                GasInstallationData."Connection type" := GasInstallationData."Connection type"::"Threaded connection";
                        end;
                        /*  if Napomena <> '' then begin
                              Napomena := ReplaceString(Napomena, 'EE', ';');
                              if StrLen(Napomena) > 20 then
                                  Napomena := CopyStr(Napomena, 1, 20);
                              GasInstallationData.Remark := Napomena;
                          end;*/

                        GasInstallationData.Insert();

                    end;


                end;

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250]
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    var

        IdInteger: Integer;
        DateD: Date;
        Contact: Record Contact;
        Čvrstoća_DatumD: Date;
        Nepropusnost_DatumD: Date;
        Upotrebljivost_DatumD: Date;
        Radni_Pritisak_DatumD: Date;
        Izvrsena_Detekcija_ppmD: Decimal;
        Izvrsena_Kontrola_CO_ppmD: Decimal;
        Street: Record Street;
        Municipality: Record Municipality;
        Customer: Record Customer;
        MMT: Record "Service Item";
}
