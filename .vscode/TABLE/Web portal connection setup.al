table 50182 "Web portal connection setup"
{

    fields
    {
        field(1; Provider; Text[30])
        {
        }
        field(2; Server; Text[30])
        {
        }
        field(3; Database; Text[30])
        {
        }
        field(4; UID; Text[30])
        {
        }
        field(10; Password; Text[30])
        {
            ExtendedDatatype = Masked;
        }
        field(12; AllowNtlm; Boolean)
        {
        }
        field(13; "Code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; Provider)
        {
        }
    }

    fieldgroups
    {
    }
}

