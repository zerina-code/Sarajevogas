xmlport 50018 "Import knj.gr.os."
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import knj.gr.os.';




    schema
    {
        textelement(Root)
        {
            tableelement("FA Depreciation Book"; "FA Depreciation Book")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'PositionMenu';
                UseTemporary = false;

                textelement(InvBr)
                {
                    MinOccurs = Zero;
                }
                textelement(ŠifraKnjGrOS)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin

                    "FA Depreciation Book".Reset();
                    "FA Depreciation Book".SetFilter("FA No.", '%1', InvBr);
                    if "FA Depreciation Book".FindFirst() then begin
                        "FA Depreciation Book".Validate("FA Posting Group", "ŠifraKnjGrOS");
                        "FA Depreciation Book".Modify();
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

