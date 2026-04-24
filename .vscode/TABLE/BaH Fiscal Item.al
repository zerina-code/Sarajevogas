/*table 50002 "BaH Fiscal Item"
{
    // BH1.00, Fiscal Process


    fields
    {
        field(1; "Fiscal Item No."; Integer)
        {
            Caption = 'Fiscal item no.';
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Item,Resource';
            OptionMembers = Unknown,Item,Resource;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource;
        }
        field(4; "VAT Group"; Text[1])
        {
            Caption = 'VAT Group';
        }
        field(5; "Alternative VAT Group"; Integer)
        {
            Caption = 'Alternative VAT Group';
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(7; Price; Decimal)
        {
            Caption = 'Price';
        }
    }

    keys
    {
        key(Key1; "Fiscal Item No.")
        {
        }
    }

    fieldgroups
    {
    }
}

*/