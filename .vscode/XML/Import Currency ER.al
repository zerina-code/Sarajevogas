xmlport 50006 "Impor Currency Exchange Rate"
{
    Direction = Import;
    FieldDelimiter = 'None';
    Caption = 'Import Currency Exchange Rate';
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = true;

    schema
    {
        textelement(root)
        {
            tableelement(Table330; "Currency Exchange Rate")
            {
                AutoSave = false;
                XmlName = 'Curr';
                textelement(Ime)
                {
                }
                textelement(Code)
                {
                }
                textelement(Jedinica)
                {
                }
                textelement(Broj)
                {
                }
                textelement(Kupovni)
                {
                }
                textelement(Srednji)
                {
                }
                textelement(Prodajni)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    IF ((Ime = 'Zemlja') OR (Code = 'EUR') OR (Code = 'Oznaka valute') or (ime = 'Rusija')) THEN
                        currXMLport.SKIP;


                    ER.RESET;
                    ER.INIT;

                    ER."Starting Date" := Datum;
                    ER."Currency Code" := Code;
                    ER.INSERT;
                    EVALUATE(JedinicaD, Jedinica);
                    ER."Exchange Rate Amount" := JedinicaD;
                    ER."Adjustment Exch. Rate Amount" := JedinicaD;

                    srednjiT := Replacestring(Srednji, '.', ',');

                    EVALUATE(srednjiD, srednjiT);
                    ER."Relational Exch. Rate Amount" := srednjiD;
                    ER."Relational Adjmt Exch Rate Amt" := srednjiD;

                    ER.MODIFY;
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
                group(Date)
                {
                    Caption = 'Date of Exch. Rates';
                    field(Datum; Datum)
                    {
                        Caption = 'Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        Datum := TODAY;
    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE(Text0001);
    end;

    var
        ER: Record "Currency Exchange Rate";
        srednjiT: Text;
        srednjiD: Decimal;
        Datum: Date;
        CurrCode: Code[10];
        JedinicaD: Decimal;
        CurrencyRec: Record Currency;
        Text0001: Label 'Currency Exchange Rates are imported.';

    procedure Replacestring(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;
}

