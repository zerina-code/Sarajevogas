xmlport 50014 "Import Knjiznih Grupa"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import Knjiznih Grupa';





    schema
    {
        textelement(Root)
        {
            tableelement(Item; Item)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'PositionMenu';
                UseTemporary = false;

                textelement(BrArtikla)
                {
                    MinOccurs = Zero;
                }
                textelement(OpstaKnjGrupa)
                {
                    MinOccurs = Zero;
                }
                textelement(KnjGrZaPDV)
                {
                    MinOccurs = Zero;
                }
                textelement(KnjGrZaliha)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin

                    Item.Reset();
                    Item.SetFilter("No.", '%1', BrArtikla);
                    if Item.FindFirst() then begin

                        Item.Validate("Gen. Prod. Posting Group", OpstaKnjGrupa);
                        Item.Validate("VAT Prod. Posting Group", KnjGrZaPDV);
                        Item.Validate("Inventory Posting Group", KnjGrZaliha);
                        Item.Modify();

                    end;
                end;

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
        MESSAGE('Završeno');

    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
}

