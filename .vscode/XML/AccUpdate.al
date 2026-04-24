xmlport 50012 AccUpdate
{

    Direction = Import;
    FieldDelimiter = ',';
    FieldSeparator = ',';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("G/L Account"; "G/L Account")
            {

                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'AccUpdate';
                UseTemporary = false;
                textelement(Br)
                {
                    MinOccurs = Zero;
                }
                textelement(zbroj)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()

                begin
                    GLACC.SETFILTER("No.", '%1', Br);
                    IF GLACC.FIND('-') THEN BEGIN
                        GLACC.Totaling := zbroj;
                        GLACC.MODIFY;
                    END;

                end;
            }
        }
    }



    var
        myInt: Integer;
        GLACC: Record "G/L Account";
}