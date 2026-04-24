/*ĐK table 50102 "Document Footer"
{
    // //SKHR7.00 Croatian Localization

    Caption = 'Document Footer';

    fields
    {
        field(1; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(2; "Footer Text"; Text[250])
        {
            Caption = 'Footer Text';
        }
        field(3; "Primary key"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Language Code", "Footer Text")
        {
        }
    }

    fieldgroups
    {
    }
}

*/