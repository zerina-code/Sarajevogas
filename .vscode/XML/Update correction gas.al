xmlport 50052 "Update correction gas"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Update correction gas';





    schema
    {
        textelement(Root)
        {
            tableelement("Calculation Journal Line"; "Calculation Journal Line")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Calculation_Journal_Line';
                UseTemporary = false;
                textelement(ŠifraObračuna)
                {
                    MinOccurs = Zero;
                }
                textelement(ŠifraMjernogMjesta)
                {
                    MinOccurs = Zero;
                }
                textelement(Mjesec)
                {
                    MinOccurs = Zero;
                }
                textelement(GOdina)
                {
                    MinOccurs = Zero;
                }
                textelement(StaraVrijednost)
                {
                    MinOccurs = Zero;
                }
                textelement(NovaVrijednost)
                {
                    MinOccurs = Zero;
                }
                textelement(BrojNeocitanihMjeseci)
                {
                    MinOccurs = Zero;
                }
                textelement(PosebnaTaksa)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                var
                    CJL: Record "Calculation Journal Line";
                    StaraVrijednostDec: Decimal;
                    NovaVrijednostDec: Decimal;
                    TaksaDec: Decimal;
                    BrojNeocitanihMjeseciInt: Integer;
                begin
                    CJL.Reset();
                    CJL.SetFilter(Code, '%1', "ŠifraObračuna");
                    CJL.SetFilter("Measuring Point Code", '%1', "ŠifraMjernogMjesta");
                    CJL.SetFilter("Old Gauge", '%1', false);
                    cjl.SetFilter("Month Of GAS Calculation", Mjesec);
                    cjl.SetFilter("Year Of GAS Calculation", GOdina);
                    if cjl.FindFirst() then begin
                        if Evaluate(StaraVrijednostDec, StaraVrijednost) then
                            cjl.Validate("Old Value", StaraVrijednostDec);
                        if Evaluate(NovaVrijednostDec, NovaVrijednost) then
                            cjl.Validate("New Value", NovaVrijednostDec);
                        if Evaluate(BrojNeocitanihMjeseciInt, BrojNeocitanihMjeseci) then
                            cjl.Validate("Previous Unobvious Month", BrojNeocitanihMjeseciInt);
                        if Evaluate(TaksaDec, PosebnaTaksa) then begin
                            cjl.Validate("War Calculation (LVT)", TaksaDec);
                            cjl.Validate("Manualy War Value", true);
                        end;

                        cjl.Difference := cjl."New Value" - cjl."Old Value";

                        cjl.Modify();
                        Commit();


                    end;

                end;
            }
        }
    }
}