xmlport 50034 "El. Volume Corr Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'EL Correction';





    schema
    {
        textelement(Root)
        {
            tableelement("El. Volume Corr"; "El. Volume Corr")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'EL_Module';
                UseTemporary = false;
                textelement(SifraKorektora)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraMM)
                {
                    MinOccurs = Zero;
                }
                textelement(DatumUgradnje)
                {
                    MinOccurs = Zero;
                }

                textelement(Serijskibroj1)
                {
                    MinOccurs = Zero;
                }

                textelement(GodinaProizvodnje)
                {
                    MinOccurs = Zero;
                }
                textelement(GodinaBazdarenja)
                {
                    MinOccurs = Zero;
                }


                textelement(Kategorija)
                {
                    MinOccurs = Zero;
                }
                textelement(Proizvodjac)
                {
                    MinOccurs = Zero;
                }
                textelement(PritisakOpseg)
                {
                    MinOccurs = zero;
                }

                textelement(KorektorTR)
                {
                    MinOccurs = Zero;
                }
                textelement(RadnTemp)
                {
                    MinOccurs = Zero;
                }
                textelement(DavacImpulsa)
                {
                    MinOccurs = Zero;
                }


                textelement(IDStanice)
                {
                    MinOccurs = Zero;
                }
                textelement(PritisakMax)
                {
                    MinOccurs = Zero;
                }
                textelement(Pizl)
                {
                    MinOccurs = Zero;
                }
                textelement(TezinaSent)
                {
                    MinOccurs = Zero;
                }
                textelement(Model)
                {
                    MinOccurs = Zero;
                }
                textelement(N2)
                {
                    MinOccurs = Zero;
                }
                textelement(GUstina)
                {
                    MinOccurs = Zero;
                }
                textelement(GOrnjaKal)
                {
                    MinOccurs = Zero;
                }
                textelement(C02)
                {
                    MinOccurs = Zero;
                }




                trigger OnAfterInsertRecord()
                var

                begin

                    "El. Volume Corr".reset;
                    "El. Volume Corr".setfilter("COde", '%1', SifraKorektora);
                    if "El. Volume Corr".findfirst then begin
                        "El. Volume Corr"."Serial Number" := Serijskibroj1;
                        if Evaluate(GodinaProizvodnjeInt, GodinaProizvodnje) then
                            "El. Volume Corr".Validate("Year of Production", GodinaProizvodnjeInt)
                        else
                            "El. Volume Corr".Validate("Year of Production", 0);

                        if Evaluate(DatumProgramiranjaDate, GodinaBazdarenja) then
                            "El. Volume Corr".Validate("DD calibration", DatumProgramiranjaDate)
                        else
                            "El. Volume Corr".Validate("DD calibration", 0);

                        if Kategorija = '1' then
                            "El. Volume Corr"."Customer Category" := "El. Volume Corr"."Customer Category"::"Large Economy";
                        if Kategorija = '2' then
                            "El. Volume Corr"."Customer Category" := "El. Volume Corr"."Customer Category"::"Small Economy";
                        if Kategorija = '3' then
                            "El. Volume Corr"."Customer Category" := "El. Volume Corr"."Customer Category"::Household;

                        MMAc.Reset();
                        MMAc.SetFilter(Name, '%1', Proizvodjac);
                        if MMAc.FindFirst() then begin
                            "El. Volume Corr".Validate("Meter Manufacturer Desc", MMAc.Name);
                            "El. Volume Corr".Validate("Meter Manufacturer", MMAc.code);


                        end;
                        "El. Volume Corr".Validate("Measuring Point", SifraMM);


                        ServiceItem.reset;
                        ServiceItem.setfilter("No.", '%1', SifraMM);
                        if ServiceItem.FindFirst() then begin
                            "El. Volume Corr".Validate("Customer No.", ServiceItem."Customer No.");

                        end;

                        if Evaluate(Pritisak1, PritisakOpseg)
                         then
                            "El. Volume Corr".Validate("Pressure from (N2%)", Pritisak1)
                        else
                            "El. Volume Corr".Validate("Pressure from (N2%)", 0);

                        if Evaluate(TrDecimal, KorektorTR) then
                            "El. Volume Corr".Validate("Number of decimals /Tr", TrDecimal)
                        else
                            "El. Volume Corr".Validate("Number of decimals /Tr", 0);


                        if Evaluate(Pritisak2, RadnTemp) then
                            "El. Volume Corr".Validate("Base Pressure", pritisak2)
                        else
                            "El. Volume Corr".Validate("Base Pressure", 0);
                        if DavacImpulsa = 'NF' then
                            "El. Volume Corr".Validate("Pulse transmitter LF/HE", "El. Volume Corr"."Pulse transmitter LF/HE"::NF);

                        if DavacImpulsa = 'HF' then
                            "El. Volume Corr".Validate("Pulse transmitter LF/HE", "El. Volume Corr"."Pulse transmitter LF/HE"::HF);

                        if DavacImpulsa = 'NN' then
                            "El. Volume Corr".Validate("Pulse transmitter LF/HE", "El. Volume Corr"."Pulse transmitter LF/HE"::nn);

                        if Evaluate(IDStaniceDec, IDStanice) then
                            "El. Volume Corr".Validate(Station, IDStaniceDec)
                        else
                            "El. Volume Corr".Validate(Station, 0);


                        if Evaluate(Pritisak3, PritisakMax) then
                            "El. Volume Corr".Validate("Base temperature", Pritisak3)
                        else
                            "El. Volume Corr".Validate("Base temperature", 0);

                        if Evaluate(Pritisak4, Pizl) then
                            "El. Volume Corr".Validate("Pressure to (N2%)", Pritisak4)
                        else
                            "El. Volume Corr".Validate("Pressure to (N2%)", 0);
                        if Evaluate(Tezina, TezinaSent)
                        then
                            "El. Volume Corr".Validate(Weight, Tezina)
                        else
                            "El. Volume Corr".validate(Weight, 0);

                        "El. Volume Corr".Validate(Model, Model);
                        if Evaluate(GustDec, GUstina) then
                            "El. Volume Corr".Validate("Thick Air", GustDec)
                        else
                            "El. Volume Corr".validate("Thick Air", 0);

                        if Evaluate(GustDec, GUstina) then
                            "El. Volume Corr".Validate("Thick Air", GustDec)
                        else
                            "El. Volume Corr".validate("Thick Air", 0);

                        if Evaluate(N2Dec, N2) then
                            "El. Volume Corr".Validate("N2%", N2Dec)
                        else
                            "El. Volume Corr".validate("N2%", 0);

                        if Evaluate(C02Dec, C02) then
                            "El. Volume Corr".Validate("CO2 %", C02Dec)
                        else
                            "El. Volume Corr".validate("CO2 %", 0);

                        if Evaluate(GornjaK, GOrnjaKal) then
                            "El. Volume Corr".Validate("Upper cal.", GornjaK)
                        else
                            "El. Volume Corr".validate("Upper cal.", 0);









                    end
                    else begin
                        "El. Volume Corr".init;
                        "El. Volume Corr".Code := SifraKorektora;
                        "El. Volume Corr"."Serial Number" := Serijskibroj1;
                        if Evaluate(GodinaProizvodnjeInt, GodinaProizvodnje) then
                            "El. Volume Corr".Validate("Year of Production", GodinaProizvodnjeInt)
                        else
                            "El. Volume Corr".Validate("Year of Production", 0);

                        if Evaluate(DatumProgramiranjaDate, GodinaBazdarenja) then
                            "El. Volume Corr".Validate("DD calibration", DatumProgramiranjaDate)
                        else
                            "El. Volume Corr".Validate("DD calibration", 0);

                        if Kategorija = '1' then
                            "El. Volume Corr"."Customer Category" := "El. Volume Corr"."Customer Category"::"Large Economy";
                        if Kategorija = '2' then
                            "El. Volume Corr"."Customer Category" := "El. Volume Corr"."Customer Category"::"Small Economy";
                        if Kategorija = '3' then
                            "El. Volume Corr"."Customer Category" := "El. Volume Corr"."Customer Category"::Household;

                        MMAc.Reset();
                        MMAc.SetFilter(Name, '%1', Proizvodjac);
                        if MMAc.FindFirst() then begin
                            "El. Volume Corr".Validate("Meter Manufacturer Desc", MMAc.Name);
                            "El. Volume Corr".Validate("Meter Manufacturer", MMAc.code);


                        end;
                        "El. Volume Corr".Validate("Measuring Point", SifraMM);


                        ServiceItem.reset;
                        ServiceItem.setfilter("No.", '%1', SifraMM);
                        if ServiceItem.FindFirst() then begin
                            "El. Volume Corr".Validate("Customer No.", ServiceItem."Customer No.");

                        end;
                        if Evaluate(Pritisak1, PritisakOpseg)
                         then
                            "El. Volume Corr".Validate("Pressure from (N2%)", Pritisak1)
                        else
                            "El. Volume Corr".Validate("Pressure from (N2%)", 0);

                        if Evaluate(TrDecimal, KorektorTR) then
                            "El. Volume Corr".Validate("Number of decimals /Tr", TrDecimal)
                        else
                            "El. Volume Corr".Validate("Number of decimals /Tr", 0);


                        if Evaluate(Pritisak2, RadnTemp) then
                            "El. Volume Corr".Validate("Base Pressure", pritisak2)
                        else
                            "El. Volume Corr".Validate("Base Pressure", 0);
                        if DavacImpulsa = 'NF' then
                            "El. Volume Corr".Validate("Pulse transmitter LF/HE", "El. Volume Corr"."Pulse transmitter LF/HE"::NF);

                        if DavacImpulsa = 'HF' then
                            "El. Volume Corr".Validate("Pulse transmitter LF/HE", "El. Volume Corr"."Pulse transmitter LF/HE"::HF);

                        if DavacImpulsa = 'NN' then
                            "El. Volume Corr".Validate("Pulse transmitter LF/HE", "El. Volume Corr"."Pulse transmitter LF/HE"::nn);

                        if Evaluate(IDStaniceDec, IDStanice) then
                            "El. Volume Corr".Validate(Station, IDStaniceDec)
                        else
                            "El. Volume Corr".Validate(Station, 0);


                        if Evaluate(Pritisak3, PritisakMax) then
                            "El. Volume Corr".Validate("Base temperature", Pritisak3)
                        else
                            "El. Volume Corr".Validate("Base temperature", 0);

                        if Evaluate(Pritisak4, Pizl) then
                            "El. Volume Corr".Validate("Pressure to (N2%)", Pritisak4)
                        else
                            "El. Volume Corr".Validate("Pressure to (N2%)", 0);
                        if Evaluate(Tezina, TezinaSent)
                        then
                            "El. Volume Corr".Validate(Weight, Tezina)
                        else
                            "El. Volume Corr".validate(Weight, 0);

                        "El. Volume Corr".Validate(Model, Model);
                        if Evaluate(GustDec, GUstina) then
                            "El. Volume Corr".Validate("Thick Air", GustDec)
                        else
                            "El. Volume Corr".validate("Thick Air", 0);

                        if Evaluate(GustDec, GUstina) then
                            "El. Volume Corr".Validate("Thick Air", GustDec)
                        else
                            "El. Volume Corr".validate("Thick Air", 0);

                        if Evaluate(N2Dec, N2) then
                            "El. Volume Corr".Validate("N2%", N2Dec)
                        else
                            "El. Volume Corr".validate("N2%", 0);

                        if Evaluate(C02Dec, C02) then
                            "El. Volume Corr".Validate("CO2 %", C02Dec)
                        else
                            "El. Volume Corr".validate("CO2 %", 0);

                        if Evaluate(GornjaK, GOrnjaKal) then
                            "El. Volume Corr".Validate("Upper cal.", GornjaK)
                        else
                            "El. Volume Corr".validate("Upper cal.", 0);
                        "El. Volume Corr".Insert();
                    end;


                    Commit();

                    InstallationHistory.Init();
                    InstallationHistory.Validate(Code, SifraKorektora);
                    InstallationHistory.Validate(Type, InstallationHistory.Type::Corrector);
                    if Evaluate(DatumUgradnjeDate, DatumUgradnje) then
                        InstallationHistory.Validate("Installation Date", DatumUgradnjeDate)
                    else
                        InstallationHistory.Validate("Installation Date", 0D);

                    InstallationHistory.Validate("Measuring Point Code", SifraMM);

                    ServiceItem.reset;
                    ServiceItem.setfilter("No.", '%1', SifraMM);
                    if ServiceItem.FindFirst() then begin
                        InstallationHistory.Validate("Address MM", ServiceItem."Address MM");
                        InstallationHistory.Validate("Customer No.", ServiceItem."Customer No.");
                    end;

                    //  InstallationHistory.Validate("Serial Number I", Serijskibroj1);
                    //   InstallationHistory.Validate("Serial Number II", Serijskibroj2);
                    InstallationHistory.Validate("Inventory Number", Serijskibroj1);
                    InstallationHistory.Validate(InvterentoryFil, Serijskibroj1);



                    InstallationHistory.Validate(Active, true);


                    InstallationHistory.Insert();
                end;















            }
        }
    }
    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        DatumProgramiranjaDate: Integer;
        DatumreprogramiranjaDate: Integer;
        InstallationHistory: Record "Installation History";
        ServiceItem: Record "Service Item";
        DatumUgradnjeDate: Date;
        EmpVec: Record Employee;
        MMAc: Record Manufacturer;
        GodinaProizvodnjeInt: Integer;
        EmailDeliveryDate_Date: date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
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
        Pritisak1: Decimal
        ;
        TrDecimal: Decimal;
        Pritisak2: Decimal;
        Pritisak3: Decimal;
        Pritisak4: Decimal;
        Tezina: Decimal;
        IDStaniceDec: Decimal;
        N2Dec: Decimal;
        C02Dec: Decimal;
        GustDec: Decimal;
        GornjaK: Decimal;
        Co2Dec: Decimal;
}

