xmlport 50049 ImportTuzbeFebruar
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ImportTuzbeFebruar';

    schema
    {
        textelement(Root)
        {
            tableelement("Accusation Header"; "Accusation Header")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'AccusationHeaderFeb';
                UseTemporary = false;

                textelement(sifra_tuzbe)
                {
                    MinOccurs = Zero;
                }
                textelement(kategorija)
                {
                    MinOccurs = Zero;
                }
                textelement(br_kupca)
                {
                    MinOccurs = Zero;
                }
                textelement(ime_kupca)
                {
                    MinOccurs = Zero;
                }
                textelement(datum_dokumenta)
                {
                    MinOccurs = Zero;
                }
                /* textelement(id_glavne)
                 {
                     MinOccurs = Zero;
                 }*/
                textelement(dug_pocetni)
                {
                    MinOccurs = Zero;
                }
                /* textelement(dug_presuda)
                 {
                     MinOccurs = Zero;
                 }*/
                /* textelement(dug_placeno)
                 {
                     MinOccurs = Zero;
                 }*/
                textelement(kamata)
                {
                    MinOccurs = Zero;
                }
                /*      textelement(kamata_presuda)
                      {
                          MinOccurs = Zero;
                      }*/
                textelement(kamata_placena)
                {
                    MinOccurs = Zero;
                }
                textelement(sudska_taksa)
                {
                    MinOccurs = Zero;
                }
                /*  textelement(sudska_taksa_presuda)
                   {
                       MinOccurs = Zero;
                   }*/
                textelement(sudska_taksa_placeno)
                {
                    MinOccurs = Zero;
                }
                textelement(IP_sifra)
                {
                    MinOccurs = Zero;
                }
                textelement(datum_ip)
                {
                    MinOccurs = Zero;
                }
                /*  textelement(IP)
                  {
                      MinOccurs = Zero;
                  }*/
                textelement(sud)
                {
                    MinOccurs = Zero;
                }
                textelement(status_tuzbe_sifra)
                {
                    MinOccurs = Zero;
                }
                textelement(status_tuzbe_datum)
                {
                    MinOccurs = Zero;
                }
                textelement(napomena)
                {
                    MinOccurs = Zero;
                }

                textelement(status_tuzbe_opis)
                {
                    MinOccurs = Zero;
                }
                /*   textelement(datum_zadnje_izmjene)
                   {
                       MinOccurs = Zero;
                   }*/




                trigger OnAfterInsertrecord()
                var
                    Kupac: Record Customer;

                begin

                    "Accusation Header".Reset();
                    "Accusation Header".SetFilter("No.", '%1', sifra_tuzbe);
                    "Accusation Header".SetFilter("Customer No.", '%1', br_kupca);

                    if "Accusation Header".FindFirst() then begin

                        /*  if "Accusation Header"."No." = '' then begin

                              "Accusation Header"."No." := sifra_tuzbe;
                          end;*/

                        if br_kupca <> '' then begin
                            Kupac.Reset();
                            Kupac.SetRange("No.", br_kupca);
                            if Kupac.FindFirst() then begin
                                "Accusation Header".Validate("Customer No.", br_kupca);
                                if StrLen(ime_kupca) > 50 then
                                    "Accusation Header"."Customer Name" := CopyStr(ime_kupca, 1, 50)
                                else
                                    "Accusation Header"."Customer Name" := ime_kupca;
                            end else begin
                                if MissingCustomer = '' then
                                    MissingCustomer := br_kupca
                                else
                                    MissingCustomer += ', ' + br_kupca;
                            end;

                        end;

                        if kategorija <> '' then begin
                            AccLine.Reset();
                            AccLine.SetRange("Document No.", sifra_tuzbe);
                            if AccLine.FindLast() then
                                AccLine."Line No." := AccLine."Line No." + 10000
                            else
                                AccLine."Line No." := 10000;

                            AccLine.Init();
                            AccLine."Document No." := sifra_tuzbe;

                            if kategorija = 'MP' then
                                AccLine.Validate("Bill Category", AccLine."Bill Category"::"Small Economy");
                            if kategorija = 'VP' then
                                AccLine.Validate("Bill Category", AccLine."Bill Category"::"Large Economy");
                            if kategorija = 'D' then
                                AccLine.Validate("Bill Category", AccLine."Bill Category"::Household);

                            AccLine.Insert();
                        end;

                        if datum_dokumenta <> '' then begin
                            if Evaluate(DatumDokumentaDate, datum_dokumenta) then
                                "Accusation Header"."Document Date" := DatumDokumentaDate;
                        end;

                        if dug_pocetni <> '' then begin
                            if Evaluate(DugPocetniDecimal, dug_pocetni) then
                                "Accusation Header".Debt := DugPocetniDecimal;
                        end;



                        if kamata <> '' then begin
                            if Evaluate(KamataDecimal, kamata) then
                                "Accusation Header".Interest := KamataDecimal;
                        end;

                        //kamata_presuda - dodati polje

                        if kamata_placena <> '' then begin
                            if Evaluate(KamataPlacenoDecimal, kamata_placena) then
                                "Accusation Header"."Interest amount paid-Transfer" := KamataPlacenoDecimal;
                        end;

                        if sudska_taksa <> '' then begin
                            if Evaluate(SudskaTaksaDecimal, sudska_taksa) then
                                "Accusation Header"."Court Expenses Amt - Transfer" := SudskaTaksaDecimal;
                        end;



                        if sudska_taksa_placeno <> '' then begin
                            if Evaluate(SudskaTaksaPlacenoDecimal, sudska_taksa_placeno) then
                                "Accusation Header"."Court Expenses Amt Paid - Tr" := SudskaTaksaPlacenoDecimal;

                        end;
                        if napomena <> '' then begin
                            "Accusation Header".Note := napomena;
                        end;


                        /*    if datum_ip <> '' then begin
                                IPsifraInsert.Reset();
                                IPsifraInsert.SetFilter(Code, '%1', sifra_tuzbe);
                                if not IPsifraInsert.FindFirst() then begin
                                    IPsifraInsert.Init();
                                    IPsifraInsert.Code := sifra_tuzbe;
                                    if Evaluate(DatumIPDate, datum_ip) then
                                        IPsifraInsert.Date := DatumIPDate;
                                    IPsifraInsert.IP := IP;
                                    IPsifraInsert.Insert();
                                    Commit();

                                end;
                            end;*/



                        /* if status_tuzbe_sifra <> '' then begin
                             AccusationStatus.Reset();
                             // AccusationStatus.SetFilter(Code, '%1', StatusId);
                             AccusationStatus.SetFilter(Code, '%1', sifra_tuzbe);
                             AccusationStatus.SetRange(Type, 4);
                             if not AccusationStatus.FindFirst() then begin
                                 AccusationStatus.Init();
                                 AccusationStatus.Code := sifra_tuzbe;
                                 if Evaluate(DatumStatus, status_tuzbe_datum) then
                                     AccusationStatus.Date := DatumStatus;
                                 AccusationStatus.Type := 4;
                                 // AccusationStatus.Accusation := StatusId;
                                 AccusationStatus.Accusation := sifra_tuzbe;
                                 AccusationStatus.Customer := br_kupca;
                                 if status_tuzbe_sifra = '1' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");


                                 if status_tuzbe_sifra = '5' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                 if status_tuzbe_sifra = '6' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                 if status_tuzbe_sifra = '7' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                 if status_tuzbe_sifra = '8' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                 if status_tuzbe_sifra = '10' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                 if status_tuzbe_sifra = '11' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                 if status_tuzbe_sifra = '12' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                 if status_tuzbe_sifra = '13' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda vraćena");
                                 if status_tuzbe_sifra = '15' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                 if status_tuzbe_sifra = '16' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Pripremljen pravnicima");
                                 if status_tuzbe_sifra = '17' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                 if status_tuzbe_sifra = '18' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                 if status_tuzbe_sifra = '19' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                 if status_tuzbe_sifra = '20' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Stečaj/Likvidacija");
                                 if status_tuzbe_sifra = '29' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                 if status_tuzbe_sifra = '30' then
                                     AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");


                                 AccusationStatus.Insert();
                                 Commit();
                             end;

                             "Accusation Header"."Accusation Status" := status_tuzbe_sifra;
                             "Accusation Header".Status := AccusationStatus.Status;

                         end;*/
                        if status_tuzbe_sifra <> '' then begin
                            AccusationStatus.Reset();
                            AccusationStatus.SetFilter(Code, '%1', sifra_tuzbe);
                            AccusationStatus.SetRange(Type, 4);

                            if AccusationStatus.FindFirst() then begin
                                // Update postojećeg zapisa
                                if Evaluate(DatumStatus, status_tuzbe_datum) then
                                    AccusationStatus.Date := DatumStatus;

                                // Postavljanje statusa prema status_tuzbe_sifra
                                case status_tuzbe_sifra of
                                    '1':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");
                                    '5':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                    '6':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                    '7':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                    '8':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                    '10':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                    '11':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                    '12':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                    '13':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda vraćena");
                                    '15':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                    '16':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Pripremljen pravnicima");
                                    '17':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                    '18':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                    '19':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                    '20':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Stečaj/Likvidacija");
                                    '29':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                    '30':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");
                                end;

                                AccusationStatus.Modify();
                                Commit();

                            end else begin
                                // Ubaci novi zapis
                                AccusationStatus.Init();
                                AccusationStatus.Code := sifra_tuzbe;
                                if Evaluate(DatumStatus, status_tuzbe_datum) then
                                    AccusationStatus.Date := DatumStatus;
                                AccusationStatus.Type := 4;
                                AccusationStatus.Accusation := sifra_tuzbe;
                                AccusationStatus.Customer := br_kupca;

                                case status_tuzbe_sifra of
                                    '1':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");
                                    '5':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                    '6':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                    '7':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                    '8':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                    '10':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                    '11':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                    '12':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                    '13':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda vraćena");
                                    '15':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                    '16':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Pripremljen pravnicima");
                                    '17':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                    '18':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                    '19':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                    '20':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Stečaj/Likvidacija");
                                    '29':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                    '30':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");
                                end;

                                AccusationStatus.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Accusation Status" := status_tuzbe_sifra;
                            "Accusation Header".Status := AccusationStatus.Status;
                        end;


                        /*   if IP_sifra <> '' then begin
                               if Evaluate(IPSifra, IP_sifra) then
                                   "Accusation Header".IP := IPSifra;
                           end;*/

                        /*if IP_sifra <> '' then begin
                            IPsifraInsert.Reset();
                            IPsifraInsert.SetFilter(Code, '%1', sifra_tuzbe);
                            //IPsifraInsert.SetFilter(IP, '%1', CopyStr(ip_suda, 1, 30));
                            if not IPsifraInsert.FindFirst() then begin
                                IPsifraInsert.Init();
                                IPsifraInsert.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.IP := IP_sifra;
                                IPsifraInsert.Accusation := sifra_tuzbe;
                                IPsifraInsert.Customer := br_kupca;
                                IPsifraInsert.Type := 6;

                                IPsifraInsert.Insert();
                                Commit();


                            end;

                            "Accusation Header".IP := IPsifraInsert.Code;


                        end;*/
                        if IP_sifra <> '' then begin
                            IPsifraInsert.Reset();
                            IPsifraInsert.SetRange(Accusation, sifra_tuzbe);
                            IPsifraInsert.SetRange(Type, 6); // Tip 6 = IP_sud

                            if IPsifraInsert.FindFirst() then begin
                                // Ažuriraj postojeći zapis za IP_sud
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.IP := IP_sifra;
                                IPsifraInsert.Customer := br_kupca;
                                IPsifraInsert.Modify();
                            end else begin
                                // Unesi novi zapis za IP_sud
                                IPsifraInsert.Init();
                                IPsifraInsert.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.IP := IP_sifra;
                                IPsifraInsert.Accusation := sifra_tuzbe;
                                IPsifraInsert.Customer := br_kupca;
                                IPsifraInsert.Type := 6; // IP_sud

                                IPsifraInsert.Insert();
                                Commit();
                            end;

                            "Accusation Header".IP := IPsifraInsert.Code;
                            "Accusation Header"."Current IP" := IPsifraInsert.IP;
                        end;

                        /*   if sud <> '' then begin
                               CourtCode.Reset();
                               CourtCode.SetFilter(Code, '%1', sifra_tuzbe);
                               if not CourtCode.FindFirst() then begin
                                   CourtCode.Init();
                                   CourtCode.Code := TerritoryCode;
                                   TerritoryCode := IncStr(TerritoryCode);
                                   CourtCode.Type := 1;
                                   CourtCode.MALS := sud;
                                   CourtCode.Accusation := sifra_tuzbe;
                                   CourtCode.Customer := br_kupca;

                                   CourtCode.Insert();
                                   Commit();



                               end;

                               "Accusation Header"."Court number" := CourtCode.Code;
                               "Accusation Header"."Actual Court Number" := CourtCode.MALS;
                           end;*/
                        if sud <> '' then begin
                            CourtCode.Reset();
                            CourtCode.SetRange(Accusation, sifra_tuzbe);
                            CourtCode.SetRange(Type, 1); // Tip 1 = Sud

                            if CourtCode.FindFirst() then begin
                                // Ažuriraj postojeći zapis za sud
                                CourtCode.MALS := sud;
                                CourtCode.Customer := br_kupca;
                                CourtCode.Modify();
                            end else begin
                                // Unesi novi zapis za sud
                                CourtCode.Init();
                                CourtCode.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                CourtCode.Type := 1; // Sud
                                CourtCode.MALS := sud;
                                CourtCode.Accusation := sifra_tuzbe;
                                CourtCode.Customer := br_kupca;

                                CourtCode.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Court number" := CourtCode.Code;
                            "Accusation Header"."Actual Court Number" := CourtCode.MALS;
                        end;

                        "Accusation Header".Modify();

                    end else begin


                        if MissingCustomer = '' then
                            MissingCustomer := br_kupca
                        else
                            MissingCustomer += ', ' + br_kupca;




                        "Accusation Header".Init();
                        "Accusation Header"."No." := sifra_tuzbe;



                        if br_kupca <> '' then begin
                            Kupac.Reset();
                            Kupac.SetRange("No.", br_kupca);
                            if Kupac.FindFirst() then begin
                                "Accusation Header".Validate("Customer No.", br_kupca);
                                if StrLen(ime_kupca) > 50 then
                                    "Accusation Header"."Customer Name" := CopyStr(ime_kupca, 1, 50)
                                else
                                    "Accusation Header"."Customer Name" := ime_kupca;
                            end else begin
                                if MissingCustomer = '' then
                                    MissingCustomer := br_kupca
                                else
                                    MissingCustomer += ', ' + br_kupca;
                            end;

                        end;

                        if kategorija <> '' then begin
                            AccLine.Reset();
                            AccLine.SetRange("Document No.", sifra_tuzbe);
                            if AccLine.FindLast() then
                                AccLine."Line No." := AccLine."Line No." + 10000
                            else
                                AccLine."Line No." := 10000;

                            AccLine.Init();
                            AccLine."Document No." := sifra_tuzbe;

                            if kategorija = 'MP' then
                                AccLine.Validate("Bill Category", AccLine."Bill Category"::"Small Economy");
                            if kategorija = 'VP' then
                                AccLine.Validate("Bill Category", AccLine."Bill Category"::"Large Economy");
                            if kategorija = 'D' then
                                AccLine.Validate("Bill Category", AccLine."Bill Category"::Household);

                            AccLine.Insert();
                        end;

                        /*  if kategorija <> '' then begin
                              if kategorija = 'MP' then
                                  "Accusation Header".Validate("Bill Category", "Accusation Header"."Bill Category"::"Small Economy");
                              if kategorija = 'VP' then
                                  "Accusation Header".Validate("Bill Category", "Accusation Header"."Bill Category"::"Large Economy");
                          end;*/

                        if datum_dokumenta <> '' then begin
                            if Evaluate(DatumDokumentaDate, datum_dokumenta) then
                                "Accusation Header"."Document Date" := DatumDokumentaDate;
                        end;

                        if dug_pocetni <> '' then begin
                            if Evaluate(DugPocetniDecimal, dug_pocetni) then
                                "Accusation Header".Debt := DugPocetniDecimal;
                        end;


                        if napomena <> '' then begin
                            "Accusation Header".Note := napomena;
                        end;

                        if kamata <> '' then begin
                            if Evaluate(KamataDecimal, kamata) then
                                "Accusation Header".Interest := KamataDecimal;
                        end;


                        if kamata_placena <> '' then begin
                            if Evaluate(KamataPlacenoDecimal, kamata_placena) then
                                "Accusation Header"."Interest amount paid-Transfer" := KamataPlacenoDecimal;
                        end;

                        if sudska_taksa <> '' then begin
                            if Evaluate(SudskaTaksaDecimal, sudska_taksa) then
                                "Accusation Header"."Court Expenses Amt - Transfer" := SudskaTaksaDecimal;
                        end;


                        if sudska_taksa_placeno <> '' then begin
                            if Evaluate(SudskaTaksaPlacenoDecimal, sudska_taksa_placeno) then
                                "Accusation Header"."Court Expenses Amt Paid - Tr" := SudskaTaksaPlacenoDecimal;

                        end;


                        /*     if datum_ip <> '' then begin
                                 IPsifraInsert.Reset();
                                 IPsifraInsert.SetFilter(Code, '%1', sifra_tuzbe);
                                 if not IPsifraInsert.FindFirst() then begin
                                     IPsifraInsert.Init();
                                     if Evaluate(DatumIPDate, datum_ip) then
                                         IPsifraInsert.Date := DatumIPDate;
                                     //  IPsifraInsert.IP := IP;
                                     IPsifraInsert.Insert();
                                     Commit();

                                 end;
                             end;*/

                        /*     if datum_ip <> '' then begin
                                 IPsifraInsert.Reset();
                                 IPsifraInsert.SetFilter(Code, '%1', sifra_tuzbe);
                                 if not IPsifraInsert.FindFirst() then begin
                                     IPsifraInsert.Init();
                                     IPsifraInsert.Code := sifra_tuzbe;
                                     if Evaluate(DatumIPDate, datum_ip) then
                                         IPsifraInsert.Date := DatumIPDate;
                                     IPsifraInsert.IP := IP;
                                     IPsifraInsert.Insert();
                                     Commit();

                                 end;
                             end;*/



                        /*  if status_tuzbe_sifra <> '' then begin
                              AccusationStatus.Reset();
                              // AccusationStatus.SetFilter(Code, '%1', StatusId);
                              AccusationStatus.SetFilter(Code, '%1', sifra_tuzbe);
                              AccusationStatus.SetRange(Type, 4);
                              if not AccusationStatus.FindFirst() then begin
                                  AccusationStatus.Init();
                                  AccusationStatus.Code := sifra_tuzbe;
                                  if Evaluate(DatumStatus, status_tuzbe_datum) then
                                      AccusationStatus.Date := DatumStatus;
                                  AccusationStatus.Type := 4;
                                  // AccusationStatus.Accusation := StatusId;
                                  AccusationStatus.Accusation := sifra_tuzbe;
                                  AccusationStatus.Customer := br_kupca;
                                  if status_tuzbe_sifra = '1' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");


                                  if status_tuzbe_sifra = '5' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                  if status_tuzbe_sifra = '6' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                  if status_tuzbe_sifra = '7' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                  if status_tuzbe_sifra = '8' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                  if status_tuzbe_sifra = '10' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                  if status_tuzbe_sifra = '11' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                  if status_tuzbe_sifra = '12' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                  if status_tuzbe_sifra = '13' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda vraćena");
                                  if status_tuzbe_sifra = '15' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                  if status_tuzbe_sifra = '16' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Pripremljen pravnicima");
                                  if status_tuzbe_sifra = '17' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                  if status_tuzbe_sifra = '18' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                  if status_tuzbe_sifra = '19' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                  if status_tuzbe_sifra = '20' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Stečaj/Likvidacija");
                                  if status_tuzbe_sifra = '29' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                  if status_tuzbe_sifra = '30' then
                                      AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");


                                  AccusationStatus.Insert();
                                  Commit();
                              end;

                              "Accusation Header"."Accusation Status" := status_tuzbe_sifra;
                              "Accusation Header".Status := AccusationStatus.Status;

                          end;*/
                        if status_tuzbe_sifra <> '' then begin
                            AccusationStatus.Reset();
                            AccusationStatus.SetFilter(Code, '%1', sifra_tuzbe);
                            AccusationStatus.SetRange(Type, 4);

                            if AccusationStatus.FindFirst() then begin
                                // Update postojećeg zapisa
                                if Evaluate(DatumStatus, status_tuzbe_datum) then
                                    AccusationStatus.Date := DatumStatus;

                                // Postavljanje statusa prema status_tuzbe_sifra
                                case status_tuzbe_sifra of
                                    '1':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");
                                    '5':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                    '6':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                    '7':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                    '8':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                    '10':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                    '11':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                    '12':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                    '13':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda vraćena");
                                    '15':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                    '16':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Pripremljen pravnicima");
                                    '17':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                    '18':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                    '19':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                    '20':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Stečaj/Likvidacija");
                                    '29':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                    '30':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");
                                end;

                                AccusationStatus.Modify();
                                Commit();

                            end else begin
                                // Ubaci novi zapis
                                AccusationStatus.Init();
                                AccusationStatus.Code := sifra_tuzbe;
                                if Evaluate(DatumStatus, status_tuzbe_datum) then
                                    AccusationStatus.Date := DatumStatus;
                                AccusationStatus.Type := 4;
                                AccusationStatus.Accusation := sifra_tuzbe;
                                AccusationStatus.Customer := br_kupca;

                                case status_tuzbe_sifra of
                                    '1':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");
                                    '5':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                    '6':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                    '7':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                    '8':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                    '10':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                    '11':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                    '12':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                    '13':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda vraćena");
                                    '15':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                    '16':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Pripremljen pravnicima");
                                    '17':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                    '18':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                    '19':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                    '20':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Stečaj/Likvidacija");
                                    '29':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                    '30':
                                        AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");
                                end;

                                AccusationStatus.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Accusation Status" := status_tuzbe_sifra;
                            "Accusation Header".Status := AccusationStatus.Status;
                        end;


                        /*    if IP_sifra <> '' then begin
                                if Evaluate(IPSifra, IP_sifra) then
                                    "Accusation Header".IP := IPSifra;
                            end;*/

                        /*    if IP_sifra <> '' then begin
                                IPsifraInsert.Reset();
                                IPsifraInsert.SetFilter(Code, '%1', sifra_tuzbe);
                                //IPsifraInsert.SetFilter(IP, '%1', CopyStr(ip_suda, 1, 30));
                                if not IPsifraInsert.FindFirst() then begin
                                    IPsifraInsert.Init();
                                    IPsifraInsert.Code := TerritoryCode;
                                    TerritoryCode := IncStr(TerritoryCode);
                                    if Evaluate(DatumIPDate, datum_ip) then
                                        IPsifraInsert.Date := DatumIPDate;
                                    IPsifraInsert.IP := IP_sifra;
                                    IPsifraInsert.Accusation := sifra_tuzbe;
                                    IPsifraInsert.Customer := br_kupca;
                                    IPsifraInsert.Type := 6;

                                    IPsifraInsert.Insert();
                                    Commit();


                                end;

                                "Accusation Header".IP := IPsifraInsert.Code;


                            end;*/
                        if IP_sifra <> '' then begin
                            IPsifraInsert.Reset();
                            IPsifraInsert.SetRange(Accusation, sifra_tuzbe);
                            IPsifraInsert.SetRange(Type, 6); // Tip 6 = IP_sud

                            if IPsifraInsert.FindFirst() then begin
                                // Ažuriraj postojeći zapis za IP_sud
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.IP := IP_sifra;
                                IPsifraInsert.Customer := br_kupca;
                                IPsifraInsert.Modify();
                            end else begin
                                // Unesi novi zapis za IP_sud
                                IPsifraInsert.Init();
                                IPsifraInsert.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.IP := IP_sifra;
                                IPsifraInsert.Accusation := sifra_tuzbe;
                                IPsifraInsert.Customer := br_kupca;
                                IPsifraInsert.Type := 6; // IP_sud

                                IPsifraInsert.Insert();
                                Commit();
                            end;

                            "Accusation Header".IP := IPsifraInsert.Code;
                            "Accusation Header"."Current IP" := IPsifraInsert.IP;
                        end;


                        /*    if sud <> '' then begin
                                CourtCode.Reset();
                                CourtCode.SetFilter(Code, '%1', sifra_tuzbe);
                                if not CourtCode.FindFirst() then begin
                                    CourtCode.Init();
                                    CourtCode.Code := TerritoryCode;
                                    TerritoryCode := IncStr(TerritoryCode);
                                    CourtCode.Type := 1;
                                    CourtCode.MALS := sud;
                                    CourtCode.Accusation := sifra_tuzbe;
                                    CourtCode.Customer := br_kupca;

                                    CourtCode.Insert();
                                    Commit();



                                end;

                                "Accusation Header"."Court number" := CourtCode.Code;
                                "Accusation Header"."Actual Court Number" := CourtCode.MALS;

                            end;*/
                        if sud <> '' then begin
                            CourtCode.Reset();
                            CourtCode.SetRange(Accusation, sifra_tuzbe);
                            CourtCode.SetRange(Type, 1); // Tip 1 = Sud

                            if CourtCode.FindFirst() then begin
                                // Ažuriraj postojeći zapis za sud
                                CourtCode.MALS := sud;
                                CourtCode.Customer := br_kupca;
                                CourtCode.Modify();
                            end else begin
                                // Unesi novi zapis za sud
                                CourtCode.Init();
                                CourtCode.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                CourtCode.Type := 1; // Sud
                                CourtCode.MALS := sud;
                                CourtCode.Accusation := sifra_tuzbe;
                                CourtCode.Customer := br_kupca;

                                CourtCode.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Court number" := CourtCode.Code;
                            "Accusation Header"."Actual Court Number" := CourtCode.MALS;
                        end;






                        "Accusation Header".Insert();





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



    trigger OnInitXmlPort()
    begin
        MissingCustomer := '';
        NoSeriesLine.Reset()
        ;
        BrojacInt := IncStr(BrojacInt);
        NoSeriesLine.SetFilter("Series Code", '%1', 'RED');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := TerritoryCode;

        end;

    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'RED');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := TerritoryCode;

            NoSeriesLine.Modify();
        end;

    end;

    trigger OnPreXmlPort()
    var
        myInt: Integer;
    begin

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'RED');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            if NoSeriesLine."Last No. Used" <> '' then begin
                TerritoryCode := IncStr(NoSeriesLine."Last No. Used");

            end
            else begin
                TerritoryCode := NoSeriesLine."Starting No.";

            end;
        end;


    end;

    var
        MissingCustomer: Text;
        DatumDokumentaDate: Date;
        BrojacInt: code[20];
        IDGlavne: code[20];
        DugPocetniDecimal: Decimal;
        KamataDecimal: Decimal;
        KamataPlacenoDecimal: Decimal;
        SudskaTaksaDecimal: Decimal;
        SudskaTaksaPlacenoDecimal: Decimal;
        IPSifra: Code[20];
        CourtCode: Record Territory;
        IPsifraInsert: Record Territory;
        TerritoryCode: code[20];
        DatumIPDate: Date;
        AccusationStatus: Record Territory;
        DatumIzmjeneDate: Date;
        DatumStatus: Date;
        AccLine: Record "Accusation Line";
        NoSeriesLine: Record "No. Series Line";


}
