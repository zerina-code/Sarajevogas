/*table 50253 "Certication and solu"
{
    // //

    Caption = 'Certication and solu';
    DrillDownPageID = "Certifications";
    LookupPageID = "Certifications";

    fields
    {
        field(7; "Show Template"; Boolean)
        {
            Caption = 'Show Template';
        }
        field(50019; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(50020; "Agreement Code"; Code[30])
        {
            Caption = 'Agreement code';
        }
        field(50021; Group; Option)
        {
            Caption = 'Group';
            OptionCaption = ' ,Certification,Solutions,decision';
            OptionMembers = " ",Certification,Solutions,decision;
        }
        field(50022; "Document Description"; Text[90])
        {
            Caption = 'Document description';
        }
        field(50025; "NAV Agreement Code"; Integer)
        {
            Caption = 'Agreement code';
        }
    }

    keys
    {
        key(Key1; ID, "Agreement Code", "Document Description", Group)
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
        fieldgroup(DropDown; "Document Description", Group, "Agreement Code")
        {
        }
    }
}

*/