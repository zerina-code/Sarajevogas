xmlport 50027 "Import Gauge"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import Gauge';





    schema
    {
        textelement(Root)
        {
            tableelement(Gauge; Gauge)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Gauge';
                UseTemporary = false;
                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }


                textelement(Kategorija)
                {
                    MinOccurs = Zero;
                }
                textelement(Serijskibroj)
                {
                    MinOccurs = Zero;
                }
                textelement(Proizvodjac)
                {
                    MinOccurs = Zero;
                }
                textelement(MjernoMjesto)
                {
                    MinOccurs = Zero;
                }
                textelement(GodinaProizvodnje)
                {
                    MinOccurs = Zero;
                }
                textelement(GOdinaBazdarenja)
                {
                    MinOccurs = Zero;

                }
                textelement(VelicinaMjeraca)
                {
                    MinOccurs = Zero;
                }
                textelement(MontazaPozicije)
                {
                    MinOccurs = Zero;
                }
                textelement(VrstaSpoja)
                {
                    MinOccurs = Zero;
                }
                textelement(SmjerProtoka)
                {
                    MinOccurs = Zero;
                }
                textelement(DUzina)
                {
                    MinOccurs = Zero;
                }
                textelement(DaljinskoVrsta)
                {
                    MinOccurs = Zero;
                }
                textelement(Porijeklo)
                {
                    MinOccurs = Zero;
                }
                textelement(Nonp)
                {
                    MinOccurs = Zero;
                }
                textelement(Pmax)
                {
                    MinOccurs = Zero;
                }
                textelement(Qmin)
                {
                    MinOccurs = Zero;
                }
                textelement(Qmax)
                {
                    MinOccurs = Zero;
                }

                textelement(DatumUgradnje)
                {
                    MinOccurs = Zero;
                }


                /*
                textelement(Djelatnost)
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
                textelement(SifraUliceD)
                {
                    MinOccurs = Zero;
                }
                textelement(BrojUliceD)
                {
                    MinOccurs = Zero;
                }
                textelement(SpratD)
                {
                    MinOccurs = Zero;
                }
                textelement(StanD)
                {
                    MinOccurs = Zero;
                }

                textelement(Kategorija)
                {
                    MinOccurs = Zero;
                }*/

                trigger OnAfterInsertRecord()
                var
                    MMActivitiy: Record "MM Activity";
                    ServiceItem: Record "Service Item";
                    Manuf: record "Manufacturer";
                    DDev: Date;
                begin


                    Gauge.Reset();
                    Gauge.SetFilter(Code, '%1', Sifra);
                    if Gauge.FindFirst() then begin

                        // key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")
                        Gauge.Validate("Inventar number", Serijskibroj);

                        if Kategorija = '1' then
                            Gauge."Gauge Category" := Gauge."Gauge Category"::"Large Economy";
                        if Kategorija = '2' then
                            Gauge."Gauge Category" := Gauge."Gauge Category"::"Small Economy";
                        if Kategorija = '3' then
                            Gauge."Gauge Category" := Gauge."Gauge Category"::Household;

                        // Gauge.Validate("Measuring Point", MjernoMjesto);
                        ServiceItem.Reset();
                        ServiceItem.SetFilter("No.", '%1', MjernoMjesto);
                        if ServiceItem.FindFirst() then begin
                            Gauge."Customer Category" := ServiceItem."Customer Category";
                            //   Gauge."Address MM" := ServiceItem."Address MM";
                        end;
                        Manuf.Reset();
                        Manuf.SetFilter(Name, '%1', Proizvodjac);
                        if Manuf.FindFirst() then
                            Gauge.Validate("Meter Manufacturer", Manuf.Code);
                        if Evaluate(GodinaProizvodnjeInt, GodinaProizvodnje) then
                            Gauge.Validate("Year of Production", GodinaProizvodnjeint);
                        if Evaluate(GodinaBazdarenjaInt, GOdinaBazdarenja) then
                            Gauge.Validate("DD calibration", GodinaBazdarenjaInt);
                        gauge.Validate("Gauge Size", VelicinaMjeraca);
                        if MontazaPozicije = '0' then
                            Gauge.Validate("Gauge Position", gauge."Gauge Position"::Unknown);
                        if MontazaPozicije = '1'
                        then
                            Gauge.Validate("Gauge Position", Gauge."Gauge Position"::"Before Regulator");

                        if MontazaPozicije = '2' then
                            gauge.Validate("Gauge Position", Gauge."Gauge Position"::"After Regulator");

                        if VrstaSpoja = '0' then
                            Gauge.Validate("Type of Connection", gauge."Type of Connection"::Unknown);
                        if VrstaSpoja = '1' then
                            gauge.Validate("Type of Connection", Gauge."Type of Connection"::Flanged);
                        if VrstaSpoja = '2' then
                            gauge.Validate("Type of Connection", Gauge."Type of Connection"::Threaded);

                        if SmjerProtoka = '0' then
                            Gauge.Validate("Flow direction", gauge."Flow direction"::Unknown);
                        if SmjerProtoka = '1' then
                            Gauge.Validate("Flow direction", Gauge."Flow direction"::"Left to Right");
                        if Evaluate(DUzinaDecimal, DUzina) then
                            Gauge.Validate("Installation length", DUzinaDecimal);


                        if DaljinskoVrsta = '0' then
                            Gauge.Validate("Type of reading", gauge."Type of reading"::Unknown);
                        if DaljinskoVrsta = '1' then
                            Gauge.Validate("Type of reading", gauge."Type of reading"::"Radio Module");
                        if DaljinskoVrsta = '2' then
                            Gauge.Validate("Type of reading", gauge."Type of reading"::"Module Type 3");

                        if Porijeklo = '0' then
                            Gauge.Validate(Origin, gauge.Origin::Unknown);
                        if Porijeklo = '1' then
                            Gauge.Validate(Origin, gauge.Origin::"Pre-war Singer");
                        if Porijeklo = '2' then
                            Gauge.Validate(Origin, gauge.Origin::"Pre-war 010392");
                        if Porijeklo = '3' then
                            Gauge.Validate(Origin, gauge.Origin::"46000");
                        if Porijeklo = '4' then
                            Gauge.Validate(Origin, gauge.Origin::"After 31052000");
                        if Porijeklo = '6' then
                            Gauge.Validate(Origin, gauge.Origin::"Approved 22062015");
                        if Evaluate(NonpDecimal, Nonp) then
                            gauge.Validate(No, NonpDecimal);
                        if Evaluate(QmaxDecimal, Qmax) then
                            Gauge.Validate(Qmax, QmaxDecimal);




                        Gauge.Modify();






                    end
                    else begin

                        Gauge.Init();
                        gauge.Validate(Code, Sifra);

                        Gauge.Validate("Inventar number", Serijskibroj);

                        if Kategorija = '1' then
                            Gauge."Gauge Category" := Gauge."Gauge Category"::"Large Economy";
                        if Kategorija = '2' then
                            Gauge."Gauge Category" := Gauge."Gauge Category"::"Small Economy";
                        if Kategorija = '3' then
                            Gauge."Gauge Category" := Gauge."Gauge Category"::Household;

                        Gauge.Validate("Measuring Point", MjernoMjesto);
                        ServiceItem.Reset();
                        ServiceItem.SetFilter("No.", '%1', MjernoMjesto);
                        if ServiceItem.FindFirst() then begin
                            Gauge."Customer Category" := ServiceItem."Customer Category";
                            Gauge."Address MM" := ServiceItem."Address MM";
                            Gauge.Validate("Customer No.", ServiceItem."Customer No.");
                        end;
                        // Gauge.Validate("Meter Manufacturer", Proizvodjac);

                        Manuf.Reset();
                        Manuf.SetFilter(Name, '%1', Proizvodjac);
                        if Manuf.FindFirst() then
                            Gauge.Validate("Meter Manufacturer", Manuf.Code);
                        Gauge.Validate("Meter Manufacturer Desc", Manuf.Name);
                        if Evaluate(GodinaProizvodnjeInt, GodinaProizvodnje) then
                            Gauge.Validate("Year of Production", GodinaProizvodnjeint);
                        if Evaluate(GodinaBazdarenjaInt, GOdinaBazdarenja) then
                            Gauge.Validate("DD calibration", GodinaBazdarenjaInt);
                        gauge.Validate("Gauge Size", VelicinaMjeraca);
                        if MontazaPozicije = '0' then
                            Gauge.Validate("Gauge Position", gauge."Gauge Position"::Unknown);
                        if MontazaPozicije = '1'
                        then
                            Gauge.Validate("Gauge Position", Gauge."Gauge Position"::"Before Regulator");

                        if MontazaPozicije = '2' then
                            gauge.Validate("Gauge Position", Gauge."Gauge Position"::"After Regulator");

                        if VrstaSpoja = '0' then
                            Gauge.Validate("Type of Connection", gauge."Type of Connection"::Unknown);
                        if VrstaSpoja = '1' then
                            gauge.Validate("Type of Connection", Gauge."Type of Connection"::Flanged);
                        if VrstaSpoja = '2' then
                            gauge.Validate("Type of Connection", Gauge."Type of Connection"::Threaded);

                        if SmjerProtoka = '0' then
                            Gauge.Validate("Flow direction", gauge."Flow direction"::Unknown);
                        if SmjerProtoka = '1' then
                            Gauge.Validate("Flow direction", Gauge."Flow direction"::"Left to Right");
                        if Evaluate(DUzinaDecimal, DUzina) then
                            Gauge.Validate("Installation length", DUzinaDecimal);


                        if DaljinskoVrsta = '0' then
                            Gauge.Validate("Type of reading", gauge."Type of reading"::Unknown);
                        if DaljinskoVrsta = '1' then
                            Gauge.Validate("Type of reading", gauge."Type of reading"::"Radio Module");
                        if DaljinskoVrsta = '2' then
                            Gauge.Validate("Type of reading", gauge."Type of reading"::"Module Type 3");

                        if Porijeklo = '0' then
                            Gauge.Validate(Origin, gauge.Origin::Unknown);
                        if Porijeklo = '1' then
                            Gauge.Validate(Origin, gauge.Origin::"Pre-war Singer");
                        if Porijeklo = '2' then
                            Gauge.Validate(Origin, gauge.Origin::"Pre-war 010392");
                        if Porijeklo = '3' then
                            Gauge.Validate(Origin, gauge.Origin::"46000");
                        if Porijeklo = '4' then
                            Gauge.Validate(Origin, gauge.Origin::"After 31052000");
                        if Porijeklo = '6' then
                            Gauge.Validate(Origin, gauge.Origin::"Approved 22062015");
                        if Evaluate(NonpDecimal, Nonp) then
                            gauge.Validate(No, NonpDecimal);
                        if Evaluate(QmaxDecimal, Qmax) then
                            Gauge.Validate(Qmax, QmaxDecimal);







                        Gauge.Insert();
                        Commit();
                        ServiceItem.Reset();
                        ServiceItem.SetFilter("No.", '%1', MjernoMjesto);
                        if ServiceItem.FindFirst() then begin
                            InstallationHistory.Init();
                            InstallationHistory.Validate(Code, Sifra);
                            InstallationHistory.Validate("Inventory Number", Serijskibroj);
                            InstallationHistory.Validate(InvterentoryFil, Serijskibroj);
                            InstallationHistory.Validate(Type, InstallationHistory.Type::Gauge);
                            if Evaluate(DDev, DatumUgradnje) then
                                InstallationHistory.Validate("Installation Date", DDev)
                            else
                                InstallationHistory.Validate("Installation Date", 0D);

                            InstallationHistory.Validate("Measuring Point Code", ServiceItem."No.");
                            InstallationHistory.Validate("Address MM", ServiceItem."Address MM");
                            InstallationHistory.Validate("Customer No.", ServiceItem."Customer No.");
                            InstallationHistory.Validate("Production Year", GodinaProizvodnjeInt);
                            InstallationHistory.Validate("DD calibration", GodinaBazdarenjaInt);
                            InstallationHistory.Validate(Active, true);


                            InstallationHistory.Insert();
                        end
                        else begin
                            InstallationHistory.Init();
                            InstallationHistory.Validate(Code, Sifra);
                            InstallationHistory.Validate("Inventory Number", Serijskibroj);
                            InstallationHistory.Validate(InvterentoryFil, Serijskibroj);
                            InstallationHistory.Validate(Type, InstallationHistory.Type::Gauge);
                            if Evaluate(DDev, DatumUgradnje) then
                                InstallationHistory.Validate("Installation Date", DDev)
                            else
                                InstallationHistory.Validate("Installation Date", 0D);

                            InstallationHistory."Measuring Point Code" := '';
                            InstallationHistory."Address MM" := '';
                            InstallationHistory."Customer No." := '';
                            InstallationHistory.Validate("Production Year", GodinaProizvodnjeInt);
                            InstallationHistory.Validate("DD calibration", GodinaBazdarenjaInt);
                            InstallationHistory.Validate(Active, true);


                            InstallationHistory.Insert();
                        end;

                        /*     ServiceItem.Reset();
                             ServiceItem.SetFilter("No.", '%1', MjernoMjesto);
                             if ServiceItem.FindFirst() then begin
                                 if ServiceItem."Starting Measuring" <> 0D then begin
                                     InstallationHistory.Init();
                                     InstallationHistory.Validate(Code, Serijskibroj);
                                     InstallationHistory.Validate(Type, InstallationHistory.Type::Gauge);
                                     InstallationHistory.Validate("Installation Date", ServiceItem."Starting Measuring");
                                     InstallationHistory.Validate("Measuring Point Code", ServiceItem."No.");
                                     InstallationHistory.Validate("Address MM", ServiceItem."Address MM");
                                     InstallationHistory.Validate("Customer No.", ServiceItem."Customer No.");
                                     InstallationHistory.Validate("Production Year", GodinaProizvodnjeInt);
                                     InstallationHistory.Validate("DD calibration", GodinaBazdarenjaInt);
                                     InstallationHistory.Validate(Active, true);


                                     InstallationHistory.Insert();

                                 end;
                             end;*/
                    end;


                end;
            }
        }
    }
    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        QmaxDecimal: Decimal;
        NonpDecimal: Decimal;
        DUzinaDecimal: Decimal;
        EmpVec: Record Employee;
        GodinaProizvodnjeInt: Integer;
        GodinaBazdarenjaInt: Integer;
        EmailDeliveryDate_Date: date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        InstallationHistory: Record "Installation History";
        EG: Record Employee;
        ER: Record Employee;
        Redoslijed: Integer;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
        AlternativeAddress: Record "Alternative Address";

        Department: Record Department;
        Slozen: Decimal;
        EmployeeU: Record Employee;
        Code2: Code[20];
        Code3: Code[20];
        HumanResSetup: Record "Human Resources Setup";
        Uslov: Decimal;

        Odgovor: Decimal;
        DatumUgradnjeDate: Date;
}

