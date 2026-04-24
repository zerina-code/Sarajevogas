xmlport 50026 "Gauge Import"
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


                //sada ide vertikala

                textelement(GIS)
                {
                    MinOccurs = Zero;
                }
                //GIS

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

                //
                textelement(NacinOcitanja)
                {
                    MinOccurs = Zero;
                }

                //ovdje alternativno
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
                begin
                    "Service Item".Reset();
                    "Service Item".SetFilter("No.", '%1', Sifra);
                    if "Service Item".FindFirst() then begin
                        if strlen(naziv) > 100 then begin
                            "Service Item".Validate(description, copystr(Naziv, 1, 100))
                        end
                        else begin
                            "Service Item".Validate(description, Naziv)
                            ;
                        end;
                        "Service Item".Validate("Search Description", "Service Item".Description);
                        "Service Item".Validate("Customer No.", SifraKupca);
                        "Service Item".Validate("Street No.", SifraUliceMM);
                        "Service Item".Validate(Street, SifraUliceMM);
                        "Service Item".Validate(Floor, SpratMM);
                        "Service Item".Validate("Apartment No.", BrojStanaMM);
                        "Service Item".Validate("Street No. Text", BrojUliceSlovimaMM);


                        if Evaluate(RezimLjetoInt, RezimLjeto) then
                            "Service Item".Validate("Summer Zone", RezimLjetoInt)
                        else
                            "Service Item".Validate("Summer Zone", 0);

                        if Evaluate(RezimZimaInt, RezimZima) then
                            "Service Item".Validate("Winter Zone", RezimZimaInt)
                        else
                            "Service Item".Validate("Winter Zone", 0);

                        if Evaluate(RezimPrelazInt, RezimPrelaz) then
                            "Service Item".Validate("Transit Zone", RezimPrelazInt)
                        else
                            "Service Item".Validate("Transit Zone", 0);


                        if NacinOcitanja = '0' then
                            "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::"Reading List")
                        else
                            "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::Digital);
                        if Evaluate(PodeseniPritisakDecimal, PodeseniPritisak) then
                            "Service Item".Validate("Adjusted Pressure", PodeseniPritisakDecimal)
                        else
                            "Service Item".Validate("Adjusted Pressure", 0);
                        if Evaluate(GISInt, GIS) then
                            "Service Item".Validate(GIS, GISInt)
                        else
                            "Service Item".Validate(GIS, 0);
                        if Evaluate(NadmorskaVisinaDecimal, NadmorskaVisina) then
                            "Service Item".Validate(Elevation, NadmorskaVisinaDecimal)
                        else
                            "Service Item".Validate(Elevation, 0);

                        if AlternativnoGorivo = '0' then
                            "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::No)
                        else
                            "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::Yes);


                        if Evaluate(ProjektovanoDecimal, Projektovano) then
                            "Service Item".Validate("Designed KW", ProjektovanoDecimal)
                        else
                            "Service Item".Validate("Designed KW", 0);
                        if Evaluate(InstalisanoDecimal, Instalisano) then
                            "Service Item".Validate("Installed KW", InstalisanoDecimal)
                        else
                            "Service Item".Validate("Installed KW", 0);
                        if Evaluate(StartPotrosnjeDate, StartPotrosnje) then
                            "Service Item".Validate("Starting Measuring", StartPotrosnjeDate)
                        else
                            "Service Item".Validate("Starting Measuring", 0D);

                        "Service Item".Validate("Minimal Consumption", MinPtr);

                        if Evaluate(OcitackaZonaljetoDecimal, OcitackaZonaljeto) then
                            "Service Item".Validate("Measuring Zone - summer", OcitackaZonaljetoDecimal)
                        else
                            "Service Item".Validate("Measuring Zone - summer", 0);
                        if Evaluate(OcitackaZonaZenoDecimal, OcitackaZonaZima) then
                            "Service Item".Validate("Measuring Zone - winter", OcitackaZonaZenoDecimal)
                        else
                            "Service Item".Validate("Measuring Zone - winter", 0);

                        "Service Item".Validate(Distribution, "Service Item".Distribution::"Distribution No");
                        "Service Item".Validate("Distribution - read", "Service Item"."Distribution - read"::"Distribution No.");

                        /*     PurposeValidate.Reset();
                             PurposeValidate.SetFilter(Code, '%1', NamjenaPotrosnje);
                             if PurposeValidate.FindFirst() then begin
                                 "Service Item".Validate(Purpose, PurposeValidate.Description)
                             end
                             else begin
                                 "Service Item".Validate(Purpose, '');
                             end;*/


                        if KategorijaMM = '1' then
                            "Service Item"."MM Category" := "Service Item"."MM Category"::"Large Economy";
                        if KategorijaMM = '2' then
                            "Service Item"."MM Category" := "Service Item"."MM Category"::"Small Economy";
                        if KategorijaMM = '3' then
                            "Service Item"."MM Category" := "Service Item"."MM Category"::Household;
                        "Service Item".validate("Applied address", true);


                        /* "Service Item".Validate("Street Customer", SifraUliceS);
                         "Service Item".Validate("Street No.", BrojUliceS);
                         "Service Item".Validate("Activity Code", Djelatnost);
                         if Status = '1' then
                             "Service Item"."Customer Status" := "Service Item"."Customer Status"::Active;
                         if Status = '2' then
                             "Service Item"."Customer Status" := "Service Item"."Customer Status"::Terminated;
                         if Status = '3' then
                             "Service Item"."Customer Status" := "Service Item"."Customer Status"::"Permanently inactive";

                         //ĐK   "Service Item".Comment:=napomena;
                         "Service Item".Validate("Street Customer 2", SifraUliceD);
                         "Service Item".Validate("Street No. 2", BrojUliceD);
                         "Service Item".Validate("Apartment No. Customer 2", StanD);
                         "Service Item".Validate("Floor Customer 2", SpratD);
                         if Kategorija = '1' then
                             "Service Item"."Customer Category" := "Service Item"."Customer Category"::"Large Economy";
                         if Kategorija = '2' then
                             "Service Item"."Customer Category" := "Service Item"."Customer Category"::"Small Economy";
                         if Kategorija = '3' then
                             "Service Item"."Customer Category" := "Service Item"."Customer Category"::Household;*/
                        "Service Item".Modify();






                    end
                    else begin
                        "Service Item".Validate("No.", Sifra);
                        // "Service Item".Validate(description, Naziv);
                        //"Service Item".Validate("Search Description", Naziv);
                        if strlen(naziv) > 100 then begin
                            "Service Item".Validate(description, copystr(Naziv, 1, 100))
                        end
                        else begin
                            "Service Item".Validate(description, Naziv)
                            ;
                        end;
                        "Service Item".Validate("Search Description", "Service Item".Description);

                        "Service Item".Validate("Customer No.", SifraKupca);
                        "Service Item".Validate("Street No.", SifraUliceMM);
                        "Service Item".Validate(Street, SifraUliceMM);
                        "Service Item".Validate("Street No. Text", BrojUliceSlovimaMM);
                        "Service Item".Validate(Floor, SpratMM);
                        "Service Item".Validate("Apartment No.", BrojStanaMM);
                        if Evaluate(RezimLjetoInt, RezimLjeto) then
                            "Service Item".Validate("Summer Zone", RezimLjetoInt)
                        else
                            "Service Item".Validate("Summer Zone", 0);

                        //"Service Item".Validate(Purpose, NamjenaPotrosnje);

                        /*    PurposeValidate.Reset();
                            PurposeValidate.SetFilter(Code, '%1', NamjenaPotrosnje);
                            if PurposeValidate.FindFirst() then begin
                                "Service Item".Validate(Purpose, PurposeValidate.Description)
                            end
                            else begin
                                "Service Item".Validate(Purpose, '');
                            end;*/

                        if Evaluate(RezimZimaInt, RezimZima) then
                            "Service Item".Validate("Winter Zone", RezimZimaInt)
                        else
                            "Service Item".Validate("Winter Zone", 0);

                        if Evaluate(RezimPrelazInt, RezimPrelaz) then
                            "Service Item".Validate("Transit Zone", RezimPrelazInt)
                        else
                            "Service Item".Validate("Transit Zone", 0);


                        if NacinOcitanja = '0' then
                            "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::"Reading List")
                        else
                            "Service Item".Validate("Reading Mode", "Service Item"."Reading Mode"::Digital);
                        if Evaluate(PodeseniPritisakDecimal, PodeseniPritisak) then
                            "Service Item".Validate("Adjusted Pressure", PodeseniPritisakDecimal)
                        else
                            "Service Item".Validate("Adjusted Pressure", 0);
                        if Evaluate(GISInt, GIS) then
                            "Service Item".Validate(GIS, GISInt)
                        else
                            "Service Item".Validate(GIS, 0);
                        if Evaluate(NadmorskaVisinaDecimal, NadmorskaVisina) then
                            "Service Item".Validate(Elevation, NadmorskaVisinaDecimal)
                        else
                            "Service Item".Validate(Elevation, 0);

                        if AlternativnoGorivo = '0' then
                            "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::No)
                        else
                            "Service Item".Validate("Alternative fuel", "Service Item"."Alternative fuel"::Yes);

                        if Evaluate(ProjektovanoDecimal, Projektovano) then
                            "Service Item".Validate("Designed KW", ProjektovanoDecimal)
                        else
                            "Service Item".Validate("Designed KW", 0);
                        if Evaluate(InstalisanoDecimal, Instalisano) then
                            "Service Item".Validate("Installed KW", InstalisanoDecimal)
                        else
                            "Service Item".Validate("Installed KW", 0);
                        if Evaluate(StartPotrosnjeDate, StartPotrosnje) then
                            "Service Item".Validate("Starting Measuring", StartPotrosnjeDate)
                        else
                            "Service Item".Validate("Starting Measuring", 0D);

                        "Service Item".Validate("Minimal Consumption", MinPtr);

                        if Evaluate(OcitackaZonaljetoDecimal, OcitackaZonaljeto) then
                            "Service Item".Validate("Measuring Zone - summer", OcitackaZonaljetoDecimal)
                        else
                            "Service Item".Validate("Measuring Zone - summer", 0);
                        if Evaluate(OcitackaZonaZenoDecimal, OcitackaZonaZima) then
                            "Service Item".Validate("Measuring Zone - winter", OcitackaZonaZenoDecimal)
                        else
                            "Service Item".Validate("Measuring Zone - winter", 0);

                        "Service Item".Validate(Distribution, "Service Item".Distribution::"Distribution No");
                        "Service Item".Validate("Distribution - read", "Service Item"."Distribution - read"::"Distribution No.");









                        if KategorijaMM = '1' then
                            "Service Item"."MM Category" := "Service Item"."MM Category"::"Large Economy";
                        if KategorijaMM = '2' then
                            "Service Item"."MM Category" := "Service Item"."MM Category"::"Small Economy";
                        if KategorijaMM = '3' then
                            "Service Item"."MM Category" := "Service Item"."MM Category"::Household;
                        "Service Item".validate("Applied address", true);


                        "Service Item".Insert();
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
        EmpVec: Record Employee;
        PurposeValidate: Record Purpose;

        OcitackaZonaljetoDecimal: Decimal;
        OcitackaZonaZenoDecimal: Decimal;

        StartPotrosnjeDate: Date;
        ProjektovanoDecimal: Decimal;
        InstalisanoDecimal: Decimal;
        AlternativnoGorivoBoolean: enum Option;
        NadmorskaVisinaDecimal: Decimal;
        GISInt: Integer;
        PodeseniPritisakDecimal: Decimal;
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
        RezimLjetoInt: Integer;
        RezimZimaInt: Integer
        ;
        RezimPrelazInt: Integer;

        Department: Record Department;
        Slozen: Decimal;
        EmployeeU: Record Employee;
        Code2: Code[20];
        Code3: Code[20];
        HumanResSetup: Record "Human Resources Setup";
        Uslov: Decimal;

        Odgovor: Decimal;
}

