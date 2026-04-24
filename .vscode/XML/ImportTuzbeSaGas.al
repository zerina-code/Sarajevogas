xmlport 50037 "ImportTuzbeSaGas"
{

    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ImportTuzbeSaGas';
    schema
    {
        textelement(Root)
        {
            tableelement("Accusation Header"; "Accusation Header")

            {

                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'AccusationHeader';
                UseTemporary = false;

                textelement(id)
                {
                    MinOccurs = Zero;
                }
                textelement(sifra_potrosaca)
                {
                    MinOccurs = Zero;
                }
                textelement(ime_prezime)
                {
                    MinOccurs = Zero;
                }
                textelement(adresa)
                {
                    MinOccurs = Zero;
                }
                textelement(ip_suda)
                {
                    MinOccurs = Zero;
                }
                textelement(datum_ip)
                {
                    MinOccurs = Zero;
                }
                textelement(dug_pocetni)
                {
                    MinOccurs = Zero;
                }
                textelement(kamata_pocetna)
                {
                    MinOccurs = Zero;
                }
                textelement(sudska_taksa_pocetna)
                {
                    MinOccurs = Zero;
                }
                textelement(aktivni_status_predmeta)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_dug)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_taksa)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_kamata)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_datum_placanja)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_datum_prijedlog_izvrsenja)
                {
                    MinOccurs = Zero;
                }
                textelement(sud)
                {
                    MinOccurs = Zero;
                }
                textelement(ziro_rn_potrosaca)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_napomena)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_pravosnaznosti)
                {
                    MinOccurs = Zero;
                }

                textelement(glavna_da_li_je_placena_taksa)
                {
                    MinOccurs = Zero;
                }
                textelement(glavna_broj_PS)
                {
                    MinOccurs = Zero;
                }
                textelement(glavna_placeno_duga)
                {
                    MinOccurs = Zero;
                }
                textelement(ostalo)
                {
                    MinOccurs = Zero;
                }
                textelement(glavna_placeno_kamata)
                {
                    MinOccurs = Zero;
                }
                textelement(glavna_placeno_taksa)
                {
                    MinOccurs = Zero;
                }
                textelement(glavna_datum_statusa)
                {
                    MinOccurs = Zero;
                }
                textelement(podaci_o_presudi_iznos_kucanjem)
                {
                    MinOccurs = Zero;
                }
                textelement(dokazi)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                var
                    Kupac: Record "Customer";

                begin


                    "Accusation Header".Reset();
                    "Accusation Header".SetFilter("No.", '%1', id);
                    if "Accusation Header".FindFirst() then begin

                        if sifra_potrosaca <> '' then begin
                            Kupac.Reset();
                            Kupac.SetRange("No.", sifra_potrosaca);
                            if Kupac.FindFirst() then begin
                                "Accusation Header".Validate("Customer No.", sifra_potrosaca);
                            end else begin
                                if MissingCustomer = '' then
                                    MissingCustomer := sifra_potrosaca
                                else
                                    MissingCustomer += ', ' + sifra_potrosaca;

                            end;

                        end;

                        /* polje IP-šifra u BC-u */

                        if ip_suda <> '' then begin
                            IPsifraInsert.Reset();
                            IPsifraInsert.SetFilter(Code, '%1', id);
                            //IPsifraInsert.SetFilter(IP, '%1', CopyStr(ip_suda, 1, 30));
                            if not IPsifraInsert.FindFirst() then begin
                                IPsifraInsert.Init();
                                IPsifraInsert.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.IP := ip_suda;
                                IPsifraInsert.Accusation := id;
                                IPsifraInsert.Customer := sifra_potrosaca;
                                IPsifraInsert.Type := 6;

                                IPsifraInsert.Insert();
                                Commit();

                            end;


                            "Accusation Header".IP := IPsifraInsert.Code;
                        end;
                        /* polje Dug u BC-u */
                        if dug_pocetni <> '' then begin
                            if Evaluate(DugPocetniDecimal, dug_pocetni) then
                                "Accusation Header".Debt := DugPocetniDecimal;

                        end;

                        /*kamata početna - preskočila */

                        /*polje Iznos sudske takse-prenos*/
                        if sudska_taksa_pocetna <> '' then begin
                            if Evaluate(SudskaTaksaDecimal, sudska_taksa_pocetna) then
                                "Accusation Header"."Court Expenses Amt - Transfer" := SudskaTaksaDecimal;
                        end;

                        if aktivni_status_predmeta <> '' then begin
                            AccusationStatus.Reset();
                            AccusationStatus.SetFilter(Code, '%1', id);
                            if not AccusationStatus.FindFirst() then begin
                                AccusationStatus.Init();
                                AccusationStatus.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumStatus, glavna_datum_statusa) then
                                    AccusationStatus.Date := DatumStatus;
                                AccusationStatus.Type := 4;
                                AccusationStatus.Accusation := id;
                                AccusationStatus.Customer := sifra_potrosaca;
                                if aktivni_status_predmeta = '1' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Given to court");
                                if aktivni_status_predmeta = '2' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Answer to the Accusation");
                                if aktivni_status_predmeta = '3' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Setup Trial");
                                if aktivni_status_predmeta = '4' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Main Trial");
                                if aktivni_status_predmeta = '5' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"First Degree Ruling Affirmative");
                                if aktivni_status_predmeta = '6' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"First Degree Ruling Negative");
                                if aktivni_status_predmeta = '7' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Submissions to the Court");
                                if aktivni_status_predmeta = '8' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Submissions of the Court");
                                if aktivni_status_predmeta = '9' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"External Submissions");
                                if aktivni_status_predmeta = '10' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Internal Submissions");
                                if aktivni_status_predmeta = '11' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Appeal");
                                if aktivni_status_predmeta = '12' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Second Degree Ruling");
                                if aktivni_status_predmeta = '13' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Withdrawal");
                                if aktivni_status_predmeta = '14' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"End of Trial");
                                if aktivni_status_predmeta = '15' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Return to the Previous State");
                                if aktivni_status_predmeta = '16' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Write Offs");
                                if aktivni_status_predmeta = '1' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Given to court");
                                if aktivni_status_predmeta = '17' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Revision");
                                if aktivni_status_predmeta = '18' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Allignment by Court");
                                if aktivni_status_predmeta = '19' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Bankruptcy");
                                if aktivni_status_predmeta = '20' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Liquidation");
                                if aktivni_status_predmeta = '21' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Proposal on Execution");
                                if aktivni_status_predmeta = '22' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Court Submissions");
                                if aktivni_status_predmeta = '23' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Submissions of Court");
                                if aktivni_status_predmeta = '24' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"External Submissions - Executive Procedure");
                                if aktivni_status_predmeta = '25' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Decision on Execution");
                                if aktivni_status_predmeta = '26' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Objection");
                                if aktivni_status_predmeta = '27' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"List Assessment Seizure");
                                if aktivni_status_predmeta = '28' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Court Sale");
                                if aktivni_status_predmeta = '29' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Postponal of Execution");
                                if aktivni_status_predmeta = '30' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Continue the Execution");
                                if aktivni_status_predmeta = '31' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Withdrawal of Proposal of Execution");
                                if aktivni_status_predmeta = '32' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Stopping of Accusation");
                                if aktivni_status_predmeta = '33' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Write Off - Executive Procedure");
                                if aktivni_status_predmeta = '34' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Submitted");
                                if aktivni_status_predmeta = '35' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Denied");
                                if aktivni_status_predmeta = '36' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Completed - Guilty");
                                if aktivni_status_predmeta = '37' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Completed - Not Guilty");
                                if aktivni_status_predmeta = '38' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Prepared for lawyers");
                                if aktivni_status_predmeta = '39' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"End Accusation");
                                if aktivni_status_predmeta = '40' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Ready for sending to court");
                                if aktivni_status_predmeta = '41' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Archived");
                                if aktivni_status_predmeta = '42' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Suspended investigation");

                                AccusationStatus.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Accusation Status" := AccusationStatus.Code;
                            "Accusation Header".Status := AccusationStatus.Status;

                        end;
                        /* polje Napomena u BC-u */
                        if podaci_o_presudi_napomena <> '' then begin
                            "Accusation Header".Validate("Note", podaci_o_presudi_napomena);
                        end;
                        if sud <> '' then begin
                            CourtCode.Reset();
                            CourtCode.SetFilter(Code, '%1', id);
                            if not CourtCode.FindFirst() then begin
                                CourtCode.Init();
                                CourtCode.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                CourtCode.Type := 1;
                                CourtCode.MALS := sud;
                                CourtCode.Accusation := id;
                                CourtCode.Customer := sifra_potrosaca;

                                CourtCode.Insert();
                                Commit();



                            end;

                            "Accusation Header"."Court number" := CourtCode.Code;
                            "Accusation Header"."Actual Court Number" := CourtCode.MALS;


                        end;

                        /* polje Plaćeni iznos sudske takse-prenos */
                        if glavna_placeno_taksa <> '' then begin
                            if Evaluate(CourtExpensesDecimal, glavna_placeno_taksa) then
                                "Accusation Header"."Court Expenses Amt Paid - Tr" := CourtExpensesDecimal;


                        end;

                        /* polje Plaćeni dug i sudski trpškovi */

                        /* polje Datum povlačenja tužbe/prijedlog za izvršenje*/
                        if podaci_o_presudi_datum_prijedlog_izvrsenja <> '' then begin
                            if Evaluate(WithdrawalDate, podaci_o_presudi_datum_prijedlog_izvrsenja) then
                                "Accusation Header"."Date of Withdrawal" := WithdrawalDate;

                        end;



                        /* polje Kamata u BC-u */

                        if kamata_pocetna <> '' then begin
                            if Evaluate(InterestDecimal, kamata_pocetna) then
                                "Accusation Header".Interest := InterestDecimal;
                        end;




                        /* polje Datum sudske odluke u BC-u */
                        if podaci_o_presudi_pravosnaznosti <> '' then begin
                            if Evaluate(CourtDecisionDate, podaci_o_presudi_pravosnaznosti) then
                                "Accusation Header"."Date of Court Decision" := CourtDecisionDate;
                        end;

                        /* polje Datum uplate-prenos */
                        if podaci_o_presudi_datum_placanja <> '' then begin
                            if Evaluate(DateTransfer, podaci_o_presudi_datum_placanja) then
                                "Accusation Header"."Payment Date" := DateTransfer;
                        end;
                        /* polje Plaćen dug i sudski troškovi u BC-u */
                        if glavna_da_li_je_placena_taksa <> '' then begin
                            if glavna_da_li_je_placena_taksa = '1' then
                                "Accusation Header".Validate("Debt and court expenses paid", true);
                            if glavna_da_li_je_placena_taksa = '0' then
                                "Accusation Header".Validate("Debt and court expenses paid", false);

                        end;


                        /*polje Status tužbe - šifra */
                        "Accusation Header".Modify();



                    end else begin

                        if MissingCustomer = '' then
                            MissingCustomer := sifra_potrosaca
                        else
                            MissingCustomer += ', ' + sifra_potrosaca;


                        "Accusation Header".Init();
                        "Accusation Header"."No." := id;

                        if sifra_potrosaca <> '' then begin
                            Kupac.Reset();
                            Kupac.SetRange("No.", sifra_potrosaca);
                            if Kupac.FindFirst() then begin
                                "Accusation Header".Validate("Customer No.", sifra_potrosaca);
                            end else begin
                                if MissingCustomer = '' then
                                    MissingCustomer := sifra_potrosaca
                                else
                                    MissingCustomer += ', ' + sifra_potrosaca;

                            end;

                        end;

                        /* polje IP-šifra u BC-u */

                        if ip_suda <> '' then begin
                            IPsifraInsert.Reset();
                            IPsifraInsert.SetFilter(Code, '%1', id);
                            //IPsifraInsert.SetFilter(IP, '%1', CopyStr(ip_suda, 1, 30));
                            if not IPsifraInsert.FindFirst() then begin
                                IPsifraInsert.Init();
                                IPsifraInsert.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.IP := ip_suda;
                                IPsifraInsert.Accusation := id;
                                IPsifraInsert.Customer := sifra_potrosaca;
                                IPsifraInsert.Type := 6;

                                IPsifraInsert.Insert();
                                Commit();


                            end;

                            "Accusation Header".IP := IPsifraInsert.Code;


                        end;

                        /* polje Dug u BC-u */
                        if dug_pocetni <> '' then begin
                            if Evaluate(DugPocetniDecimal, dug_pocetni) then
                                "Accusation Header".Debt := DugPocetniDecimal;

                        end;


                        /*kamata početna - preskočila */

                        /*polje Iznos sudske takse - ne radi */
                        if sudska_taksa_pocetna <> '' then begin
                            if Evaluate(SudskaTaksaDecimal, sudska_taksa_pocetna) then
                                "Accusation Header"."Court Expenses Amt - Transfer" := SudskaTaksaDecimal;

                        end;

                        if aktivni_status_predmeta <> '' then begin
                            AccusationStatus.Reset();
                            AccusationStatus.SetFilter(Code, '%1', id);
                            if not AccusationStatus.FindFirst() then begin
                                AccusationStatus.Init();
                                AccusationStatus.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumStatus, glavna_datum_statusa) then
                                    AccusationStatus.Date := DatumStatus;
                                AccusationStatus.Type := 4;
                                AccusationStatus.Accusation := id;
                                AccusationStatus.Customer := sifra_potrosaca;
                                if aktivni_status_predmeta = '1' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Given to court");
                                if aktivni_status_predmeta = '2' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Answer to the Accusation");
                                if aktivni_status_predmeta = '3' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Setup Trial");
                                if aktivni_status_predmeta = '4' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Main Trial");
                                if aktivni_status_predmeta = '5' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"First Degree Ruling Affirmative");
                                if aktivni_status_predmeta = '6' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"First Degree Ruling Negative");
                                if aktivni_status_predmeta = '7' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Submissions to the Court");
                                if aktivni_status_predmeta = '8' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Submissions of the Court");
                                if aktivni_status_predmeta = '9' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"External Submissions");
                                if aktivni_status_predmeta = '10' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Internal Submissions");
                                if aktivni_status_predmeta = '11' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Appeal");
                                if aktivni_status_predmeta = '12' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Second Degree Ruling");
                                if aktivni_status_predmeta = '13' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Withdrawal");
                                if aktivni_status_predmeta = '14' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"End of Trial");
                                if aktivni_status_predmeta = '15' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Return to the Previous State");
                                if aktivni_status_predmeta = '16' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Write Offs");
                                if aktivni_status_predmeta = '1' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Given to court");
                                if aktivni_status_predmeta = '17' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Revision");
                                if aktivni_status_predmeta = '18' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Allignment by Court");
                                if aktivni_status_predmeta = '19' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Bankruptcy");
                                if aktivni_status_predmeta = '20' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Liquidation");
                                if aktivni_status_predmeta = '21' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Proposal on Execution");
                                if aktivni_status_predmeta = '22' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Court Submissions");
                                if aktivni_status_predmeta = '23' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Submissions of Court");
                                if aktivni_status_predmeta = '24' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"External Submissions - Executive Procedure");
                                if aktivni_status_predmeta = '25' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Decision on Execution");
                                if aktivni_status_predmeta = '26' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Objection");
                                if aktivni_status_predmeta = '27' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"List Assessment Seizure");
                                if aktivni_status_predmeta = '28' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Court Sale");
                                if aktivni_status_predmeta = '29' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Postponal of Execution");
                                if aktivni_status_predmeta = '30' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Continue the Execution");
                                if aktivni_status_predmeta = '31' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Withdrawal of Proposal of Execution");
                                if aktivni_status_predmeta = '32' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Stopping of Accusation");
                                if aktivni_status_predmeta = '33' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Write Off - Executive Procedure");
                                if aktivni_status_predmeta = '34' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Submitted");
                                if aktivni_status_predmeta = '35' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Denied");
                                if aktivni_status_predmeta = '36' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Completed - Guilty");
                                if aktivni_status_predmeta = '37' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Completed - Not Guilty");
                                if aktivni_status_predmeta = '38' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Prepared for lawyers");
                                if aktivni_status_predmeta = '39' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"End Accusation");
                                if aktivni_status_predmeta = '40' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Accusation Ready for sending to court");
                                if aktivni_status_predmeta = '41' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Archived");
                                if aktivni_status_predmeta = '42' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Suspended investigation");

                                AccusationStatus.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Accusation Status" := AccusationStatus.Code;
                            "Accusation Header".Status := AccusationStatus.Status;

                        end;

                        /* polje Napomena u BC-u */
                        if podaci_o_presudi_napomena <> '' then begin
                            "Accusation Header".Validate("Note", podaci_o_presudi_napomena);
                        end;

                        /* polje Sudski broj-šifra */

                        if sud <> '' then begin
                            CourtCode.Reset();
                            CourtCode.SetFilter(Code, '%1', id);
                            if not CourtCode.FindFirst() then begin
                                CourtCode.Init();
                                CourtCode.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                CourtCode.Type := 1;
                                CourtCode.MALS := sud;
                                CourtCode.Accusation := id;
                                CourtCode.Customer := sifra_potrosaca;

                                CourtCode.Insert();
                                Commit();



                            end;

                            "Accusation Header"."Court number" := CourtCode.Code;
                            "Accusation Header"."Actual Court Number" := CourtCode.MALS;

                        end;

                        /* polje Plaćeni iznos sudske takse-prenos */
                        if glavna_placeno_taksa <> '' then begin
                            if Evaluate(CourtExpensesDecimal, glavna_placeno_taksa) then
                                "Accusation Header"."Court Expenses Amt Paid - Tr" := CourtExpensesDecimal;

                        end;

                        /* polje Datum povlačenja tužbe/prijedlog za izvršenje*/
                        if podaci_o_presudi_datum_prijedlog_izvrsenja <> '' then begin
                            if Evaluate(WithdrawalDate, podaci_o_presudi_datum_prijedlog_izvrsenja) then
                                "Accusation Header"."Date of Withdrawal" := WithdrawalDate;

                        end;


                        /* polje Datum uplate-prenos */
                        if podaci_o_presudi_datum_placanja <> '' then begin
                            if Evaluate(DateTransfer, podaci_o_presudi_datum_placanja) then
                                "Accusation Header"."Payment Date" := DateTransfer;
                        end;


                        /* polje Kamata u BC-u */

                        if kamata_pocetna <> '' then begin
                            if Evaluate(InterestDecimal, kamata_pocetna) then
                                "Accusation Header".Interest := InterestDecimal;
                        end;


                        /* polje Datum sudske odluke u BC-u */
                        if podaci_o_presudi_pravosnaznosti <> '' then begin
                            if Evaluate(CourtDecisionDate, podaci_o_presudi_pravosnaznosti) then
                                "Accusation Header"."Date of Court Decision" := CourtDecisionDate;
                        end;

                        /* polje Plaćen dug i sudski troškovi u BC-u */
                        if glavna_da_li_je_placena_taksa <> '' then begin
                            if glavna_da_li_je_placena_taksa = '1' then
                                "Accusation Header".Validate("Debt and court expenses paid", true);
                            if glavna_da_li_je_placena_taksa = '0' then
                                "Accusation Header".Validate("Debt and court expenses paid", false);

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
        IPsifraPostoji: Boolean;

        IPsifraInsert: Record Territory;

        DatumIPDate: Date;
        DugPocetniDecimal: Decimal;

        KamataPocetnaDecimal: Decimal;

        SudskaTaksaDecimal: Decimal;

        NoSeriesLine: Record "No. Series Line";

        BrojacInt: code[20];

        TerritoryCode: code[20];
        TerritoryType: Option;

        AccusationLineDept: Record "Accusation Line";

        AccusationStatus: Record Territory;

        TerritoryStatusCode: code[20];

        DatumStatus: Date;

        CourtCode: Record Territory;

        TerritoryCourtCode: code[20];

        CourtExpensesDecimal: Decimal;

        DebtCourtExpensesPaidBool: Boolean;

        WithdrawalDate: Date;

        AmountPaidDecimal: Decimal;

        DateTransfer: Date;

        InterestAmountDecimal: Decimal;

        DifferenceDecimal: Decimal;

        InterestDecimal: Decimal;

        DebtAmountDecimal: Decimal;

        CourtDecisionDate: Date;

}
