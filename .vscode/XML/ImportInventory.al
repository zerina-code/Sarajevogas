xmlport 50020 "Import Inventory"
{
    Direction = Import;
    FieldDelimiter = ',';
    FieldSeparator = ',';
    Format = VariableText;
    TextEncoding = UTF8;


    //R


    schema
    {
        textelement(Root)
        {
            tableelement(Table330; "Item Journal Line")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Inventura';
                UseTemporary = false;

                textelement(ItemNo)
                {

                }
                textelement(LocationCode)
                {

                }
                textelement(Broj)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                begin

                    Table330.Reset();
                    Table330.SetFilter("Item No.", '%1', ItemNo);
                    Table330.SetFilter("Location Code", '%1', LocationCode);



                    if Table330.FindSet() then begin
                        Evaluate(Number, Broj);
                        Table330."Qty. (Phys. Inventory)" := Number;
                        Table330.Modify();
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
        MESSAGE('text001');

    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        Number: Decimal;
        text001: Label 'Succesfully importred.';

}
