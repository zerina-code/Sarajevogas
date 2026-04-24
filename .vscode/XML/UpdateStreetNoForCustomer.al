xmlport 50038 "Update Street No For Customer"
{
    Caption = 'Update Street No For Customer';
    TextEncoding = UTF8;
    Format = VariableText;
    FieldSeparator = ';';
    FieldDelimiter = ';';
    Direction = Import;
    schema
    {
        textelement(Root)
        {
            tableelement(Customer; Customer)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Customer';
                UseTemporary = false;

                textelement(br_kupca)
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
                    Customer.Reset();
                    Customer.SetFilter("No.", '%1', br_kupca);
                    if Customer.FindFirst() then begin
                        if br_ulice <> '' then begin
                            if StrLen(br_ulice) > 20 then begin
                                Customer.Validate("Street Customer", CopyStr(br_ulice, 1, 20));
                                Customer.Validate("Street Customer 2", CopyStr(br_ulice, 1, 20));
                            end
                            else begin
                                Customer.Validate("Street Customer", br_ulice);
                                Customer.Validate("Street Customer 2", br_ulice);
                            end;
                        end;

                        Customer.Modify();
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
