xmlport 50008 "CustImport"
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
                textelement(DatumKnj)
                {
                    MinOccurs = Zero;
                }

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





                trigger OnAfterInsertRecord()
                var

                begin

                    "Gen. Journal Line".Reset();
                    "Gen. Journal Line".SetFilter("Journal Template Name", '%1', 'OPŠTE');
                    "Gen. Journal Line".SetFilter("Journal bATCH Name", '%1', 'OPŠTE');
                    if "Gen. Journal Line".FindFirst() then begin
                        EVALUATE(DatumKnjizenja, DatumKnj);
                        EVALUATE(DatumDok, DatumDokumenta);
                        EVALUATE(Red, BrRetka);
                        EVALUATE(Dugovno, Iznos);


                        "Gen. Journal Line".VALIDATE("Posting Date", DatumKnjizenja);
                        "Gen. Journal Line".VALIDATE("Line No.", Red);
                        "Gen. Journal Line".VALIDATE("Document Date", DatumDok);
                        "Gen. Journal Line".VALIDATE("Document No.", BrDoumenta);
                        "Gen. Journal Line".VALIDATE("External Document No.", ExBrDoumenta);
                        "Gen. Journal Line".VALIDATE("Account Type", "Gen. Journal Line"."Account Type"::Customer);

                        "Gen. Journal Line".VALIDATE("Account No.", BrRacuna);
                        IF Cust.GET(BrRacuna) then
                            "Gen. Journal Line".VALIDATE("Description", Cust.Name);
                        "Gen. Journal Line".VALIDATE("Bill Type", Vrsta);
                        "Gen. Journal Line".VALIDATE("Credit Amount", Dugovno);
                        "Gen. Journal Line".VALIDATE("Posting Group", Kgr);
                        "Gen. Journal Line".VALIDATE("Prepayment", TRUE);
                        "Gen. Journal Line".Insert;
                    end;
                end;
            }
        }
    }


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

