tableextension 50115 "Inventory Posting Groups" extends "Inventory Posting Group"
{
    fields
    {
        // Add changes to table fields here
        field(5000; GlAccountNo; Integer)
        {
            Caption = 'GlAccountNo.';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}