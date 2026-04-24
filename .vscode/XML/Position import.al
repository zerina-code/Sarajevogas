xmlport 50003 "Position Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Position Import';




    schema
    {
        textelement(Root)
        {
            tableelement("Position Menu"; "Position Menu")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'PositionMenu';
                UseTemporary = false;
                textelement(Pozicija)
                {
                    MinOccurs = Zero;
                }
                textelement(Uvecanje)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                begin
                    Evaluate(Uvec, Uvecanje);

                    "Position Menu".Reset();
                    "Position Menu".SetFilter(code, '%1', Pozicija);
                    "Position Menu".SetFilter("Org. Structure", '%1', 'SIST 1');

                    IF "Position Menu".FindFirst() THEN BEGIN
                        //slozen
                        //odg
                        //uslov

                        "Position Menu".validate(Increment, Uvec);
                        "Position Menu".Modify();

                    END;
                END;

            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        MESSAGE(Text);
    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
        Uvec: Decimal;
        Uslov: Decimal;

        Odgovor: Decimal;
}

