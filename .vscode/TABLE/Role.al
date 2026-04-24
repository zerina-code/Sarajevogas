/*table 50148 Role
{
    Caption = 'Role';
    LookupPageID = "Roles";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(50331; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,A,N';
            OptionMembers = " ",A,N;
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code")
        {
        }
    }
}

*/