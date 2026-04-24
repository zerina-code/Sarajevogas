table 50061 Vacation
{
    Caption = 'Vocation';

    fields
    {
        field(1;"No.";Code[20])
        {
            Caption = 'No.';
        }
        field(2;"Description New";Text[250])
        {
            Caption = 'Description';
            InitValue = '5';
            NotBlank = false;
        }
        field(3;"No. Old";Code[20])
        {
            Caption = 'No.';
        }
        field(4;"Description Old";Text[250])
        {
            Caption = 'Description';
            InitValue = '5';
            NotBlank = false;
        }
    }

    keys
    {
        key(Key1;"No.","Description New","No. Old")
        {
        }
    }

    fieldgroups
    {
        fieldgroup("No.";"No.","Description New","No. Old","Description Old")
        {
        }
    }
}

