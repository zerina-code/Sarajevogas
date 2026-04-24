xmlport 50013 "Import FA groups"

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
            tableelement("Fixed Asset"; "Fixed Asset")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'FixedAsset';
                UseTemporary = false;
                textelement(FaNo)
                {
                    MinOccurs = Zero;
                }
                textelement(GroupID)
                {
                    MinOccurs = Zero;
                }
                textelement(SubGroupID)
                {
                    MinOccurs = Zero;
                }



                trigger OnAfterInsertRecord()
                begin
                    "Fixed Asset".Reset();
                    "Fixed Asset".SetFilter("No.", '%1', FANo);
                    if "Fixed Asset".FindFirst() then begin
                        "Fixed Asset".VALIDATE("FA Class Code", GroupID);
                        "Fixed Asset".VALIDATE("FA Subclass Code", SubGroupID);
                        "Fixed Asset".Modify();

                    end;





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


    var

        Gr: Integer;
        SubGr: Integer;
        FA: Record "Fixed Asset";

}

