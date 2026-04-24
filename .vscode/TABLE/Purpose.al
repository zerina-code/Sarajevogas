table 50142 "Purpose"
{
    Caption = 'Purpose';
    DrillDownPageId = Purposes;
    LookupPageId = Purposes;
    // DrillDownPageID = "Activities MM";
    // LookupPageID = "Activities MM";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = ,"MM","Customer";
            OptionCaption = ' ,MM,Customer';
        }
    }

    keys
    {
        key(Key1; "Code", Type, Description)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

