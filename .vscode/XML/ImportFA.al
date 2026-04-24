xmlport 50023 "FA Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'FA Import';


    schema
    {
        textelement(Root)
        {
            tableelement("Gen. Journal Line"; "Gen. Journal Line")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'JournalLine';
                UseTemporary = false;


                textelement(BrRetka)
                {
                    MinOccurs = Zero;
                }

                textelement(DatumDokumenta)
                {
                    MinOccurs = Zero;
                }
                textelement(BrDoumenta)
                {
                    MinOccurs = Zero;
                }

                textelement(ExBrDoumenta)
                {
                    MinOccurs = Zero;
                }

                textelement(BrRacuna)
                {
                    MinOccurs = Zero;
                }

                textelement(Vrsta)
                {
                    MinOccurs = Zero;
                }

                textelement(Iznos)
                {
                    MinOccurs = Zero;
                }
                textelement(Kgr)
                {
                    MinOccurs = Zero;
                }

                /* import fa
                                textelement(Sifra)
                                {
                                    MinOccurs = Zero;
                                }


                                textelement(Opis)
                                {
                                    MinOccurs = Zero;
                                }

                                textelement(Opstina)
                                {
                                    MinOccurs = Zero;
                                }

                                textelement(DatumAktivacije)
                                {
                                    MinOccurs = Zero;
                                }


                                textelement(Procenat)
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
                */


                trigger OnAfterInsertRecord()
                var

                begin
                    "Gen. Journal Line".Reset();
                    "Gen. Journal Line".SetFilter("Journal Template Name", '%1', 'OPŠTE');
                    "Gen. Journal Line".SetFilter("Journal bATCH Name", '%1', 'PS');
                    if "Gen. Journal Line".FindFirst() then begin
                        // EVALUATE(DatumKnjizenja, DatumKnj);
                        /* IF DatumDokumenta <> '' then*/
                        EVALUATE(DatumDok, DatumDokumenta);
                        EVALUATE(Red, BrRetka);
                        EVALUATE(Dugovno, Iznos);

                        "Gen. Journal Line".VALIDATE("Posting Date", 20250630D);
                        "Gen. Journal Line".VALIDATE("Line No.", Red);
                        "Gen. Journal Line".VALIDATE("Document Date", DatumDok);
                        "Gen. Journal Line".VALIDATE("Document No.", 'PS-AV');

                        "Gen. Journal Line".VALIDATE("External Document No.", ExBrDoumenta);
                        "Gen. Journal Line".VALIDATE("Account Type", "Gen. Journal Line"."Account Type"::"Customer");

                        "Gen. Journal Line".VALIDATE("Account No.", BrRacuna);
                        "Gen. Journal Line".VALIDATE("Bill Type", Vrsta);
                        "Gen. Journal Line".VALIDATE("Amount", Dugovno);
                        "Gen. Journal Line".VALIDATE("Posting Group", Kgr);
                        "Gen. Journal Line".Insert;
                    end;
                end;





                //import novi fa
                /*  "Fixed Asset".Reset();
                  "Fixed Asset".SetFilter("No.", '%1', Sifra);
                  if NOT "Fixed Asset".FindFirst() then begin

                      // "Fixed Asset".VALIDATE("R.Employee Obligation", Zaposleni);

                      /*FA.RESET;
                      FA.SetFilter("No.", '%1', Sifra);
                      IF FA.FindFirst
                          then begin
                          FA.VALIDATE("Responsible Employee", Employee."No.");
                          FA.MODIFY;
                      "Fixed Asset".Validate("No.", Sifra);

                      EVALUATE(DatumA, DatumAktivacije);
                      evaluate(ProcenatD, Procenat);
                      "Fixed Asset".Validate("Description", Opis);
                      "Fixed Asset".Validate("Description 2", Opstina);
                      "Fixed Asset".Validate("Activation Date", DatumA);
                      //"Fixed Asset".Validate("Customer No.", Kupac);
                      //"Fixed Asset".Validate("FA Posting Date", DatumN);

                      "Fixed Asset".Validate("Donation Percentage", ProcenatD);
                      "Fixed Asset".Validate("Pipe Length", DuzinaC);
                      "Fixed Asset"."Depreciation Group" := AmGr;
                      "Fixed Asset".Validate("Class Code", Klasa);

                      "Fixed Asset".Validate("Group Code", Gr);
                      If PodGr = '0' then PodGr := '00';
                      "Fixed Asset".Validate(Subgroup, PodGr);
                      "Fixed Asset".Validate("SS number", ss);
                      "Fixed Asset".Validate("Old No.", starasifr);
                      "Fixed Asset".Validate("FA Posting Group", konto);
                      "Fixed Asset".Validate("FA Class code", klasaFA);
                      "Fixed Asset".Validate("FA Subclass code", SubklasaFA);
                      "Fixed Asset".Insert();
                  end;
                end;*/

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

                /*   "FA Depreciation Book".Reset();
                   "FA Depreciation Book".SetFilter("FA No.", '%1', Sifra);
                   if NOT "FA Depreciation Book".FindFirst() then begin
                       "FA Depreciation Book".Validate("FA No.", sifra);
                       "FA Depreciation Book".Validate("Depreciation Book Code", 'AMORT');
                       "FA Depreciation Book".Validate("FA Posting Group", konto);
                       EVALUATE(ProcenatD, amort);
                       "FA Depreciation Book".Validate("Straight-Line %", ProcenatD);
                       "FA Depreciation Book".insert;*/
                //nk
                /*"Gen. Journal Line".Reset();
                "Gen. Journal Line".SetFilter("Journal Template name", '%1', 'ASSETS');
                "Gen. Journal Line".SetFilter("Journal bATCH Name", '%1', 'ZADANO');

                if "Gen. Journal Line".FindFirst() then begin
                   "Gen. Journal Line". VALIDATE("Gen. Journal Line"."Posting Date",010125D);
                    EVALUATE(DatumDokumenta, datum);
                    if "Gen. Journal Line"."FA Posting Date" = 0D then
                        "Gen. Journal Line".VALIDATE("FA Posting Date", DatumDokumenta);
                    "Gen. Journal Line".modify;

                end;
            end;*/
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

        DatumDok: Date;
        Red: integer;
        Dugovno: Decimal;
        DatumN: date;
        DatumA: date;


}

