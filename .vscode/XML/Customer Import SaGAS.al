xmlport 50016 "Customer Import SaGAS"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Customer Import SaGAS';

    schema
    {
        textelement(Root)
        {
            tableelement(Customer; "Customer")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Customer';
                UseTemporary = false;
                textelement(sifra)
                {
                    MinOccurs = Zero;
                }
                textelement(naziv_kupca)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_grad)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_opstinaID)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_mzid)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_ulicaid)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_broj_brojcano)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_broj_slovima)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_hod)
                {
                    MinOccurs = Zero;
                }
                textelement(sjediste_niz)
                {
                    MinOccurs = Zero;
                }
                textelement(odgovorno_lice)
                {
                    MinOccurs = Zero;
                }
                textelement(fax)
                {
                    MinOccurs = Zero;
                }

                textelement(telefon)
                {
                    MinOccurs = Zero;
                }
                textelement(email)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_email)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_email_datum)
                {
                    MinOccurs = Zero;
                }
                textelement(djelatnost_glavna)
                {
                    MinOccurs = Zero;
                }
                textelement(banka1)
                {
                    MinOccurs = Zero;
                }
                textelement(banka2)
                {
                    MinOccurs = Zero;
                }
                textelement(sporazum)
                {
                    MinOccurs = Zero;
                }
                textelement(licna_karta)
                {
                    MinOccurs = Zero;
                }
                textelement(kupac_aktivan)
                {
                    MinOccurs = Zero;
                }
                textelement(id_poreski)
                {
                    MinOccurs = Zero;
                }
                textelement(PDV_broj)
                {
                    MinOccurs = Zero;
                }
                textelement(djelatnostID)
                {
                    MinOccurs = Zero;
                }
                textelement(napomena2)
                {
                    MinOccurs = Zero;
                }
                textelement(subvencija)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_grad)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_ulicaID)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_broj_brojcano)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_broj_slovima)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_sprat)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_stan)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_HOD)
                {
                    MinOccurs = Zero;
                }
                textelement(dostava_niz)
                {
                    MinOccurs = Zero;
                }
                textelement(kategorija)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_broj_ugovora)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_datum_ugovora)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_broj_izjave_za_porez)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_placa_li_avanso)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_kolicina_za_avansno)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_postotak_za_avansno)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_avansno_ide_li_P1)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_avansno_ide_li_P2)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_word_dokument)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_br_opstine)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_poreski_broj)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_iskljucen)
                {
                    MinOccurs = Zero;
                }
                textelement(gl_vlasnik_uključen)
                {
                    MinOccurs = Zero;
                }
                textelement(glavni_vlasnik_ipa_fond)
                {
                    MinOccurs = Zero;
                }
                textelement(licna_karta_prenos_polje)
                {
                    MinOccurs = Zero;
                }
                textelement(kupac_umro)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                var
                    MMActivitiy: Record "MM Activity";
                    Municipality: Record Municipality;
                    MZCustomer: Record MZ;
                    Street: Record Street;
                    Stroke: Record Stroke;
                    CustomerString: Record Stroke;
                    ActivityCode: Record "MM Activity";

                begin



                    Customer.Reset();
                    Customer.SetFilter("No.", '%1', sifra);
                    if Customer.FindFirst() then begin

                        if naziv_kupca <> '' then begin
                            naziv_kupca := ReplaceString(naziv_kupca, 'ĐĐĐ', '');
                            if StrLen(naziv_kupca) > 100 then begin
                                Customer.Validate(Name, CopyStr(naziv_kupca, 1, 100));
                            end
                            else begin
                                Customer.Validate(Name, naziv_kupca);
                            end;
                        end;

                        if sjediste_grad <> '' then begin
                            sjediste_grad := ReplaceString(sjediste_grad, 'ĐĐĐ', '');
                            Customer.Validate("City", sjediste_grad);
                        end;


                        if sjediste_ulicaid <> '' then begin
                            sjediste_ulicaid := ReplaceString(sjediste_ulicaid, 'ĐĐĐ', '');

                            Street.Reset();
                            Street.SetRange(Code, sjediste_ulicaid);
                            if Street.FindFirst() then begin
                                Customer.Validate("Street Customer", sjediste_ulicaid)
                            end else begin
                                if MissingStreetID = '' then
                                    MissingStreetID := sjediste_ulicaid
                                else
                                    MissingStreetID += ', ' + sjediste_ulicaid;
                            end;
                        end;
                        if sjediste_broj_brojcano <> '' then begin
                            sjediste_broj_brojcano := ReplaceString(sjediste_broj_brojcano, 'ĐĐĐ', '');
                            Customer.Validate("Street No.", sjediste_broj_brojcano);
                        end;

                        if sjediste_broj_slovima <> '' then begin
                            sjediste_broj_slovima := ReplaceString(sjediste_broj_slovima, 'ĐĐĐ', '');
                            Customer.Validate("Street No. Text", sjediste_broj_slovima);
                        end;

                        /*  if sjediste_hod <> '' then begin
                              if Evaluate(Stroke1, sjediste_hod) then
                                  Customer."Customer Stroke" := Stroke1
                          end
                          else begin
                              if MissingStrokeID = '' then
                                  MissingStrokeID := sjediste_hod
                              else
                                  MissingStrokeID += ', ' + sjediste_hod;
                          end;*/

                        /*   if sjediste_niz <> '' then begin
                               if Evaluate(CustomerStringNiz, sjediste_niz) then
                                   Customer."Customer String" := CustomerStringNiz
                           end
                           else begin
                               if MissingCustomerString = '' then
                                   MissingCustomerString := sjediste_niz
                               else
                                   MissingCustomerString += ', ' + sjediste_niz;

                           end;*/
                        //
                        //                    if odgovorno_lice <> '' then
                        //         

                        //      Customer.Validate("Responsible Person", odgovorno_lice);

                        ContactPostoji := false;

                        if odgovorno_lice <> '' then begin
                            odgovorno_lice := ReplaceString(odgovorno_lice, 'ĐĐĐ', '');
                            ContactBus.Reset();
                            ContactBus.SetFilter("Business Relation Code", '%1', 'KUP');
                            ContactBus.SetFilter("Link to Table", '%1', ContactBus."Link to Table"::Customer);
                            ContactBus.setfilter("No.", '%1', sifra);

                            if ContactBus.FindSet() then
                                repeat

                                    ContactF.Reset();
                                    ContactF.SetFilter("Type Relation", '%1', ContactF."Type Relation"::Customer);
                                    ContactF.SetFilter("No.", '%1', ContactBus."Contact No.");
                                    if ContactF.FindFirst() then begin
                                        if (ContactF.Name = naziv_kupca) and (ContactF."Phone - Transfer" = telefon) then begin
                                            // Customer."Primary Contact No." := ContactF."No.";
                                            // Customer."Primary Contact No.2" := ContactF."No.";
                                            Customer."Primary Contact No." := ContactF."No.";
                                            Customer."Primary Contact No.2" := ContactF."No.";
                                            Customer.Contact := Customer.name;

                                            ContactPostoji := true;
                                        end;


                                    end;


                                until ContactBus.Next() = 0;


                            if ContactPostoji = false then begin

                                //kopirala pocetak

                                ContactF.Init();
                                ContactF."No." := ContactCode;
                                ContactCode := IncStr(ContactCode);
                                ContactF.Name := CopyStr(naziv_kupca, 1, 100);
                                ContactF."Company No." := ContactF."No.";
                                ContactF.Validate("Type Relation", ContactF."Type Relation"::Customer);

                                ContactBus.Init();
                                ContactBus."Business Relation Code" := 'KUP';
                                ContactBus."Contact No." := ContactF."No.";
                                ContactBus."Link to Table" := 1;
                                ContactBus."No." := sifra;
                                ContactBus.Insert();


                                ContactF."Phone - Transfer" := telefon;
                                ContactF."Fax - Transfer" := fax;

                                if Kategorija = '1' then
                                    Customer."Customer Category" := Customer."Customer Category"::"Large Economy";
                                if Kategorija = '2' then
                                    Customer."Customer Category" := Customer."Customer Category"::"Small Economy";
                                if Kategorija = '3' then
                                    Customer."Customer Category" := Customer."Customer Category"::Household;


                                if Customer."Customer Category" = Customer."Customer Category"::Household then
                                    ContactF.Validate(Type, ContactF.type::Person) else
                                    ContactF.Validate(Type, ContactF.Type::Company);



                                ContactF.Insert();
                                Commit();

                                Customer."Primary Contact No." := ContactF."No.";
                                Customer."Primary Contact No.2" := ContactF."No.";
                                Customer.Contact := Customer.name;

                                //kopirala kraj

                            end;
                        end;

                        if fax <> '' then begin
                            fax := ReplaceString(fax, 'ĐĐĐ', '');
                            Customer.Validate("Fax - Transfer", fax);
                        end;
                        if telefon <> '' then begin
                            telefon := ReplaceString(telefon, 'ĐĐĐ', ';');
                            telefon := ReplaceString(telefon, 'EEE', '');
                            Customer.Validate("Phone - Transfer", telefon);
                        end;
                        if email <> '' then begin
                            email := ReplaceString(email, 'ĐĐĐ', '');
                            email := ReplaceString(email, 'EEE', ';');
                            Customer."E-Mail" := email;
                        end;
                        if dostava_email <> '' then begin
                            dostava_email := ReplaceString(dostava_email, 'ĐĐĐ', '');
                            dostava_email := ReplaceString(dostava_email, 'EEE', ';');
                            Customer."E-Mail 2" := dostava_email;
                        end;
                        if dostava_email_datum <> '' then begin

                            if dostava_email_datum = 'ĐĐĐ' THEN begin
                                Customer.validate("E-mail Delivery Date", 0D);
                                Customer."E-mail Delivery" := Customer."E-mail Delivery"::No;

                            end;
                            dostava_email_datum := ReplaceString(dostava_email_datum, 'ĐĐĐ', '');
                            if Evaluate(EmailDeliveryDate, dostava_email_datum) then begin
                                Customer."E-mail Delivery Date" := EmailDeliveryDate;
                                if Customer."E-mail Delivery Date" <= today then
                                    Customer."E-mail Delivery" := Customer."E-mail Delivery"::Yes;
                            end;
                        end;


                        if banka1 <> '' then begin
                            banka1 := ReplaceString(banka1, 'ĐĐĐ', '');
                            CustomerBankAccount.Reset();
                            CustomerBankAccount.SetFilter("Customer No.", '%1', sifra);
                            CustomerBankAccount.SetFilter("Bank Account No.", '%1', banka1);
                            if not CustomerBankAccount.FindFirst() then begin
                                CustomerBankAccount.Init();
                                CustomerBankAccount.Code := banka1;
                                CustomerBankAccount."Customer No." := sifra;
                                CustomerBankAccount.Name := banka2;
                                CustomerBankAccount."Bank Account No." := banka1;
                                CustomerBankAccount.Insert();
                                Commit();
                            end;
                            Customer."Preferred Bank Account Code" := banka1;


                        end;

                        if (sporazum <> '') then begin
                            sporazum := ReplaceString(sporazum, 'ĐĐĐ', '');
                            customer.validate(Agreement, sporazum);
                        end;

                        if licna_karta <> '' then begin
                            licna_karta := ReplaceString(licna_karta, 'ĐĐĐ', ';');
                            LicnaInsert.Reset();
                            LicnaInsert.SetFilter("Customer No.", '%1', sifra);
                            LicnaInsert.setfilter(Code, '%1', CopyStr(licna_karta, 1, 30));
                            if not LicnaInsert.FindFirst() then begin
                                LicnaInsert.Init();
                                LicnaInsert.Validate("Customer No.", sifra);
                                LicnaInsert.Validate(Code, CopyStr(licna_karta, 1, 30));
                                LicnaInsert.Validate("Identity card issuer", CopyStr(licna_karta, 1, 250));
                                LicnaInsert.Active := true;

                                LicnaInsert.Insert();

                                LicnaModify.Reset();
                                LicnaModify.SetFilter("Customer No.", '%1', sifra);
                                LicnaModify.SetFilter(Code, '<>%1', CopyStr(licna_karta, 1, 30));
                                if LicnaModify.FindSet() then
                                    repeat
                                        LicnaModify.Validate(Active, false);
                                        LicnaModify.Modify();
                                    until LicnaModify.Next() = 0;

                            end;

                        end;




                        if licna_karta_prenos_polje <> '' then begin
                            licna_karta_prenos_polje := ReplaceString(licna_karta_prenos_polje, 'ĐĐĐ', ';');
                            LicnaInsert.Reset();
                            LicnaInsert.SetFilter("Customer No.", '%1', sifra);
                            LicnaInsert.setfilter(Code, '%1', CopyStr(licna_karta_prenos_polje, 1, 30));
                            if not LicnaInsert.FindFirst() then begin
                                LicnaInsert.Init();
                                LicnaInsert.Validate("Customer No.", sifra);
                                LicnaInsert.Validate(Code, CopyStr(licna_karta_prenos_polje, 1, 30));
                                LicnaInsert.Validate("Identity card issuer", CopyStr(licna_karta_prenos_polje, 1, 250));
                                LicnaInsert.Active := true;
                                LicnaInsert.Insert();

                                LicnaModify.Reset();
                                LicnaModify.SetFilter("Customer No.", '%1', sifra);
                                LicnaModify.SetFilter(Code, '<>%1', CopyStr(licna_karta_prenos_polje, 1, 30));
                                if LicnaModify.FindSet() then
                                    repeat
                                        LicnaModify.Validate(Active, false);
                                        LicnaModify.Modify();
                                    until LicnaModify.Next() = 0;

                            end;

                        end;

                        if kupac_aktivan <> '' then begin
                            kupac_aktivan := ReplaceString(kupac_aktivan, 'ĐĐĐ', ';');
                            CHistory2.Reset();
                            CHistory2.SetFilter("Customer No.", '%1', sifra);
                            if kupac_aktivan = 'AKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Active);

                            if kupac_aktivan = 'NEAKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Terminated);

                            if kupac_aktivan = 'TRAJNO NEAKTIVAN' then
                                CHistory2.SetFilter("Information of processing", '%1', CHistory2."Information of processing"::"Permanently inactive");
                            CHistory2.SetFilter(Active, '%1', true);
                            if not CHistory2.FindFirst() then begin
                                CHistory.Init();
                                CHistory.Validate("Customer No.", sifra);
                                CHistory.Validate("Customer Name", Customer.Name);
                                if kupac_aktivan = 'AKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Active;
                                if kupac_aktivan = 'NEAKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Terminated;

                                if kupac_aktivan = 'TRAJNO NEAKTIVAN' then
                                    CHistory.SetFilter("Information of processing", '%1', CHistory."Information of processing"::"Permanently inactive");

                                CHistory."Request Type" := 7;
                                CHistory."Source Table" := 18;
                                CHistory.Validate(Active, true);

                                CHistory.Insert();
                                Commit();

                                CHistory3.Reset();
                                CHistory3.SetFilter("Customer No.", '%1', sifra);
                                CHistory3.SetFilter(Integer, '<>%1', CHistory.Integer);
                                if CHistory3.FindSet() then
                                    repeat
                                        CHistory3.Active := false;
                                        CHistory3.Modify();
                                    until CHistory3.Next() = 0;

                            end;

                        end;

                        if PDV_broj <> '' then begin
                            PDV_broj := ReplaceString(PDV_broj, 'ĐĐĐ', ';');
                            Customer."VAT Registration No." := PDV_broj;
                        end;
                        if id_poreski <> '' then begin
                            id_poreski := ReplaceString(id_poreski, 'ĐĐĐ', '');
                            Customer."Registration No." := id_poreski;
                        end;
                        if djelatnostID = '-1' then
                            Customer.Validate("Activity ID", '');

                        if napomena2 <> '' then begin
                            napomena2 := ReplaceString(napomena2, 'ĐĐĐ', '');
                            Customer.Validate("Father Name", napomena2);
                        end;

                        if subvencija = '0' then begin
                            subvencija := ReplaceString(subvencija, 'ĐĐĐ', '');
                            Customer.Validate("Subsidies - YES/NO", Customer."Subsidies - YES/NO"::No);
                        end;

                        if subvencija = '-1' then begin
                            subvencija := ReplaceString(subvencija, 'ĐĐĐ', '');
                            Customer.Validate("Subsidies - YES/NO", Customer."Subsidies - YES/NO"::" ");
                        end;

                        if dostava_ulicaID <> '' then begin
                            dostava_ulicaID := ReplaceString(dostava_ulicaID, 'ĐĐĐ', '');
                            Customer.Validate("Street Customer 2", dostava_ulicaID); //šifra kupca sjedište
                        end;
                        if dostava_broj_brojcano <> '' then begin
                            dostava_broj_brojcano := ReplaceString(dostava_broj_brojcano, 'ĐĐĐ', '');
                            Customer.Validate("Street No. 2", dostava_broj_brojcano);//Broj ulice - ulica ID
                        end;
                        if dostava_broj_slovima <> '' then begin
                            dostava_broj_slovima := ReplaceString(dostava_broj_slovima, 'ĐĐĐ', ';');
                            Customer.Validate("Street No.2 Text", dostava_broj_slovima); //Broj ulice slovima
                        end;
                        if dostava_sprat <> '' then begin
                            dostava_sprat := ReplaceString(dostava_sprat, 'ĐĐĐ', '');
                            Customer.Validate("Apartment No. Customer 2", dostava_sprat);
                        end;
                        if dostava_stan <> '' then begin
                            dostava_stan := ReplaceString(dostava_stan, 'ĐĐĐ', ';');
                            Customer.Validate("Floor Customer 2", dostava_stan);
                        end;
                        if Kategorija = '1' then
                            Customer."Customer Category" := Customer."Customer Category"::"Large Economy";
                        if Kategorija = '2' then
                            Customer."Customer Category" := Customer."Customer Category"::"Small Economy";
                        if Kategorija = '3' then
                            Customer."Customer Category" := Customer."Customer Category"::Household;

                        if (gl_vlasnik_broj_ugovora <> '') or (gl_vlasnik_datum_ugovora <> '') then begin

                            gl_vlasnik_broj_ugovora := ReplaceString(gl_vlasnik_broj_ugovora, 'ĐĐĐ', '');
                            gl_vlasnik_datum_ugovora := ReplaceString(gl_vlasnik_datum_ugovora, 'ĐĐĐ', '');

                            CustomerLedgerEntryR.Reset();
                            CustomerLedgerEntryR.SetFilter("Customer No.", '%1', sifra);
                            CustomerLedgerEntryR.SetFilter(Description, '%1', gl_vlasnik_broj_ugovora);
                            if not CustomerLedgerEntryR.FindFirst() then begin
                                CustomerLedgerEntryR.init;
                                CustomerLedgerEntryR.Code := format(BrojacInt);
                                BrojacInt := IncStr(BrojacInt);
                                CustomerLedgerEntryR.Validate("Customer No.", sifra);
                                if Evaluate(DatumVazenjagoovraDate, gl_vlasnik_datum_ugovora) then
                                    CustomerLedgerEntryR.Validate("Starting Date", DatumVazenjagoovraDate);
                                CustomerLedgerEntryR.Validate(Description, gl_vlasnik_broj_ugovora);
                                if CustomerLedgerEntryR."Starting Date" <= Today then begin

                                    CustomerLedgerEntryR.Validate(Active, true);
                                end;
                                CustomerLedgerEntryR."Customer Name" := Customer.Name;
                                CustomerLedgerEntryR.Insert();
                                Commit();

                                CustomerLedgerEntryR2.Reset();
                                CustomerLedgerEntryR2.SetFilter(Code, '<>%1', CustomerLedgerEntryR.Code);
                                CustomerLedgerEntryR2.SetFilter("Customer No.", '%1', sifra);
                                CustomerLedgerEntryR2.SetCurrentKey("Starting Date");
                                CustomerLedgerEntryR2.Ascending;
                                if CustomerLedgerEntryR2.FindLast() then begin
                                    CustomerLedgerEntryR2.Validate(Active, false);
                                    if CustomerLedgerEntryR."Starting Date" <> 0D then
                                        CustomerLedgerEntryR2.Validate("Ending Date", calcdate('<-1D>', CustomerLedgerEntryR."Starting Date"));
                                    CustomerLedgerEntryR2.Modify();


                                end;
                            end;
                            // Customer.Validate(PDV_NUMBER,PDVbroj);
                        end;




                        if djelatnost_glavna <> '' then begin
                            djelatnost_glavna := ReplaceString(djelatnost_glavna, 'ĐĐĐ', '');

                            ActivityCode.Reset();
                            ActivityCode.SetRange(Code, djelatnost_glavna);
                            if ActivityCode.FindFirst() then begin
                                Customer.Validate("Activity Code", ActivityCode.Description)
                            end else begin

                                if MissingActivity = '' then
                                    MissingActivity := djelatnost_glavna
                                else
                                    MissingActivity += ', ' + djelatnost_glavna;

                            end;
                        end;
                        Customer.Modify();


                    end else begin


                        if MissingCustomerIDs = '' then
                            MissingCustomerIDs := sifra
                        else
                            MissingCustomerIDs += ', ' + sifra;


                        Customer.init;

                        if naziv_kupca <> '' then begin
                            naziv_kupca := ReplaceString(naziv_kupca, 'ĐĐĐ', '');
                            if StrLen(naziv_kupca) > 100 then begin
                                Customer.Validate(Name, CopyStr(naziv_kupca, 1, 100));
                            end
                            else begin
                                Customer.Validate(Name, naziv_kupca);
                            end;
                        end;

                        if sjediste_grad <> '' then begin
                            sjediste_grad := ReplaceString(sjediste_grad, 'ĐĐĐ', '');
                            Customer.Validate("City", sjediste_grad);
                        end;


                        if sjediste_ulicaid <> '' then begin
                            sjediste_ulicaid := ReplaceString(sjediste_ulicaid, 'ĐĐĐ', '');

                            Street.Reset();
                            Street.SetRange(Code, sjediste_ulicaid);
                            if Street.FindFirst() then begin
                                Customer.Validate("Street Customer", sjediste_ulicaid)
                            end else begin
                                if MissingStreetID = '' then
                                    MissingStreetID := sjediste_ulicaid
                                else
                                    MissingStreetID += ', ' + sjediste_ulicaid;
                            end;
                        end;
                        if sjediste_broj_brojcano <> '' then begin
                            sjediste_broj_brojcano := ReplaceString(sjediste_broj_brojcano, 'ĐĐĐ', '');
                            Customer.Validate("Street No.", sjediste_broj_brojcano);
                        end;

                        if sjediste_broj_slovima <> '' then begin
                            sjediste_broj_slovima := ReplaceString(sjediste_broj_slovima, 'ĐĐĐ', '');
                            Customer.Validate("Street No. Text", sjediste_broj_slovima);
                        end;

                        /*  if sjediste_hod <> '' then begin
                              if Evaluate(Stroke1, sjediste_hod) then
                                  Customer."Customer Stroke" := Stroke1
                          end
                          else begin
                              if MissingStrokeID = '' then
                                  MissingStrokeID := sjediste_hod
                              else
                                  MissingStrokeID += ', ' + sjediste_hod;
                          end;*/

                        /*   if sjediste_niz <> '' then begin
                               if Evaluate(CustomerStringNiz, sjediste_niz) then
                                   Customer."Customer String" := CustomerStringNiz
                           end
                           else begin
                               if MissingCustomerString = '' then
                                   MissingCustomerString := sjediste_niz
                               else
                                   MissingCustomerString += ', ' + sjediste_niz;

                           end;*/
                        //
                        //                    if odgovorno_lice <> '' then
                        //         

                        //      Customer.Validate("Responsible Person", odgovorno_lice);

                        ContactPostoji := false;

                        if odgovorno_lice <> '' then begin
                            odgovorno_lice := ReplaceString(odgovorno_lice, 'ĐĐĐ', '');
                            ContactBus.Reset();
                            ContactBus.SetFilter("Business Relation Code", '%1', 'KUP');
                            ContactBus.SetFilter("Link to Table", '%1', ContactBus."Link to Table"::Customer);
                            ContactBus.setfilter("No.", '%1', sifra);

                            if ContactBus.FindSet() then
                                repeat

                                    ContactF.Reset();
                                    ContactF.SetFilter("Type Relation", '%1', ContactF."Type Relation"::Customer);
                                    ContactF.SetFilter("No.", '%1', ContactBus."Contact No.");
                                    if ContactF.FindFirst() then begin
                                        if (ContactF.Name = naziv_kupca) and (ContactF."Phone - Transfer" = telefon) then begin
                                            //   Customer.Validate("Primary Contact No.", ContactF."No.");
                                            // Customer.Validate("Primary Contact No.2", ContactF."No.");
                                            Customer."Primary Contact No." := ContactF."No.";
                                            Customer."Primary Contact No.2" := ContactF."No.";
                                            Customer.Contact := Customer.name;

                                            ContactPostoji := true;
                                        end;


                                    end;


                                until ContactBus.Next() = 0;


                            if ContactPostoji = false then begin

                                //kopirala pocetak

                                ContactF.Init();
                                ContactF."No." := ContactCode;
                                ContactCode := IncStr(ContactCode);
                                ContactF.Name := CopyStr(naziv_kupca, 1, 100);
                                ContactF."Company No." := ContactF."No.";
                                ContactF.Validate("Type Relation", ContactF."Type Relation"::Customer);

                                ContactBus.Init();
                                ContactBus."Business Relation Code" := 'KUP';
                                ContactBus."Contact No." := ContactF."No.";
                                ContactBus."Link to Table" := 1;
                                ContactBus."No." := sifra;
                                ContactBus.Insert();


                                ContactF."Phone - Transfer" := telefon;
                                ContactF."Fax - Transfer" := fax;

                                if Kategorija = '1' then
                                    Customer."Customer Category" := Customer."Customer Category"::"Large Economy";
                                if Kategorija = '2' then
                                    Customer."Customer Category" := Customer."Customer Category"::"Small Economy";
                                if Kategorija = '3' then
                                    Customer."Customer Category" := Customer."Customer Category"::Household;


                                if Customer."Customer Category" = Customer."Customer Category"::Household then
                                    ContactF.Validate(Type, ContactF.type::Person) else
                                    ContactF.Validate(Type, ContactF.Type::Company);



                                ContactF.Insert();
                                Commit();

                                Customer."Primary Contact No." := ContactF."No.";
                                Customer."Primary Contact No.2" := ContactF."No.";
                                Customer.Contact := Customer.name;

                                //kopirala kraj

                            end;
                        end;

                        if fax <> '' then begin
                            fax := ReplaceString(fax, 'ĐĐĐ', '');
                            Customer.Validate("Fax - Transfer", fax);
                        end;
                        if telefon <> '' then begin
                            telefon := ReplaceString(telefon, 'ĐĐĐ', ';');
                            telefon := ReplaceString(telefon, 'EEE', '');
                            Customer.Validate("Phone - Transfer", telefon);
                        end;
                        if email <> '' then begin
                            email := ReplaceString(email, 'ĐĐĐ', '');
                            email := ReplaceString(email, 'EEE', ';');
                            Customer."E-Mail" := email;
                        end;
                        if dostava_email <> '' then begin
                            dostava_email := ReplaceString(dostava_email, 'ĐĐĐ', '');
                            dostava_email := ReplaceString(dostava_email, 'EEE', ';');
                            Customer."E-Mail 2" := dostava_email;
                        end;
                        if dostava_email_datum <> '' then begin
                            if dostava_email_datum = 'ĐĐĐ' THEN begin
                                Customer.validate("E-mail Delivery Date", 0D);
                                Customer."E-mail Delivery" := Customer."E-mail Delivery"::No;

                            end;
                            dostava_email_datum := ReplaceString(dostava_email_datum, 'ĐĐĐ', '');
                            if Evaluate(EmailDeliveryDate, dostava_email_datum) then begin
                                Customer."E-mail Delivery Date" := EmailDeliveryDate;
                                if Customer."E-mail Delivery Date" <= today then
                                    Customer."E-mail Delivery" := Customer."E-mail Delivery"::Yes;
                            end;
                        end;


                        if banka1 <> '' then begin
                            banka1 := ReplaceString(banka1, 'ĐĐĐ', '');
                            CustomerBankAccount.Reset();
                            CustomerBankAccount.SetFilter("Customer No.", '%1', sifra);
                            CustomerBankAccount.SetFilter("Bank Account No.", '%1', banka1);
                            if not CustomerBankAccount.FindFirst() then begin
                                CustomerBankAccount.Init();
                                CustomerBankAccount.Code := banka1;
                                CustomerBankAccount.Name := banka2;
                                CustomerBankAccount."Bank Account No." := banka1;
                                CustomerBankAccount."Customer No." := sifra;
                                CustomerBankAccount.Insert();
                                Commit();
                            end;
                            Customer."Preferred Bank Account Code" := banka1;


                        end;

                        if (sporazum <> '') then begin
                            sporazum := ReplaceString(sporazum, 'ĐĐĐ', '');
                            customer.validate(Agreement, sporazum);
                        end;

                        if licna_karta <> '' then begin
                            licna_karta := ReplaceString(licna_karta, 'ĐĐĐ', ';');
                            LicnaInsert.Reset();
                            LicnaInsert.SetFilter("Customer No.", '%1', sifra);
                            LicnaInsert.setfilter(Code, '%1', CopyStr(licna_karta, 1, 30));
                            if not LicnaInsert.FindFirst() then begin
                                LicnaInsert.Init();
                                LicnaInsert.Validate("Customer No.", sifra);
                                LicnaInsert.Validate(Code, CopyStr(licna_karta, 1, 30));
                                LicnaInsert.Validate("Identity card issuer", CopyStr(licna_karta, 1, 250));
                                LicnaInsert.Active := true;

                                LicnaInsert.Insert();

                                LicnaModify.Reset();
                                LicnaModify.SetFilter("Customer No.", '%1', sifra);
                                LicnaModify.SetFilter(Code, '<>%1', CopyStr(licna_karta, 1, 30));
                                if LicnaModify.FindSet() then
                                    repeat
                                        LicnaModify.Validate(Active, false);
                                        LicnaModify.Modify();
                                    until LicnaModify.Next() = 0;

                            end;

                        end;




                        if licna_karta_prenos_polje <> '' then begin
                            licna_karta_prenos_polje := ReplaceString(licna_karta_prenos_polje, 'ĐĐĐ', ';');
                            LicnaInsert.Reset();
                            LicnaInsert.SetFilter("Customer No.", '%1', sifra);
                            LicnaInsert.setfilter(Code, '%1', CopyStr(licna_karta_prenos_polje, 1, 30));
                            if not LicnaInsert.FindFirst() then begin
                                LicnaInsert.Init();
                                LicnaInsert.Validate("Customer No.", sifra);
                                LicnaInsert.Validate(Code, CopyStr(licna_karta_prenos_polje, 1, 30));
                                LicnaInsert.Validate("Identity card issuer", CopyStr(licna_karta_prenos_polje, 1, 250));
                                LicnaInsert.Active := true;
                                LicnaInsert.Insert();

                                LicnaModify.Reset();
                                LicnaModify.SetFilter("Customer No.", '%1', sifra);
                                LicnaModify.SetFilter(Code, '<>%1', CopyStr(licna_karta_prenos_polje, 1, 30));
                                if LicnaModify.FindSet() then
                                    repeat
                                        LicnaModify.Validate(Active, false);
                                        LicnaModify.Modify();
                                    until LicnaModify.Next() = 0;

                            end;

                        end;

                        if kupac_aktivan <> '' then begin
                            kupac_aktivan := ReplaceString(kupac_aktivan, 'ĐĐĐ', ';');
                            CHistory2.Reset();
                            CHistory2.SetFilter("Customer No.", '%1', sifra);
                            if kupac_aktivan = 'AKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Active);

                            if kupac_aktivan = 'NEAKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::Terminated);

                            if kupac_aktivan = 'TRAJNO NEAKTIVAN' then
                                CHistory2.setfilter("Information of processing", '%1', CHistory2."Information of processing"::"Permanently inactive");

                            CHistory2.SetFilter(Active, '%1', true);
                            if not CHistory2.FindFirst() then begin
                                CHistory.Init();
                                CHistory.Validate("Customer No.", sifra);
                                CHistory.Validate("Customer Name", Customer.Name);
                                if kupac_aktivan = 'AKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Active;
                                if kupac_aktivan = 'NEAKTIVAN' then
                                    CHistory."Information of processing" := CHistory."Information of processing"::Terminated;

                                if kupac_aktivan = 'TRAJNO NEAKTIVAN' then
                                    CHistory.setfilter("Information of processing", '%1', CHistory."Information of processing"::"Permanently inactive");

                                CHistory."Request Type" := 7;
                                CHistory."Source Table" := 18;
                                CHistory.Validate(Active, true);

                                CHistory.Insert();
                                Commit();

                                CHistory3.Reset();
                                CHistory3.SetFilter("Customer No.", '%1', sifra);
                                CHistory3.SetFilter(Integer, '<>%1', CHistory.Integer);
                                if CHistory3.FindSet() then
                                    repeat
                                        CHistory3.Active := false;
                                        CHistory3.Modify();
                                    until CHistory3.Next() = 0;

                            end;

                        end;

                        if PDV_broj <> '' then begin
                            PDV_broj := ReplaceString(PDV_broj, 'ĐĐĐ', ';');
                            Customer."VAT Registration No." := PDV_broj;
                        end;
                        if id_poreski <> '' then begin
                            id_poreski := ReplaceString(id_poreski, 'ĐĐĐ', '');
                            Customer."Registration No." := id_poreski;
                        end;
                        if djelatnostID = '-1' then
                            Customer.Validate("Activity ID", '');

                        if napomena2 <> '' then begin
                            napomena2 := ReplaceString(napomena2, 'ĐĐĐ', '');
                            Customer.Validate("Father Name", napomena2);
                        end;

                        if subvencija = '0' then begin
                            subvencija := ReplaceString(subvencija, 'ĐĐĐ', '');
                            Customer.Validate("Subsidies - YES/NO", Customer."Subsidies - YES/NO"::No);
                        end;

                        if subvencija = '-1' then begin
                            subvencija := ReplaceString(subvencija, 'ĐĐĐ', '');
                            Customer.Validate("Subsidies - YES/NO", Customer."Subsidies - YES/NO"::" ");
                        end;

                        if dostava_ulicaID <> '' then begin
                            dostava_ulicaID := ReplaceString(dostava_ulicaID, 'ĐĐĐ', '');
                            Customer.Validate("Street Customer 2", dostava_ulicaID); //šifra kupca sjedište
                        end;
                        if dostava_broj_brojcano <> '' then begin
                            dostava_broj_brojcano := ReplaceString(dostava_broj_brojcano, 'ĐĐĐ', '');
                            Customer.Validate("Street No. 2", dostava_broj_brojcano);//Broj ulice - ulica ID
                        end;
                        if dostava_broj_slovima <> '' then begin
                            dostava_broj_slovima := ReplaceString(dostava_broj_slovima, 'ĐĐĐ', ';');
                            Customer.Validate("Street No.2 Text", dostava_broj_slovima); //Broj ulice slovima
                        end;
                        if dostava_sprat <> '' then begin
                            dostava_sprat := ReplaceString(dostava_sprat, 'ĐĐĐ', '');
                            Customer.Validate("Apartment No. Customer 2", dostava_sprat);
                        end;
                        if dostava_stan <> '' then begin
                            dostava_stan := ReplaceString(dostava_stan, 'ĐĐĐ', ';');
                            Customer.Validate("Floor Customer 2", dostava_stan);
                        end;
                        if Kategorija = '1' then
                            Customer."Customer Category" := Customer."Customer Category"::"Large Economy";
                        if Kategorija = '2' then
                            Customer."Customer Category" := Customer."Customer Category"::"Small Economy";
                        if Kategorija = '3' then
                            Customer."Customer Category" := Customer."Customer Category"::Household;

                        if (gl_vlasnik_broj_ugovora <> '') or (gl_vlasnik_datum_ugovora <> '') then begin

                            gl_vlasnik_broj_ugovora := ReplaceString(gl_vlasnik_broj_ugovora, 'ĐĐĐ', '');
                            gl_vlasnik_datum_ugovora := ReplaceString(gl_vlasnik_datum_ugovora, 'ĐĐĐ', '');

                            CustomerLedgerEntryR.Reset();
                            CustomerLedgerEntryR.SetFilter("Customer No.", '%1', sifra);
                            CustomerLedgerEntryR.SetFilter(Description, '%1', gl_vlasnik_broj_ugovora);
                            if not CustomerLedgerEntryR.FindFirst() then begin
                                CustomerLedgerEntryR.init;
                                CustomerLedgerEntryR.Code := format(BrojacInt);
                                BrojacInt := IncStr(BrojacInt);
                                CustomerLedgerEntryR.Validate("Customer No.", sifra);
                                if Evaluate(DatumVazenjagoovraDate, gl_vlasnik_datum_ugovora) then
                                    CustomerLedgerEntryR.Validate("Starting Date", DatumVazenjagoovraDate);
                                CustomerLedgerEntryR.Validate(Description, gl_vlasnik_broj_ugovora);
                                if CustomerLedgerEntryR."Starting Date" <= Today then begin

                                    CustomerLedgerEntryR.Validate(Active, true);
                                end;
                                CustomerLedgerEntryR."Customer Name" := Customer.Name;
                                CustomerLedgerEntryR.Insert();
                                Commit();

                                CustomerLedgerEntryR2.Reset();
                                CustomerLedgerEntryR2.SetFilter(Code, '<>%1', CustomerLedgerEntryR.Code);
                                CustomerLedgerEntryR2.SetFilter("Customer No.", '%1', sifra);
                                CustomerLedgerEntryR2.SetCurrentKey("Starting Date");
                                CustomerLedgerEntryR2.Ascending;
                                if CustomerLedgerEntryR2.FindLast() then begin
                                    CustomerLedgerEntryR2.Validate(Active, false);
                                    if CustomerLedgerEntryR."Starting Date" <> 0D then
                                        CustomerLedgerEntryR2.Validate("Ending Date", calcdate('<-1D>', CustomerLedgerEntryR."Starting Date"));
                                    CustomerLedgerEntryR2.Modify();


                                end;
                            end;
                            // Customer.Validate(PDV_NUMBER,PDVbroj);
                        end;




                        if djelatnost_glavna <> '' then begin
                            djelatnost_glavna := ReplaceString(djelatnost_glavna, 'ĐĐĐ', '');

                            ActivityCode.Reset();
                            ActivityCode.SetRange(Code, djelatnost_glavna);
                            if ActivityCode.FindFirst() then begin
                                Customer.Validate("Activity Code", djelatnost_glavna)
                            end else begin

                                if MissingActivity = '' then
                                    MissingActivity := djelatnost_glavna
                                else
                                    MissingActivity += ', ' + djelatnost_glavna;

                            end;
                        end;

                        Customer.insert;

                    end;


                end;


            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnInitXmlPort()
    begin
        MissingCustomerIDs := '';
        MissingMunicipalityIDs := '';
        MZCustomerID := '';
        MissingStreetID := '';
        MissingStrokeID := '';

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'STAV-UG');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            BrojacInt := NoSeriesLine."Last No. Used";
        end;
        BrojacInt := IncStr(BrojacInt);

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'KONTAKT');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            ContactCode := NoSeriesLine."Last No. Used";
        end;
        ContactCode := IncStr(ContactCode);



    end;

    procedure ReplaceString(String: Text[250]; FindWhat: Text[250]; ReplaceWith: Text[250]) NewString: Text[250]
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;



    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'STAV-UG');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := BrojacInt;
            NoSeriesLine.Modify();
        end;
        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'KONTAKT');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := ContactCode;
            NoSeriesLine.Modify();
        end;

    end;

    var

        MissingCustomerIDs: Text;
        LicnaInsert: Record "Customer ID";
        LicnaModify: Record "Customer ID";
        MissingMunicipalityIDs: Text;
        NoSeriesLine: Record "No. Series Line";
        MZCustomerID: Text;
        MissingStreetID: Text;
        MissingStrokeID: Text;
        MissingCustomerString: Text;
        MissingActivity: Text;
        CustomerLedgerEntryR: Record "Customer Ledger Entry";
        CustomerLedgerEntryR2: Record "Customer Ledger Entry";
        MissingCustomerStatus: Text;
        CustomerBankAccount: Record "Customer Bank Account";
        CHistory: Record "Status History";

        CHistory2: Record "Status History";
        CHistory3: Record "Status History";
        ContactF: Record Contact;
        ContactI: Record Contact;
        ContactBus: Record "Contact Business Relation";







        Stroke1: Integer;
        CustomerStringNiz: Integer;
        EmailDeliveryDate: Date;
        BrojacInt: code[20];
        CustomerStatus: Option;
        DatumVazenjagoovraDate: Date;
        NoSeries: Record "No. Series";
        ContactPostoji: Boolean;
        ContactCode: code[20];















}
