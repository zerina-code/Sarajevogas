xmlport 50051 "Update Applied"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'MM Import';





    schema
    {
        textelement(Root)
        {
            tableelement("Service Item"; "Service Item")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Service_Item';
                UseTemporary = false;
                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }
                trigger OnAfterInsertRecord()
                var
                    MMActivity: Record "MM Activity";
                    HodogramI: Integer;
                    CU: Record Customer;
                    SI: Record "Service Item";
                begin
                    SI.Reset();
                    SI.SetFilter("No.", '%1', Sifra);
                    if SI.FindFirst() then begin
                        SI.Validate("Applied address", true);
                        SI.Modify();
                    end;

                end;
            }
        }
    }
}