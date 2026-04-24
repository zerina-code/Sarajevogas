xmlport 50017 "Import CGS Description"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import Description';

    //R


    schema
    {
        textelement(Root)
        {
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'PositionMenu';
                UseTemporary = false;

                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }


                /* textelement(Opis)
                 {
                     MinOccurs = Zero;
                 }

                 textelement(Opstina)
                 {
                     MinOccurs = Zero;
                 }*/

                textelement(DatumNabave)
                {
                    MinOccurs = Zero;
                }
                textelement(DatumAktivacije)
                {
                    MinOccurs = Zero;
                }


                /* textelement(Procenat)
                 {
                     MinOccurs = Zero;
                 }

                 textelement(AmGr)
                 {
                     MinOccurs = Zero;
                 }

                 textelement(Klasa)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Gr)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(PodGr)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(ss)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(starasifr)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(konto)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(klasaFA)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(SubklasaFA)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(amort)
                 {
                     MinOccurs = Zero;
                 }*/
                trigger OnAfterInsertRecord()
                var

                begin


                    "Fixed Asset".Reset();
                    "Fixed Asset".SetFilter("No.", '%1', Sifra);
                    if "Fixed Asset".FindFirst() then begin

                        // "Fixed Asset".VALIDATE("R.Employee Obligation", Zaposleni);

                        /*FA.RESET;
                        FA.SetFilter("No.", '%1', Sifra);
                        IF FA.FindFirst
                            then begin
                            FA.VALIDATE("Responsible Employee", Employee."No.");
                            FA.MODIFY;
                        "Fixed Asset".Validate("No.", Sifra);*/

                        EVALUATE(DatumA, DatumAktivacije);
                        //evaluate(ProcenatD, Procenat);
                        //"Fixed Asset".Validate("Description", Opis);
                        //"Fixed Asset".Validate("Description 2", Opstina);

                        "Fixed Asset".Validate("Activation Date", DatumA);
                        //"Fixed Asset".Validate("Customer No.", Kupac);
                        //"Fixed Asset".Validate("FA Posting Date", DatumN);

                        // "Fixed Asset".Validate("Donation Percentage", ProcenatD);
                        //"Fixed Asset".Validate("Pipe Length", DuzinaC);
                        // "Fixed Asset"."Depreciation Group" := AmGr;
                        // "Fixed Asset".Validate("Class Code", Klasa);

                        /*"Fixed Asset".Validate("Group Code", Gr);
                         If PodGr = '0' then PodGr := '00';
                         "Fixed Asset".Validate(Subgroup, PodGr);
                         "Fixed Asset".Validate("SS number", ss);
                         "Fixed Asset".Validate("Old No.", starasifr);
                         "Fixed Asset".Validate("FA Posting Group", konto);
                         "Fixed Asset".Validate("FA Class code", klasaFA);
                         "Fixed Asset".Validate("FA Subclass code", SubklasaFA);*/
                        "Fixed Asset".modify();
                    end;


                    /*Obligation.Reset();
                    Obligation.SetFilter("No.", '%1', Sifra);
                    if Obligation.FindFirst() then begin
                        EVALUATE(ZaposleniInt, Zaposleni);
                        Employee.Reset();
                        Employee.SetFilter("Old number", '%1', ZaposleniInt);
                        IF Employee.FindFirst then begin
                            Obligation."Employee No." := Employee."No.";
                            Obligation.MODIFY;
                            /*FA.RESET;
                            FA.SetFilter("No.", '%1', Sifra);
                            IF FA.FindFirst
                                then begin
                                FA.VALIDATE("Responsible Employee", Employee."No.");
                                FA.MODIFY;

                            end;
                        end
                        ELSE
                            MESSAGE(Zaposleni);

                    end;
                    end;*/
                    /*validacija kupca
                                        "Fixed Asset".Reset();
                                        "Fixed Asset".SetFilter("No.", '%1', Sifra);
                                        if "Fixed Asset".FindFirst() then begin
                                            "Fixed Asset".Validate("Location Code", kupac);
                                            "Fixed Asset".modify;
                                        end;
                                    end;*/

                    FADB.Reset();
                    FADB.SetFilter("FA No.", '%1', Sifra);
                    if FADB.FindFirst() then begin

                        EVALUATE(datumN, datumNabave);
                        FADB.Validate("Acquisition Date", datumN);
                        FADB.modify;
                    end;
                end;

            }
        }
    }

    trigger OnPreXmlPort()
    begin

    end;

    var

        ProcenatD: Decimal;
        DuzinaC: Decimal;
        Employee: Record Employee;
        FA: Record "Fixed Asset";
        Cust: Record Customer;
        ZaposleniInt: integer;
        DatumKnjizenja: Date;
        FADB: record "FA Depreciation Book";
        DatumDok: Date;
        Red: integer;
        Dugovno: Decimal;
        DatumN: date;
        DatumA: date;


}

