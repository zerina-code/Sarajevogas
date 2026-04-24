xmlport 50039 "Update StreetNo ServiceItem"
{
    Caption = 'Update Street No For Service Item';
    TextEncoding = UTF8;
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = ';';
    Direction = Import;
    schema
    {
        textelement(Root)
        {
            tableelement(ServiceItem; "Service Item")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Service_Item';
                UseTemporary = false;
                textelement(br_mjeraca)
                {
                    MinOccurs = Zero;
                }

                textelement(br_ulice)
                {
                    MinOccurs = Zero;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    ServiceItem.Reset();
                    ServiceItem.SetFilter("No.", '%1', br_mjeraca);
                    if ServiceItem.FindFirst() then begin
                        if br_ulice <> '' then begin
                            if StrLen(br_ulice) > 20 then begin
                                ServiceItem.Validate("Street", CopyStr(br_ulice, 1, 20));
                            end
                            else begin
                                ServiceItem.Validate("Street", br_ulice);
                            end;
                        end;

                        ServiceItem.Modify();
                    end;
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
