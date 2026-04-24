xmlport 50043 ImportTuzbeSeptembar
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ImportTuzbe';
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
                textelement(glavna_placeno_taksa)
                {
                    MinOccurs = Zero;
                }
                textelement(datum_ip)
                {
                    MinOccurs = Zero;
                }
                textelement(aktivni_status_predmeta)
                {
                    MinOccurs = Zero;
                }
                textelement(StatusOpis)
                {
                    MinOccurs = Zero;
                }
                /*  textelement(IDGlavne)
                  {
                      MinOccurs = Zero;
                  }*/



                trigger OnAfterInsertRecord()
                var
                    Kupac: Record "Customer";

                begin

                    "Accusation Header".Reset();
                    "Accusation Header".SetFilter("No.", '%1', 'TZ');
                    "Accusation Header".SetFilter("Customer No.", '%1', sifra_potrosaca);
                    if "Accusation Header".FindFirst() then begin

                        if "Accusation Header"."No." = '' then begin

                            AccusationCode.Reset();

                            AccusationCode."No." := AccCode;

                            "Accusation Header"."No." := AccCode;

                            AccCode := IncStr(AccCode);


                            //"Accusation Header"."No." := AccCode;


                        end;


                        if sifra_potrosaca <> '' then begin
                            Kupac.Reset();
                            Kupac.SetRange("No.", sifra_potrosaca);
                            if Kupac.FindFirst() then begin
                                "Accusation Header".Validate("Customer No.", sifra_potrosaca);
                                //"Accusation Header"."Customer Name" := ime_prezime;
                                if StrLen(ime_prezime) > 50 then
                                    "Accusation Header"."Customer Name" := CopyStr(ime_prezime, 1, 50)
                                else
                                    "Accusation Header"."Customer Name" := ime_prezime;
                            end else begin
                                if MissingCustomer = '' then
                                    MissingCustomer := sifra_potrosaca
                                else
                                    MissingCustomer += ', ' + sifra_potrosaca;

                            end;


                        end;

                        if dug_pocetni <> '' then begin
                            if Evaluate(DugPocetniDecimal, dug_pocetni) then
                                "Accusation Header".Debt := DugPocetniDecimal;

                        end;

                        if sudska_taksa_pocetna <> '' then begin
                            if Evaluate(SudskaTaksaDecimal, sudska_taksa_pocetna) then
                                "Accusation Header"."Court Expenses Amt - Transfer" := SudskaTaksaDecimal;
                        end;


                        if aktivni_status_predmeta <> '' then begin
                            AccusationStatus.Reset();
                            // AccusationStatus.SetFilter(Code, '%1', StatusId);
                            AccusationStatus.SetFilter(Code, '%1', TerritoryCode);
                            if not AccusationStatus.FindFirst() then begin
                                AccusationStatus.Init();
                                AccusationStatus.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                /*   if Evaluate(DatumStatus, glavna_datum_statusa) then
                                       AccusationStatus.Date := DatumStatus;*/
                                AccusationStatus.Type := 4;
                                // AccusationStatus.Accusation := StatusId;
                                AccusationStatus.Accusation := "Accusation Header"."No.";
                                AccusationStatus.Customer := sifra_potrosaca;
                                if aktivni_status_predmeta = '1' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");


                                if aktivni_status_predmeta = '5' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                if aktivni_status_predmeta = '6' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                if aktivni_status_predmeta = '7' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                if aktivni_status_predmeta = '8' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                if aktivni_status_predmeta = '10' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                if aktivni_status_predmeta = '11' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                if aktivni_status_predmeta = '12' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                if aktivni_status_predmeta = '15' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                if aktivni_status_predmeta = '16' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvrš. bez parnice -bez pln");
                                if aktivni_status_predmeta = '17' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                if aktivni_status_predmeta = '18' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                if aktivni_status_predmeta = '19' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                if aktivni_status_predmeta = '29' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                if aktivni_status_predmeta = '30' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");


                                AccusationStatus.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Accusation Status" := AccusationStatus.Code;
                            "Accusation Header".Status := AccusationStatus.Status;

                        end;

                        if glavna_placeno_taksa <> '' then begin
                            if Evaluate(CourtExpensesDecimal, glavna_placeno_taksa) then
                                "Accusation Header"."Court Expenses Amt Paid - Tr" := CourtExpensesDecimal;

                        end;

                        if kamata_pocetna <> '' then begin
                            if Evaluate(InterestDecimal, kamata_pocetna) then
                                "Accusation Header".Interest := InterestDecimal;
                        end;


                        /*if IDGlavne <> '' then begin
                            if Evaluate(IDGlavne1, IDGlavne) then
                                "Accusation Header".IDGlavne := IDGlavne1;


                        end;*/

                        if datum_ip <> '' then begin
                            IPsifraInsert.Reset();
                            if not IPsifraInsert.FindFirst() then begin
                                IPsifraInsert.Init();
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;

                                IPsifraInsert.Insert();
                                Commit();

                            end;

                        end;



                        "Accusation Header".Modify();

                    end else begin

                        if MissingCustomer = '' then
                            MissingCustomer := sifra_potrosaca
                        else
                            MissingCustomer += ', ' + sifra_potrosaca;


                        "Accusation Header".Init();
                        // "Accusation Header"."No." := id;

                        if "Accusation Header"."No." = '' then begin

                            AccusationCode.Reset();
                            AccusationCode."No." := AccCode;

                            "Accusation Header"."No." := AccCode;

                            AccCode := IncStr(AccCode);


                            // "Accusation Header"."No." := AccCode;



                        end;


                        if sifra_potrosaca <> '' then begin
                            Kupac.Reset();
                            Kupac.SetRange("No.", sifra_potrosaca);
                            if Kupac.FindFirst() then begin
                                "Accusation Header".Validate("Customer No.", sifra_potrosaca);
                                //  "Accusation Header".Validate("Customer Name", ime_prezime);
                                if StrLen(ime_prezime) > 50 then
                                    "Accusation Header"."Customer Name" := CopyStr(ime_prezime, 1, 50)
                                else
                                    "Accusation Header"."Customer Name" := ime_prezime;
                            end else begin
                                if MissingCustomer = '' then
                                    MissingCustomer := sifra_potrosaca
                                else
                                    MissingCustomer += ', ' + sifra_potrosaca;

                            end;

                        end;


                        /* if IDGlavne <> '' then begin
                             if Evaluate(IDGlavne1, IDGlavne) then
                                 "Accusation Header".IDGlavne := IDGlavne1;


                         end;*/

                        if datum_ip <> '' then begin
                            IPsifraInsert.Reset();
                            IPsifraInsert.SetFilter(Code, '%1', TerritoryCode);
                            if not IPsifraInsert.FindFirst() then begin
                                IPsifraInsert.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                if Evaluate(DatumIPDate, datum_ip) then
                                    IPsifraInsert.Date := DatumIPDate;
                                IPsifraInsert.Accusation := "Accusation Header"."No.";
                                IPsifraInsert.Customer := sifra_potrosaca;
                                IPsifraInsert.Type := 6;

                                IPsifraInsert.Insert();
                                Commit();



                            end;




                        end;

                        if dug_pocetni <> '' then begin
                            if Evaluate(DugPocetniDecimal, dug_pocetni) then
                                "Accusation Header".Debt := DugPocetniDecimal;

                        end;

                        if aktivni_status_predmeta <> '' then begin
                            AccusationStatus.Reset();
                            AccusationStatus.SetFilter(Code, '%1', TerritoryCode);
                            if not AccusationStatus.FindFirst() then begin
                                AccusationStatus.Init();
                                AccusationStatus.Code := TerritoryCode;
                                TerritoryCode := IncStr(TerritoryCode);
                                /*   if Evaluate(DatumStatus, glavna_datum_statusa) then
                                       AccusationStatus.Date := DatumStatus;*/
                                AccusationStatus.Type := 4;
                                AccusationStatus.Accusation := "Accusation Header"."No.";
                                AccusationStatus.Customer := sifra_potrosaca;
                                if aktivni_status_predmeta = '1' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Predan Sudu");


                                if aktivni_status_predmeta = '5' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda pozitivna");
                                if aktivni_status_predmeta = '6' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda negativna");
                                if aktivni_status_predmeta = '7' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Presuda djelomična");
                                if aktivni_status_predmeta = '8' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršenje bez parnice");
                                if aktivni_status_predmeta = '10' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Obustava postupka");
                                if aktivni_status_predmeta = '11' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Žalba na presudu");
                                if aktivni_status_predmeta = '12' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"II stepen presuda potvrđena");
                                if aktivni_status_predmeta = '15' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno");
                                if aktivni_status_predmeta = '16' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvrš. bez parnice -bez pln");
                                if aktivni_status_predmeta = '17' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Otpis");
                                if aktivni_status_predmeta = '18' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Prijedlog za izvršenje");
                                if aktivni_status_predmeta = '19' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Rješenje o izvršenju");
                                if aktivni_status_predmeta = '29' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno PP");
                                if aktivni_status_predmeta = '30' then
                                    AccusationStatus.Validate(Status, AccusationStatus.Status::"Izvršeno IP");


                                AccusationStatus.Insert();
                                Commit();
                            end;

                            "Accusation Header"."Accusation Status" := AccusationStatus.Code;
                            "Accusation Header".Status := AccusationStatus.Status;

                        end;

                        if glavna_placeno_taksa <> '' then begin
                            if Evaluate(CourtExpensesDecimal, glavna_placeno_taksa) then
                                "Accusation Header"."Court Expenses Amt Paid - Tr" := CourtExpensesDecimal;

                        end;

                        if kamata_pocetna <> '' then begin
                            if Evaluate(InterestDecimal, kamata_pocetna) then
                                "Accusation Header".Interest := InterestDecimal;
                        end;

                        if sudska_taksa_pocetna <> '' then begin
                            if Evaluate(SudskaTaksaDecimal, sudska_taksa_pocetna) then
                                "Accusation Header"."Court Expenses Amt - Transfer" := SudskaTaksaDecimal;

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

        NoSeriesLine.Reset();
        BrojacInt := IncStr(BrojacInt);
        NoSeriesLine.SetFilter("Series Code", '%1', 'TZ');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            //  AccCode := NoSeriesLine."Last No. Used";
            NoSeriesLine."Last No. Used" := AccCode;



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

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'TZ');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := AccCode;



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

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'TZ');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            if NoSeriesLine."Last No. Used" <> '' then begin
                AccCode := IncStr(NoSeriesLine."Last No. Used");
            end
            else begin
                AccCode := NoSeriesLine."Starting No.";


            end;



        end;
    end;


    var
        MissingCustomer: Text;
        DugPocetniDecimal: Decimal;

        SudskaTaksaDecimal: Decimal;

        AccusationStatus: Record Territory;

        TerritoryCode: code[20];

        DatumStatus: Date;
        CourtExpensesDecimal: Decimal;
        InterestDecimal: Decimal;
        IPsifraInsert: Record Territory;

        DatumIPDate: Date;

        NoSeriesLine: Record "No. Series Line";

        BrojacInt: code[20];

        AccusationCode: Record "Accusation Header";

        AccCode: code[20];

        StatusId: code[20];

        IDGlavne1: code[20];


}