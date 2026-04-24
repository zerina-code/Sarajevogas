/*table 50236 "Document Register"
{
    Caption = 'Document Register';
    DrillDownPageID = "Document Register";
    LookupPageID = "Document Register";

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            //ĐK
            Caption = 'ID';
        }
        field(2; "Agreement Code"; Code[30])
        {
            Caption = 'Agreement code';
        }
        field(3; Group; Text[188])
        {
            Caption = 'Group';
        }
        field(4; "Document Description"; Text[250])
        {
            Caption = 'Document description';
        }
        field(5; "NAV Agreement Code"; Integer)
        {
            Caption = 'Agreement code';
        }
        field(6; "Attachment No"; Integer)
        {
        }
        field(7; "Show Template"; Boolean)
        {
            Caption = 'Show Template';
        }
    }

    keys
    {
        key(Key1; ID, "Document Description")
        {
        }
        key(Key2; "Document Description")
        {
        }
        key(Key3; Group)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Group, "Document Description", "Agreement Code")
        {
        }
    }
}

*/