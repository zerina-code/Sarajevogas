table 50097 "Manner for Termination"
{
    Caption = 'Manners for Termination';
    DrillDownPageID = "Manners for Termination";
    LookupPageID = "Manners for Termination";

    fields
    {
        field(1; "Code Manner"; Code[10])
        {
            Caption = 'Code manner for termination';
            NotBlank = true;
        }
        field(2; "Description Manner"; Text[250])
        {
            Caption = 'Description Manner for Termination';
        }
        field(50000; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Reason,Manner';
            OptionMembers = " ",Reason,Manner;
        }
    }

    keys
    {
        key(Key1; "Code Manner", "Description Manner")
        {
        }
        key(Key2; "Description Manner")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Description Manner", "Code Manner")
        {
        }
    }
}

