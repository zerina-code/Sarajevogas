xmlport 50015 "Import JM"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import JM';




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
                textelement(JM)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin

                    Item.Reset();
                    Item.SetFilter("No.", '%1', BrArtikla);
                    if Item.FindFirst() then begin
                        Item.Validate("Base Unit of Measure", JM);
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

