table 50077 "Training Type"
{
    Caption = 'Training Type';
    LookupPageID = "Training Types";
    DrillDownPageId = "Training Types";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            //NotBlank = true;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            //Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

