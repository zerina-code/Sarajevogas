xmlport 50019 "Item Posting Groups import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;


    schema
    {
        textelement(Root)
        {
            tableelement(Item; "Item")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Item';
                UseTemporary = false;

                textelement(Br)
                {
                    MinOccurs = Zero;
                }
                textelement(KAtegorija)
                {
                    MinOccurs = Zero;
                }
                /* textelement(NazivKategorije)
                {
                    MinOccurs = Zero;
                }*/
                textelement(Grupa)
                {
                    MinOccurs = Zero;
                }
                /*textelement(NazivGrupe)
                {
                    MinOccurs = Zero;
                }*/
                textelement(Podgrupa)
                {
                    MinOccurs = Zero;
                }
                /* textelement(NazivPodgrupe)
                {
                    MinOccurs = Zero;
                } */



                trigger OnAfterInsertRecord()
                begin

                    Item.Reset();
                    Item.SetFilter("No.", '%1', Br);
                    if Item.FindFirst()
                    then begin
                        Item.VALIDATE("Category Code", KAtegorija);
                        //Item."Category Description" := NazivKategorije;
                        Item.VALIDATE("Item Group", Grupa);
                        //Item."Group Description" := NazivGrupe;
                        Item.VALIDATE("Item Subgroup", Podgrupa);
                        //Item."Subgroup Description" := NazivPodgrupe;
                        Item.Modify;

                        NoSeries.SetFilter("Category Code", '%1', KAtegorija);
                        NoSeries.SetFilter("Group Code", '%1', Grupa);
                        NoSeries.SetFilter("Subgroup Code", '%1', Podgrupa);
                        if NoSeries.FindFirst
                        then begin
                            Item."Gen. Prod. Posting Group" := NoSeries."Gen. Prod. Posting Group";
                            Item."VAT Prod. Posting Group" := NoSeries."VAT Prod. Posting Group";
                            Item."Inventory Posting Group" := NoSeries."Inventory Posting Group";

                        end;
                        Item.Modify;
                    END;
                end;



            }
        }
    }
    var

        NoSeries: Record "No. Series";
}